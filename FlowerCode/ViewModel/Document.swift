//
//  Document.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/7.
//

import Foundation

class FlowerCode: ObservableObject {
    
    // 模型
    @Published private(set) var userModel: UserModel
    @Published private(set) var runtimeModel: RuntimeModel
    
    // Model不设置初始化函数，全部放在ViewModel中初始化
    init() {
        userModel = UserModel(loginStatus: .Visitor)
        runtimeModel = RuntimeModel(selectedView: 0) // 默认在登陆界面
    }
}
