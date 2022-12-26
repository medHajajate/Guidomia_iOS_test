//
//  CarsFlowCoordinator.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

protocol CarsFlowCoordinatorDelegate: AnyObject {
    func openNextViewController()
}

class CarsFlowCoordinator: Coordinator {
    
    var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    weak var delegate: CarsFlowCoordinatorDelegate?
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
        self.setupNavigation()
    }
    
    func start() {
        let service = CarsListService(dataParser: JSONFileParser())
        let viewModel = CarsListViewModel(service: service)
        let carsListViewController = CarsListViewController.instantiate(viewModel: viewModel)
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
