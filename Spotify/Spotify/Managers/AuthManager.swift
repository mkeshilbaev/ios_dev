//
//  AuthManager.swift
//  Spotify
//
//  Created by Madi Keshilbayev on 29.01.2022.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants{
        static let clientID = "e970f9b535034b05832850e2f5845a78"
        static let clientSecret = "a003308d16374a95be7b81e85f35eac6"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let redirectURI = "https://kbtu.kz/"
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String?{
        return nil
    }
    
    private var refreshToken: String?{
        return nil
    }
    
    private var tokenExpirationDate: Date?{
        return nil
    }
    
    private var shouldRefreshToken: Bool{
        return false
    }
    
    public func exchangeCodeForToken(
        code: String,
        completion: @escaping ((Bool) -> Void)
    ){
        // Get token
    }
    
//    public func refreshToken(){
//
//    }
//
//    private func cacheToken(){
//
//    }
    
    
    
}
