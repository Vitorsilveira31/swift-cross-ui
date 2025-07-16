import DefaultBackend
import SwiftCrossUI

@main
struct WasiApp: App {
  var body: some Scene {
    WindowGroup("Hello, WASM!") {
      Text("Hello, World!")
    }
  }
}
