//
//  ComponentItem.swift
//  Obolus
//
//  Created by Nikita Ermolenko on 16/08/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

open class ComponentItem<AdaptorType> where AdaptorType: Adaptor {

    public typealias RowType = AdaptorType.RowItemType
    
    public var width: CGFloat?
    public var rowItems: [RowType]

    public weak var pickerViewManager: PickerViewManager<AdaptorType>?
    public weak var pickerView: UIPickerView?
    
    public var index: Int? {
        let index = pickerViewManager?.components.index(where: { item in
            item === self
        })
        return index
    }
    
    public init(rowItems: [RowType]) {
        self.rowItems = rowItems
    }
    
    open func reload() {
        if let index = index {
            pickerView?.reloadComponent(index)
        }
    }
    
    open subscript(index: Int) -> RowType {
        assert(index >= 0, "Index can not be negative.")
        assert(index < rowItems.count, "Index(\(index) outside of row items count(\(rowItems.count)).")
        
        return rowItems[index]
    }
}

// MARK: - Selection

extension ComponentItem {
    
    public var selectedRowItem: RowType? {
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
    
    open func selectFirstRow(animated: Bool) {
        selectRow(0, animated: animated)
    }
    
    open func selectLastRow(animated: Bool) {
        selectRow(rowItems.count - 1, animated: animated)
    }
}

// MARK: - PickerViewManagerDelegate

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
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}
