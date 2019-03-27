print("every COLORS in COLOR\n")
for colors in Color.allColors {
    print("raw value : " + String(colors.rawValue) + "\nhash value : " + String(colors.hashValue))
}

print("\nevery VALUES in VALUE\n")
for values in Value.allValues {
    print(values)
    print("raw value : " + String(values.rawValue) + "\nhash value : " + String(values.hashValue))
}