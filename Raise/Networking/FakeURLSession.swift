//
//  FakeURLSession.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import Foundation

class FakeURLSession: URLSessionProtocol {
    
    var nextDataTask = FakeURLSessionDataTask()
    
    private (set) var lastURL: URL?
    
    func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        
        lastURL = request.url
        
        //completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        
        return nextDataTask
    }
}

class FakeURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
}
