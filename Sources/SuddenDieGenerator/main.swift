//
//  main.swift
//
//  Created by Hori,Masaki on 2018/04/15.
//

import Utility
import SuddenDieGeneratorCore

let parser = ArgumentParser(usage: "text", overview: "”Sudden die“ generator")
let args = parser.add(positional: "text", kind: String.self, usage: "Base text")

do {
    
    let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))
    
    if let value = result.get(args) {
        
        let generator = Generator(value)
        print(generator.generate())
    }
    
} catch let error as ArgumentParserError {
    
    print(error.description)
    
} catch {
    
    print(error.localizedDescription)
}
