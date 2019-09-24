//
//  MessageDataSourceMock.swift
//  ConcurrencyTestTests
//


import Foundation

@testable import ConcurrencyTest

struct MessageDataSourceMock:DataSource {
    var messageOneResponseTime = 1000
    var messageTwoResponseTime = 500
    var messageOne = "Good"
    var messageTwo = "Morning"
    
    func messageOne(completion: @escaping (String) -> Void) {
        _asyncStringAfter(time: messageOneResponseTime,
                          value: messageOne, completion: completion)
    }
    
    func messageTwo(completion: @escaping (String) -> Void) {
        _asyncStringAfter(time: messageTwoResponseTime,
                          value: messageTwo, completion: completion)
        
    }
    
    private func _asyncStringAfter(time:Int, value: String, completion: @escaping (String) -> Void) {
        let interval = DispatchTimeInterval.milliseconds(time)
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + interval) {
            completion(value)
        }
    }
    
}
