//
//  SwiftCLITests.swift
//  SwiftCLITests
//
//  Created by Jake Heiser on 6/28/16.
//  Copyright (c) 2016 jakeheis. All rights reserved.
//


import SwiftCLI

class TestCommand: OptionCommandType {
    
    let name = "test"
    let signature = "<testName> [<testerName>]"
    let shortDescription = "A command to test stuff"
    
    var silentFlag = false
    var times: Int = 1
    var executionString = ""
    
    let completion: ((executionString: String) -> ())?
    
    init(completion: ((executionString: String) -> ())? = nil) {
        self.completion = completion
    }
    
    func setupOptions(options: OptionRegistry) {
        options.add(flags: ["-s", "--silent"], usage: "Silence all test output") {(flag) in
            self.silentFlag = true
        }
        options.add(keys: ["-t", "--times"], usage: "Number of times to run the test", valueSignature: "times") {(key, value) in
            self.times = Int(value)!
        }
    }
    
    func execute(arguments: CommandArguments) throws {
        let testName = arguments.requiredArgument("testName")
        let testerName = arguments.optionalArgument("testerName") ?? "Tester"
        executionString = "\(testerName) will test \(testName), \(times) times"
        if silentFlag {
            executionString += ", silently"
        }
        
        completion?(executionString: executionString)
    }
    
}
