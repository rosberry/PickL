//
//  Adaptor.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 31/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol Adaptor: class, UIPickerViewDelegate {
    
    associatedtype RowItemType
    
    var components: [ComponentItem<Self>] { get set }
    init()
}

// MARK: - UIPickerViewDelegate

public extension Adaptor {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return components[component].pickerView(pickerView, widthForComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return components[component].pickerView(pickerView, rowHeightForComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let componentItem = components[component]
        if let rowItem = componentItem[row] as? RowItemProtocol {
            rowItem.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
    }
}
