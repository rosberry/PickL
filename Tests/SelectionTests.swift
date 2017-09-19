//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import XCTest
import PickL

class SelectionTests: XCTestCase {

    func testRowStringItem_didSelectHandler() {
        let pickerView = UIPickerView()
        let rowItem1 = RowStringItem(title: "item1")
        let rowItem2 = RowStringItem(title: "item2")
        
        var isHandlerCalled = false
        rowItem2.didSelectHandler = { rowIndex, componentIndex in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex, 1)
            XCTAssertEqual(componentIndex, 0)
        }

        let componentItem = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2])
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        XCTAssertTrue(isHandlerCalled)
    }
    
    func testRowAttributedStringItem_didSelectHandler() {
        let pickerView = UIPickerView()
        let rowItem1 = RowAttributedStringItem(attributedTitle: NSAttributedString(string: "item1"))
        let rowItem2 = RowAttributedStringItem(attributedTitle: NSAttributedString(string: "item2"))
        
        var isHandlerCalled = false
        rowItem2.didSelectHandler = { rowIndex, componentIndex in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex, 1)
            XCTAssertEqual(componentIndex, 0)
        }
        
        let componentItem = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2])
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        XCTAssertTrue(isHandlerCalled)
    }
    
    func testComponentItem_didSelectRowHandler() {
        let pickerView = UIPickerView()
        let rowItem1 = RowStringItem(title: "item1")
        let rowItem2 = RowStringItem(title: "item2")
        let componentItem = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2])
        
        var isHandlerCalled = false
        componentItem.didSelectRowHandler = { _componentItem, rowIndex, _rowItem in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex, 1)
            XCTAssertTrue(componentItem === _componentItem)
            XCTAssertTrue(rowItem2 === (_rowItem as? RowStringItem))
        }
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        XCTAssertTrue(isHandlerCalled)
    }
    
    func testPickL_selectedRowsArrayHandler() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        let componentItem3 = makeStringComponentItem(withRowItemsCount: 4)
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2, componentItem3]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        
        var isHandlerCalled = false
        pickL.selectedRowsArrayHandler { indexes in
            isHandlerCalled = true
            XCTAssertEqual(indexes, [1, 2, 3])
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2, 3])
    }
    
    func testPickL_selectedRowsHandler1() {
        let pickerView = UIPickerView()
        let componentItem = makeStringComponentItem(withRowItemsCount: 2)

        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem]
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex, 1)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1])
    }
    
    func testPickL_selectedRowsHandler2() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex1, rowIndex2 in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex1, 1)
            XCTAssertEqual(rowIndex2, 2)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2])
    }
    
    func testPickL_selectedRowsHandler3() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        let componentItem3 = makeStringComponentItem(withRowItemsCount: 4)

        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2, componentItem3]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex1, rowIndex2, rowIndex3 in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex1, 1)
            XCTAssertEqual(rowIndex2, 2)
            XCTAssertEqual(rowIndex3, 3)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2, 3])
    }
    
    func testPickL_selectedRowsHandler4() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        let componentItem3 = makeStringComponentItem(withRowItemsCount: 4)
        let componentItem4 = makeStringComponentItem(withRowItemsCount: 5)
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2, componentItem3, componentItem4]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 4, inComponent: 3)
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex1, rowIndex2, rowIndex3, rowIndex4 in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex1, 1)
            XCTAssertEqual(rowIndex2, 2)
            XCTAssertEqual(rowIndex3, 3)
            XCTAssertEqual(rowIndex4, 4)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 4, inComponent: 3)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2, 3, 4])
    }
    
    func testPickL_selectedRowsHandler5() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        let componentItem3 = makeStringComponentItem(withRowItemsCount: 4)
        let componentItem4 = makeStringComponentItem(withRowItemsCount: 5)
        let componentItem5 = makeStringComponentItem(withRowItemsCount: 6)
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2, componentItem3, componentItem4, componentItem5]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 4, inComponent: 3)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 5, inComponent: 4)
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex1, rowIndex2, rowIndex3, rowIndex4, rowIndex5 in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex1, 1)
            XCTAssertEqual(rowIndex2, 2)
            XCTAssertEqual(rowIndex3, 3)
            XCTAssertEqual(rowIndex4, 4)
            XCTAssertEqual(rowIndex5, 5)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 5, inComponent: 4)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2, 3, 4, 5])
    }

    func testPickL_selectedRowsHandler6() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        let componentItem3 = makeStringComponentItem(withRowItemsCount: 4)
        let componentItem4 = makeStringComponentItem(withRowItemsCount: 5)
        let componentItem5 = makeStringComponentItem(withRowItemsCount: 6)
        let componentItem6 = makeStringComponentItem(withRowItemsCount: 7)
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2, componentItem3, componentItem4, componentItem5, componentItem6]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 4, inComponent: 3)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 5, inComponent: 4)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 6, inComponent: 5)
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex1, rowIndex2, rowIndex3, rowIndex4, rowIndex5, rowIndex6 in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex1, 1)
            XCTAssertEqual(rowIndex2, 2)
            XCTAssertEqual(rowIndex3, 3)
            XCTAssertEqual(rowIndex4, 4)
            XCTAssertEqual(rowIndex5, 5)
            XCTAssertEqual(rowIndex6, 6)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 6, inComponent: 5)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2, 3, 4, 5, 6])
    }

    func testPickL_selectedRowsHandler7() {
        let pickerView = UIPickerView()
        let componentItem1 = makeStringComponentItem(withRowItemsCount: 2)
        let componentItem2 = makeStringComponentItem(withRowItemsCount: 3)
        let componentItem3 = makeStringComponentItem(withRowItemsCount: 4)
        let componentItem4 = makeStringComponentItem(withRowItemsCount: 5)
        let componentItem5 = makeStringComponentItem(withRowItemsCount: 6)
        let componentItem6 = makeStringComponentItem(withRowItemsCount: 7)
        let componentItem7 = makeStringComponentItem(withRowItemsCount: 8)
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [componentItem1, componentItem2, componentItem3, componentItem4, componentItem5, componentItem6, componentItem7]
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 1, inComponent: 0)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 2, inComponent: 1)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 3, inComponent: 2)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 4, inComponent: 3)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 5, inComponent: 4)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 6, inComponent: 5)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 7, inComponent: 6)
        
        var isHandlerCalled = false
        pickL.selectedRowsHandler { rowIndex1, rowIndex2, rowIndex3, rowIndex4, rowIndex5, rowIndex6, rowIndex7 in
            isHandlerCalled = true
            
            XCTAssertEqual(rowIndex1, 1)
            XCTAssertEqual(rowIndex2, 2)
            XCTAssertEqual(rowIndex3, 3)
            XCTAssertEqual(rowIndex4, 4)
            XCTAssertEqual(rowIndex5, 5)
            XCTAssertEqual(rowIndex6, 6)
            XCTAssertEqual(rowIndex7, 7)
        }
        
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 7, inComponent: 6)
        
        XCTAssertTrue(isHandlerCalled)
        XCTAssertEqual(pickL.selectedRows, [1, 2, 3, 4, 5, 6, 7])
    }
}
