//
//  ComponentItemTests.swift
//  PickLTests
//
//  Created by Nikita Ermolenko on 06/09/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import XCTest
import PickL

class ComponentItemTests: XCTestCase {

    func testComponentItemIndex() {
        let component1 = makeStringComponentItem()
        let component2 = makeStringComponentItem()
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        
        XCTAssertEqual(component1.index, 0)
        XCTAssertEqual(component2.index, 1)
    }
    
    func testNilComponentItemIndex() {
        let component1 = makeStringComponentItem()
        let component2 = makeStringComponentItem()

        XCTAssertNil(component1.index)
        XCTAssertNil(component2.index)
    }
    
    func testSelectedRowIndex() {
        let component1 = makeStringComponentItem(withRowItemsCount: 3)
        let component2 = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        pickerView.selectRow(2, inComponent: 1, animated: false)
        
        XCTAssertEqual(component1.selectedRowIndex, 0)
        XCTAssertEqual(component2.selectedRowIndex, 2)
    }
    
    func testNilSelectedRowIndex() {
        let component1 = makeStringComponentItem(withRowItemsCount: 3)
        let component2 = makeStringComponentItem(withRowItemsCount: 3)
        
        XCTAssertNil(component1.selectedRowIndex)
        XCTAssertNil(component2.selectedRowIndex)
    }
    
    func testSelectedRowItem() {
        let rowItem1 = RowStringItem(title: "1")
        let rowItem2 = RowStringItem(title: "2")
        let rowItem3 = RowStringItem(title: "3")
        let component = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2, rowItem3])
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        pickerView.selectRow(2, inComponent: 0, animated: false)
        
        XCTAssertTrue(component.selectedRowItem as? RowStringItem === rowItem3)
    }
    
    func testNilSelectedRowItem() {
        let component = makeStringComponentItem(withRowItemsCount: 3)

        XCTAssertNil(component.selectedRowItem)
    }
    
    func testSelectRow() {
        let component = makeStringComponentItem(withRowItemsCount: 3)

        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        component.selectRow(2, animated: false)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 2)
    }
    
    func testSelectNextRow() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
        component.selectNextRow(animated: false)

        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 1)
    }
    
    func testSelectNextRowWithLoop() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(2, inComponent: 0, animated: false)
        component.selectNextRow(animated: false, isLoopEnabled: true)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 0)
    }
    
    func testSelectNextRowWithoutCheckingIndexOutOfRange() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(2, inComponent: 0, animated: false)
        component.selectNextRow(animated: false, checkIndexOutOfRange: false)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 2)
    }
    
    func testSelectPreviousRow() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(2, inComponent: 0, animated: false)
        component.selectPreviousRow(animated: false)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 1)
    }
    
    func testSelectPreviousRowWithLoop() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
        component.selectPreviousRow(animated: false, isLoopEnabled: true)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 2)
    }
    
    func testSelectPreviousRowWithoutCheckingIndexOutOfRange() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
        component.selectPreviousRow(animated: false, checkIndexOutOfRange: false)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 0)
    }
    
    func testSelectFirstRow() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        pickerView.selectRow(2, inComponent: 0, animated: false)
        XCTAssertEqual(pickerView.selectedRow(inComponent: 0), 2)
        
        component.selectFirstRow(animated: false)
        XCTAssertEqual(pickerView.selectedRow(inComponent: 0), 0)
    }
    
    func testSelectLastRow() {
        let component = makeStringComponentItem(withRowItemsCount: 3)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        component.selectLastRow(animated: false)
        
        let selectedRowIndex = pickerView.selectedRow(inComponent: 0)
        XCTAssertEqual(selectedRowIndex, 2)
    }
}
