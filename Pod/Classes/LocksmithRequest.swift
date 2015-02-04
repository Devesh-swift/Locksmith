//
//  LocksmithRequest.swift
//
//  Created by Matthew Palmer on 26/10/2014.
//  Copyright (c) 2014 Colour Coding. All rights reserved.
//

import UIKit
import Security

public enum SecurityClass: Int {
    case GenericPassword, InternetPassword, Certificate, Key, Identity
}

public enum MatchLimit: Int {
    case One, Many
}

public enum RequestType: Int {
    case Create, Read, Update, Delete
}

public enum Accessible: Int {
    case WhenUnlock, AfterFirstUnlock, Always, WhenPasscodeSetThisDeviceOnly,
    WhenUnlockedThisDeviceOnly, AfterFirstUnlockThisDeviceOnly, AlwaysThisDeviceOnly
    
    /*
var kSecAttrAccessibleWhenUnlocked: CFStringRef

@availability(iOS, introduced=4.0)
var kSecAttrAccessibleAfterFirstUnlock: CFStringRef

@availability(iOS, introduced=4.0)
var kSecAttrAccessibleAlways: CFStringRef

@availability(iOS, introduced=8.0)
var kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly: CFStringRef

@availability(iOS, introduced=4.0)
var kSecAttrAccessibleWhenUnlockedThisDeviceOnly: CFStringRef

@availability(iOS, introduced=4.0)
var kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly: CFStringRef

@availability(iOS, introduced=4.0)
var kSecAttrAccessibleAlwaysThisDeviceOnly: CFStringRef
*/
}

public class LocksmithRequest: NSObject, DebugPrintable {
    // Keychain Options
    // Required
    var service: String = NSBundle.mainBundle().infoDictionary![kCFBundleIdentifierKey] as String // Default to Bundle Identifier
    var userAccount: String
    var type: RequestType = .Read  // Default to non-destructive
    
    // Optional
    var securityClass: SecurityClass = .GenericPassword  // Default to password lookup
    var group: String?
    var data: NSDictionary?
    var matchLimit: MatchLimit = .One
    var synchronizable = false
    var accessible: Accessible?
    
    // Debugging
    override public var debugDescription: String {
        return "service: \(self.service), type: \(self.type.rawValue), userAccount: \(self.userAccount)"
    }
    
    required public init(userAccount: String, service: String = LocksmithDefaultService) {
        self.service = service
        self.userAccount = userAccount
    }
    
    convenience init(userAccount: String, requestType: RequestType, service: String = LocksmithDefaultService) {
        self.init(userAccount: userAccount, service: service)
        self.type = requestType
    }
    
    convenience init(userAccount: String, requestType: RequestType, data: NSDictionary, service: String = LocksmithDefaultService) {
        self.init(userAccount: userAccount, requestType: requestType, service: service)
        self.data = data
    }
}