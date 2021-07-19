//
//  MNURLRequestSerializer.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/19.
//  请求序列化

import UIKit
import Foundation

public class MNURLRequestSerializer: NSObject {
    /** 是否允许使用蜂窝网络*/
    public var allowsCellularAccess: Bool = true
    /** 超时时长*/
    public var timeoutInterval: TimeInterval = 10.0
    /** 字符串编码格式*/
    public var stringEncoding: String.Encoding = .utf8
    /** 上传内容的分割标记*/
    public var boundary: String = MNNet.BoundaryName
    /**数据体*/
    public var body: Codable?
    /**请求地址参数拼接 支持 String, [String: Any]*/
    public var query: AnyObject?
    /**缓存策略*/
    public var cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    /**Header信息*/
    public var headerFields: [String: String]?
    /**服务端认证信息*/
    public var authFields: [String: String]?
    
    
    public func request(_ url: String!, _ method: MNNet.RequestMethod) throws -> URLRequest? {
        // 检查链接
        guard url != nil, url.count > 0 else { throw MNNet.NetError.badUrl }
        // 检查链接
        guard url != nil, url.count > 0 else { throw MNNet.NetError.badUrl }
        // 拼接参数并编码
        guard let str = query(url) else { throw MNNet.NetError.badUrl }
        // 拼接参数并编码
        guard let URL = URL(string: str) else { throw MNNet.NetError.badUrl }
        // 创建请求体
        var request = URLRequest(url: URL)
        request.cachePolicy = cachePolicy
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval
        request.allowsCellularAccess = allowsCellularAccess
        request.allHTTPHeaderFields = headerFields
        // 添加认证信息
        if let header = authFields, header.count > 0 {
            if let (username, password) = header.first {
                if let data = (username + ":" + password).data(using: stringEncoding) {
                    request.setValue(data.base64EncodedString(), forHTTPHeaderField: "Authorization")
                }
            }
        }
        // 添加数据体
        if method == .post, let body = body {
            let data: Data? = body is Data ? (body as? Data) : MNQueryExtract(body as AnyObject)?.data(using: stringEncoding)
            if let httpBody = data, httpBody.count > 0 {
                request.httpBody = httpBody
                if request.value(forHTTPHeaderField: "Content-Type") == nil {
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                }
            } else { throw MNNet.NetError.bodyError }
            //
        }
        return request
    }
    
    // url编码
    private func query(_ url: String) -> String? {
        // 链接编码
        var string: String? = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        guard let _ = string else { return nil }
        // 参数编码
        guard let query = MNQueryExtract(query) else { return string }
        // 拼接参数
        string?.append((query.contains("?") ? "&" : "?"))
        string?.append(query)
        return string
    }
    
}




