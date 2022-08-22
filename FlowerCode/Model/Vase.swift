//
//  Vase.swift
//  FlowerCode
// 花瓶
//  Created by 昏影终 on 2022/8/21.
//

import Foundation
import SwiftUI
import CoreLocation

struct Vase: Hashable, Codable, Identifiable {
    var id:Int
    var name:String
    var imageName: String  
    var image: Image {
           Image(imageName) //mage类型为Image View,用Imagename进行初始化
    }
}
