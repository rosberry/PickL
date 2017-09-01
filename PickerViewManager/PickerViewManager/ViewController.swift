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
    
    typealias A = StringAdaptor
    
    lazy var pickerViewManager: PickerViewManager<A> = {
        return PickerViewManager<A>(pickerView: self.pickerView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.backgroundColor = .red
        view.addSubview(pickerView)

        let rowItems1 = RowStringItem(title: "1")
        let rowItems2 = RowStringItem(title: "2")

        let rowItems3 = RowStringItem(title: "1")
        let rowItems4 = RowStringItem(title: "2")
        
        let rowItems5 = RowStringItem(title: "1")
        let rowItems6 = RowStringItem(title: "2")
        
        let component1 = ComponentItem<A>(rowItems: [rowItems1, rowItems2])
        component1.didSelectRowItem = { _, index, rowItem in
            print("\(index)")
        }
        
        let component2 = ComponentItem<A>(rowItems: [rowItems3, rowItems4])
        component2.didSelectRowItem = { _, index, rowItem in
            print("\(index)")
        }
        
        let component3 = ComponentItem<A>(rowItems: [rowItems5, rowItems6])

        pickerViewManager.components = [component1, component2, component3]
        
//
//        pickerViewManager.selectedRowsHandler { row in
//
//        }
//
//        pickerViewManager.selectedRowsHandler { row1, row2 in
//
//        }
//
        pickerViewManager.selectedRowsHandler { row1, row2, row3 in
            print("\(row1), \(row2), \(row3)")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
    }
}

