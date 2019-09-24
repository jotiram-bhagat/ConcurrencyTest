//
//  MessagePresenenterTests.swift
//  ConcurrencyTestTests
//

import XCTest
@testable import ConcurrencyTest

private class MessageViewMock:NSObject, MessageView{
    var showMessageCalledCount = 0
    var message:String = ""
    func showMessage(message: String) {
        showMessageCalledCount += 1
        self.message = message
    }
}

private class MessageServiceMock:MessageServiceProtocol{
    var loadMessageCalledCount = 0
    var stubMessage:String = "Hello World"
    func loadMessage(completion: @escaping (String) -> Void) {
        loadMessageCalledCount += 1
        completion(stubMessage)
    }
}


 final class MessagePresenenterTests: XCTestCase {
    
    func testLoadMessageCalled() {
        let messageServiceMock = MessageServiceMock()
        let presenter = MessagePresenter()
        presenter.messageService = messageServiceMock
        presenter.loadMessage()
        XCTAssertTrue(messageServiceMock.loadMessageCalledCount > 0)
    }

    func testShowMessageCalled() {
        let messageServiceMock = MessageServiceMock()
        let presenter = MessagePresenter()
        let messageViewMock = MessageViewMock()
        presenter.messageService = messageServiceMock
        presenter.attachView(view: messageViewMock)
        presenter.loadMessage()
        XCTAssertTrue(messageViewMock.showMessageCalledCount > 0)
    }
    
    func testShowMessageCalledWithCorrectMessage() {
        let messageServiceMock = MessageServiceMock()
        messageServiceMock.stubMessage = "Good Morning"
        let presenter = MessagePresenter()
        let messageViewMock = MessageViewMock()
        presenter.messageService = messageServiceMock
        presenter.attachView(view: messageViewMock)
        presenter.loadMessage()
        XCTAssertTrue(messageViewMock.showMessageCalledCount > 0)
        XCTAssertTrue(messageViewMock.message == messageServiceMock.stubMessage)
    }
}
