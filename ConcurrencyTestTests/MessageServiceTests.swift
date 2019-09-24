//
//  ConcurrencyTestTests.swift
//  ConcurrencyTestTests
//


import XCTest
@testable import ConcurrencyTest

class MessageServiceTests: XCTestCase {
    
    func testloadMessageWhenSucess() {
        var  mockClient = MessageDataSourceMock()
        mockClient.messageOneResponseTime = 1000
        mockClient.messageTwoResponseTime = 1500
        mockClient.messageOne = "Good"
        mockClient.messageTwo = "Morning"
        
        let expectationLoadMessage = expectation(description: "Load Message")
        let messageService = MessageService(dataSource: mockClient)
        messageService.loadMessage { combinedMessage in
            let expectedMessage = "\(mockClient.messageOne) \(mockClient.messageTwo)"
            XCTAssert(combinedMessage == expectedMessage, "Combined message should be \(expectedMessage)" )
            expectationLoadMessage.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    
    func testloadMessageWhenTimeout() {
        var  mockClient = MessageDataSourceMock()
        mockClient.messageOneResponseTime = 3000
        mockClient.messageTwoResponseTime = 3000
        
        let expectationLoadMessage = expectation(description: "Load Message")
        let messageService = MessageService(dataSource: mockClient)
        messageService.loadMessage { combinedMessage in
            XCTAssert(combinedMessage == ConstantString.timeoutMessage.localized(),
                      "Combined message should be \(ConstantString.timeoutMessage.localized())")
            expectationLoadMessage.fulfill()
        }
        waitForExpectations(timeout: 5)
        
    }
    
    func testloadMessageWhenMessageOneTimeout() {
        var  mockClient = MessageDataSourceMock()
        mockClient.messageOneResponseTime = 3000
        mockClient.messageTwoResponseTime = 1000
        
        let expectationLoadMessage = expectation(description: "Load Message")
        let messageService = MessageService(dataSource: mockClient)
        messageService.loadMessage { combinedMessage in
            XCTAssert(combinedMessage == ConstantString.timeoutMessage.localized(),
                      "Combined message should be \(ConstantString.timeoutMessage.localized())")
            expectationLoadMessage.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testloadMessageWhenMessageTwoTimeout() {
        var  mockClient = MessageDataSourceMock()
        mockClient.messageOneResponseTime = 1000
        mockClient.messageTwoResponseTime = 3000
        let expectationLoadMessage = expectation(description: "Load Message")
        let messageService = MessageService(dataSource: mockClient)
        messageService.loadMessage { combinedMessage in
            XCTAssert(combinedMessage == ConstantString.timeoutMessage.localized(),
                      "Combined message should be \(ConstantString.timeoutMessage.localized())")
            expectationLoadMessage.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}

