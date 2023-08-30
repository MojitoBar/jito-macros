import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(Jito)
import Jito
#endif

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(JitoMacros)
import JitoMacros

let testMacros: [String: Macro.Type] = [
    "stringify": StringifyMacro.self,
    "unwrap": UnwrapMacro.self,
]
#endif

final class JitoTests: XCTestCase {
    func testMacro() throws {
        let abc: Int? = nil
        #unwrap(abc, message: "abc가 nil 입니다.")
    }

    func testMacroWithStringLiteral() throws {
        #if canImport(JitoMacros)
        assertMacroExpansion(
            #"""
            #unwrap(value, "message")
            """#,
            expandedSource: #"""
            guard let value = value else {
                fatalError("message")
            }

            return value
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
