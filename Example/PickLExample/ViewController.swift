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

        view.addSubview(pickerView)

        let rowItem1 = RowStringItem2(title: "test1")
        let rowItem2 = RowStringItem2(title: "test2")
        let rowItem3 = RowStringItem2(title: "test3")
        
        let componentItem1 = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2, rowItem3])
        componentItem1.height = .auto
        componentItem1.width = .value(80)
        
        
        let rowItem4 = RowStringItem2(title: "test4")
        let rowItem5 = RowStringItem2(title: "test5")
        let rowItem6 = RowStringItem2(title: "test6")
        
        let componentItem2 = ComponentItem<StringAdaptor>(rowItems: [rowItem4, rowItem5, rowItem6])
        componentItem2.height = .auto

        pickL.components = [componentItem1, componentItem2]
        pickL.selectedRowsHandler { rowIndex1, rowIndex2 in
            print("\(rowIndex1), \(rowIndex2)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pickerView.frame = CGRect(x: 10, y: 10, width: 320, height: 320)
    }

}
