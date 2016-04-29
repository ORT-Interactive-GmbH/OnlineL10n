//
//  LocalizationManager.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 26.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import ReactiveCocoa

public let LocalizationManagerUpdateLanguage = "LocalizationManagerUpdateLanguage"
let LocalizationManagerCurrentLanguage = "LocalizationManagerCurrentLanguage"

public class LocalizationManager: NSObject {
    // localizations are all stored in this map
    var localizations: [String: String] = [:]
    // language provider
    var languageProvider: LanguageProvider

    /**
     Initialize localization manager

     - parameter languageProvider: Language provider to fetch language values from
     - parameter defaultLanguage:  Default language to use
     - parameter language:         The language to use. Parameter is optional to override last selected language

     - returns: new instance of instancetype
     */
    public init(languageProvider: LanguageProvider, defaultLanguage: String, language: String?) {
        // set initial language provider
        self.languageProvider = languageProvider
        // initialise super class
        super.init()
        // determine the initial current language
        var selectedLanguage = language
        // get last selected language
        if (selectedLanguage == nil) {
            selectedLanguage = currentLanguage()
            if (selectedLanguage == nil) {
                selectedLanguage = defaultLanguage
            }
        }
        // set default language
        self.selectLanguage(selectedLanguage!)
    }

    /**
     Get current language from user defaults

     - returns: currently selected language or nil
     */
    public func currentLanguage() -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(LocalizationManagerCurrentLanguage)
    }

    /**
     Convenience method to select language by its index

     - parameter index: selected language or country index
     */
    public func selectLanguageByIndex(index: Int) -> String {
        let language = self.languageProvider.languages()[index]
        selectLanguage(language)
        return language
    }

    /**
     Select language and update internal map of language keys

     - parameter lang: selected language or country
     */
    public func selectLanguage(lang: String) {
        guard (self.languageProvider.hasLanguage(lang)) else {
            // TODO: exception?
            return
        }

        // clear localizations
        self.localizations.removeAll()

        // get new values
        for (key, value) in self.languageProvider.languageKeys(lang) {
            // update values in map
            self.localizations[key] = value

            // notify subscribers
            NSNotificationCenter.defaultCenter().postNotificationName(LocalizationManagerUpdateLanguage, object: self, userInfo: [key: value])
        }

        // store language as currently selected language
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(lang, forKey: LocalizationManagerCurrentLanguage)
        userDefaults.synchronize()
    }

    /**
     Get all available languages

     - returns: available language strings
     */
    public func languages() -> [String] {
        return self.languageProvider.languages()
    }

    /**
     Number of available languages

     - returns: number of languages
     */
    public func languageCount() -> Int {
        return self.languageProvider.languages().count
    }

    /**
     Get a single language value for a given key

     - parameter key: name of the key describing a language value

     - returns: localised string
     */
    public func value(key: String) -> String {
        var retVal = self.localizations[key]
        retVal = retVal ?? NSLocalizedString(key, comment: "String for key that has not been localized in language provider")
        return retVal == nil || retVal! == key ? "" : retVal!
    }

    /**
     Check, whether flags are provided by implementation

     - returns: do we support flags?
     */
    public func hasFlags() -> Bool {
        return self.languageProvider.hasFlags()
    }

    /**
     Get the flag for a country/language

     - parameter language: language key

     - returns: flag as data object
     */
    public func flag(language: String) -> NSData? {
        return self.languageProvider.flag(language)
    }

    /**
     Subscribe to changes in language strings

     - parameter object: reference object determining the lifetime of this subscription
     - parameter key:    language key to filter for
     - parameter block:  block that is used to update language values in user interface or model
     */
    public func subscribeToChange(object: AnyObject, key: String, block: ((AnyObject!) -> Void)!) {
        NSNotificationCenter.defaultCenter()
            .rac_addObserverForName(LocalizationManagerUpdateLanguage, object: nil)
            .takeUntil(object.rac_willDeallocSignal())
            .filter({(x: AnyObject!) -> Bool in
                let notification = x as! NSNotification
                return notification.userInfo != nil && notification.userInfo!.indexForKey(key) != nil
            })
            .map({(x: AnyObject!) -> AnyObject in
                let notification = x as! NSNotification
                return notification.userInfo![key]!
            })
            .subscribeNext(block)
    }
}
