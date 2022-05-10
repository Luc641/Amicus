//
//  KeychainHelper.swift
//  Amicus_Frontend
//
//  Created by Nils Theres on 04.05.22.
//

import Foundation


/// Internal keychain helper to facilitate communcation between authenticated services and the frontend model.
final class KeychainHelper {
    // Singleton class
    static let standard = KeychainHelper()
    private init() {}
    
    /// Saves and encrypts data to the internal device keychain.
    /// - Parameters:
    ///   - data: the data to save
    ///   - service: the service type of the primary key
    ///   - account: the account that is being saved
    func save(_ data: Data, service: String, account: String) {
        
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        if SecItemAdd(query, nil) == errSecDuplicateItem {
            // Update the item, if it exists already.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    
    
    /// Reads encrypted data from the internal device keychain.
    /// - Parameters:
    ///   - service: the service type of the data
    ///   - account: the account that should be retrieved
    /// - Returns: The stored data or nil
    func read(service: String, account: String) -> Data? {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return result as? Data
    }
    
    func delete(service: String, account: String) {
        
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}

extension KeychainHelper {
    /// Saves and encrypts data to the internal device keychain.
    /// - Parameters:
    ///   - data: the data to save
    ///   - service: the service type of the primary key
    ///   - account: the account that is being saved
    func save<T>(_ item: T, service: String, account: String) where T : Codable {
        
        do {
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            assertionFailure("Failed to encode item for keychain: \(error)")
        }
    }
    
    /// Reads encrypted data from the internal device keychain.
    /// - Parameters:
    ///   - service: the service type of the data
    ///   - account: the account that should be retrieved
    /// - Returns: The stored data or nil
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable {
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            assertionFailure("Fail to decode item for keychain: \(error)")
            return nil
        }
    }
    
    func readAmicusToken() -> String? {
        return read(service: "token", account: "amicus", type: ApiToken.self)?.accessToken
    }
}
