# Radix

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A `Radix` pairs a positional numeral base with its ordered digit alphabet and maps single digits between numeric value and glyph. Foundation-free, with zero dependencies.

---

## Quick Start

```swift
import Radix

let hex = Radix.hexadecimal
hex.base                       // 16
hex.digit(for: 10)             // "a"   — value → glyph
hex.value(of: "A")             // 10    — glyph → value (hex is case-insensitive)
hex.value(of: "g")             // nil   — not a hex digit
```

The four standard numeral radixes are provided as values:

```swift
Radix.binary.base              // 2
Radix.octal.digit(for: 7)      // "7"
Radix.decimal.value(of: "9")   // 9
Radix.hexadecimal.digit(for: 15) // "f"
```

Build a custom radix from its alphabet — the initializer validates that there are at least two distinct digits:

```swift
let base4 = try Radix(digits: ["w", "x", "y", "z"])
base4.base                     // 4
base4.value(of: "y")           // 2
```

### A model, not a formatter

Rendering an integer to a base-N string needs a digit alphabet *and* a division-and-remainder algorithm. `Radix` owns the first half — the alphabet and the per-digit mapping — so that every formatter agrees on what "base 16" means before any of them decides how to spell a whole number. The model is a frozen value type, `Sendable`, and validated at construction; it deliberately stops short of rendering whole integers, which is a separate formatter concern.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-radix.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Radix", package: "swift-radix"),
    ]
)
```

The package is pre-1.0 — until 0.1.0 is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`. Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

| Product | Target | Purpose |
|---------|--------|---------|
| `Radix` | `Sources/Radix/` | The `Radix` model — the type, the standard `binary` / `octal` / `decimal` / `hexadecimal` radixes, digit mapping (`base`, `digit(for:)`, `value(of:)`), and validating construction. Import this. |
| `Radix Standard Library Integration` | `Sources/Radix Standard Library Integration/` | Extensions of and conformances to Swift standard library types and protocols. |
| `Radix Apple Foundation Integration` | `Sources/Radix Apple Foundation Integration/` | The only module allowed to import Foundation. |

The package depends only on the Swift standard library. Digit glyphs are `Unicode.Scalar`; digit values are `Int`. Case folding for case-insensitive radixes is ASCII-only, keeping the model usable from Embedded Swift. Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Embedded Swift | Supported |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
