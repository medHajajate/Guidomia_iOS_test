//
//  CarsListViewModel.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import Foundation

protocol CarsListViewModelDelegate: NSObject {
    func reloadData()
}

class CarsListViewModel {
    
    // MARK: - Properties
    
    weak var delegate: CarsListViewModelDelegate?
    var service: CarsListService
    let builder = BuilderCarsList()
    var cars = [Car]()
    var viewDataList = [CarInfosViewCell.Data]()
    var filterData: CarFilterHeaderView.Data?
    
    var noDataList: Bool {
        return viewDataList.count == 0
    }
    
    var filterMake: String?
    var filterModel: String?

    // MARK: - Initializers
    
    init() {
        self.service = CarsListService(dataParser: JSONFileParser())
    }
    
    // MARK: - Methods
    
    func fetchList() {
        self.service.fetchCarList { result in
            switch result {
            case .success(let list):
                print(list)
                self.cars = list
                self.viewDataList = self.builder.buildCarsList(cars: list)
                self.buildFilterList(cars: list)
                self.didSelectCar(index: self.viewDataList.startIndex)
            case.failure( let error):
                self.viewDataList = []
                print(error)
            }
        }
    }
    
    func buildFilterList(cars: [Car]) {
        let applyFilterMake: (String?) -> Void =  { make in
            self.filterMake = make
            self.applyFilter()
        }
        let applyFilterModel: (String?) -> Void = { model in
            self.filterModel = model
            self.applyFilter()
        }
        self.filterData = self.builder.buildFilterList(cars: cars,
                                                       makeFilter: self.filterMake,
                                                       modelFilter: self.filterModel,
                                                       filterMake: applyFilterMake,
                                                       filterModel: applyFilterModel)
    }
    
    func didSelectCar(index: Int) {
        selectedCar(index: index)
        self.delegate?.reloadData()
    }
    
    func resetFilter() {
        self.filterModel = nil
        self.filterMake = nil
        self.viewDataList = self.builder.buildCarsList(cars: self.cars)
        buildFilterList(cars: cars)
        self.didSelectCar(index: self.viewDataList.startIndex)
    }
    
    private func selectedCar(index: Int) {
        for i in 0 ..< viewDataList.count {
            viewDataList[i].isExpandable = i == index
        }
    }
    
    private func applyFilter() {
        
        let filterdList = cars.filter { car in
            if let make = filterMake, car.make != make {
                return false
            }
            
            if let model = filterModel, car.model != model {
                return false
            }
            
            return true
            
        }
        self.viewDataList = self.builder.buildCarsList(cars: Array(Set(filterdList)))
        self.didSelectCar(index: self.viewDataList.startIndex)
    }
}
