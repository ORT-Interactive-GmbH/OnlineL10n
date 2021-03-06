//
//  UILanguageProvider.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 27.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import Foundation
import OnlineL10n

class UILanguageProvider: LanguageProvider {
    @objc func languages() -> [String] {
        return ["Deutschland", "England"]
    }

    @objc func languageKeys(language: String) -> [String : String] {
        if language == "Deutschland" {
            return ["top_label" : "Top Label Text auf Deutsch", "button" : "Ein Knopf", "text_field" : "Ein tolles Eingabefeld", "text_view" : "Eine mehrzeilige Text-Ansicht nicht\nbesonders\ndoll befüllt.", "segment_0" : "Deutsch", "segment_1" : "Englisch", "placeholder" : "Platzhaltertext", "de.ortinteractive.OnlineL10n.countrycontroller.title" : "Länderauswahl", "de.ortinteractive.OnlineL10n.countrycontroller.back" : "Zurück", "de.ortinteractive.OnlineL10n.countrycontroller.done" : "Fertig"]
        } else {
            return ["top_label" : "top_label", "button" : "A button", "text_field" : "a beautiful text field", "text_view" : "a multi-line text view which is\nnot\nentirely\nfilled.", "segment_0" : "German", "segment_1" : "English", "placeholder" : "placeholdertext", "de.ortinteractive.OnlineL10n.countrycontroller.title" : "Select country", "de.ortinteractive.OnlineL10n.countrycontroller.back" : "back", "de.ortinteractive.OnlineL10n.countrycontroller.done" : "Done"]
        }
    }

    @objc func has(language: String) -> Bool {
        return language == "Deutschland" || language == "England"
    }

    // do we provide flags for countries?
    @objc func hasFlags() -> Bool {
        return true
    }

    @objc func flag(language: String) -> Data? {
        if (language == "Deutschland") {
            return UIImage(named: "Germany")!.pngData()
        } else {
            return UIImage(named: "England")!.pngData()
        }
    }

    @objc func flag(language: String, callback: (_ language: String, _ image: Data) -> Void) {
    }
}
