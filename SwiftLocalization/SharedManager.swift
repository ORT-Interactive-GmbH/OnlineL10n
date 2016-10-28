//
//  SharedManager.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 28.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import OnlineL10n

class SharedManager {
    static let sharedInstance = LocalizationManager(languageProvider: UILanguageProvider(), defaultLanguage: "Deutschland", language: "Deutschland")

    fileprivate init() {}
}
