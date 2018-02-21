//
//  DependencyContainerTests.swift
//  BeaverDITests
//
//  Created by Théophane Rupin on 2/20/18.
//

import Foundation
import XCTest

@testable import BeaverDI

final class DependencyContainerTests: XCTestCase {
    
    var instanceCacheMock: InstanceCacheMock!
    var builderStoreMock: BuilderStoreMock!
    var dependencyContainer: DependencyContainer!
    
    override func setUp() {
        super.setUp()

        instanceCacheMock = InstanceCacheMock()
        builderStoreMock = BuilderStoreMock()
        dependencyContainer = DependencyContainer(builderStore: builderStoreMock, instanceCache: instanceCacheMock)
    }

    // MARK: - Register / Resolve
    
    func testRegisterThenResolveWithNoParameterShouldBuildTheDependency() {
        
        var builderCallCount = 0
        
        dependencyContainer.register(DependencyStub.self, scope: .graph) { dependencies in
            builderCallCount += 1
            return DependencyStub(dependencies: dependencies)
        }
        
        _ = dependencyContainer.resolve(DependencyStub.self)
        
        let instanceKey = InstanceKey(for: DependencyStub.self)

        XCTAssertEqual(builderCallCount, 1)
        XCTAssertEqual(instanceCacheMock.cacheCallCount, 1)
        XCTAssertEqual(instanceCacheMock.key, instanceKey)
        XCTAssertEqual(instanceCacheMock.scope, .graph)

        XCTAssertEqual(builderStoreMock.getCallCount, 1)
        XCTAssertEqual(builderStoreMock.setCallCount, 1)
        XCTAssertEqual(builderStoreMock.scope, .graph)
        XCTAssertEqual(builderStoreMock.key, instanceKey)
    }
    
    func testRegisterThenResolveWithOneParameterShouldBuildTheDependency() {
        
        var builderCallCount = 0
        
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int) in
            builderCallCount += 1
            return DependencyStub(dependencies: dependencies, parameter1: parameter1)
        }
        
        let dependency = dependencyContainer.resolve(DependencyStub.self, parameter: 42)
        
        let instanceKey = InstanceKey(for: DependencyStub.self, parameterType: Int.self)
        
        XCTAssertEqual(builderCallCount, 1)
        XCTAssertEqual(instanceCacheMock.cacheCallCount, 1)
        XCTAssertEqual(instanceCacheMock.key, instanceKey)
        XCTAssertEqual(instanceCacheMock.scope, .graph)
    
        XCTAssertEqual(dependency.parameter1, 42)
        
        XCTAssertEqual(builderStoreMock.getCallCount, 1)
        XCTAssertEqual(builderStoreMock.setCallCount, 1)
        XCTAssertEqual(builderStoreMock.scope, .graph)
        XCTAssertEqual(builderStoreMock.key, instanceKey)
    }

    func testRegisterThenResolveWithTwoParametersShouldBuildTheDependency() {
        
        var builderCallCount = 0
        
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int, parameter2: String) in
            builderCallCount += 1
            return DependencyStub(dependencies: dependencies, parameter1: parameter1, parameter2: parameter2)
        }
        
        let dependency = dependencyContainer.resolve(DependencyStub.self, parameters: 42, "43")
        
        let instanceKey = InstanceKey(for: DependencyStub.self, parameterTypes: Int.self, String.self)

        XCTAssertEqual(builderCallCount, 1)
        XCTAssertEqual(instanceCacheMock.cacheCallCount, 1)
        XCTAssertEqual(instanceCacheMock.key, instanceKey)
        XCTAssertEqual(instanceCacheMock.scope, .graph)
        
        XCTAssertEqual(dependency.parameter1, 42)
        XCTAssertEqual(dependency.parameter2, "43")
        
        XCTAssertEqual(builderStoreMock.getCallCount, 1)
        XCTAssertEqual(builderStoreMock.setCallCount, 1)
        XCTAssertEqual(builderStoreMock.scope, .graph)
        XCTAssertEqual(builderStoreMock.key, instanceKey)
    }
    
    func testRegisterThenResolveWithThreeParametersShouldBuildTheDependency() {
        
        var builderCallCount = 0
        
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int, parameter2: String, parameter3: Double) in
            builderCallCount += 1
            return DependencyStub(dependencies: dependencies, parameter1: parameter1, parameter2: parameter2, parameter3: parameter3)
        }
        
        let dependency = dependencyContainer.resolve(DependencyStub.self, parameters: 42, "43", 44.0)
        
        let instanceKey = InstanceKey(for: DependencyStub.self, parameterTypes: Int.self, String.self, Double.self)
        
        XCTAssertEqual(builderCallCount, 1)
        XCTAssertEqual(instanceCacheMock.cacheCallCount, 1)
        XCTAssertEqual(instanceCacheMock.key, instanceKey)
        XCTAssertEqual(instanceCacheMock.scope, .graph)
        
        XCTAssertEqual(dependency.parameter1, 42)
        XCTAssertEqual(dependency.parameter2, "43")
        XCTAssertEqual(dependency.parameter3, 44.0)
        
        XCTAssertEqual(builderStoreMock.getCallCount, 1)
        XCTAssertEqual(builderStoreMock.setCallCount, 1)
        XCTAssertEqual(builderStoreMock.scope, .graph)
        XCTAssertEqual(builderStoreMock.key, instanceKey)
    }
    
    func testRegisterThenResolveWithFourParametersShouldBuildTheDependency() {
        
        var builderCallCount = 0
        
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int, parameter2: String, parameter3: Double, parameter4: Float) in
            builderCallCount += 1
            return DependencyStub(dependencies: dependencies, parameter1: parameter1, parameter2: parameter2, parameter3: parameter3, parameter4: parameter4)
        }
        
        let dependency = dependencyContainer.resolve(DependencyStub.self, parameters: 42, "43", 44.0, 45 as Float)
        
        let instanceKey = InstanceKey(for: DependencyStub.self, parameterTypes: Int.self, String.self, Double.self, Float.self)
        
        XCTAssertEqual(builderCallCount, 1)
        XCTAssertEqual(instanceCacheMock.cacheCallCount, 1)
        XCTAssertEqual(instanceCacheMock.key, instanceKey)
        XCTAssertEqual(instanceCacheMock.scope, .graph)
        
        XCTAssertEqual(dependency.parameter1, 42)
        XCTAssertEqual(dependency.parameter2, "43")
        XCTAssertEqual(dependency.parameter3, 44.0)
        XCTAssertEqual(dependency.parameter4, 45 as Float)
        
        XCTAssertEqual(builderStoreMock.getCallCount, 1)
        XCTAssertEqual(builderStoreMock.setCallCount, 1)
        XCTAssertEqual(builderStoreMock.scope, .graph)
        XCTAssertEqual(builderStoreMock.key, instanceKey)
    }

    // MARK: - Retain cycle
    
    func testContainerShouldDeallocateAfterCallingRegisterAndResoveWithNoParameter() {
        
        weak var weakDependencyContainer: DependencyContainer? = dependencyContainer
        dependencyContainer.register(DependencyStub.self, scope: .graph) { dependencies in
            return DependencyStub(dependencies: dependencies)
        }
        _ = dependencyContainer.resolve(DependencyStub.self)
        dependencyContainer = nil
        
        XCTAssertNil(weakDependencyContainer)
    }
    
    func testContainerShouldDeallocateAfterCallingRegisterAndResoveWithOneParameter() {
        
        weak var weakDependencyContainer: DependencyContainer? = dependencyContainer
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int) in
            return DependencyStub(dependencies: dependencies, parameter1: parameter1)
        }
        _ = dependencyContainer.resolve(DependencyStub.self, parameter: 42)
        dependencyContainer = nil
        
        XCTAssertNil(weakDependencyContainer)
    }

    func testContainerShouldDeallocateAfterCallingRegisterAndResoveWithTwoParameters() {
        
        weak var weakDependencyContainer: DependencyContainer? = dependencyContainer
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int, parameter2: String) in
            return DependencyStub(dependencies: dependencies, parameter1: parameter1, parameter2: parameter2)
        }
        _ = dependencyContainer.resolve(DependencyStub.self, parameters: 42, "43")
        dependencyContainer = nil
        
        XCTAssertNil(weakDependencyContainer)
    }

    func testContainerShouldDeallocateAfterCallingRegisterAndResoveWithThreeParameters() {
        
        weak var weakDependencyContainer: DependencyContainer? = dependencyContainer
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int, parameter2: String, parameter3: Double) in
            return DependencyStub(dependencies: dependencies, parameter1: parameter1, parameter2: parameter2, parameter3: parameter3)
        }
        _ = dependencyContainer.resolve(DependencyStub.self, parameters: 42, "43", 44.0)
        dependencyContainer = nil
        
        XCTAssertNil(weakDependencyContainer)
    }
    
    func testContainerShouldDeallocateAfterCallingRegisterAndResoveWithFourParameters() {
        
        weak var weakDependencyContainer: DependencyContainer? = dependencyContainer
        dependencyContainer.register(DependencyStub.self, scope: .graph) { (dependencies: DependencyResolver, parameter1: Int, parameter2: String, parameter3: Double, parameter4: Float) in
            return DependencyStub(dependencies: dependencies, parameter1: parameter1, parameter2: parameter2, parameter3: parameter3, parameter4: parameter4)
        }
        _ = dependencyContainer.resolve(DependencyStub.self, parameters: 42, "43", 44.0, 45 as Float)
        dependencyContainer = nil
        
        XCTAssertNil(weakDependencyContainer)
    }
}

// MARK: - Stubs

private extension DependencyContainerTests {
    
    final class DependencyStub {
        
        let dependencies: DependencyResolver
        
        let parameter1: Int
        let parameter2: String
        let parameter3: Double
        let parameter4: Float
        
        init(dependencies: DependencyResolver,
             parameter1: Int = 0,
             parameter2: String = "",
             parameter3: Double = 0,
             parameter4: Float = 0) {
            
            self.dependencies = dependencies
            self.parameter1 = parameter1
            self.parameter2 = parameter2
            self.parameter3 = parameter3
            self.parameter4 = parameter4
        }
    }
}
