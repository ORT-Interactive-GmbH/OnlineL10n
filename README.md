OnlineL10n - an online localization library written in Swift
------------------------------------------------------------
The OnlineL10n library uses data binding technologies to bind interface elements to localization variables. All you have to do is implement a simple language provider protocol and bind your interface elements by key. When languages are switched, the databinding mechanism automatically switches all text elements.

If you need an example, simply clone the library and run the application in simulator. An example language switching interface is part of the library and can be included via storyboard reference.

Data binding is implemented using [ReactiveObjC][3] library. So even if you _don't_ need online localization, at least you have a miniature example for how to use data binding with [ReactiveObjC][3] :wink:

Info:
v0.3.1 -> v0.3.2 -> updated from SWIFT 3 to 5

## Installation

The recommended approach for installing OnlineL10n is via the [CocoaPods][4] package manager, as it provides flexible dependency management and dead simple installation.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project, and Create and Edit your Podfile and add RestKit:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
platform :ios, '10.0'

pod 'OnlineL10n'
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

## Examples
You might want to implement a shared LocalizationManager like this:
``` Swift
import OnlineL10n

class SharedManager {
    static let sharedInstance = LocalizationManager(languageProvider: UILanguageProvider(), defaultLanguage: "de", language: "de")

    private init() {}
}
```

And provide your own class implementing the `LanguageProvider` protocol, like the `UILanguageProvider` in the example below:
``` Swift
import OnlineL10n

class UILanguageProvider: LanguageProvider {
	// get languages
    func languages() -> [String] {
        return ["de", "en"]
    }

    // get all language keys for one specified language
    func languageKeys(language: String) -> [String : String] {
        if language == "de" {
            return ["top_label" : "Top Label Text auf Deutsch", "button" : "Ein Knopf"]
        } else {
            return ["top_label" : "Top label text in English", "button" : "A button"]
        }
    }

    // check for one specified language
    func has(language: String) -> Bool {
        return language == "de" || language == "en"
    }

    // do we provide flags for countries?
    func hasFlags() -> Bool {
        return true
    }

    // provide a flag for a country/language
    func flag(language: String) -> Data? {
        if (language == "de") {
            return UIImagePNGRepresentation(UIImage(named: "Germany")!)
        } else {
            return UIImagePNGRepresentation(UIImage(named: "England")!)
        }
    }
}
```

Bind your interface elements like this:
``` Swift
// bind to language keys
self.labelTop.subscribeToLanguage(self, manager: SharedManager.sharedInstance, key: "top_label")
```
## Credits

Example flag icons taken from [icondrawer][1].

## License :
  
The code is available as github [project][home] under [MIT licence][2].
  
   [home]: https://github.com/ORT-Interactive-GmbH/OnlineL10n
   [1]: http://www.icondrawer.com
   [2]: http://revolunet.mit-license.org
   [3]: https://github.com/ReactiveCocoa/ReactiveObjC
   [4]: http://cocoapods.org
