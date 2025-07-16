import SwiftCrossUI
import UIKit

final class ProgressSpinner: WrapperWidget<UIActivityIndicatorView> {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        child.startAnimating()
    }
}

extension UIKitBackend {
    @MainActor
    public func createProgressSpinner() -> Widget {
        ProgressSpinner()
    }

    @MainActor
    public func createProgressBar() -> Widget {
        let style: UIProgressView.Style
        #if os(tvOS)
            style = .default
        #else
            style = .bar
        #endif
        return WrapperWidget(child: UIProgressView(progressViewStyle: style))
    }

    @MainActor
    public func updateProgressBar(
        _ widget: Widget,
        progressFraction: Double?,
        environment: EnvironmentValues
    ) {
        guard let progressFraction else { return }
        let wrapper = widget as! WrapperWidget<UIProgressView>

        wrapper.child.setProgress(Float(progressFraction), animated: true)
    }
}
