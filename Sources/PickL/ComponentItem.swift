//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

final public class ComponentItem<A> where A: Adaptor, A: SpecificAdaptor {

    public enum Size {
        case value(CGFloat)
        case auto
    }

    public typealias RowType = A.RowItemType
    public typealias SelectedRowHandler = (ComponentItem<A>, Int, RowType) -> Void
    
    public var width: Size = .auto
    public var height: Size = .auto

    public var rowItems: [RowType] {
        didSet {
            configureRowItems()
        }
    }

    public weak var pickL: PickL<A>?
    public weak var pickerView: UIPickerView?
    
    public var didSelectRowHandler: SelectedRowHandler?
    
    public var index: Int? {
        let index = pickL?.components.index(where: { item in
            item === self
        })
        return index
    }
    
    public init(rowItems: [RowType]) {
        self.rowItems = rowItems
        configureRowItems()
    }
    
    public func reload() {
        if let index = index {
            pickerView?.reloadComponent(index)
        }
    }
    
    public subscript(index: Int) -> RowType {
        assert(index >= 0, "Index can not be negative.")
        assert(index < rowItems.count, "Index(\(index) out of row items count(\(rowItems.count)) range.")
        
        return rowItems[index]
    }
    
    private func configureRowItems() {
        rowItems
            .flatMap { rowItem -> RowItemProtocol? in
                rowItem as? RowItemProtocol
            }
            .forEach { rowItem in
                var rowItem = rowItem
                rowItem.internalItemDidSelectHandler = { [unowned self] _, rowIndex, componentIndex in
                    if let selectedRowItem = self.selectedRowItem {
                        self.didSelectRowHandler?(self, rowIndex, selectedRowItem)
                    }
                }
            }
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
    
    public func selectRow(_ row: Int, animated: Bool) {
        assert(row >= 0, "Selected row can not be a negative.")
        assert(row < rowItems.count, "Row index(\(row)) out of row items count(\(rowItems.count)) range.")
        
        if let index = index {
            pickerView?.selectRow(row, inComponent: index, animated: animated)
        }
    }
    
    public func selectNextRow(animated: Bool, checkIndexOutOfRange: Bool = true, isLoopEnabled: Bool = false) {
        if let selectedRowIndex = selectedRowIndex {
            let newIndex = selectedRowIndex + 1
            let indexOutOfRange = newIndex >= rowItems.count
            
            if indexOutOfRange, isLoopEnabled {
                selectRow(0, animated: animated)
                return
            }
            
            if !checkIndexOutOfRange, indexOutOfRange {
                return
            }
            
            selectRow(newIndex, animated: animated)
        }
    }
    
    public func selectPreviousRow(animated: Bool, checkIndexOutOfRange: Bool = true, isLoopEnabled: Bool = false) {
        if let selectedRowIndex = selectedRowIndex {
            let newIndex = selectedRowIndex - 1
            let indexOutOfRange = newIndex < 0
            
            if indexOutOfRange, isLoopEnabled {
                selectRow(rowItems.count - 1, animated: animated)
                return
            }
            
            if !checkIndexOutOfRange, indexOutOfRange {
                return
            }
            
            selectRow(newIndex, animated: animated)
        }
    }
    
    public func selectFirstRow(animated: Bool) {
        selectRow(0, animated: animated)
    }
    
    public func selectLastRow(animated: Bool) {
        selectRow(rowItems.count - 1, animated: animated)
    }
}

// MARK: - Component item delegate

public extension ComponentItem {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> Size {
        return width
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> Size {
        return height
    }
}
