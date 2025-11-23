# Test Guidelines

## One Assertion Per Test

- Each test must have exactly one `expect_*()` call.
- Combine related assertions using composite expectations (e.g., list comparisons) if needed, but keep the test atomic.

## Behavior-Focused Testing

- Tests should focus on behaviour and outputs rather than implementation details.
- Tests will verify return types, error conditions, and key properties without examining internal structure.
- Avoid coupling tests to function implementation details (e.g., column names, internal data ordering).
- A test passes if the function returns the correct type, raises the expected error, or meets the contract—regardless of how it achieves that internally.
