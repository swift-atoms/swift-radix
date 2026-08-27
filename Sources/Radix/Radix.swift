@frozen
public struct Radix {

    public let digits: [Unicode.Scalar]

    public let casing: Casing

    package init(_ digits: [Unicode.Scalar], casing: Casing) {
        self.digits = digits
        self.casing = casing
    }
}

extension Radix: Sendable {}
