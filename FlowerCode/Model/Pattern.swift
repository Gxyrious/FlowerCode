//
//  Pattern.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import Foundation
import SwiftUI
import CoreLocation

struct Pattern: Hashable, Codable, Identifiable {
    var id:Int
    var name: String
    var description:String
    private var imageName: String  //隐私变量
    var image: Image {
           Image(imageName) //mage类型为Image View,用Imagename进行初始化
    }
}
