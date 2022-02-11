//
//  String+Extension.swift
//  SeSac_Friends
//
//  Created by 이주경 on 2022/01/23.
//

import UIKit

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1) // '+1'이 있는 이유: endIndex는 문자열의 마지막 그 다음을 가리키기 때문
        
        return String(self[startIndex ..< endIndex])
    }
}



extension String {
    func pretty() -> String {
        
        let _str = self.replacingOccurrences(of: "-", with: "")
        
        let arr = Array(_str)
        
        if arr.count > 3 {
            
            let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
            
            if prefix == "02" {
                
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    
                    return modString
                }
            } else if prefix == "15" || prefix == "16" || prefix == "18" {
                
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2")
                    
                    return modString
                    
                }
                
            } else {
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) { let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    
                    return modString
                }
            }
        }
        
        return self
    }
}



// 출처: https://me.innori.com/2679 [LIFE NOTE]
