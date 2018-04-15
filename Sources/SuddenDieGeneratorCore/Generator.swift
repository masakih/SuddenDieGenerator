//
//  Generator.swift
//
//  Created by Hori,Masaki on 2018/04/15.
//

import Foundation

public class Generator {
    
    private let value: String
    
    public init(_ value: String) {
        
        self.value = value
    }
    
    public func generate(suffix: String? = nil) -> String {
        
        let display = suffix.map { value + $0 } ?? value
        let valueWidth = display.width / 2
        
        return "＿" + Array(repeating: "人", count: valueWidth + 2).reduce("", +) + "＿\n"
            + "＞　" + display + "　＜\n"
            + "￣Y" + Array(repeating: "^Y", count: valueWidth).reduce("", +) + "￣"
    }
}
