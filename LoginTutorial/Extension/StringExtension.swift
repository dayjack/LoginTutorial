//
//  StringExtension.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/20.
//

import Foundation

extension String {
    
    enum pwdCase {
        case noUpper
        case noNumber
        case lessCount
        case none
    }
    
    func checkCanbePwd() -> pwdCase {
        
        if !checkUpper() {
            return .noUpper
        }
        if !checkNumber() {
            return .noNumber
        }
        if self.count < 4 {
            return .lessCount
        }
        return .none
    }
    
    func checkUpper() -> Bool {
        
        var bool: Bool = false
        self.forEach {
            if $0.isUppercase { bool = true }
        }
        return bool
    }
    
    func checkNumber() -> Bool {
        
        var bool: Bool = false
        self.forEach {
            if $0.isNumber { bool = true }
        }
        return bool
    }
}
