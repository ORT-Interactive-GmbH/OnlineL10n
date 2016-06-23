//
//  CountryController.swift
//  ORT Interactive
//
//  Created by Alexander Vorobjov on 22/01/15.
//  Copyright (c) 2015 Alexander Vorobjov. All rights reserved.
//

public class CountryController: UIViewController {

    // localization manager has to be set before opening view
    public var localizationManager: LocalizationProvider!
    public var hideBackButton = false
    private var previousLanguage: String?
    private var selectedLanguage = ""

    var selectedRow: NSIndexPath? {
        didSet {
            self.selectionChanged(old: oldValue)
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    public var delegate: CountryControllerDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()

        // bundle identifier might be something like org.cocoapods.OnlineL10n when installed through CocoaPods
        let bundleIdentifier = NSBundle(forClass: CountryController.self).bundleIdentifier!
        // set title string here
        self.subscribeToLanguage(self.localizationManager, key: "\(bundleIdentifier).countrycontroller.title")
        // set back button title
        self.backButton.subscribeToLanguage(self.localizationManager, key: "\(bundleIdentifier).countrycontroller.back")
        // set done button title
        self.doneButton.subscribeToLanguage(self.localizationManager, key: "\(bundleIdentifier).countrycontroller.done")
        // keep initial language
        self.previousLanguage = self.localizationManager.currentLanguage()

        doneButton.enabled = false

        selectDefaultRow()
    }

    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // might not need back button
        if self.hideBackButton {
            self.navigationItem.leftBarButtonItem?.enabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clearColor()
        }
    }

    func selectionChanged(old oldSelection: NSIndexPath? = nil) {
        doneButton.enabled = selectedRow != nil

        if let old = oldSelection {
            tableView.cellForRowAtIndexPath(old)?.accessoryType = .None
        }

        if let current = selectedRow {
            tableView.cellForRowAtIndexPath(current)?.accessoryType = .Checkmark
            // select language
            self.selectedLanguage = self.localizationManager.selectLanguageByIndex(selectedRow!.row)
            // notify delegate
            if let del = delegate {
                del.selectedLanguage(self.selectedLanguage)
            }
        }
    }

    func selectDefaultRow() {
        selectedRow = findDefaultRow()

        if let sel = selectedRow {
            tableView.scrollToRowAtIndexPath(sel, atScrollPosition: .Middle, animated: false)
        }
    }

    func findDefaultRow() -> NSIndexPath? {
        if let selectedLocale = self.localizationManager.currentLanguage() {
            let allLocales = self.localizationManager.languages()

            if let index = allLocales.indexOf(selectedLocale) {
                return NSIndexPath(forRow: index, inSection: 0)
            }
        }

        return nil
    }

    @IBAction func onDone() {
        // notify delegate
        if let del = delegate {
            del.onDoneButton(self.previousLanguage, toLanguage: self.selectedLanguage)
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

    @IBAction func onBack() {
        // notify delegate
        if let del = delegate {
            del.onBackButton()
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}

extension CountryController : UITableViewDataSource {
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localizationManager == nil ? 0 : self.localizationManager.languageCount()
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let country = self.localizationManager.languages()[indexPath.row]

        let cell = tableView.dequeueReusableCellWithIdentifier(CountryCellStoryboardId, forIndexPath: indexPath) as! CountryCell

        cell.accessoryType = (indexPath == selectedRow) ? .Checkmark : .None
        cell.labelName.text = country
        cell.layoutMargins = UIEdgeInsetsZero
        if (self.localizationManager.hasFlags()) {
            cell.displayFlag(self.localizationManager.flag(country))
        } else {
            cell.displayFlag(nil)
        }

        return cell
    }
}

extension CountryController : UITableViewDelegate {
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRow = indexPath
    }
}
