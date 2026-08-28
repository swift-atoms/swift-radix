import RadixTest_Support
import Testing

extension Radix {
    @Suite struct Test {}
}

extension Radix.Test {
    @Suite struct Standard {}
    @Suite struct Mapping {}
    @Suite struct Construction {}
    @Suite struct `Edge Case` {}
}

extension Radix.Test.Standard {
    @Test
    func `binary has base two`() {
        #expect(Radix.binary.base == 2)
        #expect(Radix.binary.digits == ["0", "1"])
    }

    @Test
    func `octal has base eight`() {
        #expect(Radix.octal.base == 8)
        #expect(Radix.octal.digit(for: 7) == "7")
    }

    @Test
    func `decimal has base ten`() {
        #expect(Radix.decimal.base == 10)
        #expect(Radix.decimal.digit(for: 9) == "9")
    }

    @Test
    func `hexadecimal has base sixteen with lowercase alphabet`() {
        #expect(Radix.hexadecimal.base == 16)
        #expect(Radix.hexadecimal.digit(for: 10) == "a")
        #expect(Radix.hexadecimal.digit(for: 15) == "f")
    }
}

extension Radix.Test.Mapping {
    @Test
    func `digit for value returns the glyph`() {
        #expect(Radix.decimal.digit(for: 0) == "0")
        #expect(Radix.hexadecimal.digit(for: 12) == "c")
    }

    @Test
    func `digit for out of range value is nil`() {
        #expect(Radix.binary.digit(for: 2) == nil)
        #expect(Radix.decimal.digit(for: -1) == nil)
        #expect(Radix.hexadecimal.digit(for: 16) == nil)
    }

    @Test
    func `value of glyph returns the digit value`() {
        #expect(Radix.decimal.value(of: "7") == 7)
        #expect(Radix.hexadecimal.value(of: "a") == 10)
        #expect(Radix.hexadecimal.value(of: "f") == 15)
    }

    @Test
    func `value of unknown glyph is nil`() {
        #expect(Radix.binary.value(of: "2") == nil)
        #expect(Radix.hexadecimal.value(of: "g") == nil)
    }

    @Test
    func `hexadecimal value lookup is case insensitive`() {
        #expect(Radix.hexadecimal.value(of: "A") == 10)
        #expect(Radix.hexadecimal.value(of: "F") == 15)
        #expect(Radix.hexadecimal.value(of: "a") == Radix.hexadecimal.value(of: "A"))
    }

    @Test
    func `round trips value through glyph`() {
        (0..<Radix.hexadecimal.base).forEach { value in
            let glyph = Radix.hexadecimal.digit(for: value)
            #expect(glyph != nil)
            if let glyph {
                #expect(Radix.hexadecimal.value(of: glyph) == value)
            }
        }
    }
}

extension Radix.Test.Construction {
    @Test
    func `custom radix maps by alphabet position`() throws(Radix.Error) {
        let base4 = try Radix(digits: ["w", "x", "y", "z"])
        #expect(base4.base == 4)
        #expect(base4.digit(for: 2) == "y")
        #expect(base4.value(of: "z") == 3)
    }

    @Test
    func `case sensitive radix distinguishes letter case`() throws(Radix.Error) {
        let radix = try Radix(digits: ["a", "A"], casing: .sensitive)
        #expect(radix.value(of: "a") == 0)
        #expect(radix.value(of: "A") == 1)
    }

    @Test
    func `case insensitive radix folds letter case`() throws(Radix.Error) {
        let radix = try Radix(digits: ["a", "b", "c"], casing: .insensitive)
        #expect(radix.value(of: "B") == 1)
    }

    @Test
    func `insufficient digits throws`() {
        #expect(throws: Radix.Error.insufficientDigits(count: 1)) {
            _ = try Radix(digits: ["0"])
        }
    }

    @Test
    func `duplicate digit throws`() {
        #expect(throws: Radix.Error.duplicateDigit("x")) {
            _ = try Radix(digits: ["x", "y", "x"])
        }
    }

    @Test
    func `case insensitive duplicate is detected across letter case`() {
        #expect(throws: Radix.Error.duplicateDigit("A")) {
            _ = try Radix(digits: ["a", "A"], casing: .insensitive)
        }
    }
}

extension Radix.Test.`Edge Case` {
    @Test
    func `non letter glyphs are unaffected by case folding`() throws(Radix.Error) {
        let radix = try Radix(digits: ["!", "@", "#"], casing: .insensitive)
        #expect(radix.value(of: "@") == 1)
        #expect(radix.value(of: "?") == nil)
    }

    @Test
    func `radix is sendable value type`() {
        let copy = Radix.hexadecimal
        #expect(copy.base == 16)
    }
}
