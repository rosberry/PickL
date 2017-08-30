//
//  PickerViewManager.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

open class PickerViewManager: NSObject {
    
    unowned let pickerView: UIPickerView
    
    var components: [ComponentItem] = [] {
        didSet {
            for component in components {
                component.pickerViewManager = self
                component.pickerView = pickerView
            }
            pickerView.reloadAllComponents()
        }
    }
    
    init(pickerView: UIPickerView) {
        self.pickerView = pickerView
        
        super.init()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

// MARK: - UIPickerViewDataSource

extension PickerViewManager: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].rowItems.count
    }
}

// MARK: - UIPickerViewDelegate

extension PickerViewManager: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return components[component].pickerView(pickerView, widthForComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return components[component][row].pickerView(pickerView, titleForRow: row, forComponent: component)
    }

    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return components[component][row].pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return components[component][row].pickerView(pickerView, didSelectRow: row, inComponent: component)
    }
}
