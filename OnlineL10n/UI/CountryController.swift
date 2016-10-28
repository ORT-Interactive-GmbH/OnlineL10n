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

    var selectedRow: IndexPath? {
        didSet {
            self.selectionChanged(old: oldValue)
        }
    }

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    public var delegate: CountryControllerDelegate?

    override public func viewDidLoad() {
        // bundle identifier might be something like org.cocoapods.OnlineL10n when installed through CocoaPods
        let bundleIdentifier = Bundle(for: CountryController.self).bundleIdentifier!
        // set title string here
        self.subscribeToLanguage(manager: self.localizationManager, key: "\(bundleIdentifier).countrycontroller.title")
        // set back button title
        self.backButton.subscribeToLanguage(manager: self.localizationManager, key: "\(bundleIdentifier).countrycontroller.back")
        // set done button title
        self.doneButton.subscribeToLanguage(manager: self.localizationManager, key: "\(bundleIdentifier).countrycontroller.done")
        // keep initial language
        self.previousLanguage = self.localizationManager.currentLanguage()

        doneButton.isEnabled = false

        selectDefaultRow()

        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        // might not need back button
        if self.hideBackButton {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
        }
        super.viewWillAppear(animated)
    }

    func selectionChanged(old oldSelection: IndexPath? = nil) {
        doneButton.isEnabled = selectedRow != nil

        if let old = oldSelection {
            tableView.cellForRow(at: old)?.accessoryType = .none
        }

        if let current = selectedRow {
            tableView.cellForRow(at: current)?.accessoryType = .checkmark
            // select language
            self.selectedLanguage = self.localizationManager.selectLanguageBy(index: selectedRow!.row)
            // notify delegate
            if let del = delegate {
                del.selected(language: self.selectedLanguage)
            }
        }
    }

    func selectDefaultRow() {
        selectedRow = findDefaultRow()

        if let sel = selectedRow {
            tableView.scrollToRow(at: sel, at: .middle, animated: false)
        }
    }

    func findDefaultRow() -> IndexPath? {
        if let selectedLocale = self.localizationManager.currentLanguage() {
            let allLocales = self.localizationManager.languages()

            if let index = allLocales.index(of: selectedLocale) {
                return IndexPath(row: index, section: 0)
            }
        }

        return nil
    }

    @IBAction func onDone() {
        // notify delegate
        if let del = delegate {
            del.onDoneButton(fromLanguage: self.previousLanguage, toLanguage: self.selectedLanguage)
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func onBack() {
        // notify delegate
        if let del = delegate {
            del.onBackButton()
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CountryController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localizationManager == nil ? 0 : self.localizationManager.languageCount()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = self.localizationManager.languages()[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCellStoryboardId, for: indexPath) as! CountryCell

        cell.accessoryType = (indexPath == selectedRow) ? .checkmark : .none
        cell.labelName.text = country
        cell.layoutMargins = UIEdgeInsets.zero
        if (self.localizationManager.hasFlags()) {
            cell.display(flag: self.localizationManager.flag(language: country))
        } else {
            cell.display(flag: nil)
        }

        return cell
    }
}

extension CountryController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
    }
}
