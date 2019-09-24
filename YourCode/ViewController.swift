//
//  ViewController.swift
//  ConcurrencyTest
//


import UIKit

protocol MessageView:NSObjectProtocol {
    func showMessage(message:String)
}

final class ViewController: UIViewController {
    enum Constants{
        static let messageLabelId = "messageLabel"
    }
    // MARK: Properties
    private let label = UILabel(frame: .zero)
    private var presenter:MessagePresenterProtocol = MessagePresenter()
    
    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        presenter.attachView(view: self)
        presenter.loadMessage()
    }
}

extension ViewController {
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isAccessibilityElement = true
        label.accessibilityIdentifier = ViewController.Constants.messageLabelId
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
    //MARK: MessageView Protocol Implementation
extension ViewController:MessageView{
    func showMessage(message:String){
        label.text = message
        label.accessibilityLabel =  message
        UIAccessibility.post(notification: .layoutChanged, argument: label)
    }
}
