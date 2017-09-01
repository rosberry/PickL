//
//  PickerViewManager.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol PickerViewManagerDelegate: class {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
}

open class PickerViewManager<A>: NSObject, UIPickerViewDataSource where A: Adaptor, A: SpecificAdaptor {

    unowned let pickerView: UIPickerView
    private lazy var adaptor = A(delegate: self)

    var components: [ComponentItem<A>] = [] {
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

        pickerView.dataSource = self
        pickerView.delegate = adaptor
    }
    
    // MARK: - UIPickerViewDataSource

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].rowItems.count
    }
}

// MARK: - PickerViewManagerDelegate

extension PickerViewManager: PickerViewManagerDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return components[component].pickerView(pickerView, widthForComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let rowItem = components[component][row] as? RowItemProtocol {
            rowItem.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
    }
}

// MARK: RowStringItemProtocol

extension PickerViewManager {

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let rowItem = components[component][row] as? RowStringItemProtocol {
            return rowItem.pickerView(pickerView, titleForRow: row, forComponent: component)
        }
        return nil
    }

    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if let rowItem = components[component][row] as? RowStringItemProtocol {
            return rowItem.pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
        }
        return nil
    }
}

// MARK: RowViewItemProtocol

extension PickerViewManager {

    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let rowItem = components[component][row] as? RowViewItemProtocol {
            return rowItem.pickerView(pickerView, viewForRow: row, forComponent: component, reusing: view)
        }
        return UIView()
    }
}
