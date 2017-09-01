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
//
//        let rowItems1 = UIView()
//        rowItems1.backgroundColor = .yellow
//
//        let rowItems2 = UIView()
//        rowItems2.backgroundColor = .green
        
        let component1 = ComponentItem<A>(rowItems: [rowItems1, rowItems2])
        component1.didSelectRowItem = { _, index, rowItem in
            print("\(index)")
        }
        
        let component2 = ComponentItem<A>(rowItems: [rowItems1, rowItems2])
        component2.didSelectRowItem = { _, index, rowItem in
            print("\(index)")
        }
        
        let component3 = ComponentItem<A>(rowItems: [rowItems1, rowItems2])

        pickerViewManager.components = [component1, component2, component3]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
    }
}

