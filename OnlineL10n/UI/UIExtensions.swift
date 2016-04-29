//
//  UIExtensions.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 27.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.text = x as? String
        })
        self.text = manager.value(key)
    }
}

extension UITextField {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.text = x as? String
        })
        self.text = manager.value(key)
    }

    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, placeholder: String) {
        manager.subscribeToChange(object, key: placeholder, block: { (x: AnyObject!) in
            self.placeholder = x as? String
        })
        self.placeholder = manager.value(placeholder)
    }
}

extension UITextView {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.text = x as? String
        })
        self.text = manager.value(key)
    }
}

extension UIButton {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.setTitle(x as? String, forState: .Normal)
        })
        self.setTitle(manager.value(key), forState: .Normal)
    }
}

extension UISegmentedControl {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String, index: Int) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.setTitle(x as? String, forSegmentAtIndex: index)
        })
        self.setTitle(manager.value(key), forSegmentAtIndex: index)
    }
}

extension UIViewController {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.title = x as? String
        })
        self.title = manager.value(key)
    }
}

extension UIBarButtonItem {
    public func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.title = x as? String
        })
        self.title = manager.value(key)
    }
}
