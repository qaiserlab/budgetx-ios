import Foundation
import Alamofire

class Auth {
    static let shared = Auth()
    
    private let baseURL = "https://lemur-8.cloud-iam.com"
    private let accessTokenKey = "AccessKey"
    
    private let adminUsername = "admin"
    private let adminPassword = "rahasia"
    
    private var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    private var username: String? {
        get {
            return UserDefaults.standard.string(forKey: "\(accessTokenKey)_username")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "\(accessTokenKey)_username")
        }
    }
    
    private init() {
        if let storedAccessToken = UserDefaults.standard.string(forKey: accessTokenKey) {
            self.accessToken = storedAccessToken
        }
        
        if let storedUsername = UserDefaults.standard.string(forKey: "\(accessTokenKey)_username") {
            self.accessToken = storedUsername
        }
    }
    
    func isLoggedIn() -> Bool {
        return accessToken != nil
    }
    
    func getUsername() -> String? {
        return username
    }
    
    func login(username: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
                let loginUrl = "\(baseURL)/auth/realms/dev-keycloak/protocol/openid-connect/token"
                let parameters: [String: Any] = [
                    "grant_type": "password",
                    "client_id": "be-sso-client",
                    "client_secret": "Ggv9XsZhsNeqp0niZHIHgcyyDWaZL5J8",
                    "scope": "openid",
                    "username": username,
                    "password": password
                ]
        
                AF.request(loginUrl, method: .post, parameters: parameters)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: TokenResponse.self) { response in
                        switch response.result {
                        case .success(let tokenResponse):
                            self.accessToken = tokenResponse.accessToken
                            self.username = username
                            completion(.success(()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: "\(accessTokenKey)_username")
        accessToken = nil
        username = nil
    }
    
    func register(username: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        login(username: adminUsername, password: adminPassword) { result in
            switch result {
            case .success:
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(self.accessToken)",
                    "Content-Type": "application/json"
                ]
                let registerUrl = "\(self.baseURL)/auth/admin/realms/dev-keycloak/users"
                let parameters: [String: Any] = [
                    "username": username,
                    "email": email,
                    "enabled": true,
                    "emailVerified": true,
                    "credentials": [
                        "temporary": false,
                        "type": "password",
                        "value": password
                    ]
                ]
        
                AF.request(registerUrl, method: .post, parameters: parameters, headers: headers)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: TokenResponse.self) { response in
                        switch response.result {
                        case .success(let tokenResponse):
                            completion(.success(()))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            case .failure(let error):
                print("Login error: \(error)")
            }
        }
    }
 }

struct TokenResponse: Decodable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}
