//
//  RowItem.swift
//  PickerViewManager
//
//  Created by Nikita Ermolenko on 31/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

fileprivate struct AssociatedKeys {
    static var didSelectHandler = "rsb_didSelectHandler"
}

public typealias Row = Int
public typealias Component = Int
public typealias SelectionHandler = ((UIPickerView, Row, Component) -> Void)

public protocol RowItem {

    var itemDidSelectHandler: SelectionHandler? { get set }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}

public extension RowItem {
    
    public var itemDidSelectHandler: SelectionHandler? {
        get {
            return ClosureWrapper<SelectionHandler>.handler(for: self, key: &AssociatedKeys.didSelectHandler)
        }
        set {
            ClosureWrapper<SelectionHandler>.setHandler(newValue, for: self, key: &AssociatedKeys.didSelectHandler)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemDidSelectHandler?(pickerView, row, component)
    }
}
