//
//  RaiseTests.swift
//  RaiseTests
//
//  Created by dkdesai on 12/14/17.
//  Copyright © 2017 Daxes Desai. All rights reserved.
//

import XCTest
@testable import Raise

class RaiseTests: XCTestCase {
    
    var httpClient: HttpClient!
    
    let session = FakeURLSession()
    
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testPostRequestwithURL() {
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        let request = NSMutableURLRequest(url: url)
        httpClient.post(request: request) { (success, response) in
            // Return data
        }
        XCTAssert(session.lastURL == URL(string: "https://mockurl"))
    }
    
    func testPostResumeCalled() {
        let dataTask = FakeURLSessionDataTask()
        session.nextDataTask = dataTask
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        let request = NSMutableURLRequest(url: url)
        httpClient.post(request: request) { (success, response) in
            // Return data
        }
        XCTAssert(dataTask.resumeWasCalled)
    }
    
}
