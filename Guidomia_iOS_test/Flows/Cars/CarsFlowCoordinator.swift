//
//  CarsFlowCoordinator.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

class CarsFlowCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
        
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let carsListViewController = CarsListViewController()
        self.navigationController.pushViewController(carsListViewController, animated: true)
    }
    
}
