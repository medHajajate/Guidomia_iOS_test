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
            let filterdList = cars.filter { $0.make == make }
            self.viewDataList = self.builder.buildCarsList(cars: filterdList)
            self.didSelectCar(index: self.viewDataList.startIndex)
        }
        let applyFilterModel: (String?) -> Void = { model in
            let filterdList = cars.filter { $0.model == model }
            self.viewDataList = self.builder.buildCarsList(cars: filterdList)
            self.didSelectCar(index: self.viewDataList.startIndex)
        }
        self.filterData = self.builder.buildFilterList(cars: cars, filterMake: applyFilterMake, filterModel: applyFilterModel)
    }
    
    func didSelectCar(index: Int) {
        selectedCar(index: index)
        self.delegate?.reloadData()
    }
    
    private func selectedCar(index: Int) {
        for i in 0 ..< viewDataList.count {
            viewDataList[i].isExpandable = i == index
        }
    }
}
