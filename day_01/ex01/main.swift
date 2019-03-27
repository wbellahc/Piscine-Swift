let r = Card(color: Color.red, value: Value.Two)
let s = Card(color: Color.black, value: Value.Six)
let t = r
print(r)
print(s)

if (r == s) {
    print("the first card == the second card")
} else {
    print ("the first card ==! the second card")
}

print("\n")
print(r)
print(t)
if (r == t) {
    print("the first card == the second card")
} else {
    print ("the first card ==! the second card")
}

let first = Card(color: Color.orange, value: Value.Seven)
let second = Card(color: Color.orange, value: Value.Seven)
let third = r
print("\n")
print(first)
print(second)
if first.isEqual(second) {
    print("the two Cards are equals")
} else {
    print ("the two Cards are equals")
}

print("\n")
print(first)
print(third)
if first.isEqual(third) {
    print("the two Cards are equals")
} else {
    print ("the two Cards are not equals")
}