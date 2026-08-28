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
