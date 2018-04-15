//
//  main.swift
//
//  Created by Hori,Masaki on 2018/04/15.
//

import Utility
import SuddenDieGeneratorCore

/// ベーストなるパーサ
/// usage, overviewはhelpに使用される
let parser = ArgumentParser(usage: "text", overview: "”Sudden die“ generator")

/// パーサに引数の指定を追加
/// positionalは識別子であり、heplに使用される
/// kindは引数の型
/// usageはhelpに使用される
let arguments = parser.add(positional: "text", kind: String.self, usage: "Base text")

do {
    
    /// コマンドライン引数からツール名を取り除きパーサにパースさせる
    let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))
    
    /// パースの結果からarguments(="text")の値を取り出す
    if let value = result.get(arguments) {
        
        let generator = Generator(value)
        print(generator.generate())
    }
    
} catch let error as ArgumentParserError {
    
    print(error.description)
    
} catch {
    
    print(error.localizedDescription)
}
