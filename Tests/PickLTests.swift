//
//  PickLTests.swift
//  PickLTests
//
//  Created by Nikita Ermolenko on 05/09/2017.
//  Copyright © 2017 Rosberry. All rights reserved.
//

import XCTest
import PickL

class PickLTests: XCTestCase {

    func testShowsSelectionIndicator() {
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        
        pickL.pickerView.showsSelectionIndicator = true
        XCTAssertTrue(pickL.showsSelectionIndicator)
        
        pickL.showsSelectionIndicator = false
        XCTAssertFalse(pickL.pickerView.showsSelectionIndicator)
        
        pickL.showsSelectionIndicator = true
        XCTAssertTrue(pickL.pickerView.showsSelectionIndicator)
    }

    func testComponentsConfiguration() {
        let component1 = makeStringComponentItem()
        let component2 = makeStringComponentItem()
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        
        XCTAssertEqual(component1.pickL, pickL)
        XCTAssertEqual(component1.pickerView, pickerView)
        
        XCTAssertEqual(component2.pickL, pickL)
        XCTAssertEqual(component2.pickerView, pickerView)
        
        XCTAssertEqual(pickL.selectedRows, [0, 0])
    }
    
    func testSelectedRowsAfterSettingComponents() {
        let component1 = makeStringComponentItem()
        let component2 = makeStringComponentItem()
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]

        XCTAssertEqual(pickL.selectedRows, [0, 0])
    }

    func testSubscriptRowItem() {
        let rowItem1 = RowStringItem(title: "1")
        let rowItem2 = RowStringItem(title: "2")
        let component = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2])
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]

        let testedItem = pickL[0, 1] as? RowStringItem
        XCTAssertTrue(testedItem === rowItem2)
    }

    func testNumberOfComponentPickerViewDatasourceMethod() {
        let component1 = makeStringComponentItem()
        let component2 = makeStringComponentItem()
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        
        let count = pickerView.dataSource?.numberOfComponents(in: pickerView)
        XCTAssertEqual(count, 2)
    }
    
    func testNumberOfRowsInComponentPickerViewDatasourceMethod() {
        let component1 = makeStringComponentItem(withRowItemsCount: 3)
        let component2 = makeStringComponentItem(withRowItemsCount: 4)
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        
        let count1 = pickerView.dataSource?.pickerView(pickerView, numberOfRowsInComponent: 0)
        let count2 = pickerView.dataSource?.pickerView(pickerView, numberOfRowsInComponent: 1)
        
        XCTAssertEqual(count1, 3)
        XCTAssertEqual(count2, 4)
    }
    
    func testWidthForComponentPickerViewDelegateMethod() {
        let component1 = makeStringComponentItem()
        component1.width = .value(50)
        let component2 = makeStringComponentItem()
        
        let pickerView = UIPickerView()
        pickerView.frame = CGRect(origin: .zero, size: CGSize(width: 80, height: CGFloat.greatestFiniteMagnitude))
        
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        
        let component1Width = pickerView.delegate?.pickerView?(pickerView, widthForComponent: 0)
        let component2Width = pickerView.delegate?.pickerView?(pickerView, widthForComponent: 1)
        
        XCTAssertEqual(component1Width, 50)
        XCTAssertEqual(component2Width, 30)
    }
    
    func testRowHeightForComponentPickerViewDelegateMethod() {
        let component1 = makeStringComponentItem()
        component1.height = .value(50)
        
        let component2 = makeStringComponentItem()
        component2.height = .auto
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component1, component2]
        
        let component1Height = pickerView.delegate?.pickerView?(pickerView, rowHeightForComponent: 0)
        let component2Height = pickerView.delegate?.pickerView?(pickerView, rowHeightForComponent: 1)
        
        XCTAssertEqual(component1Height, 50)
        XCTAssertEqual(component2Height, 44)
    }
    
    func testTitleForRowPickerViewDelegateMethod() {
        let rowItem1 = RowStringItem(title: "1")
        let rowItem2 = "2"
        let component = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2])
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        let title1 = pickerView.delegate?.pickerView?(pickerView, titleForRow: 0, forComponent: 0)
        XCTAssertEqual(title1, "1")
        
        let title2 = pickerView.delegate?.pickerView?(pickerView, titleForRow: 1, forComponent: 0)
        XCTAssertEqual(title2, "2")
        
        let attrTitle1 = pickerView.delegate?.pickerView?(pickerView, attributedTitleForRow: 0, forComponent: 0)
        XCTAssertNil(attrTitle1)
        
        let attrTitle2 = pickerView.delegate?.pickerView?(pickerView, attributedTitleForRow: 1, forComponent: 0)
        XCTAssertNil(attrTitle2)
    }
    
    func testAttributedTitleForRowPickerViewDelegateMethod() {
        let rowItem1 = NSAttributedString(string: "1")
        let rowItem2 = NSAttributedString(string: "2")
        let component = ComponentItem<StringAdaptor>(rowItems: [rowItem1, rowItem2])
        
        let pickerView = UIPickerView()
        let pickL = PickL<StringAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        let attrTitle1 = pickerView.delegate?.pickerView?(pickerView, attributedTitleForRow: 0, forComponent: 0)
        XCTAssertEqual(attrTitle1, rowItem1)
        
        let attrTitle2 = pickerView.delegate?.pickerView?(pickerView, attributedTitleForRow: 1, forComponent: 0)
        XCTAssertEqual(attrTitle2, rowItem2)
        
        let title1 = pickerView.delegate?.pickerView?(pickerView, titleForRow: 0, forComponent: 0)
        XCTAssertNil(title1)
        
        let title2 = pickerView.delegate?.pickerView?(pickerView, titleForRow: 1, forComponent: 0)
        XCTAssertNil(title2)
    }
    
    func testViewForRowPickerViewDelegateMethod() {
        let rowItem1 = UIView()
        let rowItem2 = UIView()
        let component = ComponentItem<ViewAdaptor>(rowItems: [rowItem1, rowItem2])
        
        let pickerView = UIPickerView()
        let pickL = PickL<ViewAdaptor>(pickerView: pickerView)
        pickL.components = [component]
        
        let view1 = pickerView.delegate?.pickerView?(pickerView, viewForRow: 0, forComponent: 0, reusing: nil)
        XCTAssertEqual(view1, rowItem1)
        
        let view2 = pickerView.delegate?.pickerView?(pickerView, viewForRow: 1, forComponent: 0, reusing: nil)
        XCTAssertEqual(view2, rowItem2)
    }
}
