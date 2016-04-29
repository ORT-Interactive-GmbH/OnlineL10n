//
//  TestObject.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 27.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import OnlineL10n

class TestObject {
    var text: String

    init() {
        self.text = String()
    }
}

extension TestObject {
     func subscribeToLanguage(object: AnyObject, manager: LocalizationManager, key: String) {
        manager.subscribeToChange(object, key: key, block: { (x: AnyObject!) in
            self.text = x as! String
        })
        self.text = manager.valueForKey(key)
    }
}
