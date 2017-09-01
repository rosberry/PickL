//
//  StringAdaptor.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 31/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public final class StringAdaptor: Adaptor, SpecificAdaptor {

    public typealias RowItemType = RowStringItemProtocol
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return delegate.pickerView(pickerView, titleForRow: row, forComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return delegate.pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
    }
}
