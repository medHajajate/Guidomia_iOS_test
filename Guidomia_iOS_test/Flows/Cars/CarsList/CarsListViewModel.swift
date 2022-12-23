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
    var carsList = [CarInfosViewCell.Data]()
    
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
                self.carsList = self.builder.buildCarsList(cars: list)
                self.selectedCar(index: self.carsList.startIndex)
                self.delegate?.reloadData()
            case.failure( let error):
                self.carsList = []
                print(error)
            }
        }
    }
    
    func didSelectCar(index: Int) {
        selectedCar(index: index)
        self.delegate?.reloadData()
    }
    
    private func selectedCar(index: Int) {
        for i in 0 ..< carsList.count {
            carsList[i].isExpandable = i == index
        }
    }
}
