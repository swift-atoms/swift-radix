extension Radix {

    public enum Error: Swift.Error, Sendable, Equatable, Hashable {

        case insufficientDigits(count: Int)

        case duplicateDigit(Unicode.Scalar)
    }
}
