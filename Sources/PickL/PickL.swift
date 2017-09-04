//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

public protocol PickLDelegate: class {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
}

open class PickL<A>: NSObject, UIPickerViewDataSource, PickLDelegate where A: Adaptor, A: SpecificAdaptor {

    public unowned let pickerView: UIPickerView
    
    private lazy var adaptor = A(delegate: self)
    
    public private(set) var selectedRows: [Int] = []
    private var selectedRowsHandler: (([Int]) -> Void)?
    
    public var components: [ComponentItem<A>] = [] {
        didSet {
            selectedRows = Array(repeating: 0, count: components.count)
            
            for component in components {
                component.pickL = self
                component.pickerView = pickerView
            }
            pickerView.reloadAllComponents()
        }
    }
    
    public init(pickerView: UIPickerView) {
        self.pickerView = pickerView
        
        super.init()

        pickerView.dataSource = self
        pickerView.delegate = adaptor
    }

    open subscript(component: Int, row: Int) -> A.RowItemType {
        assert(component >= 0, "Component index can not be negative.")
        assert(row >= 0, "Row index can not be negative.")
        assert(component < components.count, "Component index(\(component)) out of component items count(\(components.count)) range.")

        let componentItem = components[component]
        assert(row < componentItem.rowItems.count, "Row index(\(row)) out of row items count(\(componentItem.rowItems.count)) range.")

        return componentItem.rowItems[row]
    }

    // MARK: - UIPickerViewDataSource

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return components.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return components[component].rowItems.count
    }
}

// MARK: - Selection

public typealias SelectedRowsHandler1 = (Int) -> Void
public typealias SelectedRowsHandler2 = (Int, Int) -> Void
public typealias SelectedRowsHandler3 = (Int, Int, Int) -> Void
public typealias SelectedRowsHandler4 = (Int, Int, Int, Int) -> Void
public typealias SelectedRowsHandler5 = (Int, Int, Int, Int, Int) -> Void
public typealias SelectedRowsHandler6 = (Int, Int, Int, Int, Int, Int) -> Void
public typealias SelectedRowsHandler7 = (Int, Int, Int, Int, Int, Int, Int) -> Void

extension PickL {
    
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler1) {
        selectedRowsHandler = { selectedRows in
            handler(selectedRows[0])
        }
    }
    
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler2) {
        selectedRowsHandler = { [unowned self] selectedRows in
            assert(self.components.count >= 2, "This `selectedRowsHandler` is inappropriate for your components count (\(self.components.count)).")
            handler(selectedRows[0], selectedRows[1])
        }
    }
    
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler3) {
        selectedRowsHandler = { [unowned self] selectedRows in
            assert(self.components.count >= 3, "This `selectedRowsHandler` is inappropriate for your components count (\(self.components.count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2])
        }
    }
    
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler4) {
        selectedRowsHandler = { [unowned self] selectedRows in
            assert(self.components.count >= 4, "This `selectedRowsHandler` is inappropriate for your components count (\(self.components.count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3])
        }
    }
    
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler5) {
        selectedRowsHandler = { [unowned self] selectedRows in
            assert(self.components.count >= 5, "This `selectedRowsHandler` is inappropriate for your components count (\(self.components.count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3], selectedRows[4])
        }
    }
    
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler6) {
        selectedRowsHandler = { [unowned self] selectedRows in
            assert(self.components.count >= 6, "This `selectedRowsHandler` is inappropriate for your components count (\(self.components.count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3], selectedRows[4], selectedRows[5])
        }
    }

    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler7) {
        selectedRowsHandler = { [unowned self] selectedRows in
            assert(self.components.count >= 7, "This `selectedRowsHandler` is inappropriate for your components count (\(self.components.count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3], selectedRows[4], selectedRows[5], selectedRows[6])
        }
    }
}

// MARK: - PickLDelegate

public extension PickL {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if case let .value(width) = components[component].width {
            return width
        }

        var numberOfComponentsWithWidth = 0
        var widthSum: CGFloat = 0

        components.forEach { component in
            if case let .value(width) = component.width {
                numberOfComponentsWithWidth += 1
                widthSum += width
            }
        }
        return (pickerView.bounds.width - widthSum) / CGFloat(components.count - numberOfComponentsWithWidth)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        let isIndexOfRange = component >= components.count
        if !isIndexOfRange, case let .value(height) = components[component].height {
            return height
        }
        return 44
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRows[component] = row
        selectedRowsHandler?(selectedRows)

        if let rowItem = components[component][row] as? RowItemProtocol {
            rowItem.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
    }
}

// MARK: RowStringItemProtocol

public extension PickL {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let rowItem = components[component][row] as? RowStringItemProtocol {
            return rowItem.pickerView(pickerView, titleForRow: row, forComponent: component)
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if let rowItem = components[component][row] as? RowStringItemProtocol {
            return rowItem.pickerView(pickerView, attributedTitleForRow: row, forComponent: component)
        }
        return nil
    }
}

// MARK: RowViewItemProtocol

public extension PickL {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let rowItem = components[component][row] as? RowViewItemProtocol {
            return rowItem.pickerView(pickerView, viewForRow: row, forComponent: component, reusing: view)
        }
        return UIView()
    }
}
