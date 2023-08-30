import Jito

let a = 17
let b = 25

let (result, code) = #stringify(a + b)

print("The value \(result) was produced by the code \"\(code)\"")

let c: Int? = nil

let value = #unwrap(c, message: "value is empty")

print(value)
