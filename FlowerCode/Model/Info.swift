//
//  Info.swift
//  FlowerCode
// 修建与造型
//  Created by 昏影终 on 2022/8/19.
//

import Foundation
import SwiftUI
import CoreLocation

struct Info: Hashable, Codable, Identifiable {
    var id:Int
    var title: String
    var content:String
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case basicPrinciple = "基本原理"
        case basicForm = "基本形式"
        case arrangeCategory = "插花类别"
        case makeTechnique = "制作技巧"
    }
    private var imageName: String  //隐私变量
    var image: Image {
           Image(imageName) //mage类型为Image View,用Imagename进行初始化
    }
}
