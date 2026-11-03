# swift-radix

Use this package when you need to turn single digit values into glyphs and back for a positional numeral system: one of the standard bases (`Radix.binary`, `Radix.octal`, `Radix.decimal`, `Radix.hexadecimal`) or your own alphabet built with `Radix(digits:casing:)`. Start from `Radix`. It maps one digit at a time. It does not parse or format whole numbers.

## Laws

- A digit's value is its position in `digits`. `digit(for:)` and `value(of:)` are inverses for every value in `0..<base`. Any value outside that range, and any glyph not in the alphabet, gives `nil`.
- An alphabet must have at least two digits, and no two of them may be equal. Under `Radix.Casing.insensitive`, two digits count as equal when they are equal after case folding, so `["a", "A"]` is rejected. The error reports the first glyph that repeats an earlier one, exactly as that later glyph is spelled.
- Case folding covers ASCII only: `A` to `Z` fold to `a` to `z`. Every other scalar, including non-ASCII letters, compares exactly.
- Case folding applies only to lookup. A `Radix.Casing.insensitive` radix keeps its glyphs exactly as given, so `digit(for:)` always returns the stored glyph. `Radix.hexadecimal` returns lowercase digits and accepts both cases in `value(of:)`. `Radix.binary`, `Radix.octal` and `Radix.decimal` are `Radix.Casing.sensitive`.
