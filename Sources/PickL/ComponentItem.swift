//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

open class ComponentItem<A> where A: Adaptor, A: SpecificAdaptor {

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
    
    open func reload() {
        if let index = index {
            pickerView?.reloadComponent(index)
        }
    }
    
    open subscript(index: Int) -> RowType {
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
    
    open func selectRow(_ row: Int, animated: Bool) {
        assert(row >= 0, "Selected row can not be a negative.")
        assert(row < rowItems.count, "Row index(\(row) out of row items count(\(rowItems.count)) range.")
        
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

// MARK: - Component item delegate

public extension ComponentItem {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> Size {
        return width
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> Size {
        return height
    }
}
