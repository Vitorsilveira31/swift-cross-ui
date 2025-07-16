import Foundation
import OpenCombineShim

public final class Publisher {
    private let subject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var tag: String?

    public init() {}

    /// Publishes a change to all observers
    public func send() {
        subject.send(())
    }

    /// Observe future events
    public func observe(with closure: @escaping () -> Void) -> Cancellable {
        let cancellable = subject
            .sink(receiveValue: closure)

        let wrapper = Cancellable {
            cancellable.cancel()
        }.tag(with: tag)

        // Store to keep alive
        cancellables.insert(cancellable)
        return wrapper
    }

    /// Link to upstream publisher
    public func link(toUpstream publisher: Publisher) -> Cancellable {
        let cancellable = publisher.subject
            .sink { [weak self] _ in
                self?.send()
            }

        let wrapper = Cancellable {
            cancellable.cancel()
        }.tag(with: "\(tag ?? "no tag") <-> linked")

        cancellables.insert(cancellable)
        return wrapper
    }

    @discardableResult
    public func tag(with tag: @autoclosure () -> String?) -> Self {
        #if DEBUG
        self.tag = tag()
        #endif
        return self
    }

    /// Observe with throttling, WASM-friendly using OpenCombine's `throttle` operator
    public func observeAsUIUpdater<Backend: AppBackend>(
        backend: Backend,
        action: @escaping @MainActor @Sendable () -> Void
    ) -> Cancellable {
        // Example: throttle to run at most once every 100ms
        let cancellable = subject
            .throttle(for: .milliseconds(100), scheduler: ImmediateScheduler.shared, latest: true)
            .sink {
                backend.runInMainThread {
                    action()
                }
            }

        let wrapper = Cancellable {
            cancellable.cancel()
        }.tag(with: tag)

        cancellables.insert(cancellable)
        return wrapper
    }
}
