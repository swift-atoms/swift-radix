@frozen
public struct Radix {

    public let digits: [Unicode.Scalar]

    public let casing: Casing

    package init(_ digits: [Unicode.Scalar], casing: Casing) {
        self.digits = digits
        self.casing = casing
    }
}

extension Radix: Swift::Sendable {}

extension Radix {

    public init(digits: [Unicode.Scalar], casing: Casing = .sensitive) throws(Self.Error) {
        guard digits.count >= 2 else {
            throw .insufficientDigits(count: digits.count)
        }

        var seen: Set<UInt32> = []
        seen.reserveCapacity(digits.count)
        for glyph in digits {
            let key: UInt32
            switch casing {
            case .sensitive:
                key = glyph.value

            case .insensitive:
                key = Self.folded(glyph).value
            }
            guard seen.insert(key).inserted else {
                throw .duplicateDigit(glyph)
            }
        }

        self.init(digits, casing: casing)
    }

    @usableFromInline
    static func folded(_ glyph: Unicode.Scalar) -> Unicode.Scalar {
        guard glyph.value >= 0x41, glyph.value <= 0x5A else { return glyph }
        return Unicode.Scalar(UInt8(glyph.value + 0x20))
    }
}

extension Radix {

    @inlinable
    public var base: Int { digits.count }

    @inlinable
    public func digit(for value: Int) -> Unicode.Scalar? {
        guard value >= 0, value < digits.count else { return nil }
        return digits[value]
    }

    @inlinable
    public func value(of glyph: Unicode.Scalar) -> Int? {
        switch casing {
        case .sensitive:
            return digits.firstIndex(of: glyph)

        case .insensitive:
            let target = Self.folded(glyph)
            return digits.firstIndex { Self.folded($0) == target }
        }
    }
}

extension Radix {

    public static let binary = Radix(
        ["0", "1"],
        casing: .sensitive
    )

    public static let octal = Radix(
        ["0", "1", "2", "3", "4", "5", "6", "7"],
        casing: .sensitive
    )

    public static let decimal = Radix(
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
        casing: .sensitive
    )

    public static let hexadecimal = Radix(
        ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"],
        casing: .insensitive
    )
}
