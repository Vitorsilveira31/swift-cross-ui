#if os(WASI)
    @_exported import FoundationEssentials

    public typealias CGFloat = Float

    nonisolated public struct CGPoint: Equatable, Sendable {
        public init(x: CGFloat, y: CGFloat) {
            self.x = x
            self.y = y
        }

        public var x: CGFloat
        public var y: CGFloat

        public static let zero = CGPoint(x: 0, y: 0)
    }

    nonisolated public struct CGSize: Equatable, Sendable {
        public static let zero = CGSize(width: Float.zero, height: Float.zero)

        public init(width: CGFloat, height: CGFloat) {
            self.width = width
            self.height = height
        }

        public static func fromDouble(width: Double, height: Double) -> CGSize {
            return CGSize.init(width: CGFloat(width), height: CGFloat(height))
        }

        public var width: CGFloat
        public var height: CGFloat
    }

    nonisolated public struct CGRect: Equatable, Sendable {
        public init(origin: CGPoint, size: CGSize) {
            self.origin = origin
            self.size = size
        }

        public var origin: CGPoint
        public var size: CGSize

        public static let zero = CGRect(x: 0, y: 0, width: 0, height: 0)

        public var height: CGFloat {
            get { size.height }
            set { size.height = newValue }
        }
        public var width: CGFloat {
            get { size.width }
            set { size.width = newValue }
        }

        public var minX: CGFloat {
            get { origin.x }
            set { origin.x = newValue }
        }

        public var minY: CGFloat {
            get { origin.y }
            set { origin.y = newValue }
        }

        public var midX: CGFloat {
            return origin.x + size.width / 2
        }

        public var midY: CGFloat {
            return origin.y + size.height / 2
        }

        public var maxX: CGFloat {
            return origin.x + size.width
        }
        public var maxY: CGFloat {
            return origin.y + size.height
        }
    }

    extension CGRect {
        public init(x: CGFloat = 0, y: CGFloat = 0, width: CGFloat, height: CGFloat) {
            self.origin = CGPoint(x: x, y: y)
            self.size = CGSize(width: width, height: height)
        }
    }

    import Foundation

    public enum JSONSerialization {
        /// Mock replacement for `JSONSerialization.jsonObject(with:)`
        public static func jsonObject(with data: Data, options opt: JSONReadingOptions = []) throws
            -> Any
        {
            // ⚠️ IMPORTANT:
            // Since Foundation's JSON parser isn't available in WASI,
            // this stub must either:
            // - actually parse JSON (by pulling in a pure Swift parser like OpenCombineFoundation or JSONDecoder)
            // - or just throw an error so your app can handle it gracefully

            // Easiest stub: always throw
            struct JSONStubError: Error {}
            throw JSONStubError()

            // ⚠️ OR, if you *know* your data is always e.g. an empty object:
            // return [String: Any]()
        }

        public struct JSONReadingOptions: OptionSet {
            public let rawValue: Int
            public init(rawValue: Int) { self.rawValue = rawValue }

            public static let mutableContainers = JSONReadingOptions(rawValue: 1 << 0)
            public static let mutableLeaves = JSONReadingOptions(rawValue: 1 << 1)
            public static let fragmentsAllowed = JSONReadingOptions(rawValue: 1 << 2)
        }
    }

    public struct Progress {
        public var isIndeterminate: Bool {
            return false
        }

        public var fractionCompleted: Double {
            0.0
        }

        public init(totalUnitCount: Int64) {
            // This is a stub implementation for the sake of compatibility.
        }

        public func completedUnitCount(_ count: Int64) {
            // This is a stub implementation for the sake of compatibility.
        }
    }

    public struct Bundle: @unchecked Sendable {
        /// Mimic `.main`
        public static let main = Bundle(path: "/")!

        public let bundlePath: String

        public init?(path: String) {
            // For WASI, always succeed, or you could check if path exists if you build a virtual FS
            self.bundlePath = path
        }

        /// Stubbed method, always returns nil
        public func path(forResource name: String, ofType ext: String? = nil) -> String? {
            return nil
        }

        /// Example: return fixed strings or empty arrays if needed
        public var resourcePath: String? {
            return nil
        }

        public var bundleIdentifier: String? {
            return "com.example.mockbundle"
        }

        public var executableURL: URL? {
            return nil
        }
    }

    extension String {
        /// Mock para `String(format: _, _)` que só converte Double/Float para String com 4 casas decimais
        public init(format: String, _ value: CVarArg) {
            if let doubleValue = value as? Double {
                self = String(doubleValue)
            } else if let floatValue = value as? Float {
                self = String(floatValue)
            } else {
                // fallback simples
                self = "\(value)"
            }
        }
    }
#endif
