//
//  AppCoordinator.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

protocol Coordinator : AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}


class AppCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.openCarsFlow()
    }
    
    func openCarsFlow() {
        let coordinator = CarsFlowCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        children.append(coordinator)
        coordinator.start()
    }
}
