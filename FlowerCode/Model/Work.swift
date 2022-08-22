//
//  Work.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/21.
//

import Foundation
import SwiftUI
import CoreLocation

struct Work: Hashable, Codable, Identifiable {
    var id:Int
    var name: String
    var description:String
    var difficulty:String
    var humidity:String
    var maintenance:String
    private var imageName: String  //隐私变量
    var image: Image {
           Image(imageName) //mage类型为Image View,用Imagename进行初始化
            .resizable()
    }
    var floNames:[String]
    var keys:[String] //制作要点
    var steps:[Step]
    var vaseNames:String
    
    struct Step: Hashable, Codable{
        var dp:String
        var ign: String  //隐私变量
        var ig: Image {
               Image(ign) //mage类型为Image View,用Imagename进行初始化
        }
    }
}
