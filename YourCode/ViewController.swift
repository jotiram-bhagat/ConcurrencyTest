//
//  ViewController.swift
//  ConcurrencyTest
//


import UIKit

class ViewController: UIViewController {

    let label = UILabel(frame: .zero)
    var messageService:MessageServiceProtocol = MessageService(dataSource: MessageDataSource())
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
        
        label.text = "loading"
        
        messageService.loadMessage { combinedMessage in
            self.label.text = combinedMessage
        }
    }
}

extension ViewController {
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
