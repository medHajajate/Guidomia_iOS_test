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
        self.setupNavigation()
    }
    
    func start() {
        let carsListViewController = CarsListViewController.instantiate(viewModel: CarsListViewModel())
        self.navigationController.pushViewController(carsListViewController, animated: true)
    }
    
    private func setupNavigation() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .orange
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController.navigationBar.tintColor = UIColor.orange
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
}
