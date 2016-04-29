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
        self.labelTop.subscribeToLanguage(self, key: "top_label")
        self.labelContent.subscribeToLanguage(self, key: "content_label")
        self.button.subscribeToLanguage(self, key: "button")
        self.textField.subscribeToLanguage(self, key: "text_field")
        self.textView.subscribeToLanguage(self, key: "text_view")
        self.segmentedControl.subscribeToLanguage(self, key: "segment_0", index: 0)
        self.segmentedControl.subscribeToLanguage(self, key: "segment_1", index: 1)
        self.textFieldPlaceholder.subscribeToLanguage(self, placeholder: "placeholder")
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
            controller.localizationManager = self.manager
        }

    }
}
