# NavigationSwipeControl

NavigationSwipeControl is a Swift package that allows you to flexibly control the "back" gesture (edge swipe) and navigation bar back button behavior for each SwiftUI screen.

## Features

- Enable or disable the back gesture (edge swipe) per SwiftUI view
- Show or hide the navigation bar back button per view
- Fine-grained control using the `dismissible(backButton:edgeSwipe:)` modifier

## Installation (Swift Package Manager)

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL and add the package to your project.

## Usage Example

```swift
import NavigationSwipeControl
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Go to Next View") {
                NextView()
                    .dismissible(backButton: false, edgeSwipe: true)
            }
        }
    }
}

struct NextView: View {
    var body: some View {
        Text("Back button is hidden, but edge swipe is enabled.")
    }
}
```

### `dismissible` Parameters

- `backButton: Bool`  
  Show or hide the navigation bar back button
- `edgeSwipe: Bool`  
  Enable or disable the edge swipe (back gesture)

### Using `swipeable(_:)`

If you want to control the edge swipe gesture per view, use `.swipeable(true/false)`.

## License

MIT License

## Note

This README and parts of the package were generated with the help of GitHub Copilot (GPT
