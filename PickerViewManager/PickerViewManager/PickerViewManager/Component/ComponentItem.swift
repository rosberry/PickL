//
//  ComponentItem.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

open class ComponentItem {

    public var width: CGFloat?
    public var rowItems: [RowItemProtocol]

    public weak var pickerViewManager: PickerViewManager?
    public weak var pickerView: UIPickerView?
    
    public var selectedRowItem: RowItemProtocol? {
        guard let selectedRowIndex = selectedRowIndex else {
            return nil
        }
        return self[selectedRowIndex]
    }
    
    public var selectedRowIndex: Int? {
        guard let index = index else {
            return nil
        }
        return pickerView?.selectedRow(inComponent: index)
    }
    
    public var index: Int? {
        let index = pickerViewManager?.components.index(where: { item in
            item === self
        })
        return index
    }
    
    public init(rowItems: [RowItemProtocol]) {
        self.rowItems = rowItems
    }
    
    open func selectRow(_ row: Int, animated: Bool) {
        assert(row >= 0, "Selected row can not be a negative.")
        assert(row < rowItems.count, "Row(\(row) outside of row items count(\(rowItems.count)).")
        
        if let index = index {
            pickerView?.selectRow(row, inComponent: index, animated: animated)
        }
    }
    
    open func selectNextRow(animated: Bool) {
        if let selectedRowIndex = selectedRowIndex {
            selectRow(selectedRowIndex + 1, animated: animated)
        }
    }
    
    open func selectPreviousRow(animated: Bool) {
        if let selectedRowIndex = selectedRowIndex {
            selectRow(selectedRowIndex - 1, animated: animated)
        }
    }
    
    open func reload() {
        if let index = index {
            pickerView?.reloadComponent(index)
        }
    }
    
    open subscript(index: Int) -> RowItemProtocol {
        assert(index >= 0, "Index can not be negative.")
        assert(index < rowItems.count, "Index(\(index) outside of row items count(\(rowItems.count)).")
        
        return rowItems[index]
    }
}

public extension ComponentItem {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        guard let pickerViewManager = pickerViewManager else {
            return 0
        }
        
        if let width = width {
            return width
        }
        
        var numberOfComponentsWithWidth = 0
        var widthSum: CGFloat = 0
        
        pickerViewManager.components.forEach { component in
            if let width = component.width {
                numberOfComponentsWithWidth += 1
                widthSum += width
            }
        }
        return (pickerView.bounds.width - widthSum) / CGFloat(pickerViewManager.components.count - numberOfComponentsWithWidth)
    }
}
