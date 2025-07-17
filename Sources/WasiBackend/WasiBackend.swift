import DOM
import Foundation
import JavaScriptEventLoop
import JavaScriptKit
import SwiftCrossUI

extension App {
    public typealias Backend = WasiBackend

    public var backend: WasiBackend {
        WasiBackend()
    }
}

public final class WasiBackend: AppBackend {
    public func resolveTextStyle(_ textStyle: Font.TextStyle)
        -> Font.TextStyle.Resolved
    {
        textStyle.resolve(for: deviceClass)
    }

    public typealias Window = Element
    public typealias Widget = Element
    public typealias Menu = Element
    public typealias Alert = Element
    public typealias Path = Element

    public let defaultTableRowContentHeight = 20
    public let defaultTableCellVerticalPadding = 4
    public let defaultPaddingAmount = 10
    public let requiresToggleSwitchSpacer = false
    public let requiresImageUpdateOnScaleFactorChange = false
    public let menuImplementationStyle = MenuImplementationStyle.dynamicPopover
    public let deviceClass = DeviceClass.desktop
    public let canRevealFiles = true

    public var scrollBarWidth: Int = 10

    private let document: Document = globalThis.document

    public init() {
        JavaScriptEventLoop.installGlobalExecutor()
    }

    nonisolated public func runMainLoop(_ callback: @escaping @Sendable () -> Void) {
        callback()
    }

    public func createWindow(withDefaultSize defaultSize: SIMD2<Int>?) -> Window {
        let container = document.createElement(localName: "div")
        container.className = "window"
        return container
    }

    public func setTitle(ofWindow window: Window, to title: String) {

    }

    public func setResizability(ofWindow window: Window, to resizable: Bool) {

    }

    public func setChild(ofWindow window: Window, to child: Widget) {
        if let body = document.body {
            while let firstChild = body.firstChild {
                _ = body.removeChild(child: firstChild)
            }
            _ = body.appendChild(node: child)
        }
    }

    public func size(ofWindow window: Window) -> SIMD2<Int> {
        let width = Int(window.jsObject.innerWidth.number ?? 0.0)
        let height = Int(window.jsObject.innerHeight.number ?? 0.0)
        return SIMD2(width, height)
    }

    public func isWindowProgrammaticallyResizable(_ window: Window) -> Bool {
        false
    }

    public func setSize(ofWindow window: Window, to newSize: SIMD2<Int>) {
        window.jsObject.style.width = "\(newSize.x)px".jsValue
        window.jsObject.style.height = "\(newSize.y)px".jsValue
    }

    public func setMinimumSize(ofWindow window: Window, to minimumSize: SIMD2<Int>) {
        window.jsObject.style.minWidth = "\(minimumSize.x)px".jsValue
        window.jsObject.style.minHeight = "\(minimumSize.y)px".jsValue
    }

    public func setResizeHandler(
        ofWindow window: Window,
        to action: @escaping (SIMD2<Int>) -> Void
    ) {}

    public func show(window: Window) {
    }

    public func activate(window: Window) {
    }

    nonisolated public func runInMainThread(action: @escaping @Sendable () -> Void) {
        action()
    }

    public func computeRootEnvironment(defaultEnvironment: EnvironmentValues)
        -> EnvironmentValues
    {
        defaultEnvironment
    }

    public func setRootEnvironmentChangeHandler(to action: @escaping () -> Void) {}

    public func computeWindowEnvironment(
        window: Window,
        rootEnvironment: EnvironmentValues
    ) -> EnvironmentValues {
        rootEnvironment
    }

    public func setWindowEnvironmentChangeHandler(
        of window: Window,
        to action: @escaping () -> Void
    ) {}

    public func show(widget: Widget) {}

    public func tag(widget: Widget, as tag: String) {
        widget.jsObject.className = "\(widget.jsObject.className) tag-\(tag)".lowercased().jsValue
    }

    public func createContainer() -> Widget {
        let container = document.createElement(localName: "div")
        container.className = "container"
        return container
    }

    public func removeAllChildren(of container: Widget) {
        while true {
            let lastChild = container.jsObject.lastChild
            if lastChild.isNull || lastChild.isUndefined { break }
            _ = container.jsObject.removeChild?(lastChild)
        }
    }

    public func addChild(_ child: Widget, to container: Widget) {
        _ = container.jsObject.appendChild?(child)
    }

    public func setPosition(ofChildAt index: Int, in container: Widget, to position: SIMD2<Int>) {
        let children = container.jsObject.childNodes
        guard let length = children.length.number, index < Int(length) else {
            assertionFailure("Child index out of bounds")
            return
        }
        guard let child = children[Int(index)].object else {
            return
        }
        // Understand better how to handle centering
        // if is the root container
        if container.jsObject.parentNode.className == "" {
            child.style.position = "absolute"
            child.style.left = "50%".jsValue
            child.style.top = "50%".jsValue
            child.style.transform = "translate(-50%, -50%)".jsValue

            return
        }
        child.style.position = "absolute"
        child.style.left = "\(position.x)px".jsValue
        child.style.top = "\(position.y)px".jsValue
    }

    public func removeChild(_ child: Widget, from container: Widget) {
        _ = container.jsObject.removeChild?(child)
    }

    public func createColorableRectangle() -> Widget {
        let element = document.createElement(localName: "div")
        element.className = "colorable-rectangle"
        return element
    }

    public func setColor(ofColorableRectangle widget: Widget, to color: Color) {
        widget.jsObject.style.backgroundColor = color.cssString.jsValue
    }

    public func setCornerRadius(of widget: Widget, to radius: Int) {
        widget.jsObject.style.borderRadius = "\(radius)px".jsValue
    }

    public func naturalSize(of widget: Widget) -> SIMD2<Int> {
        let rect = widget.getBoundingClientRect()
        return SIMD2(Int(rect.width.rounded()), Int(rect.height.rounded()))
    }

    public func setSize(of widget: Widget, to size: SIMD2<Int>) {
        widget.jsObject.style.width = "\(size.x)px".jsValue
        widget.jsObject.style.height = "\(size.y)px".jsValue
    }

    public func createScrollContainer(for child: Widget) -> Widget {
        HTMLElement()
    }

    public func updateScrollContainer(
        _ scrollView: Widget, environment: EnvironmentValues
    ) {

    }

    public func setScrollBarPresence(
        ofScrollContainer scrollView: Widget, hasVerticalScrollBar: Bool,
        hasHorizontalScrollBar: Bool
    ) {

    }

    public func createSelectableListView() -> Widget {
        HTMLElement()
    }

    public func baseItemPadding(ofSelectableListView listView: Widget) -> EdgeInsets {
        EdgeInsets(
            top: 0,
            bottom: 0,
            leading: 0,
            trailing: 0
        )
    }

    public func minimumRowSize(ofSelectableListView listView: Widget) -> SIMD2<Int> {
        let rect = listView.getBoundingClientRect()
        return SIMD2(Int(rect.width.rounded()), Int(rect.height.rounded()))
    }

    public func setItems(
        ofSelectableListView listView: Widget,
        to items: [Widget],
        withRowHeights rowHeights: [Int]
    ) {

    }

    public func setSelectionHandler(
        forSelectableListView listView: Widget,
        to action: @escaping (Int) -> Void
    ) {

    }

    public func setSelectedItem(ofSelectableListView listView: Widget, toItemAt index: Int?) {

    }

    public func createSplitView(leadingChild: Widget, trailingChild: Widget) -> Widget {
        HTMLElement()
    }

    public func setResizeHandler(ofSplitView splitView: Widget, to action: @escaping () -> Void) {

    }

    public func sidebarWidth(ofSplitView splitView: Widget) -> Int {
        100
    }

    public func setSidebarWidthBounds(
        ofSplitView splitView: Widget, minimum minimumWidth: Int, maximum maximumWidth: Int
    ) {

    }

    public func size(
        of text: String,
        whenDisplayedIn widget: Widget,
        proposedFrame: SIMD2<Int>?,
        environment: EnvironmentValues
    ) -> SIMD2<Int> {
        let temp = document.createElement(localName: "span")
        temp.textContent = text

        temp.jsObject.style.fontSize = "\(environment.resolvedFont.pointSize)px".jsValue
        // temp.jsObject.style.fontFamily = environment.resolvedFont.family.jsValue
        temp.jsObject.style.position = "absolute".jsValue
        temp.jsObject.style.visibility = "hidden".jsValue
        temp.jsObject.style.whiteSpace = "pre-wrap".jsValue

        if let proposedFrame {
            temp.jsObject.style.width = "\(proposedFrame.x)px".jsValue
        } else {
            temp.jsObject.style.whiteSpace = "nowrap".jsValue
        }

        _ = document.body?.appendChild(node: temp)

        _ = temp.jsObject.offsetWidth

        let rect = temp.getBoundingClientRect()
        let width = temp.jsObject.scrollWidth.number ?? 0
        let height = temp.jsObject.scrollHeight.number ?? 0
        let result = SIMD2(Int(width), Int(height))

        temp.remove()
        return result
    }

    public func createTextView() -> Widget {
        let text = document.createElement(localName: "text")
        text.className = "text-view"
        return text
    }

    public func updateTextView(
        _ textView: Widget, content: String, environment: EnvironmentValues
    ) {
        textView.textContent = content
    }

    public func createImageView() -> Widget {
        HTMLElement()
    }

    public func updateImageView(
        _ imageView: Widget, rgbaData: [UInt8], width: Int, height: Int, targetWidth: Int,
        targetHeight: Int, dataHasChanged: Bool, environment: EnvironmentValues
    ) {

    }

    public func createTable() -> Widget {
        HTMLElement()
    }

    public func setRowCount(ofTable table: Widget, to rows: Int) {

    }

    public func setColumnLabels(
        ofTable table: Widget, to labels: [String], environment: EnvironmentValues
    ) {

    }

    public func setCells(
        ofTable table: Widget, to cells: [Widget], withRowHeights rowHeights: [Int]
    ) {

    }

    public func createButton() -> Widget {
        let button = document.createElement(localName: "button")
        button.className = "button"
        return button
    }

    public func updateButton(
        _ button: Widget, label: String, environment: EnvironmentValues,
        action: @escaping () -> Void
    ) {
        button.textContent = label
        button.addEventListener(
            type: "click",
            callback: { _ in
                action()
            }
        )
    }

    public func updateButton(
        _ button: Widget,
        label: String,
        menu: Menu,
        environment: EnvironmentValues
    ) {

    }

    public func createToggle() -> Widget {
        HTMLElement()
    }

    public func updateToggle(
        _ toggle: Widget,
        label: String,
        environment: EnvironmentValues,
        onChange: @escaping (Bool) -> Void
    ) {

    }

    public func setState(ofToggle toggle: Widget, to state: Bool) {

    }

    public func createSwitch() -> Widget {
        HTMLElement()
    }

    public func updateSwitch(
        _ switchWidget: Widget,
        environment: EnvironmentValues,
        onChange: @escaping (Bool) -> Void
    ) {

    }

    public func setState(ofSwitch switchWidget: Widget, to state: Bool) {

    }

    public func createCheckbox() -> Widget {
        HTMLElement()
    }

    public func updateCheckbox(
        _ checkboxWidget: Widget, environment: EnvironmentValues,
        onChange: @escaping (Bool) -> Void
    ) {

    }

    public func setState(ofCheckbox checkboxWidget: Widget, to state: Bool) {

    }

    public func createSlider() -> Widget {
        HTMLElement()
    }

    public func updateSlider(
        _ slider: Widget, minimum: Double, maximum: Double, decimalPlaces: Int,
        environment: EnvironmentValues, onChange: @escaping (Double) -> Void
    ) {

    }

    public func setValue(ofSlider slider: Widget, to value: Double) {

    }

    public func createTextField() -> Widget {
        HTMLElement()
    }

    public func updateTextField(
        _ textField: Widget,
        placeholder: String,
        environment: EnvironmentValues,
        onChange: @escaping (String) -> Void,
        onSubmit: @escaping () -> Void
    ) {

    }

    public func setContent(ofTextField textField: Widget, to content: String) {

    }

    public func getContent(ofTextField textField: Widget) -> String {
        ""
    }

    public func createTextEditor() -> Widget {
        HTMLElement()
    }

    public func updateTextEditor(
        _ textEditor: Widget,
        environment: EnvironmentValues,
        onChange: @escaping (String) -> Void
    ) {

    }

    public func setContent(ofTextEditor textEditor: Widget, to content: String) {

    }

    public func getContent(ofTextEditor textEditor: Widget) -> String {
        ""
    }

    public func createPicker() -> Widget {
        HTMLElement()
    }

    public func updatePicker(
        _ picker: Widget,
        options: [String],
        environment: EnvironmentValues,
        onChange: @escaping (Int?) -> Void
    ) {

    }

    public func setSelectedOption(ofPicker picker: Widget, to selectedOption: Int?) {

    }

    public func createProgressSpinner() -> Widget {
        HTMLElement()
    }

    public func createProgressBar() -> Widget {
        HTMLElement()
    }

    public func updateProgressBar(
        _ widget: Widget,
        progressFraction: Double?,
        environment: EnvironmentValues
    ) {

    }

    public func createPopoverMenu() -> Menu {
        HTMLElement()
    }

    public func updatePopoverMenu(
        _ menu: Menu, content: ResolvedMenu,
        environment: EnvironmentValues
    ) {

    }

    public func showPopoverMenu(
        _ menu: Menu,
        at position: SIMD2<Int>,
        relativeTo widget: Widget,
        closeHandler handleClose: @escaping () -> Void
    ) {

    }

    public func createAlert() -> Alert {
        HTMLElement()
    }

    public func updateAlert(
        _ alert: Alert,
        title: String,
        actionLabels: [String],
        environment: EnvironmentValues
    ) {

    }

    public func showAlert(
        _ alert: Alert,
        window: Window?,
        responseHandler handleResponse: @escaping (Int) -> Void
    ) {

    }

    public func dismissAlert(_ alert: Alert, window: Window?) {

    }

    public func createTapGestureTarget(wrapping child: Widget, gesture: TapGesture)
        -> Widget
    {
        HTMLElement()
    }

    public func updateTapGestureTarget(
        _ tapGestureTarget: Widget, gesture: TapGesture,
        environment: EnvironmentValues, action: @escaping () -> Void
    ) {

    }

    public func createPathWidget() -> Widget {
        HTMLElement()
    }

    public func createPath() -> Path {
        HTMLElement()
    }

    public func updatePath(
        _ path: Path,
        _ source: Path,
        bounds: SwiftCrossUI.Path.Rect,
        pointsChanged: Bool,
        environment: EnvironmentValues
    ) {

    }

    public func renderPath(
        _ path: Path,
        container: Widget,
        strokeColor: Color,
        fillColor: Color,
        overrideStrokeStyle: StrokeStyle?
    ) {

    }

    public func createWebView() -> Widget {
        HTMLElement()
    }

    public func setApplicationMenu(_ submenus: [ResolvedMenu.Submenu]) {

    }
}
