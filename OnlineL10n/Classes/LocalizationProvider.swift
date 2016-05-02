//
//  LocalizationProvider.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 29.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation

@objc public protocol LocalizationProvider {
    /**
     Get current language from user defaults

     - returns: currently selected language or nil
     */
    func currentLanguage() -> String?

    /**
     Convenience method to select language by its index

     - parameter index: selected language or country index
     */
    func selectLanguageByIndex(index: Int) -> String

    /**
     Select language and update internal map of language keys

     - parameter lang: selected language or country
     */
    func selectLanguage(lang: String)

    /**
     Get all available languages

     - returns: available language strings
     */
    func languages() -> [String]

    /**
     Number of available languages

     - returns: number of languages
     */
    func languageCount() -> Int

    /**
     Get a single language value for a given key

     - parameter key: name of the key describing a language value

     - returns: localised string
     */
    func value(key: String) -> String

    /**
     Check, whether flags are provided by implementation

     - returns: do we support flags?
     */
    func hasFlags() -> Bool

    /**
     Get the flag for a country/language

     - parameter language: language key

     - returns: flag as data object
     */
    func flag(language: String) -> NSData?

    /**
     Subscribe to changes in language strings

     - parameter object: reference object determining the lifetime of this subscription
     - parameter key:    language key to filter for
     - parameter block:  block that is used to update language values in user interface or model
     */
    func subscribeToChange(object: AnyObject, key: String, block: ((AnyObject!) -> Void)!)
}
