// import DOM
// import JavaScriptEventLoop
// import JavaScriptKit
// import _Concurrency

// func fetchString(url: String) async throws(JSException) -> String {
//   let result = try await Window.global.fetch(input: .init(url))
//   return try await result.text()
// }

// enum AppError: Error {
//   case documentNotAvailable
// }

// @main
// struct Entrypoint {
//   static func main() throws {
//     guard let document = JSObject.global.document.object else {
//       throw AppError.documentNotAvailable
//     }

//     JavaScriptEventLoop.installGlobalExecutor()

//     document.title = "⏱️ MeetingMeter ⏱️"

//     var title = document.createElement!("h1")
//     title.textContent = "⏱️ MeetingMeter ⏱️"
//     title.className = "title"
//     _ = document.body.append(title)

//     Task {
//       do {
//         let json = try await fetchString(url: "https://jsonplaceholder.typicode.com/todos/1")
//         title.textContent = JSValue(stringLiteral: json)
//       } catch {
//         print("Triste")
//       }
//     }
//   }
// }

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
