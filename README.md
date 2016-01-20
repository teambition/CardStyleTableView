#CardStyleTableViewCell
A subclass of UITableViewCell which displays a card style view for cells in grouped tableView, similar to the system's tableView before iOS 7.

![Screenshot](Screenshots/Screenshot-1.png "Screenshot-1")

![Screenshot](Screenshots/Screenshot-2.png "Screenshot-2")


##How To Get Started
###Carthage
Specify "CardStyleTableViewCell" in your Cartfile:
```ogdl 
github "teambition/CardStyleTableViewCell"
```

###Usage
#####  Inherit CardStyleTableViewCell
```swift
class MyCell: CardStyleTableViewCell {

}
```

Assign delegate
```swift
cell.cardStyleDelegate = self
```

#####  Implement delegate
```swift
func roundingCornersForCardInSection(section: Int) -> UIRectCorner {
    // set rounding corners of this section, default is UIRectCorner.AllCorners
}

func leftPaddingForCardStyleTableViewCell() -> CGFloat {
    // leftPadding
}

func rightPaddingForCardStyleTableViewCell() -> CGFloat {
    // rightPadding
}

func cornerRadiusForCardStyleTableViewCell() -> CGFloat {
    // cornerRadius
}
```

## Minimum Requirement
iOS 8.0

## Release Notes
* [Release Notes](https://github.com/teambition/CardStyleTableViewCell/releases)

## License
CardStyleTableViewCell is released under the MIT license. See [LICENSE](https://github.com/teambition/CardStyleTableViewCell/blob/master/LICENSE.md) for details.

## More Info
Have a question? Please [open an issue](https://github.com/teambition/CardStyleTableViewCell/issues/new)!
