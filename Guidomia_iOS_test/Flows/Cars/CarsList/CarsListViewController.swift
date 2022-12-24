//
//  CarsListViewController.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

class CarsListViewController: UIViewController {
    
    // MARK: - Initializers

    static func instantiate(viewModel: CarsListViewModel) -> CarsListViewController {
        let controller = CarsListViewController()
        viewModel.delegate = controller
        controller.viewModel = viewModel
        return controller
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: CarsListViewModel!
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Guidomia".uppercased()
        setupTableView()
        self.viewModel.fetchList()
    }
    
}

extension CarsListViewController {
    // MARK: - Methods
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: CarInfosViewCell.className, bundle: nil), forCellReuseIdentifier: CarInfosViewCell.className)
        self.tableView.register(UINib(nibName: CarsListSeparationViewFooter.className, bundle: nil), forHeaderFooterViewReuseIdentifier: CarsListSeparationViewFooter.className)
        self.tableView.register(UINib(nibName: CarFilterHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: CarFilterHeaderView.className)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CarsListViewController: CarsListViewModelDelegate {
    // MARK: CarsListViewModelDelegate
    func reloadData() {
        self.tableView.reloadData()
    }
    
}

extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: UITableViewDataSource, UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.noDataList ? 1 : viewModel.viewDataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.noDataList ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CarInfosViewCell.className, for: indexPath) as? CarInfosViewCell {
            cell.config(with: viewModel.viewDataList[indexPath.section])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.noDataList ? 0 : 24
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard !viewModel.noDataList else { return UIView() }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CarsListSeparationViewFooter.className) as? CarsListSeparationViewFooter
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectCar(index: indexPath.section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CarFilterHeaderView.className) as? CarFilterHeaderView
        view?.config(with: viewModel.filterData)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 440 : 0
    }
}
