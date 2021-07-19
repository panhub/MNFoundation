//
//  MNURLQuery.swift
//  MNFoundation
//
//  Created by 冯盼 on 2021/7/19.
//  链接参数提取

import Foundation
import CoreGraphics

fileprivate class MNQueryPair: NSObject {
    fileprivate var field: String?
    fileprivate var value: String?
    
    fileprivate var queryValue: String? {
        guard let field = field, field.count > 0 else { return nil }
        guard let value = value else { return nil }
        return MNQueryEncoding(field + "=" + value)
    }
}

// 参数提取
public func MNQueryExtract(_ obj: AnyObject?) -> String? {
    
    return MNQueryStringExtract(obj, "&")
}

public func MNQueryStringExtract(_ obj: AnyObject?, _ separator: String) -> String? {
    guard let query = obj else { return nil }
    // 字符串直接编码
    if let string = query as? String {
        return MNQueryEncoding(string)
    }
    // 字典
    if let item = query as? [String: Any] {
        if let pairs = MNQueryPairExtract(item) {
            var result = [String]()
            for pair in pairs {
                if let value = pair.queryValue {
                    result.append(value)
                }
            }
            return result.count > 0 ? result.joined(separator: separator) : nil
        }
    }
    // 拒绝其他类型
    return nil
}

fileprivate func MNQueryPairExtract(_ item: [String: Any]) -> [MNQueryPair]? {
    var pairs = [MNQueryPair]()
    for (key, value) in item {
        let pair = MNQueryPair()
        pair.field = key
        if let string = value as? String {
            pair.value = string
        } else if let number = value as? NSNumber {
            pair.value = number.stringValue
        } else if let v = value as? Double {
            pair.value = NSNumber(value: v).stringValue
        } else if let v = value as? Float {
            pair.value = NSNumber(value: v).stringValue
        } else if let v = value as? Int {
            pair.value = NSNumber(value: v).stringValue
        } else if let v = value as? Bool {
            pair.value = NSNumber(value: v).stringValue
        } else if let v = value as? NSInteger {
            pair.value = NSNumber(value: v).stringValue
        }
        pairs.append(pair)
    }
    return pairs.count > 0 ? pairs : nil
}

// 参数编码
fileprivate let MNQueryEncodBatchLength = 50
fileprivate let MNCharactersGeneralDelimitersToEncode: String = ":#[]@"
fileprivate let MNCharactersSubDelimitersToEncode: String = "!$&'()*+,;="
public func MNQueryEncoding(_ query: String) -> String {
    guard query.count > 0 else { return "" }
    // 利用NSString遍历编码
    let string = query as NSString
    // 定义编码通用字符
    var allowedCharacterSet = NSCharacterSet.urlQueryAllowed
    allowedCharacterSet.remove(charactersIn: MNCharactersGeneralDelimitersToEncode + MNCharactersSubDelimitersToEncode)
    // 分段编码
    var index: Int = 0
    var result: String = ""
    while index < query.count {
        let length = min(query.count - index, MNQueryEncodBatchLength)
        var range = NSRange(location: index, length: length)
        // 避免表情分割
        range = string.rangeOfComposedCharacterSequences(for: range)
        guard let sub = string.substring(with: range).addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) else { return "" }
        result.append(sub)
        index += range.length
    }
    return result
}

