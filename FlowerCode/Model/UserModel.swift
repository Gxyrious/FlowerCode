//
//  UserModel.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/7.
//

import Foundation

struct UserModel {
    
    // 登录状态
    var loginStatus: LoginStatus
    
    enum LoginStatus {
        case Login(user: User)
        case Visitor
    }
}
