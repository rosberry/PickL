//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Enum represents the size values.
///
/// - value: The value for manually size configuration.
/// - auto: Size will be generated automatically.
public enum Size {
    case value(CGFloat)
    case auto
}

/// Item represents a component with row items.
///
/// - note: Don't forget to point out a generic constraint.
/// ```
///  ComponentItem<StringAdaptor>(rowItems: [rowItem])
///  ComponentItem<ViewAdaptor>(rowItems: [rowItem])
/// ```
///
final public class ComponentItem<A> where A: Adaptor, A: SpecificAdaptor {

    public typealias RowType = A.RowItemType
    
    /// Convenient typealias for `didSelectRowHandler`.
    ///
    /// - Parameters:
    ///   - componentItem: The component item.
    ///   - rowIndex: The selected row index.
    ///   - rowItem: The selected row item.
    public typealias SelectedRowHandler = (_ componentItem: ComponentItem<A>, _ rowIndex: RowIndex, _ rowItem: RowType) -> Void
    
    /// The width of component. `Size.auto` - by default.
    public var width: Size = .auto
    
    /// The height of component. `Size.auto` - by default.
    public var height: Size = .auto

    /// The array of row items with `RowStringItemProtocol` or `RowViewItemProtocol` types.
    public var rowItems: [RowType]

    /// The weak reference to `PickL` object.
    public weak var pickL: PickL<A>?
    
    /// The weak reference to `UIPickerView`.
    public weak var pickerView: UIPickerView?
    
    /// The handler for detecting row selection.
    public var didSelectRowHandler: SelectedRowHandler?
    
    /// The ordered index of component item.
    ///
    /// - note: Returns `nil` if component item hasn't got a parent object.
    public var index: Int? {
        let index = pickL?.components.index(where: { item in
            item === self
        })
        return index
    }
    
    /// Initializes and returns a newly allocated component item object with the specified row items.
    ///
    /// - Parameter rowItems: The row items for an allocated component item.
    public init(rowItems: [RowType]) {
        self.rowItems = rowItems
    }
    
    /// Reload component item.
    ///
    /// Calling this method causes the picker view to query the delegate for new data for the given component.
    public func reload() {
        if let index = index {
            pickerView?.reloadComponent(index)
        }
    }

    /// Subscript that returns the row item with specified index.
    public subscript(index: Int) -> RowType {
        assert(index >= 0, "Index can not be negative.")
        assert(index < rowItems.count, "Index(\(index)) out of row items count(\(rowItems.count)) range.")
        
        return rowItems[index]
    }
}

// MARK: - Selection

extension ComponentItem {
    
    /// Returns the selected row item.
    ///
    /// - note: Returns `nil` if component item hasn't got a parent object.
    public var selectedRowItem: RowType? {
        guard let selectedRowIndex = selectedRowIndex else {
            return nil
        }
        return self[selectedRowIndex]
    }
    
    /// Returns the selected row index.
    ///
    /// - note: Returns `nil` if component item hasn't got a parent object.
    public var selectedRowIndex: Int? {
        guard let index = index else {
            return nil
        }
        return pickerView?.selectedRow(inComponent: index)
    }

    /// Selects a row in a specified component of the picker view.
    ///
    /// - Parameters:
    ///   - row: A zero-indexed number identifying a row of component.
    ///   - animated: `True` - animates the selection by spinning the wheel (component) to the new value.
    ///                If you specify false, the new selection is shown immediately.
    public func selectRow(_ row: Int, animated: Bool) {
        assert(row >= 0, "Selected row can not be a negative.")
        assert(row < rowItems.count, "Row index(\(row)) out of row items count(\(rowItems.count)) range.")
        
        if let index = index {
            pickerView?.selectRow(row, inComponent: index, animated: animated)
        }
    }
    
    /// Select the next row item for the current one.
    ///
    /// - Parameters:
    ///   - animated: `True` - animates the selection by spinning the wheel (component) to the new value.
    ///                If you specify false, the new selection is shown immediately.
    ///   - checkIndexOutOfRange: `True` - generates exeption if the next selected index is out of range. `true` - by default.
    ///   - isLoopEnabled: `True` - selects the first row item if index out of range. `false` - by default.
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
    
    /// Selects the previous row item before the current one.
    ///
    /// - Parameters:
    ///   - animated: `True` - animates the selection by spinning the wheel (component) to the new value.
    ///                If you specify false, the new selection is shown immediately.
    ///   - checkIndexOutOfRange: `True` - generates exeption if the previous selected index is out of range. `true` - by default.
    ///   - isLoopEnabled: `True` - selects the last row item if index out of range. `false` - by default.
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
    
    /// Selects the first row item.
    ///
    /// - Parameter animated: `True` - animates the selection by spinning the wheel (component) to the new value.
    ///                        If you specify false, the new selection is shown immediately.
    public func selectFirstRow(animated: Bool) {
        selectRow(0, animated: animated)
    }
    
    /// Selects the last row item.
    ///
    /// - Parameter animated: `True` - animates the selection by spinning the wheel (component) to the new value.
    ///                        If you specify false, the new selection is shown immediately.
    public func selectLastRow(animated: Bool) {
        selectRow(rowItems.count - 1, animated: animated)
    }
}
