//
//  MNNetworking.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/19.
//

import Foundation


public class MNNet: NSObject {
    
}

public extension MNNet {
    
    /**请求方法*/
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case head = "HEAD"
        case delete = "DELETE"
    }
    
    /**错误信息*/
    enum NetError: Error {
        case unknown
        case badUrl
        case badMethod
        case dataError
        case message(String)
        
        var description: String {
            switch self {
            case .unknown:
                return "发生未知错误"
            case .badUrl:
                return "链接错误"
            case .badMethod:
                return "请求方法错误"
            case .dataError:
                return "发生未知错误"
            case .message(let msg):
                return msg
            default:
                return "发生未知错误"
            }
        }
        
        
    }
}
