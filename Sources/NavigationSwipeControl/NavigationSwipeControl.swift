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
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

@available(iOS 13.0, *)
struct SwipeableView: UIViewControllerRepresentable {
    
    var enabled: Bool

    init(enabled: Bool = true) {
        self.enabled = enabled
    }
    
    class SwipeableController: UIViewController, SwipeableControllerProtocol {
        var isSwipeable = true
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }

    }
    
    func makeUIViewController(context: Context) -> SwipeableController {
        let controller = SwipeableController()
        controller.isSwipeable = enabled
        return controller
    }

    func updateUIViewController(_ uiViewController: SwipeableController, context: Context) {
        
    }
}

@available(iOS 16.0, *)
extension View {
    @ViewBuilder
    public func swipeable(_ isEnabled: Bool = true)-> some View{
        self
            .background(
                SwipeableView(
                    enabled: isEnabled
                )
            )
    }
}

@available(iOS 16.0, *)
extension View {
    @ViewBuilder
    public func dismissible(backButton: Bool = true, edgeSwipe: Bool = true) -> some View {
        self
            .swipeable(edgeSwipe)
            .navigationBarBackButtonHidden(!backButton)
    }
}

