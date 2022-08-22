//
//  Flower.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import Foundation
import SwiftUI
import CoreLocation

struct Flower: Hashable, Codable, Identifiable {
    var id:Int
    var name: String
    var description:String
    var smell:String
    var humidity:String
    var maintenance:String
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case massMaterial = "团状花材"
        case linearMaterial = "线状花材"
        case scatteredMaterial = "散状花材"
        case specialShapeMaterial = "特殊形状花材"
    }
    var imageName: String  //隐私变量
    var image: Image {
           Image(imageName) //mage类型为Image View,用Imagename进行初始化
    }
}
