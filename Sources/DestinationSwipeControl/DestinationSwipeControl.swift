// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import UIKit

@MainActor
protocol SwipeableControllerProtocol {
    var isSwipeable: Bool { get }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let lastVC = viewControllers.last, viewControllers.count > 1 else {
            return false
        }
        
        guard let swipeableVC = lastVC.children.first as? SwipeableControllerProtocol else {
            return true
        }
        return swipeableVC.isSwipeable
    }
}

@available(iOS 13.0, *)
struct SwipeableView<Content: View>: UIViewControllerRepresentable {
    
    var enabled: Bool
    let content: Content

    init(enabled: Bool = true, @ViewBuilder content: () -> Content) {
        self.enabled = enabled
        self.content = content()
    }
    
    class SwipeableController: UIHostingController<Content>, SwipeableControllerProtocol {
        var isSwipeable = true
    }
    
    func makeUIViewController(context: Context) -> SwipeableController {
        let controller = SwipeableController(rootView: content)
        controller.isSwipeable = enabled
        controller.rootView = content
        return controller
    }

    func updateUIViewController(_ uiViewController: SwipeableController, context: Context) {
        uiViewController.rootView = content
    }
}

@available(iOS 13.0, *)
extension View {
    @ViewBuilder
    public func swipeable(_ isEnabled: Bool = true)-> some View{
        SwipeableView(
            enabled: isEnabled
        ){
            self
        }
    }
}

@available(iOS 15.0, *)
extension View {
    @ViewBuilder
    public func dismisible(backButton: Bool, edgeSwipe: Bool) -> some View {
        self
            .navigationBarBackButtonHidden(!backButton)
            .swipeable(edgeSwipe)
    }
}
