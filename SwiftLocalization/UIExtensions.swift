//
//  UIExtensions.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 28.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation

import UIKit

extension UILabel {
    public func subscribeToLanguage(_ key: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key)
    }
}

extension UITextField {
    public func subscribeToLanguage(_ key: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key)
    }

    public func subscribeToLanguagePlaceholder(_ placeholder: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, placeholder: placeholder)
    }
}

extension UITextView {
    public func subscribeToLanguage(_ key: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key)
    }
}

extension UIButton {
    public func subscribeToLanguage(_ key: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key)
    }
}

extension UISegmentedControl {
    public func subscribeToLanguage(_ key: String, index: Int) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key, index: index)
    }
}

extension UIViewController {
    public func subscribeToLanguage(_ key: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key)
    }
}

extension UIBarButtonItem {
    public func subscribeToLanguage(_ key: String) {
        self.subscribeToLanguage(manager: SharedManager.sharedInstance, key: key)
    }
}
