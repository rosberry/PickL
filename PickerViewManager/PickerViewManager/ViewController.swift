//
//  ViewController.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 30/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let pickerView = UIPickerView()
    
    lazy var pickerViewManager: PickerViewManager<StringAdaptor> = {
        return PickerViewManager<StringAdaptor>(pickerView: self.pickerView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pickerView)
        
//        pickerViewManager.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pickerView.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
    }

}

