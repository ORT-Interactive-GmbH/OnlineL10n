//
//  LocalizationManager.swift
//  OnlineL18N
//
//  Created by Sebastian Westemeyer on 26.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import ReactiveObjC

let LocalizationManagerCurrentLanguage = "LocalizationManagerCurrentLanguage"

extension Notification.Name {
    static let localizationManagerUpdateLanguage = Notification.Name("LocalizationManagerUpdateLanguage")
}

public class LocalizationManager: NSObject, LocalizationProvider {
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
        self.select(language: selectedLanguage!)
    }

    /**
     Get current language from user defaults

     - returns: currently selected language or nil
     */
    public func currentLanguage() -> String? {
        return UserDefaults.standard.string(forKey: LocalizationManagerCurrentLanguage)
    }

    /**
     Convenience method to select language by its index

     - parameter index: selected language or country index
     */
    public func selectLanguageBy(index: Int) -> String {
        let language = self.languageProvider.languages()[index]
        select(language: language)
        return language
    }

    /**
     Select language and update internal map of language keys

     - parameter language: selected language or country
     */
    public func select(language: String) {
        guard (self.languageProvider.has(language: language)) else {
            // TODO: exception?
            return
        }

        // clear localizations
        self.localizations.removeAll()

        // get new values
        for (key, value) in self.languageProvider.languageKeys(language: language) {
            // update values in map
            self.localizations[key] = value
        }

        // send notifications after all values have been cached
        for (key, value) in self.localizations {
            let postVal = defaultValue(key: key, val: value)
            // notify subscribers
            NotificationCenter.default.post(name: .localizationManagerUpdateLanguage, object: self, userInfo: [key: postVal])
        }

        // store language as currently selected language
        let userDefaults = UserDefaults.standard
        userDefaults.set(language, forKey: LocalizationManagerCurrentLanguage)
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
        return defaultValue(key: key, val: self.localizations[key])
    }

    private func defaultValue(key: String, val: String?) -> String {
        var retVal = val
        if retVal == nil || retVal! == key {
           retVal = NSLocalizedString(key, comment: "String for key that has not been localized in language provider")
        }
        return retVal ?? ""
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
    public func flag(language: String) -> Data? {
        return self.languageProvider.flag(language: language)
    }

    /**
     Subscribe to changes in language strings

     - parameter object: reference object determining the lifetime of this subscription
     - parameter key:    language key to filter for
     - parameter block:  block that is used to update language values in user interface or model
     */
    public func subscribeToChange(object: AnyObject, key: String, block: ((Any?) -> Void)!) {
        NotificationCenter.default
            .rac_addObserver(forName: Notification.Name.localizationManagerUpdateLanguage.rawValue, object: nil)
            .take(until: object.rac_willDeallocSignal())
            .filter({(x: Any?) -> Bool in
                let notification = x as! NSNotification
                return notification.userInfo != nil && notification.userInfo!.index(forKey: key) != nil
            })
            .map({(x: Any?) -> Any? in
                let notification = x as! NSNotification
                return notification.userInfo![key]!
            })
            .subscribeNext(block)
    }
}
