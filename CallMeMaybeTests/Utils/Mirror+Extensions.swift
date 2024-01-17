extension Mirror {

    static func extract<T>(_ name: StaticString, from testClass: AnyObject) -> T? {
        Mirror(reflecting: testClass).descendant("\(name)") as? T
    }
}
