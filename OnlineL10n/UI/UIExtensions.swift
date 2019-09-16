//
//  UIExtensions.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 27.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import UIKit

@objc extension UILabel {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.text = x as? String
        })
        self.text = manager.value(key: key)
    }
}

@objc extension UITextField {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.text = x as? String
        })
        self.text = manager.value(key: key)
    }
    
    public func subscribeToLanguage(manager: LocalizationProvider, placeholder: String) {
        manager.subscribeToChange(object: self, key: placeholder, block: { (x: Any?) in
            self.placeholder = x as? String
        })
        self.placeholder = manager.value(key: placeholder)
    }
}

@objc extension UITextView {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.text = x as? String
        })
        self.text = manager.value(key: key)
    }
}

@objc extension UIButton {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.setTitle(x as? String, for: .normal)
        })
        self.setTitle(manager.value(key: key), for: .normal)
    }
}

@objc extension UISegmentedControl {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String, index: Int) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.setTitle(x as? String, forSegmentAt: index)
        })
        self.setTitle(manager.value(key: key), forSegmentAt: index)
    }
}

@objc extension UIViewController {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.title = x as? String
        })
        self.title = manager.value(key: key)
    }
}

@objc extension UIBarButtonItem {
    public func subscribeToLanguage(manager: LocalizationProvider, key: String) {
        manager.subscribeToChange(object: self, key: key, block: { (x: Any?) in
            self.title = x as? String
        })
        self.title = manager.value(key: key)
    }
}
