//
//  Swift+Url_Tests.swift
//  Mia_ExampleTests
//
//  Created by Michael Hedaitulla on 8/20/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Mia

class Swift_Url_Tests: XCTestCase {

    let text = "http://stackoverflow.com bla bla https://stackexchange.com"

    func containsLink() {
        assert(text.containsLink, "Could not parse link")
    }
    
    func extractLinksTest() {
        let links = text.extractLinks()
        assert(links.count == 2, "Unable to ")
    }

}
