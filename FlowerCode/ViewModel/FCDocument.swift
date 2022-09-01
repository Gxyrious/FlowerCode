//
//  Document.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/7.
//

import Foundation
import SceneKit
import SwiftUI

extension FCDocument {
    
    struct AlertInfo: Codable {
        
        var alertSuccessLogIn = false
        
        var alertSuccessRegister = false

        var alertFailLogIn = false
        
        var alertFailRegister = false
        
        var alertUnknown = false
        
        var alertIllegal = false
    }
}

class FCDocument: ObservableObject {
    
    // 模型
    @Published private(set) var fcModel: FCModel
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    func getModelData() -> Data? {
        var data: Data? = nil
        do {
            data = try fcModel.json()
        } catch {
            print("error = \(error)")
        }
        return data
    }
    
//    func save() {
//        print("===save===")
//        for user in users {
//            print("username = \(user.username!) & password = \(user.password!)")
//            if user.username == username {
//                do {
//                    let data: Data = try fcModel.json()
//                    user.model = data
//                } catch {
//                    print("error = \(error)")
//                }
//            }
//        }
//    }
    
//    private struct Save {
//        static let filename = "flower.code"
//        static var url: URL? {
//            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
//            return documentDirectory?.appendingPathExtension(filename)
//        }
//    }
    
    func initModel(_ modelData: Data) {
        do {
            fcModel = try FCModel(json: modelData)
        } catch {
            print("初始化失败，错误：\(error)")
        }
    }
    
    init() {
        
//        if let url = Save.url, let savedModel = try? FCModel(url: url) {
//            fcModel = savedModel
//        } else {
//            fcModel = FCModel()
//        }
        
        fcModel = FCModel()
    }
    
    
    @Published public var alert = AlertInfo()
    
    @Published var isShowTabBar = true
    
    @Published var isLoggedIn = false
    
    var listSceneChildren: [FCModel.ModelNode] { fcModel.listSceneChildren }
    
    var selectedNodeName: String { fcModel.selectedNodeName }
    
    var flowerNumber: [String:Int] { fcModel.flower_number }
    
    var username: String { fcModel.userInfo.username }
    
    var password: String { fcModel.userInfo.password }
    
    var signature: String { fcModel.userInfo.signature }
    
    var isDisplayed: [String:Bool] { fcModel.isDisplayed }
    
    func displayByName(name: String) {
        for child in listSceneChildren {
            if child.name == name {
                fcModel.isDisplayed[name] = true
            }
        }
    }
    
    func toggleAlertSuccessLogIn(_ username: String, _ password: String) {
        alert.alertSuccessLogIn.toggle()
        fcModel.userInfo.username = username
        fcModel.userInfo.password = password
        isLoggedIn = true
    }
    
    func toggleAlertSuccessRegister() {
        alert.alertSuccessRegister.toggle()
    }
    
    func toggleAlertFailLogIn() {
        alert.alertFailLogIn.toggle()
    }
    
    func toggleAlertFailRegister() {
        alert.alertFailRegister.toggle()
    }
    
    func toggleAlertUnknown() {
        alert.alertUnknown.toggle()
    }
    
    func toggleAlertIllegal() {
        alert.alertIllegal.toggle()
    }
    
    func selectSCNNode(_ nodeName: String) {
        fcModel.selectedNodeName = nodeName
    }
    
    func addFlowerByOne(_ name: String) {
        fcModel.flower_number[name]! += 1
    }
    
    func addSceneChild(_ childName: String, _ position: SCNVector3, _ rotate: SCNVector4) {
        let node = FCModel.ModelNode(childName,
                             position.x, position.y, position.z,
                             rotate.x, rotate.y, rotate.z, rotate.w)
        fcModel.listSceneChildren.append(node)
        // 保证isDisplayed[:String]和listSceneChildren中child的name对应
        fcModel.isDisplayed.updateValue(false, forKey: childName)
    }
    
    func updateSceneChild(_ childName: String, _ position: SCNVector3, _ rotate: SCNVector4) {
        // 存在就更新，不存在就不操作
//        fcModel.listSceneChildren.filter { node in
//            return node.name == childName
//        }
        for index in 0 ..< fcModel.listSceneChildren.count {
            let child = fcModel.listSceneChildren[index]
            if child.name == childName {
                let newChild = FCModel.ModelNode(
                    childName, position.x, position.y, position.z,
                    rotate.x, rotate.y, rotate.z, rotate.w
                )
                fcModel.listSceneChildren.remove(at: index)
                fcModel.listSceneChildren.append(newChild)
            }
        }
        print(listSceneChildren)
    }
    
    func autoGenerate() {
        for index in 0 ..< fcModel.listSceneChildren.count {
            let child = fcModel.listSceneChildren.remove(at: index)
            let newChild = FCModel.ModelNode(child.name, Float.zero, Float.zero, Float.zero,
                                             Float.zero, Float.zero, Float.zero, Float.zero)
            
            fcModel.listSceneChildren.append(newChild)
        }
    }
    
    static func ModelPosition2SCNVector3(_ position: FCModel.ModelNode.Position) -> SCNVector3 {
        return SCNVector3(x: position.x, y: position.y, z: position.z)
    }
    
    static func ModelRotate2SCNVector4(_ rotate: FCModel.ModelNode.Rotate) -> SCNVector4 {
        return SCNVector4(x: rotate.x, y: rotate.y, z: rotate.z, w: rotate.w)
    }
}
