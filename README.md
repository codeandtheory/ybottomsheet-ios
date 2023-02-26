![Y—Bottom Sheet](https://user-images.githubusercontent.com/1037520/220544799-9b2e899f-32ba-4629-a819-c7b1f14ad1be.jpeg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyml-org%2Fybottomsheet-ios%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/yml-org/ybottomsheet-ios) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fyml-org%2Fybottomsheet-ios%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/yml-org/ybottomsheet-ios)  
_An easy-to-use bottom sheet controller for iOS._

This framework offers a bottom sheet view controller that can be initialized to host any view or view controller.

![Bottom Sheet demo animation](https://user-images.githubusercontent.com/1037520/220545009-58ba333c-a367-4bc1-8e6e-5cbdfc9d546f.gif)

Licensing
----------
Y—BottomSheet is licensed under the [Apache 2.0 license](LICENSE).

Documentation
----------

Documentation is automatically generated from source code comments and rendered as a static website hosted via GitHub Pages at: https://yml-org.github.io/ybottomsheet-ios/

Usage
----------

### Initializers
The Bottom sheet controller can be initialized with either a title and a view or else with a view controller. 

```swift
init(
    title: String,
    childView: UIView,
    appearance: BottomSheetController.Appearance = .default
)

init(
    childController: UIViewController,
    appearance: BottomSheetController.Appearance = .default
)
```

When initializing with a view controller, the title is drawn from `UIViewController.title`. When the view controller is a `UINavigationController`, the header appearance options are ignored and the navigation controller's navigation bar is displayed as the sheet's header. In this situation, if you wish to have a close button, then that should be set using the view controller's `navigationItem.rightBarButtonItem` or `.leftBarButtonItem`.

Both initializers include an appearance parameter that allows you to fully customize the sheet's appearance. You can also update the sheet's appearance at any time.

#### Simple use case 1: Passing a title and a view

```swift
import YBottomSheet

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showBottomSheet()
    }
    
    func showBottomSheet() {
        let yourView = UIView() 
        let sheet = BottomSheetController(
            title: "Title",
            childView: yourView
        )
        present(sheet, animated: true)
    }
}
```

#### Simple use case 2: Passing a view controller.

```swift
import YBottomSheet

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showBottomSheet()
    }
    
    func showBottomSheet() {
        let yourViewController = UIViewController() 
        let sheet = BottomSheetController(
            childController: yourViewController
        )
        present(sheet, animated: true)
    }
}
```

### Customization
`BottomSheetController` has an `appearance` property of type `Appearance`.

`Appearance` lets you customize the bottom sheet appearance. We can customize the appearance of the indicator view, the header view, dimmer color, animation etc.

```swift
/// Determines the appearance of the bottom sheet.
public struct Appearance {
    /// Appearance of the drag indicator.
    public var indicatorAppearance: DragIndicatorView.Appearance?
    /// Appearance of the sheet header view.
    public var headerAppearance: SheetHeaderView.Appearance?
    /// Bottom sheet layout properties such as corner radius. Default is `.default`.
    public let layout: Layout
    /// Bottom sheet's shadow. Default is `nil` (no shadow).
    public let elevation: Elevation?
    /// Dimmer view color. Default is 'UIColor.black.withAlphaComponent(0.5)'.
    public let dimmerColor: UIColor?
    /// Animation duration on bottom sheet. Default is `0.3`.
    public let animationDuration: TimeInterval
    /// Animation type during presenting. Default is `curveEaseIn`.
    public let presentAnimationCurve: UIView.AnimationOptions
    /// Animation type during dismissing. Default is `curveEaseOut`.
    public let dismissAnimationCurve: UIView.AnimationOptions
    /// (Optional) Minimum content view height. Default is `nil`.
    ///
    /// Only applicable for resizable sheets. `nil` means to use the content view's intrinsic height as the minimum.
    public var minimumContentHeight: CGFloat?
}
```

**Update or customize appearance**

```swift
// Declare a resizable sheet.
let sheet = BottomSheetController(
    childController: yourViewController,
    appearance: .defaultResizable
)

// Change corner radius, remove dimmer,
// and use a shadow instead.
sheet.appearance.layout.cornerRadius = 24
sheet.appearance.dimmerColor = nil
sheet.appearance.elevation = Elevation(
    xOffset: 0,
    yOffset: 4,
    blur: 16,
    spread: 0,
    color: .black,
    opacity: 0.4
)

// Present the sheet.
present(sheet, animated: true)
```

Installation
----------

You can add Y—BottomSheet to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Add Packages...**
2. Enter "[https://github.com/yml-org/ybottomsheet-ios](https://github.com/yml-org/ybottomsheet-ios)" into the package repository URL text field
3. Click **Add Package**

Contributing to Y—BottomSheet
----------

### Requirements

#### SwiftLint (linter)
```
brew install swiftlint
```

#### Jazzy (documentation)
```
sudo gem install jazzy
```

### Setup

Clone the repo and open `Package.swift` in Xcode.

### Versioning strategy

We utilize [semantic versioning](https://semver.org).

```
{major}.{minor}.{patch}
```

e.g.

```
1.0.5
```

### Branching strategy

We utilize a simplified branching strategy for our frameworks.

* main (and development) branch is `main`
* both feature (and bugfix) branches branch off of `main`
* feature (and bugfix) branches are merged back into `main` as they are completed and approved.
* `main` gets tagged with an updated version # for each release
 
### Branch naming conventions:

```
feature/{ticket-number}-{short-description}
bugfix/{ticket-number}-{short-description}
```
e.g.
```
feature/CM-44-button
bugfix/CM-236-textview-color
```

### Pull Requests

Prior to submitting a pull request you should:

1. Compile and ensure there are no warnings and no errors.
2. Run all unit tests and confirm that everything passes.
3. Check unit test coverage and confirm that all new / modified code is fully covered.
4. Run `swiftlint` from the command line and confirm that there are no violations.
5. Run `jazzy` from the command line and confirm that you have 100% documentation coverage.
6. Consider using `git rebase -i HEAD~{commit-count}` to squash your last {commit-count} commits together into functional chunks.
7. If HEAD of the parent branch (typically `main`) has been updated since you created your branch, use `git rebase main` to rebase your branch.
    * _Never_ merge the parent branch into your branch.
    * _Always_ rebase your branch off of the parent branch.

When submitting a pull request:

* Use the [provided pull request template](PULL_REQUEST_TEMPLATE.md) and populate the Introduction, Purpose, and Scope fields at a minimum.
* If you're submitting before and after screenshots, movies, or GIF's, enter them in a two-column table so that they can be viewed side-by-side.

When merging a pull request:

* Make sure the branch is rebased (not merged) off of the latest HEAD from the parent branch. This keeps our git history easy to read and understand.
* Make sure the branch is deleted upon merge (should be automatic).

### Releasing new versions
* Tag the corresponding commit with the new version (e.g. `1.0.5`)
* Push the local tag to remote

Generating Documentation (via Jazzy)
----------

You can generate your own local set of documentation directly from the source code using the following command from Terminal:
```
jazzy
```
This generates a set of documentation under `/docs`. The default configuration is set in the default config file `.jazzy.yaml` file.

To view additional documentation options type:
```
jazzy --help
```
A GitHub Action automatically runs each time a commit is pushed to `main` that runs Jazzy to generate the documentation for our GitHub page at: https://yml-org.github.io/ybottomsheet-ios/
