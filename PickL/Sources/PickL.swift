//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import UIKit

/// Delegate for convenience work with adaptors.
protocol PickLDelegate: class {

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
}

public typealias RowIndex = Int
public typealias ComponentIndex = Int

open class PickL<Adaptor>: NSObject, UIPickerViewDataSource where Adaptor: BaseAdaptor & SpecificAdaptor {

    /// The reference to `UIPickerView`.
    public unowned let pickerView: UIPickerView

    private lazy var adaptor: Adaptor = .init(delegate: self)

    /// A Boolean value that determines whether the selection indicator is displayed.
    public var showsSelectionIndicator: Bool {
        get {
            return pickerView.showsSelectionIndicator
        }
        set {
            pickerView.showsSelectionIndicator = newValue
        }
    }

    /// Current selected row indexes.
    private(set) var selectedRows: [RowIndex] = []

    internal var selectedRowsHandler: (([RowIndex]) -> Void)?

    /// The array of component items with specific row items type.
    public var components: [ComponentItem<Adaptor>] = [] {
        didSet {
            selectedRows = Array(repeating: 0, count: components.count)

            for component in components {
                component.pickL = self
                component.pickerView = pickerView
            }
            pickerView.reloadAllComponents()
        }
    }

    /// Initializes and returns a newly allocated `PickL` object with the specified pickerView.
    public init(pickerView: UIPickerView) {
        self.pickerView = pickerView

        super.init()

        pickerView.dataSource = self
        pickerView.delegate = adaptor
    }

    /// Subscript that returns the row item with specified column and row.
    open subscript(component: Int, row: Int) -> Adaptor.RowItemType {
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

// MARK: - PickLDelegate

extension PickL: PickLDelegate {

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
        guard (0..<selectedRows.count).contains(component) else {
            return
        }
        selectedRows[component] = row
        selectedRowsHandler?(selectedRows)

        let componentItem = components[component]
        componentItem.didSelectRowHandler?(componentItem, row, componentItem.rowItems[row])

        if let rowItem = componentItem[row] as? RowItemProtocol {
            rowItem.pickerView(pickerView, didSelectRow: row, inComponent: component)
        }
    }
}

// MARK: Strings

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

// MARK: Views

public extension PickL {

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let rowItem = components[component][row] as? RowViewItemProtocol {
            return rowItem.pickerView(pickerView, viewForRow: row, forComponent: component, reusing: view)
        }
        return UIView()
    }
}
