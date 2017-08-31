//
//  StringAdaptor.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 31/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public final class StringAdaptor: NSObject, Adaptor {
    
    public typealias RowItemType = RowStringItem    
    public var components: [ComponentItem<StringAdaptor>] = []
}

public extension StringAdaptor {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return components[component][row].pickerView(pickerView, titleForRow: row, forComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return components[component][row].pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
    }
}
