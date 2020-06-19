# CardStyleTableView
An extension of UITableView and UITableViewCell which displays a card style view in grouped tableView, similar to the system's tableView before iOS 7.

![Screenshot](Screenshots/Screenshot-1.png "Screenshot-1")

![Screenshot](Screenshots/Screenshot-2.png "Screenshot-2")


## How To Get Started
### Carthage
Specify "CardStyleTableView" in your ```Cartfile```:
```ogdl 
github "teambition/CardStyleTableView"
```

### CocoaPods (version equal or above 0.1.4)

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate features into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'TBCardStyleTableView, '~> 0.1.4'
```

Then, run the following command:

```bash
$ pod install
```

### Usage
####  Import CardStyleTableView
```swift
import CardStyleTableView
```

#### Setup in your ```AppDelegate```
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    CardStyle.setup()
    return true
}
```

#### Assign delegate
```swift
tableView.cardStyleSource = self
```

####  CardStyleTableViewStyleSource
```swift
func roundingCornersForCard(inSection section: Int) -> UIRectCorner {
    // set rounding corners of this section, default is .allCorners
}

func leftPaddingForCardStyleTableView() -> CGFloat {
    // leftPadding
}

func rightPaddingForCardStyleTableView() -> CGFloat {
    // rightPadding
}

func cornerRadiusForCardStyleTableView() -> CGFloat {
    // cornerRadius
}
```

## Minimum Requirement
iOS 8.0

## Release Notes
* [Release Notes](https://github.com/teambition/CardStyleTableView/releases)

## License
CardStyleTableView is released under the MIT license. See [LICENSE](https://github.com/teambition/CardStyleTableView/blob/master/LICENSE.md) for details.

## More Info
Have a question? Please [open an issue](https://github.com/teambition/CardStyleTableView/issues/new)!


