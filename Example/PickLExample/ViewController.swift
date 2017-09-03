//
//  ViewController.swift
//  PickLExample
//
//  Created by Nikita Ermolenko on 01/09/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit
import PickL

class RowStringItem2: RowStringItem {}

class ViewController: UIViewController {

    let pickerView = UIPickerView()
    lazy var pickL = PickL<StringAdaptor>(pickerView: self.pickerView)
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let rowItem = RowStringItem2(title: "test")
        let componentItem = ComponentItem<StringAdaptor>(rowItems: [rowItem])
        
        componentItem.didSelectRowHandler = { _, index, item in

        }
    }

}

