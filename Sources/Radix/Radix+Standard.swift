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
