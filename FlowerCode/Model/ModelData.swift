//
//  ModelData.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/19.
//

import Foundation
import Combine

var infos: [Info] = load("InfoData.json")
var tips: [Tip] = load("TipData.json")
var flowers: [Flower] = load("FlowerDate.json")
var patterns: [Pattern] = load("PatternData.json")
var vases:[Vase]=load("VaseDate.json")
var basicworks:[Work]=load("BasicWorksDate.json")

var categories: [String: [Info]] {
    Dictionary(
        grouping: infos,
        by: { $0.category.rawValue }
    )
}

var tipCategories: [String: [Tip]] {
    Dictionary(
        grouping: tips,
        by: { $0.category.rawValue }
    )
}

var flowerCategories: [String: [Flower]] {
    Dictionary(
        grouping: flowers,
        by: { $0.category.rawValue }
    )
}

var nameFlowerDic: [String: Flower] {
       var result = [String: Flower]()
       flowers.forEach { result[$0.name] = $0}
       return result
   }

var nameVaseDic: [String: Vase] {
       var result = [String: Vase]()
       vases.forEach { result[$0.name] = $0}
       return result
   }


var it=1

//从应用程序的主包中获取具有给定名称的 JSON 数据的方法。
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
