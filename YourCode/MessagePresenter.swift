//
//  MessagePresenter.swift
//  ConcurrencyTest
//


import Foundation

protocol MessagePresenterProtocol{
    func attachView(view:MessageView)
    func loadMessage()
}

final class MessagePresenter{
    // MARK: Properties
    var messageService:MessageServiceProtocol = MessageService(dataSource: MessageDataSource())
    private weak var messageView:MessageView?
}

    //MARK: MessagePresenterProtocol Imeplementation
extension MessagePresenter:MessagePresenterProtocol{
    
    // MARK: Public Methods
    func attachView(view:MessageView){
        self.messageView = view
    }
    
    func loadMessage(){
        self.messageView?.showMessage(message: ConstantString.loadingMessage.localized())
        messageService.loadMessage(){ message in
            self.messageView?.showMessage(message: message)
        }
    }
}
