/// This file is generated by Weaver 0.10.2
/// DO NOT EDIT!
// MARK: - FooTest6
protocol FooTest6DependencyResolver {
    var fuu: FuuProtocolTest6? { get }
}
final class FooTest6DependencyContainer: FooTest6DependencyResolver {
    private var _fuu: FuuProtocolTest6??
    var fuu: FuuProtocolTest6? {
        if let value = _fuu { return value }
        let value = FuuTest6()
        _fuu = value
        return value
    }
    init() {
        _ = fuu
    }
}
