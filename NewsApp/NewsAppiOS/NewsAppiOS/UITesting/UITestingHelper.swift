//
//  NewsAppiOSApp.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 14/2/23.
//


#if DEBUG

import Foundation

struct UITestingHelper {
    
    static var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("-ui-testing")
    }
    
    static var isNewsAPISuccessful: Bool {
        ProcessInfo.processInfo.environment["-news-networking-success"] == "1"
    }
}

#endif
