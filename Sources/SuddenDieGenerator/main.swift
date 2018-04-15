//
//  main.swift
//
//  Created by Hori,Masaki on 2018/04/15.
//

import Foundation
import Basic
import Utility
import SuddenDieGeneratorCore

/// 引数やオプションを保持するstruct
struct SuddenDieOptions {
    
    var suffix: String?
    
    var outputPath: AbsolutePath?
    
    var texts = [String]()
}

/// 引数やオプションを設定するのに利用するArgumentBinder
/// bind時にSuddenDieOptionsが与えられる
let binder = ArgumentBinder<SuddenDieOptions>()

/// ベースとなるパーサ
/// usage, overviewはhelpに使用される
let parser = ArgumentParser(usage: "text[s]", overview: "”Sudden die“ generator")

/// パーサにオプションの指定を追加
/// optionは "--" から始めなければならない
/// shortNameは "-" から始めなければならない
/// kindはオプションの値の型
/// usageはhelpに使用される
///
/// ArgumentBinderを利用し値を取得する
///
/// 複数のオプションを同時にbind可能
binder.bind(parser.add(option: "--suffix",
                       shortName: "-s",
                       kind: String.self,
                       usage: "Suffix of text"),
            parser.add(option: "--output",
                       shortName: "-o",
                       kind: PathArgument.self,
                       usage: "output file"),
    to: { options, suffix, output in
        
        options.suffix = suffix
        options.outputPath = output?.path
})


/// パーサに引数の指定を追加
/// positionalは識別子であり、heplに使用される
/// kindは引数の型
/// strategyは読み込みをどのように行うか。upToNextOptionは次のオプションが現れるまでの値を全て取得する
/// usageはhelpに使用される
///
/// ArgumentBinderを利用し値を取得する
binder.bindArray(positional: parser.add(positional: "text[s]",
                                        kind: [String].self,
                                        strategy: .upToNextOption,
                                        usage: "Base texts"),
            to: { options, texts in
                
                options.texts = texts
})

do {
    
    /// コマンドライン引数からツール名を取り除きパーサにパースさせる
    let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))
    
    /// bindに利用するSuddenDieOptionsを用意
    var options = SuddenDieOptions()
    
    /// パースの結果を用いてbindすることで与えたoptionsに値が設定される
    binder.fill(result, into: &options)
    
    let displayText = options
        .texts
        .map { Generator($0) }
        .map { $0.generate(suffix: options.suffix) }
        .reduce(into: [String]()) { $0.append($1) }
        .joined(separator: "\n")
    
    if let outputPath = options.outputPath?.asString {
        
        try displayText.data(using: .utf8)?.write(to: Foundation.URL(fileURLWithPath: outputPath))
        
    } else {
        
        print(displayText)
    }
    
} catch let error as ArgumentParserError {
    
    print(error.description)
    
} catch {
    
    print(error.localizedDescription)
}
