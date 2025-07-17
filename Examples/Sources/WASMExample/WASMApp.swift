import DefaultBackend
import SwiftCrossUI

@main
struct WASMApp: App {
    @State private var counter: Int = 0

    var body: some Scene {
        WindowGroup("Hello, WASM!") {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("\(counter)")
                    Text("\(counter)")
                }
                .background(Color.blue)
                Text("\(counter)")
                Button("Click Me") {
                    counter += 1
                }
            }
            .background(Color.red)
        }
    }
}
