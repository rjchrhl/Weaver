/// This file is generated by Weaver 0.10.3
/// DO NOT EDIT!
import Foundation
// MARK: - FooTest16
@objc protocol FooTest16DependencyResolver {
    var fuu: FuuTest16 { get }
}
final class FooTest16DependencyContainer: NSObject, FooTest16DependencyResolver {
    private var _fuu: FuuTest16?
    var fuu: FuuTest16 {
        if let value = _fuu { return value }
        let value = FuuTest16()
        _fuu = value
        return value
    }
    override init() {
        super.init()
        _ = fuu
    }
}
protocol FooTest16ObjCDependencyInjectable {}
