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
    
    public func generate() -> String {
        
        let valueWidth = value.width / 2
        
        return "＿" + Array(repeating: "人", count: valueWidth + 2).reduce("", +) + "＿\n"
            + "＞　" + value + "　＜\n"
            + "￣Y" + Array(repeating: "^Y", count: valueWidth).reduce("", +) + "￣"
    }
}
