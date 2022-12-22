//
//  CarsListViewController.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 22/12/2022.
//

import UIKit

class CarsListViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Guidomia".uppercased()
        setupTableView()
    }
    
}

extension CarsListViewController {
    // MARK: - Methods
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: CarInfosViewCell.className, bundle: nil), forCellReuseIdentifier: CarInfosViewCell.className)
        self.tableView.register(UINib(nibName: CarsListSeparationViewFooter.className, bundle: nil), forHeaderFooterViewReuseIdentifier: CarsListSeparationViewFooter.className)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CarsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CarInfosViewCell.className, for: indexPath) as? CarInfosViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CarsListSeparationViewFooter.className) as? CarsListSeparationViewFooter
        return view
    }
}
