//
//  DataController.swift
//  tracker
//
//  Created by Marco on 22/03/17.
//

import Foundation
import AFNetworking

enum enumMethodType {
    case GET
    case POST
}

enum DataManagerError: Error {
    case noUrl
    case noDataInResponse
    case noSerializableData
}

extension DataManagerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noUrl:
            return NSLocalizedString("The url is not valid", comment: "")
        case .noDataInResponse:
            return NSLocalizedString("No data in the response", comment: "")
        case .noSerializableData:
            return NSLocalizedString("The data couldn't be serialized", comment: "")
        }
    }
}

class DataManager {
    
    private class func getManager(_ timeOut: TimeInterval) -> AFHTTPSessionManager {
        let manager = AFHTTPSessionManager()
        #if DEBUG
            manager.securityPolicy = .init(pinningMode: .none)
            manager.securityPolicy.validatesDomainName = false
            manager.securityPolicy.allowInvalidCertificates = true
        #endif
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = timeOut
        
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json"]
        
        return manager
    }
    
    func request<T: Decodable>(method: enumMethodType, url: String, parameters: [String: Any?]? = nil, type: T.Type, _ progress: ((Progress) -> Void)? = nil, _ successBlock: @escaping (_ response: Any?) -> Void, _ errorBlock: @escaping (_ errorType: Error) -> Void, timeOut: Double = 60.0) {
        
        if method == enumMethodType.GET {
            get(url: url, parameters: parameters, type: type, progress, successBlock, errorBlock, timeOut: timeOut)
        } else {
            post(url: url, parameters: parameters, type: type, progress, successBlock, errorBlock, timeOut: timeOut)
        }
    }
    
    private func get<T:Decodable>(url: String, parameters: [String: Any?]? = nil, type: T.Type, _ progress: ((Progress) -> Void)? = nil, _ successBlock: @escaping (_ response: Any?) -> Void, _ errorBlock: @escaping (_ errorType: Error) -> Void, timeOut: Double = 60.0) {
        
        let manager = DataManager.getManager(timeOut)
        let headers = ["Content-Type": "application/json"]
        
        manager.get(url, parameters: parameters, headers: headers, progress: progress) { (task, response) in
            
            #if DEBUG
            print("POST: ", url, "\nParams: ", parameters?.description ?? "", "\nResponse: ", response ?? "")
            #endif
            
            guard let response = response else {
                errorBlock(DataManagerError.noDataInResponse)
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let obj = try JSONDecoder().decode(type, from: data)
                successBlock(obj)
            } catch {
                errorBlock(DataManagerError.noSerializableData)
            }
            
        } failure: { (task, error) in
            errorBlock(error)
        }
    }
    
    private func post<T:Decodable>(url: String, parameters: [String: Any?]? = nil, type: T.Type, _ progress: ((Progress) -> Void)? = nil, _ successBlock: @escaping (_ response: Any?) -> Void, _ errorBlock: @escaping (_ errorType: Error) -> Void, timeOut: Double = 60.0) {
        
        let manager = DataManager.getManager(timeOut)
        let headers = ["Content-Type": "application/json"]
        
        manager.post(url, parameters: parameters, headers: headers, progress: progress, success: { (task, response) in
            
            #if DEBUG
            print("POST: ", url, "\nParams: ", parameters?.description ?? "", "\nResponse: ", response ?? "")
            #endif
            
            guard let response = response as? [String: Any?] else {
                errorBlock(DataManagerError.noDataInResponse)
                return
            }
            
            do {
                let data = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                let obj = try JSONDecoder().decode(type, from: data)
                successBlock(obj)
            } catch {
                errorBlock(DataManagerError.noSerializableData)
            }
            
        }) { (task, error) in
            errorBlock(error)
        }
    }
}


