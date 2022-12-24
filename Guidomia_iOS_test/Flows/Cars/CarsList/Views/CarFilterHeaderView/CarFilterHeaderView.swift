//
//  CarFilterHeaderView.swift
//  Guidomia_iOS_test
//
//  Created by Hajajate  on 24/12/2022.
//

import UIKit

class CarFilterHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!

    // MARK: - Properties
    
    var data: Data?
    var makePiker: UIPickerView?
    var modelPiker: UIPickerView?
    
    // MARK: - ViewLifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Methods
    
    func config(with data: Data?) {
        self.data = data
        if (data?.makeList?.count ?? 0) > 0 {
            configMakePicker()
        }
        if (data?.modelList?.count ?? 0) > 0 {
            configModelPicker()
        }
    }
    
    private func setupView() {
        filterView.layer.cornerRadius = 5
        filterView.layer.masksToBounds = true
    }
    
    private func configMakePicker() {
        makePiker = UIPickerView()
        makePiker?.backgroundColor = .white
        makePiker?.delegate = self
        makePiker?.dataSource = self
        makeTextField.inputView = makePiker
        makeTextField.inputAccessoryView = setupToolBar()
    }
    
    private func configModelPicker() {
        modelPiker = UIPickerView()
        modelPiker?.backgroundColor = .white
        modelPiker?.delegate = self
        modelPiker?.dataSource = self
        modelTextField.inputView = modelPiker
        modelTextField.inputAccessoryView = setupToolBar()
    }
    
    private func setupToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: nil)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(dismissPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    @objc private func dismissPicker() {
        self.makeTextField.resignFirstResponder()
        self.modelTextField.resignFirstResponder()
    }
}

extension CarFilterHeaderView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == makePiker ? (data?.makeList?.count ?? 0) : (data?.modelList?.count ?? 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == makePiker ? data?.makeList?[row] : data?.modelList?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == makePiker, let make = data?.makeList?[row] {
            makeTextField.text = make
        } else if let model = data?.modelList?[row] {
            modelTextField.text = model
        }
    }
}

extension CarFilterHeaderView {
    
    struct Data {
        let makeList: [String]?
        let modelList: [String]?
    }
}