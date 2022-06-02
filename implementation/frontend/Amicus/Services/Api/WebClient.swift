//
//  WebClient.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 03.05.22.
//

import Foundation
import UIKit
import CoreLocation


/// Webclient singleton class for APi calls to the amicus backend server.
final class WebClient {
    private final var apiBase = URL(string: "https://amicus.sou.tf")
    
    /// Returns the standard instance of this class
    static let standard = WebClient()
    
    private init(){}
    
    private func createApiUrl(path: String) -> URL {
        return URL(string: path, relativeTo: apiBase)!
    }
    
    private func decodeResponse<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    
    private func createYieldingRequest<T: ApiRequestBody>(method: String, for endpoint: Endpoint, with body: T,
                                                          authToken: String? = nil) -> URLRequest {
        var request = URLRequest(url: createApiUrl(path: endpoint.path))
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let authToken = authToken {
            request.setValue("Bearer: \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.amicus)
        request.httpBody = try? encoder.encode(body)
        return request
    }
    
    /// Creates a POST request to the amicus API backend.
    /// - Parameters:
    ///   - endpoint: the API endpoint  to use
    ///   - body: the body of the request
    /// - Returns: The new POST request
    private func createPostRequest<T: ApiRequestBody>(for endpoint: Endpoint, with body: T, authToken: String? = nil) -> URLRequest {
        return createYieldingRequest(method: "POST", for: endpoint, with: body, authToken: authToken)
    }
    
    
    private func createPatchRequest<T: ApiRequestBody>(for endpoint: Endpoint, body: T, authToken: String) -> URLRequest {
        return createYieldingRequest(method: "PATCH", for: endpoint, with: body, authToken: authToken)
    }
    
    
    /// Creates a GET request to the amicus API backend.
    /// - Parameters:
    ///   - endpoint: the API endpoint to use
    ///   - parameters: the query parameters
    ///   - authToken: the authentication token to pass, if needed
    /// - Returns: The new GET request
    private func createGetRequest(for endpoint: Endpoint, parameters: [(String, String)] = [(String, String)](), authToken: String? = nil) -> URLRequest {
        var components = URLComponents(url: createApiUrl(path: endpoint.path), resolvingAgainstBaseURL: true)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        
        if let authToken = authToken {
            request.setValue("Bearer: \(authToken)", forHTTPHeaderField: "Authorization")
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    
    /// Performs an asynchronous request to the amicus API backend.
    /// - Parameter request: The request object to use
    /// - Returns: The requested API object, if successful
    private func makeRequest<T: Codable>(with request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299) ~= httpResponse.statusCode else {
            let code = (response as? HTTPURLResponse)!.statusCode
            print("Got bad response code: \(code)")
            switch code {
            case 401: throw RequestError.unauthorized
            case 400...499: throw RequestError.unexpectedStatusCode
            case 500...510: throw RequestError.internalErr
            default: throw RequestError.unknown
            }
        }
        
        return try decodeResponse(data: data) as T
    }
    
    
    /// Makes a request to the login endpoint of the amicus API backend.
    /// - Parameters:
    ///   - email: the email of the user
    ///   - password: the password of the user
    /// - Returns: The JWT authentication of the user, if successful
    ///
    func login(email: String, password: String) async throws -> LoginResponse {
        let body = LoginRequestBody(email: email, password: password)
        let request = createPostRequest(for: UserEndpoint.login, with: body)
        return try await makeRequest(with: request)
    }
    
    
    /// Makes a basic ping request to the amicus backend API.
    /// - Returns: The ping response from the server
    func ping() async throws -> PingResponse {
        let request = createGetRequest(for: RootEndpoint.ping)
        return try await makeRequest(with: request)
    }
    
    
    /// Makes a whoami request to the amicus backend API.
    /// - Parameter authToken: the authentication token of the user that is requested
    /// - Returns: The user object associated with the authentication token
    func whoAmI(authToken: String) async throws -> UserResponse {
        let request = createGetRequest(for: UserEndpoint.whoami, authToken: authToken)
        return try await makeRequest(with: request)
    }
    
    
    /// Returns the user with the requested ID.
    /// - Parameter id: the id to search fo
    /// - Returns: The user object with the associated ID
    func getUserById(id: Int) async throws -> UserResponse {
        let request = createGetRequest(for: UserEndpoint.byId(id: id))
        return try await makeRequest(with: request)
    }
    
    func register(_ firstName: String, _ lastName: String, _ password: String,
                  _ birthDate: Date, _ email: String, _ username: String, _ avatar: UIImage, _ categories: [Category])
    async throws -> UserResponse {
        let profilePictureBody = MediaCreateRequestBody(
            data: avatar.pngData()!.base64EncodedString(),
            name: "\(username)_avatar", dataType: "png", appUserId: -1)
        
        let expertCategories = categories.map { CategoryRequest(categoryName: $0.categoryName) }
        let body = UserCreateRequestBody(
            firstName: firstName, lastName: lastName, email: email, address: "", passwordHash: password,
            username: username, birthDate: birthDate,
            profilePicture: profilePictureBody, expertCategories: expertCategories)
        let request = createPostRequest(for: UserEndpoint.register, with: body)
        return try await makeRequest(with: request)
    }
    
    func retrieveMedia(id: Int, authToken: String) async throws -> MediaResponse {
        let request = createGetRequest(for: MediaEndpoint.retrieveById(id: id), authToken: authToken)
        return try await makeRequest(with: request)
    }
    
    func uploadMedia(name: String, data: Data, fileType: String, userId: Int, authToken: String) async throws -> MediaResponse {
        let body = MediaCreateRequestBody(data: data.base64EncodedString(), name: name, dataType: fileType, appUserId: userId)
        let request = createPostRequest(for: MediaEndpoint.upload, with: body, authToken: authToken)
        return try await makeRequest(with: request)
    }
    
    func retrieveCategories() async throws -> Categories {
        let request = createGetRequest(for: CategoryEndpoint.retrieveAll)
        return try await makeRequest(with: request)
    }
    
    func createHelpPost(title: String, description: String, category: Category, media: UIImage,
                        coords: CLLocationCoordinate2D?, userId: Int, authToken: String ) async throws -> Request {
        
        var strCoords = ""
        if let coords = coords {
            strCoords = "\(coords.latitude),\(coords.longitude)"
        }
        
        // Upload and link the created media file.
        let uploaded = try! await uploadMedia(name: "\(userId)-\(title)-media", data: media.pngData()!, fileType: "png", userId: userId, authToken: authToken)
        let body = RequestCreateBody(
            title: title, content: description, date: Date.now,
            location: strCoords, isOpen: true, requesterId: userId, expertCategoryId: category.id, mediaId: uploaded.getIdUnsafe())
        
        let request = createPostRequest(for: RequestEndpoint.create, with: body, authToken: authToken)
        return try await makeRequest(with: request)
    }
    
    func retrieveRequestsByCategory(categories: Categories) async throws -> [FullRequest] {
        let pairs: [(String, String)] = categories.map { cat in ("id", String(cat.id)) }
        let request = createGetRequest(for: RequestEndpoint.findForCategoryIds, parameters: pairs)
        return try await makeRequest(with: request)
    }
    
    
    private func retrievePersonalRequests(userId: Int, isClosed: Bool, authToken: String, endpoint: RequestEndpoint) -> URLRequest {
        let pairs = [("user_id", String(userId)), ("is_closed", String(isClosed))]
        return createGetRequest(for: endpoint, parameters: pairs, authToken: authToken)
    }
    
    func retrieveMyRequests(userId: Int, isClosed: Bool, authToken: String) async throws -> [FullRequest] {
        let request = retrievePersonalRequests(userId: userId, isClosed: isClosed, authToken: authToken, endpoint: RequestEndpoint.myRequests)
        return try await makeRequest(with: request)
    }
    
    func retrieveAdviceRequests(userId: Int, isClosed: Bool, authToken: String) async throws -> [FullRequest] {
        let request = retrievePersonalRequests(userId: userId, isClosed: isClosed, authToken: authToken, endpoint: RequestEndpoint.myAdvice)
        return try await makeRequest(with: request)
    }
    
    func retrieveCategoriesForUser(userId: Int, authToken: String) async throws -> Categories {
        let request = createGetRequest(for: UserEndpoint.categories(userId: userId), authToken: authToken)
        return try await makeRequest(with: request)
    }
    
    func createExpertResponse(for requestId: Int, content: String, authToken: String) async throws -> ExpertResponse {
        let body = ExpertResponseBody(content: content, date: Date.now, requestId: requestId)
        let request = createPostRequest(for: RequestEndpoint.createResponse(requestId: requestId), with: body)
        return try await makeRequest(with: request)
    }
    
    func updateExpertIdForRequest(for requestId: Int, expertId: Int, authToken: String) async throws -> GenericResponse {
        let body = ExpertRequestPatchBody(expertId: expertId, isOpen: false)
        let request = createPatchRequest(for: RequestEndpoint.byId(id: requestId), body: body, authToken: authToken)
        return try await makeRequest(with: request) as GenericResponse
    }
    
    func uploadUserDeviceToken(userId: Int, deviceToken: String, authToken: String) async throws -> DeviceToken {
        let body = DeviceTokenBody(data: deviceToken, appUserId: userId)
        let request = createPostRequest(for: UserEndpoint.deviceToken(userId: userId), with: body, authToken: authToken)
        return try await makeRequest(with: request)
    }
}

fileprivate extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

fileprivate extension URLRequest {
    func log() {
        print("\(httpMethod ?? "") \(self)")
        print("BODY \n \(String(describing: httpBody?.toString()))")
        print("HEADERS \n \(String(describing: allHTTPHeaderFields))")
    }
}

fileprivate extension DateFormatter {
    static let amicus: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

