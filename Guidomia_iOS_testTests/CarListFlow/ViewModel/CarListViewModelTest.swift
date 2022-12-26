//
//  CarListViewModelTest.swift
//  Guidomia_iOS_testTests
//
//  Created by Hajajate  on 25/12/2022.
//

import XCTest
@testable import Guidomia_iOS_test

class CarListViewModelTest: XCTestCase {
    
    func makeViewModelSUTValideData() -> CarsListViewModel {
        let service = CarListServiceMock(fileName: "test_car_list")
        return CarsListViewModel(service: service)
    }
    
    func makeViewModelSUTNotValideData() -> CarsListViewModel {
        let service = CarListServiceMock(fileName: "invalid_test_car_list")
        return CarsListViewModel(service: service)
    }
    
    func testFetchCarsSucceed() {
        
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        XCTAssertEqual(vm.cars.count, 4)
        XCTAssertEqual(vm.cars.first?.make, "Land Rover")
        XCTAssertEqual(vm.cars.first?.rating, 3)
    }
    
    func testFetchCarsFailed() {
        let vm = makeViewModelSUTNotValideData()
        vm.fetchList()
        XCTAssertEqual(vm.cars.count, 0)
    }
    
    func testViewDataCellNotEmptyWithSucceed() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        XCTAssertEqual(vm.viewDataList.count, 4)
        XCTAssertEqual(vm.viewDataList.first?.price, "Price : 125k")
    }
    
    func testCreateViewDataFiltrList() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        vm.buildFilterList(cars: vm.cars)
        XCTAssertNil(vm.filterData?.makeFilter)
        XCTAssertEqual(vm.filterData?.modelList?.first, "")
        XCTAssertEqual(vm.filterData?.modelList?[1], "Range Rover")
    }
    
    
    func testSelectionCell() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        vm.didSelectCar(index: 3)
        XCTAssertTrue(vm.viewDataList[3].isExpandable)
    }
    
    func testApplyFilterWithMakeValue() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        vm.buildFilterList(cars: vm.cars)
        vm.filterMake = "BMW"
        vm.applyFilter()
        XCTAssertEqual(vm.viewDataList.count, 1)
        XCTAssertEqual(vm.viewDataList.first?.name, "3300i")
    }
    
    func testApplyFilterWithModelValue() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        vm.buildFilterList(cars: vm.cars)
        vm.filterModel = "3300i"
        vm.applyFilter()
        XCTAssertEqual(vm.viewDataList.count, 1)
        XCTAssertEqual(vm.viewDataList.first?.name, "3300i")
    }
    
    func testApplyFilterWithBothMakeAndModelValue() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        vm.buildFilterList(cars: vm.cars)
        vm.filterMake = "BMW"
        vm.filterModel = "3300i"
        vm.applyFilter()
        XCTAssertEqual(vm.viewDataList.count, 1)
        XCTAssertEqual(vm.viewDataList.first?.name, "3300i")
    }
    
    func testApplyFilterWithWrongValue() {
        let vm = makeViewModelSUTValideData()
        vm.fetchList()
        vm.buildFilterList(cars: vm.cars)
        vm.filterMake = "Golf"
        vm.applyFilter()
        XCTAssertEqual(vm.viewDataList.count, 0)
        XCTAssertNotEqual(vm.viewDataList.first?.name, "3300i")
    }
}
