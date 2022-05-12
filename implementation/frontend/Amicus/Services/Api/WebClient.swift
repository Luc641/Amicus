//
//  WebClient.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 03.05.22.
//

import Foundation


/// Webclient singleton class for APi calls to the amicus backend server.
final class WebClient {
    private final var apiBase = URL(string: "http://localhost:3000/")
    
    /// Returns the standard instance of this class
    static let standard = WebClient()
    
    private init(){}
    
    private func createApiUrl(path: String) -> URL {
        return URL(string: path, relativeTo: apiBase)!
    }
    
    private func decodeResponse<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    /// Creates a POST request to the amicus API backend.
    /// - Parameters:
    ///   - endpoint: the API endpoint  to use
    ///   - body: the body of the request
    /// - Returns: The new POST request
    private func createPostRequest<T: ApiRequestBody>(for endpoint: Endpoint, with body: T) -> URLRequest {
        var request = URLRequest(url: createApiUrl(path: endpoint.path))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.amicus)
        request.httpBody = try? encoder.encode(body)
        return request
    }
    
    
    /// Creates a GET request to the amicus API backend.
    /// - Parameters:
    ///   - endpoint: the API endpoint to use
    ///   - parameters: the query parameters
    ///   - authToken: the authentication token to pass, if needed
    /// - Returns: The new GET request
    private func createGetRequest(for endpoint: Endpoint, parameters: [String: String] = [:], authToken: String? = nil) -> URLRequest {
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
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
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
    /// - Parameter id: the id to search for
    /// - Returns: The user object with the associated ID
    func getUserById(id: Int) async throws -> UserResponse {
        let request = createGetRequest(for: UserEndpoint.byId(id: id))
        return try await makeRequest(with: request)
    }
    
    func register(_ firstName: String, _ lastName: String, _ password: String, _ birthDate: Date, _ email: String, _ username: String)
    async throws -> UserResponse {
        let body = UserCreateRequestBody(firstName: firstName, lastName: lastName, email: email, address: "", passwordHash: password,
                                         username: username, birthDate: birthDate)
        let request = createPostRequest(for: UserEndpoint.register, with: body)
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

