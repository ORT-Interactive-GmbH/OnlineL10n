//
//  CountryControllerDelegate.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 29.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation

@objc public protocol CountryControllerDelegate {
    // implement navigation for back button here
    func onBackButton()
    // implement navigation for done button here
    func onDoneButton(fromLanguage: String?, toLanguage: String)
    // you might want to know, which language is selected
    func selectedLanguage(lang: String)
}
