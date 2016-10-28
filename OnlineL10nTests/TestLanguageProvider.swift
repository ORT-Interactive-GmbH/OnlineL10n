//
//  TestLanguageProvider.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 26.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import OnlineL10n

class TestLanguageProvider: LanguageProvider {
    // get languages
    @objc func languages() -> [String] {
        return ["Deutschland", "England"]
    }

    // check for one specified language
    @objc func has(language: String) -> Bool {
        return true
    }

    // get all language keys for one specified language
    @objc func languageKeys(language: String) -> [String: String] {
        if (language == "Deutschland") {
            return [ "a" : "b", "c" : "d" ]
        } else {
            return [ "a" : "e", "c" : "f" ]
        }
    }

    // do we provide flags for countries?
    @objc func hasFlags() -> Bool {
        return false
    }

    // no flags are provided
    @objc func flag(language: String) -> Data? {
        return nil
    }
}
