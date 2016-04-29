//
//  LanguageProvider.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 26.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation

@objc public protocol LanguageProvider {
    // get languages
    func languages() -> [String]
    // get all language keys for one specified language
    func languageKeys(language: String) -> [String: String]
    // check for one specified language
    func hasLanguage(language: String) -> Bool
    // do we provide flags for countries?
    func hasFlags() -> Bool
    // provide a flag for a country/language
    func flag(language: String) -> NSData?
}
