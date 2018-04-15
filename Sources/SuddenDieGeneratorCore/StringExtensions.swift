//
//  StringExtensions.swift
//
//  Created by Hori,Masaki on 2018/04/15.
//

extension String {
    
    var width: Int {
        
        var result = 0
        
        for c in self.unicodeScalars {
            
            switch c.value {
                
            case 0..<0x81, 0xf8f0, 0xff61..<0xffa0, 0xf8f1..<0xf8f4:
                result += 1
                
            default:
                result += 2
            }
        }
        
        return result
    }
}
