//
//  AppCoordinator.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: AppCoordinator? { get }
    var navigationController : UINavigationController { get set }
    func start()
}

class AppCoordinator {
    
    var navigationController: UINavigationController
    
    // MARK: Childs Coordinator
    
    var carsFlowCoordinator: CarsFlowCoordinator?
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.openCarsFlow()
    }
    
    func openCarsFlow() {
        let coordinator = CarsFlowCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        coordinator.delegate = self
        self.carsFlowCoordinator = coordinator
        coordinator.start()
    }
}

extension AppCoordinator: CarsFlowCoordinatorDelegate {
    
    func openNextViewController() {}
}
