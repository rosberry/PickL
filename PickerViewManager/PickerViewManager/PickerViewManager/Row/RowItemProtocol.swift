//
//  RowItemProtocol.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public typealias SelectionHandler = ((UIPickerView, Int, Int) -> Void)

public protocol RowItemProtocol {

    var itemDidSelectHandler: SelectionHandler? { get set }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}

fileprivate struct AssociatedKeys {
    static var didSelectHandler = "rsb_didSelectHandler"
}

public extension RowItemProtocol {
    
    public var itemDidSelectHandler: SelectionHandler? {
        get {
            return ClosureWrapper<SelectionHandler>.handler(for: self, key: &AssociatedKeys.didSelectHandler)
        }
        set {
            ClosureWrapper<SelectionHandler>.setHandler(newValue, for: self, key: &AssociatedKeys.didSelectHandler)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        return UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        itemDidSelectHandler?(pickerView, row, component)
    }
}
