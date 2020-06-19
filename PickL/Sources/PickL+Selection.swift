//
//  Copyright © 2020 Rosberry. All rights reserved.
//

import UIKit

/// Convenient typealiases for `selectedRowsHandler` methods.

public typealias SelectedRowsHandler  = ([RowIndex]) -> Void
public typealias SelectedRowsHandler1 = (RowIndex) -> Void
public typealias SelectedRowsHandler2 = (RowIndex, RowIndex) -> Void
public typealias SelectedRowsHandler3 = (RowIndex, RowIndex, RowIndex) -> Void
public typealias SelectedRowsHandler4 = (RowIndex, RowIndex, RowIndex, RowIndex) -> Void
public typealias SelectedRowsHandler5 = (RowIndex, RowIndex, RowIndex, RowIndex, RowIndex) -> Void
public typealias SelectedRowsHandler6 = (RowIndex, RowIndex, RowIndex, RowIndex, RowIndex, RowIndex) -> Void
public typealias SelectedRowsHandler7 = (RowIndex, RowIndex, RowIndex, RowIndex, RowIndex, RowIndex, RowIndex) -> Void

extension PickL {

    /// The handler for detecting a row selection in one component.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler1) {
        selectedRowsHandler = { selectedRows in
            handler(selectedRows[0])
        }
    }

    /// The handler for detecting a rows selection in two components. From right to left.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler2) {
        selectedRowsHandler = { [unowned self] selectedRows in
            let count = self.components.count
            assert(count >= 2, "This `selectedRowsHandler` is inappropriate for your components count (\(count)).")
            handler(selectedRows[0], selectedRows[1])
        }
    }

    /// The handler for detecting a rows selection in three components. From right to left.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler3) {
        selectedRowsHandler = { [unowned self] selectedRows in
            let count = self.components.count
            assert(count >= 3, "This `selectedRowsHandler` is inappropriate for your components count (\(count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2])
        }
    }

    /// The handler for detecting a rows selection in four components. From right to left.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler4) {
        selectedRowsHandler = { [unowned self] selectedRows in
            let count = self.components.count
            assert(count >= 4, "This `selectedRowsHandler` is inappropriate for your components count (\(count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3])
        }
    }

    /// The handler for detecting a rows selection in five components. From right to left.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler5) {
        selectedRowsHandler = { [unowned self] selectedRows in
            let count = self.components.count
            assert(count >= 5, "This `selectedRowsHandler` is inappropriate for your components count (\(count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3], selectedRows[4])
        }
    }

    /// The handler for detecting a rows selection in six components. From right to left.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler6) {
        selectedRowsHandler = { [unowned self] selectedRows in
            let count = self.components.count
            assert(count >= 6, "This `selectedRowsHandler` is inappropriate for your components count (\(count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3], selectedRows[4], selectedRows[5])
        }
    }

    /// The handler for detecting a rows selection in seven components. From right to left.
    @nonobjc public func selectedRowsHandler(_ handler: @escaping SelectedRowsHandler7) {
        selectedRowsHandler = { [unowned self] selectedRows in
            let count = self.components.count
            assert(count >= 7, "This `selectedRowsHandler` is inappropriate for your components count (\(count)).")
            handler(selectedRows[0], selectedRows[1], selectedRows[2], selectedRows[3], selectedRows[4], selectedRows[5], selectedRows[6])
        }
    }

    /// The handler for detecting a rows selection in array component.
    @nonobjc public func selectedRowsArrayHandler(_ handler: @escaping SelectedRowsHandler) {
        selectedRowsHandler = { selectedRows in
            handler(selectedRows)
        }
    }
}
