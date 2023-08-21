//
//  AsyncUtility.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import Foundation
import FirebaseAuth

enum urlMethod : String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

final class asyncUtility {
    
    
    @Published var error : Error?
   
    static let shared = asyncUtility()
    
    private init(){}
    
    @MainActor
    func fetchDataAsync<R:Encodable,T:Decodable>(url Url : URL? , method Method : urlMethod,requestBody: R?, resultType:T.Type, completionHandler:@escaping(_ result: T? , _ loading : Bool) -> Void ) async throws {
        
        do{
            guard let url = Url else {
                _ = completionHandler(nil , false)
                throw ErrorModel.invalidURL
            }
            
            
            var request = URLRequest(url: url)
            
            request.httpMethod = Method.rawValue
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if Method.rawValue != "GET" {
                request.httpBody = try? JSONEncoder().encode(requestBody.self)
            }
            
            let sessionConfig = URLSessionConfiguration.default
            
                        
            let session = URLSession(configuration: sessionConfig, delegate: self as? URLSessionDelegate, delegateQueue: nil)
            //            let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            let (data , response) = try await session.data(for: request)
            
            print((response as? HTTPURLResponse)?.statusCode ?? 0)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 || (response as? HTTPURLResponse)?.statusCode == 201 else {
                _ = completionHandler(nil , false)
                throw ErrorModel.serverError
                
            }
            
            guard let Data = try? JSONDecoder().decode(resultType.self , from: data) else {
                _ = completionHandler(nil , false)
                throw ErrorModel.invalidData
            }
            _ = completionHandler(Data , false)


            
        }catch{
            _ = completionHandler(nil , false)
            self.error = error
        }
    }
    
    func loadData<R:Encodable,T:Decodable>(url Url : URL? , method Method : urlMethod,requestBody: R?, resultType:T.Type, completionHandler:@escaping(_ result: T? , _ loading : Bool) -> Void){
        
        Task(priority: .medium) {
            try await fetchDataAsync(url: Url, method: Method, requestBody: requestBody, resultType: resultType, completionHandler: { result , load in
                _ = completionHandler(result , load)
            })
        }
    }
    
   
}


class AppViewModel : ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false

    var isSignedIn : Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email : String , password : String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil , error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func signUp(email : String , password : String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            guard result != nil , error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        
        self.signedIn = false
    }
}
