//
//  HttpClient.swift
//  Raise
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import Foundation

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol { func resume() }

class HttpClient {
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func post(request: NSMutableURLRequest, callback: @escaping completeClosure ) {
        
        //let request = NSMutableURLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        
        task.resume()
    }
}

