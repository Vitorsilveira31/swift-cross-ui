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
    public func resolveTextStyle(_ textStyle: SwiftCrossUI.Font.TextStyle)
        -> SwiftCrossUI.Font.TextStyle.Resolved
    {
        textStyle.resolve(for: deviceClass)
    }

    public typealias Window = JSValue
    public typealias Widget = JSValue
    public typealias Menu = JSValue
    public typealias Alert = JSValue
    public typealias Path = JSValue

    public let defaultTableRowContentHeight = 20
    public let defaultTableCellVerticalPadding = 4
    public let defaultPaddingAmount = 10
    public let requiresToggleSwitchSpacer = false
    public let requiresImageUpdateOnScaleFactorChange = false
    public let menuImplementationStyle = MenuImplementationStyle.dynamicPopover
    public let deviceClass = DeviceClass.desktop
    public let canRevealFiles = true

    public var scrollBarWidth: Int = 10

    private let document: JSObject?

    public init() {
        document = JSObject.global.document.object
        JavaScriptEventLoop.installGlobalExecutor()
    }

    nonisolated public func runMainLoop(_ callback: @escaping @Sendable () -> Void) {
        callback()
    }

    public func createWindow(withDefaultSize defaultSize: SIMD2<Int>?) -> Window {
        JSValue.null
    }

    public func setTitle(ofWindow window: Window, to title: String) {

    }

    public func setResizability(ofWindow window: Window, to resizable: Bool) {

    }

    public func setChild(ofWindow window: Window, to child: Widget) {
        _ = document?.body.append(child)
    }

    public func size(ofWindow window: Window) -> SIMD2<Int> {
        SIMD2(100, 100)  // Placeholder, as WASI does not provide window size information
    }

    public func isWindowProgrammaticallyResizable(_ window: Window) -> Bool {
        false
    }

    public func setSize(ofWindow window: Window, to newSize: SIMD2<Int>) {

    }

    public func setMinimumSize(ofWindow window: Window, to minimumSize: SIMD2<Int>) {

    }

    public func setResizeHandler(ofWindow window: Window, to action: @escaping (SIMD2<Int>) -> Void)
    {

    }

    public func show(window: Window) {

    }

    public func activate(window: Window) {

    }

    nonisolated public func runInMainThread(action: @escaping @Sendable () -> Void) {
        action()
    }

    public func computeRootEnvironment(defaultEnvironment: SwiftCrossUI.EnvironmentValues)
        -> SwiftCrossUI.EnvironmentValues
    {
        return defaultEnvironment
    }

    public func setRootEnvironmentChangeHandler(to action: @escaping () -> Void) {

    }

    public func computeWindowEnvironment(
        window: Window, rootEnvironment: SwiftCrossUI.EnvironmentValues
    ) -> SwiftCrossUI.EnvironmentValues {
        return rootEnvironment
    }

    public func setWindowEnvironmentChangeHandler(
        of window: Window, to action: @escaping () -> Void
    ) {

    }

    public func show(widget: Widget) {

    }

    public func tag(widget: Widget, as tag: String) {

    }

    public func createContainer() -> Widget {
        guard let document else {
            return JSValue.null
        }
        let container = document.createElement!("div")
        return container
    }

    public func removeAllChildren(of container: Widget) {

    }

    public func addChild(_ child: Widget, to container: Widget) {
        container.object?.appendChild?(child)
    }

    public func setPosition(ofChildAt index: Int, in container: Widget, to position: SIMD2<Int>) {

    }

    public func removeChild(_ child: Widget, from container: Widget) {

    }

    public func createColorableRectangle() -> Widget {
        JSValue.null
    }

    public func setColor(ofColorableRectangle widget: Widget, to color: SwiftCrossUI.Color) {

    }

    public func setCornerRadius(of widget: Widget, to radius: Int) {

    }

    public func naturalSize(of widget: Widget) -> SIMD2<Int> {
        SIMD2(100, 100)  // Placeholder, as WASI does not provide natural size information
    }

    public func setSize(of widget: Widget, to size: SIMD2<Int>) {

    }

    public func createScrollContainer(for child: Widget) -> Widget {
        JSValue.null
    }

    public func updateScrollContainer(
        _ scrollView: Widget, environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func setScrollBarPresence(
        ofScrollContainer scrollView: Widget, hasVerticalScrollBar: Bool,
        hasHorizontalScrollBar: Bool
    ) {

    }

    public func createSelectableListView() -> Widget {
        JSValue.null
    }

    public func baseItemPadding(ofSelectableListView listView: Widget) -> SwiftCrossUI.EdgeInsets {
        SwiftCrossUI.EdgeInsets(
            top: 0,
            bottom: 0,
            leading: 0,
            trailing: 0
        )
    }

    public func minimumRowSize(ofSelectableListView listView: Widget) -> SIMD2<Int> {
        SIMD2(100, 30)  // Placeholder, as WASI does not provide minimum row size information
    }

    public func setItems(
        ofSelectableListView listView: Widget, to items: [Widget], withRowHeights rowHeights: [Int]
    ) {

    }

    public func setSelectionHandler(
        forSelectableListView listView: Widget, to action: @escaping (Int) -> Void
    ) {

    }

    public func setSelectedItem(ofSelectableListView listView: Widget, toItemAt index: Int?) {

    }

    public func createSplitView(leadingChild: Widget, trailingChild: Widget) -> Widget {
        JSValue.null
    }

    public func setResizeHandler(ofSplitView splitView: Widget, to action: @escaping () -> Void) {

    }

    public func sidebarWidth(ofSplitView splitView: Widget) -> Int {
        10
    }

    public func setSidebarWidthBounds(
        ofSplitView splitView: Widget, minimum minimumWidth: Int, maximum maximumWidth: Int
    ) {

    }

    public func size(
        of text: String, whenDisplayedIn widget: Widget, proposedFrame: SIMD2<Int>?,
        environment: SwiftCrossUI.EnvironmentValues
    ) -> SIMD2<Int> {
        return SIMD2(100, 20)
    }

    public func createTextView() -> Widget {
        guard let document else {
            return JSValue.null
        }
        let text = document.createElement!("h1")
        text.textContent = "Hello, World!"
        return text
    }

    public func updateTextView(
        _ textView: Widget, content: String, environment: SwiftCrossUI.EnvironmentValues
    ) {
        textView.object?.textContent = content as! JSValue
    }

    public func createImageView() -> Widget {
        JSValue.null
    }

    public func updateImageView(
        _ imageView: Widget, rgbaData: [UInt8], width: Int, height: Int, targetWidth: Int,
        targetHeight: Int, dataHasChanged: Bool, environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func createTable() -> Widget {
        JSValue.null
    }

    public func setRowCount(ofTable table: Widget, to rows: Int) {

    }

    public func setColumnLabels(
        ofTable table: Widget, to labels: [String], environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func setCells(
        ofTable table: Widget, to cells: [Widget], withRowHeights rowHeights: [Int]
    ) {

    }

    public func createButton() -> Widget {
        JSValue.null
    }

    public func updateButton(
        _ button: Widget, label: String, environment: SwiftCrossUI.EnvironmentValues,
        action: @escaping () -> Void
    ) {

    }

    public func updateButton(
        _ button: Widget, label: String, menu: Menu, environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func createToggle() -> Widget {
        JSValue.null
    }

    public func updateToggle(
        _ toggle: Widget, label: String, environment: SwiftCrossUI.EnvironmentValues,
        onChange: @escaping (Bool) -> Void
    ) {

    }

    public func setState(ofToggle toggle: Widget, to state: Bool) {

    }

    public func createSwitch() -> Widget {
        JSValue.null
    }

    public func updateSwitch(
        _ switchWidget: Widget, environment: SwiftCrossUI.EnvironmentValues,
        onChange: @escaping (Bool) -> Void
    ) {

    }

    public func setState(ofSwitch switchWidget: Widget, to state: Bool) {

    }

    public func createCheckbox() -> Widget {
        JSValue.null
    }

    public func updateCheckbox(
        _ checkboxWidget: Widget, environment: SwiftCrossUI.EnvironmentValues,
        onChange: @escaping (Bool) -> Void
    ) {

    }

    public func setState(ofCheckbox checkboxWidget: Widget, to state: Bool) {

    }

    public func createSlider() -> Widget {
        JSValue.null
    }

    public func updateSlider(
        _ slider: Widget, minimum: Double, maximum: Double, decimalPlaces: Int,
        environment: SwiftCrossUI.EnvironmentValues, onChange: @escaping (Double) -> Void
    ) {

    }

    public func setValue(ofSlider slider: Widget, to value: Double) {

    }

    public func createTextField() -> Widget {
        JSValue.null
    }

    public func updateTextField(
        _ textField: Widget, placeholder: String, environment: SwiftCrossUI.EnvironmentValues,
        onChange: @escaping (String) -> Void, onSubmit: @escaping () -> Void
    ) {

    }

    public func setContent(ofTextField textField: Widget, to content: String) {

    }

    public func getContent(ofTextField textField: Widget) -> String {
        ""
    }

    public func createTextEditor() -> Widget {
        JSValue.null
    }

    public func updateTextEditor(
        _ textEditor: Widget, environment: SwiftCrossUI.EnvironmentValues,
        onChange: @escaping (String) -> Void
    ) {

    }

    public func setContent(ofTextEditor textEditor: Widget, to content: String) {

    }

    public func getContent(ofTextEditor textEditor: Widget) -> String {
        ""
    }

    public func createPicker() -> Widget {
        JSValue.null
    }

    public func updatePicker(
        _ picker: Widget, options: [String], environment: SwiftCrossUI.EnvironmentValues,
        onChange: @escaping (Int?) -> Void
    ) {

    }

    public func setSelectedOption(ofPicker picker: Widget, to selectedOption: Int?) {

    }

    public func createProgressSpinner() -> Widget {
        JSValue.null
    }

    public func createProgressBar() -> Widget {
        JSValue.null
    }

    public func updateProgressBar(
        _ widget: Widget, progressFraction: Double?, environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func createPopoverMenu() -> Menu {
        JSValue.null
    }

    public func updatePopoverMenu(
        _ menu: Menu, content: SwiftCrossUI.ResolvedMenu,
        environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func showPopoverMenu(
        _ menu: Menu, at position: SIMD2<Int>, relativeTo widget: Widget,
        closeHandler handleClose: @escaping () -> Void
    ) {

    }

    public func createAlert() -> Alert {
        JSValue.null
    }

    public func updateAlert(
        _ alert: Alert, title: String, actionLabels: [String],
        environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func showAlert(
        _ alert: Alert, window: Window?, responseHandler handleResponse: @escaping (Int) -> Void
    ) {

    }

    public func dismissAlert(_ alert: Alert, window: Window?) {

    }

    public func createTapGestureTarget(wrapping child: Widget, gesture: SwiftCrossUI.TapGesture)
        -> Widget
    {
        JSValue.null
    }

    public func updateTapGestureTarget(
        _ tapGestureTarget: Widget, gesture: SwiftCrossUI.TapGesture,
        environment: SwiftCrossUI.EnvironmentValues, action: @escaping () -> Void
    ) {

    }

    public func createPathWidget() -> Widget {
        JSValue.null
    }

    public func createPath() -> Path {
        JSValue.null
    }

    public func updatePath(
        _ path: Path, _ source: SwiftCrossUI.Path, bounds: SwiftCrossUI.Path.Rect,
        pointsChanged: Bool, environment: SwiftCrossUI.EnvironmentValues
    ) {

    }

    public func renderPath(
        _ path: Path, container: Widget, strokeColor: SwiftCrossUI.Color,
        fillColor: SwiftCrossUI.Color, overrideStrokeStyle: SwiftCrossUI.StrokeStyle?
    ) {

    }

    public func createWebView() -> Widget {
        JSValue.null
    }

    public func setApplicationMenu(_ submenus: [SwiftCrossUI.ResolvedMenu.Submenu]) {

    }
}
