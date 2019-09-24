//
//  Localization.swift
//  ConcurrencyTest
//

import Foundation

public enum ConstantString:String{
    case loadingMessage = "loadingMessage"
    case timeoutMessage = "timeoutMessage"
    
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
