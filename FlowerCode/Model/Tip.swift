//
//  Tip.swift
//  FlowerCode
//  花材养护
//  Created by 昏影终 on 2022/8/20.
//

import Foundation
import SwiftUI
import CoreLocation

struct Tip: Hashable, Codable, Identifiable {
    var id:Int
    var title: String
    var content:String
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case before = "插花前养护要点"
        case after = "插花后养护要点"
        case common = "常见花材养护"
    }
    private var imageName: String  //隐私变量
    var image: Image {
           Image(imageName) //mage类型为Image View,用Imagename进行初始化
    }
}
