//
//  PickerView.swift
//  DatePickerHandler
//
//  Created by Chetu Mac on 01/07/20.
//  Copyright © 2020 Chetu Mac. All rights reserved.
//

import Foundation
import UIKit

class  PickerView:UIView {
    var pickerView : UIPickerView! {
        didSet {
            pickerView.dataSource = self
            pickerView.delegate = self
        }
    }
    private var callBack :(_ index:Int, _ value:Any?) -> ()? = {(index:Int, value:Any?) in }
    let height = 190.0
    var arrayList = [String]()
    var textField = UITextField()
    var nexttextField = UIResponder()
    var index : Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    @discardableResult
    convenience init(_ textField:UITextField,  view:UIView,  list:[String],  _ completionHandler:@escaping (_ index:Int, _ value:Any?) -> Void) {
        self.init()
        self.arrayList = list
        self.textField = textField
        self.nexttextField = view.viewWithTag(textField.tag + 1) as? UITextField ?? UITextField()
         pickerView = UIPickerView(frame: CGRect(x: 0.0, y: Double(view.frame.height) - height, width: Double(view.frame.width), height: height))
        textField.inputView = pickerView
        //pickerView.backgroundColor = .black
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.reloadAllComponents()
        pickerView.backgroundColor = .lightGray
        view.addSubview(self)
        addToolBar()
        callBack = completionHandler
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToolBar () {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
         let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneHandler))
         let fixedSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelBtn))
        toolbar.setItems([doneButton, fixedSpace , cancelBtn], animated: false)
        textField.inputAccessoryView = toolbar
      
    }
    
    @objc  func doneHandler (){
             self.callBack(self.pickerView.selectedRow(inComponent: 0), self.arrayList[self.pickerView.selectedRow(inComponent: 0)].capitalized)
           textField.resignFirstResponder()
           nexttextField.becomeFirstResponder()
          
        //self.removeFromSuperview()
    }
    
    @objc func tapCancelBtn() {
        textField.resignFirstResponder()
        self.removeFromSuperview()
    }
}

extension  PickerView : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      // callBack(row, arrayList[row])
        //textField.text = arrayList[row]
    }
    
    
}

extension PickerView: UIPickerViewDelegate {
    
}
