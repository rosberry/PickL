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
        
        pickerView.backgroundColor = .red
        view.addSubview(pickerView)

        let rowItems1 = RowStringItem(title: "1")
        let rowItems2 = RowStringItem(title: "2")

        let component1 = ComponentItem<StringRowItem>(rowItems: [rowItems1, rowItems2])
        let component2 = ComponentItem<StringRowItem>(rowItems: [rowItems1, rowItems2])
        let component3 = ComponentItem<StringRowItem>(rowItems: [rowItems1, rowItems2])

        pickerViewManager.components = [component1, component2, component3]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerView.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
    }
}

