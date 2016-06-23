//
//  ViewController.swift
//  SwiftLocalization
//
//  Created by Sebastian Westemeyer on 27.04.16.
//  Copyright © 2016 ORT Interactive. All rights reserved.
//

import UIKit
import OnlineL10n

class ViewController: UIViewController {

    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textFieldPlaceholder: UITextField!

    var manager: LocalizationManager?

    override func viewDidLoad() {
        // call super implementation
        super.viewDidLoad()
        // create new localization manager
        self.manager = SharedManager.sharedInstance

        // bind to language keys
        self.labelTop.subscribeToLanguage("top_label")
        self.labelContent.subscribeToLanguage("content_label")
        self.button.subscribeToLanguage("button")
        self.textField.subscribeToLanguage("text_field")
        self.textView.subscribeToLanguage("text_view")
        self.segmentedControl.subscribeToLanguage("segment_0", index: 0)
        self.segmentedControl.subscribeToLanguage("segment_1", index: 1)
        self.textFieldPlaceholder.subscribeToLanguagePlaceholder("placeholder")
    }

    @IBAction func onToggleSegmentedControl(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            self.manager?.selectLanguage("England")
        default:
            self.manager?.selectLanguage("Deutschland")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if ( segue.identifier == "showcountries" ) {
            let controller = segue.destinationViewController as! CountryController
            controller.hideBackButton = true
            controller.localizationManager = self.manager
        }
    }
}
