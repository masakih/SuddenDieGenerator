//
//  main.swift
//
//  Created by Hori,Masaki on 2018/04/15.
//

import Utility
import SuddenDieGeneratorCore

/// 引数やオプションを保持するstruct
struct SuddenDieOptions {
    
    var suffix: String?
    
    var text = ""
}

/// 引数やオプションを設定するのに利用するArgumentBinder
/// bind時にSuddenDieOptionsが与えられる
let binder = ArgumentBinder<SuddenDieOptions>()

/// ベースとなるパーサ
/// usage, overviewはhelpに使用される
let parser = ArgumentParser(usage: "text", overview: "”Sudden die“ generator")

/// パーサにオプションの指定を追加
/// optionは "--" から始めなければならない
/// shortNameは "-" から始めなければならない
/// kindはオプションの値の型
/// usageはhelpに使用される
///
/// ArgumentBinderを利用し値を取得する
binder.bind(option: parser.add(option: "--suffix",
                               shortName: "-s",
                               kind: String.self,
                               usage: "Suffix of text"),
            to: { options, suffix in
                
                options.suffix = suffix
})

/// パーサに引数の指定を追加
/// positionalは識別子であり、heplに使用される
/// kindは引数の型
/// usageはhelpに使用される
///
/// ArgumentBinderを利用し値を取得する
binder.bind(positional: parser.add(positional: "text", kind: String.self, usage: "Base text"),
            to: { options, text in
                
                options.text = text
})

do {
    
    /// コマンドライン引数からツール名を取り除きパーサにパースさせる
    let result = try parser.parse(Array(CommandLine.arguments.dropFirst()))
    
    /// bindに利用するSuddenDieOptionsを用意
    var options = SuddenDieOptions()
    
    /// パースの結果を用いてbindすることで与えたoptionsに値が設定される
    binder.fill(result, into: &options)

    let generator = Generator(options.text)
    print(generator.generate(suffix: options.suffix))
    
} catch let error as ArgumentParserError {
    
    print(error.description)
    
} catch {
    
    print(error.localizedDescription)
}
