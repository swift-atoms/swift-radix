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
