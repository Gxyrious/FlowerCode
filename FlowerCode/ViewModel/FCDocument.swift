//
//  Document.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/7.
//

import Foundation
import SceneKit

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
    
    
    func save() {
        let thisFunction = "\(String(describing: self)).\(#function)"
        do {
            let data: Data = try fcModel.json()
            print("\(thisFunction) json = \(String(data: data, encoding: .utf8) ?? "nil")")
            try data.write(to: Save.url!)
            print("\(thisFunction) success!")
        } catch let encodingError where encodingError is EncodingError {
            print("\(thisFunction) couldn't encode FlowerCode as JSON because \(encodingError.localizedDescription)")
        } catch {
            print("\(thisFunction) error = \(error)")
        }
    }
    
    private struct Save {
        static let filename = "flower.code"
        static var url: URL? {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            return documentDirectory?.appendingPathExtension(filename)
        }
    }
    
    init() {
        if let url = Save.url, let savedModel = try? FCModel(url: url) {
            fcModel = savedModel
        } else {
            fcModel = FCModel()
        }
    }
    
    @Published public var alert = AlertInfo()
    
    @Published var isShowTabBar = true
    
    @Published var isLoggedIn = false
    
    var listSceneChildren: [FCModel.ModelNode] { fcModel.listSceneChildren }
    
    var selectedNodeName: String { fcModel.selectedNodeName }
    
    var flowerName: [String:Int] { fcModel.flower_number }
    
    var username: String { fcModel.userInfo.username }
    
    var password: String { fcModel.userInfo.password }
    
    var signature: String { fcModel.userInfo.signature }
    
    
    
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
    }
    
    static func ModelPosition2SCNVector3(_ position: FCModel.ModelNode.Position) -> SCNVector3 {
        return SCNVector3(x: position.x, y: position.y, z: position.z)
    }
    
    static func ModelRotate2SCNVector4(_ rotate: FCModel.ModelNode.Rotate) -> SCNVector4 {
        return SCNVector4(x: rotate.x, y: rotate.y, z: rotate.z, w: rotate.w)
    }
}
