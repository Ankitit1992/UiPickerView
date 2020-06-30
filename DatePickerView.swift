//
//  DatePickerView.swift
//  DatePickerHandler
//
//  Created by Chetu Mac on 01/07/20.
//  Copyright © 2020 Chetu Mac. All rights reserved.
//

import Foundation
import UIKit
let pickerTopMargin: CGFloat = 0

class DatePickerView: UIView {
        //MARK:- ----------Closures----------
        private var callBack = {(response: Any?) -> () in
        }
        
        //MARK:- ----------Public Variables----------
        var pickerView: UIDatePicker!
        var viewContainer: UIView!
        var textField: UITextField!
        let toolbar = UIToolbar()
        var nexttextField = UIResponder()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        //MARK:- ----------Initializer Methods----------
    convenience init(view: UIView, pickerMode mode: UIDatePicker.Mode,textField:UITextField, handler completionBlock: @escaping (_ response: Any?) -> ())
        {
            self.init()
            //let rect = view.bounds
           //self.init(frame: rect)
              self.textField = textField
             self.nexttextField = view.viewWithTag(textField.tag + 1) as? UITextField ?? UITextField()
            pickerView = UIDatePicker(frame: CGRect(x: 0.0, y: Double(view.frame.height) - 190, width: Double(UIScreen.main.bounds.width), height: 190))
            pickerView.date = Date()
            pickerView.datePickerMode = mode
            textField.inputView = pickerView
             view.addSubview(self)
            addToolBar()
           
            callBack = completionBlock
        }
        
       
        
        required init?(coder aDecoder: NSCoder)
        {
            fatalError("init(coder:) has not been implemented")
        }
        
        //MARK:- ----------Public Methods----------
   
        func setMinimumDate(date: Date){
            pickerView.minimumDate = date
        }
        
        func setMaximumDate(date: Date){
            pickerView.maximumDate = date
        }
        
        func setCurrentDate(date: Date){
            pickerView.date = date
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
                 self.callBack(self.pickerView?.date)
               textField.resignFirstResponder()
            nexttextField.becomeFirstResponder()
             // self.removeFromSuperview()
        }
        
        @objc func tapCancelBtn() {
            textField.resignFirstResponder()
           self.removeFromSuperview()
        }
    

}
