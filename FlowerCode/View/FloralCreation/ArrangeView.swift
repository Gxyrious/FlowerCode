//
//  CreatingView.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/7/3.
//

import SwiftUI
import UIKit
import SceneKit
import QuartzCore

struct ArrangeView: UIViewRepresentable {
    @Binding var scene: SCNScene
    @EnvironmentObject var document: FCDocument
    
    var view = SCNView()
    var cameraFrontNode = SCNNode()
    var cameraSideNode = SCNNode()
    var frontCameraButton = UIButton(type:UIButton.ButtonType.system)//设置按钮位置与尺寸
    var sideCameraButton = UIButton(type:UIButton.ButtonType.system)//设置按钮位置与尺寸
    var removeFlowerButton = UIButton(type:UIButton.ButtonType.system)
    var panGesture=UIPanGestureRecognizer() // 移动手势
    var tapGesture=UITapGestureRecognizer() // 触碰手势
   
    func makeUIView(context: Context) -> SCNView {
        // 初始化
        print("==makeUIView==")
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        // 添加创作背景板
        let sceneAroundFile = SCNScene(named: "CreateScene.dae")!
        let sceneAround = sceneAroundFile.rootNode.childNode(withName: "Sketchfab_model", recursively: true)!
        sceneAround.name = "Around"
        scene.rootNode.addChildNode(sceneAround)
        
//         添加model中的花
        for node in document.listSceneChildren {
            let name = node.name.components(separatedBy: "-").first!
            print("获取花名：\(name)")
            var flag = true
            for child in scene.rootNode.childNodes {
                if child.name == node.name {
                    // 已经存在
                    flag = false
                    break
                }
            }
            if flag {
                let flowerFile = SCNScene(named: FlowerKind2FileName[name]!)!
                let flower = flowerFile.rootNode.childNode(withName: node.name, recursively: true)!
    //                flower.name = node.name
                flower.position = FCDocument.ModelPosition2SCNVector3(node.position)
                flower.rotation = FCDocument.ModelRotate2SCNVector4(node.rotate)
                scene.rootNode.addChildNode(flower)
            }
        }
        
        // 添加一些测试的花
        
        // flowerSet.dae
//        let flowerSet = SCNScene(named: "flowerSet.dae")!
//        let flowerSetNode = flowerSet.rootNode.childNode(withName: "RootNode-001", recursively: true)!
////        scene.rootNode.addChildNode(flowerSetNode)
//        let eucalyptus1 = flowerSetNode.childNode(withName: "AnShu-1", recursively: true)!
//        scene.rootNode.addChildNode(eucalyptus1)
//
//        let eucalyptus2 = flowerSetNode.childNode(withName: "AnShu-2", recursively: true)!
//        scene.rootNode.addChildNode(eucalyptus2)

//        let babybreath1 = flowerSetNode.childNode(withName: "ManTianXing-1", recursively: true)!
//        scene.rootNode.addChildNode(babybreath1)
//
//        let nigella1 = flowerSetNode.childNode(withName: "ManTianXing-2", recursively: true)!
//        scene.rootNode.addChildNode(nigella1)
//
//        let nigella3 = flowerSetNode.childNode(withName: "HeiZhongCao-1", recursively: true)!
//        scene.rootNode.addChildNode(nigella3)
//
//        let nigella4 = flowerSetNode.childNode(withName: "HeiZhongCao-2", recursively: true)!
//        scene.rootNode.addChildNode(nigella4)
//
//        let larkspur = flowerSetNode.childNode(withName: "HeiZhongCao-3", recursively: true)!
//        scene.rootNode.addChildNode(larkspur)
//
//        let astrantia = flowerSetNode.childNode(withName: "DaXingQin-1", recursively: true)!
//        scene.rootNode.addChildNode(astrantia)
//
//        let astrantia1 = flowerSetNode.childNode(withName: "DaXingQin-2", recursively: true)!
//        scene.rootNode.addChildNode(astrantia1)
//
//        let astrantia2 = flowerSetNode.childNode(withName: "DaXingQin-3", recursively: true)!
//        scene.rootNode.addChildNode(astrantia2)

        // flowerSet_yujinxiang.dae
//        let flowerSet_yujinxiang = SCNScene(named: "flowerSet_yujinxiang.dae")!
//        let yujinxiangNode = flowerSet_yujinxiang.rootNode.childNode(withName: "yujinxiang", recursively: true)!
////        scene.rootNode.addChildNode(yujinxiangNode)
//        let yujingxiang1 = yujinxiangNode.childNode(withName: "YuJinXiang-1", recursively: true)!
//        scene.rootNode.addChildNode(yujingxiang1)
//
//        let yujingxiang2 = yujinxiangNode.childNode(withName: "YuJinXiang-2", recursively: true)!
//        scene.rootNode.addChildNode(yujingxiang2)
//
//        let yujingxiang3 = yujinxiangNode.childNode(withName: "YuJinXiang-3", recursively: true)!
//        scene.rootNode.addChildNode(yujingxiang3)
//
//        let yujingxiang4 = yujinxiangNode.childNode(withName: "YuJinXiang-4", recursively: true)!
//        scene.rootNode.addChildNode(yujingxiang4)
//
//        let yujingxiang5 = yujinxiangNode.childNode(withName: "YuJinXiang-5", recursively: true)!
//        scene.rootNode.addChildNode(yujingxiang5)
        
        // flowerSet_baizhang.dae
//        let flowerSet_baizhang = SCNScene(named: "flowerSet_baizhang.dae")!
//        let baizhangNode = flowerSet_baizhang.rootNode.childNode(withName: "RootNode-002", recursively: true)!
////        scene.rootNode.addChildNode(baizhangNode)
//        let baizhang1 = baizhangNode.childNode(withName: "BaiZhang-1", recursively: true)!
//        scene.rootNode.addChildNode(baizhang1)

//        let baizhang2 = baizhangNode.childNode(withName: "BaiZhang-2", recursively: true)!
//        scene.rootNode.addChildNode(baizhang2)
//
//        let baizhang3 = baizhangNode.childNode(withName: "BaiZhang-3", recursively: true)!
//        scene.rootNode.addChildNode(baizhang3)
//
//        let baizhang4 = baizhangNode.childNode(withName: "BaiZhang-4", recursively: true)!
//        scene.rootNode.addChildNode(baizhang4)
//
//        let baizhang5 = baizhangNode.childNode(withName: "BaiZhang-5", recursively: true)!
//        scene.rootNode.addChildNode(baizhang5)
        
//        let flowerSet_meigui = SCNScene(named: "flowerSet_meigui.dae")!
//        let meiguiNode = flowerSet_meigui.rootNode.childNode(withName: "Empty-002_9", recursively: true)!
////        scene.rootNode.addChildNode(meiguiNode)
//        let meigui1 = meiguiNode.childNode(withName: "MeiGui-1", recursively: true)!
//        scene.rootNode.addChildNode(meigui1)
//
//        let meigui2 = meiguiNode.childNode(withName: "MeiGui-2", recursively: true)!
//        scene.rootNode.addChildNode(meigui2)
//
//        let meigui3 = meiguiNode.childNode(withName: "MeiGui-3", recursively: true)!
//        scene.rootNode.addChildNode(meigui3)
//
//        let meigui4 = meiguiNode.childNode(withName: "MeiGui-4", recursively: true)!
//        scene.rootNode.addChildNode(meigui4)
//
//        let meigui5 = meiguiNode.childNode(withName: "MeiGui-5", recursively: true)!
//        scene.rootNode.addChildNode(meigui5)
//
//        let meigui6 = meiguiNode.childNode(withName: "MeiGui-6", recursively: true)!
//        scene.rootNode.addChildNode(meigui6)

//        let vaseSet = SCNScene(named: "vaseSet.dae")!
//        let vaseNode = vaseSet.rootNode
////        scene.rootNode.addChildNode(vaseNode)
//        let vase1 = vaseNode.childNode(withName: "Vase-1", recursively: true)!
//        scene.rootNode.addChildNode(vase1)
        
//        let vase2 = vaseNode.childNode(withName: "Vase-2", recursively: true)!
//        scene.rootNode.addChildNode(vase2)
//
//        let vase3 = vaseNode.childNode(withName: "Vase-3", recursively: true)!
//        scene.rootNode.addChildNode(vase3)
//
//        let vase4 = vaseNode.childNode(withName: "Vase-4", recursively: true)!
//        scene.rootNode.addChildNode(vase4)
//
//        let vase5 = vaseNode.childNode(withName: "Vase-5", recursively: true)!
//        scene.rootNode.addChildNode(vase5)
        
        // 正面镜头
        let modelCameraFrontNode = sceneAroundFile.rootNode.childNode(withName: "Camera_front", recursively: true)
        cameraFrontNode.camera = SCNCamera()
        cameraFrontNode.position = modelCameraFrontNode!.position
        cameraFrontNode.rotation = modelCameraFrontNode!.rotation
        view.pointOfView = cameraFrontNode
        print("-modelCameraFrontNode-")
        print(modelCameraFrontNode!.position)
        print(modelCameraFrontNode!.rotation)
        
        // 侧面镜头
        let modelCameraSizeNode = sceneAroundFile.rootNode.childNode(withName: "Camera_side", recursively: true)
        cameraSideNode.camera = SCNCamera()
        cameraSideNode.position = modelCameraSizeNode!.position
        cameraSideNode.rotation = modelCameraSizeNode!.rotation
        print("-modelCameraSizeNode-")
        print(modelCameraSizeNode!.position)
        print(modelCameraSizeNode!.rotation)
        
        //点光源
        let omniLight=SCNLight()
        omniLight.type=SCNLight.LightType.omni
        omniLight.color=UIColor(white:1.0,alpha:1.0)
        
        let modelSideLightNode = sceneAroundFile.rootNode.childNode(withName: "Light-001", recursively: true)!
        let modelFrontLightNode = sceneAroundFile.rootNode.childNode(withName: "Light", recursively: true)!
        
        let sideLightNode = SCNNode()
        sideLightNode.name = "side-light"
        sideLightNode.light = omniLight
        sideLightNode.position=modelSideLightNode.position
        sideLightNode.rotation=modelSideLightNode.rotation
        
        let frontLightNode = SCNNode()
        frontLightNode.name = "front-light"
        frontLightNode.light = omniLight
        frontLightNode.position = modelFrontLightNode.position
        frontLightNode.rotation = modelFrontLightNode.rotation

        scene.rootNode.addChildNode(sideLightNode)
        scene.rootNode.addChildNode(frontLightNode)
        
        
        // 添加手势检测
        panGesture.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.handlePan(_:))
        )
        view.addGestureRecognizer(panGesture)
        
        tapGesture.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.handleTap(_:))
        )
        view.addGestureRecognizer(tapGesture)
        
        /// 创建UIButton实例用于旋转镜头
        frontCameraButton.frame = CGRect(x:280,y:50,width:80,height:30)//设置按钮背景色
        frontCameraButton.backgroundColor=UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)//设置按钮标题
        frontCameraButton.setTitle("正面镜头", for: UIControl.State())
        frontCameraButton.setTitleColor(UIColor.white,for: UIControl.State())//添加到当前视图
        self.view.addSubview(frontCameraButton)
        frontCameraButton.addTarget(
            context.coordinator,
            action :#selector(context.coordinator.startFrontCamera),
            for :UIControl.Event.touchUpInside
        )
        
        /// 创建UIButton实例用于移动花
        sideCameraButton.frame = CGRect(x:180,y:50,width:80,height:30)//设置按钮背景色
        sideCameraButton.backgroundColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
        sideCameraButton.setTitle("侧面镜头", for: UIControl.State())
        sideCameraButton.setTitleColor(UIColor.white,for: UIControl.State())//添加到当前视图
        self.view.addSubview(sideCameraButton)
        sideCameraButton.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.startSideCamera),
            for: .touchUpInside
        )
        
        /// 创建UIButton实例用于删除花
        removeFlowerButton.frame = CGRect(x:180,y:90,width:80,height:30)//设置按钮背景色
        removeFlowerButton.backgroundColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
        removeFlowerButton.setTitle("删除", for: UIControl.State())
        removeFlowerButton.setTitleColor(UIColor.white,for: UIControl.State())//添加到当前视图
        self.view.addSubview(removeFlowerButton)
        removeFlowerButton.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.removeChildByName),
            for: .touchUpInside
        )
        
        // 设置背景
        scene.background.contents=UIImage(named: "background.jpg")
        
        // 设置代理
        view.delegate = context.coordinator
        
        return view
    }

    func updateUIView(_ view: SCNView, context: Context) {
        // 该函数何时被触发？
        print("======updateUIView======")
        
        print(document.listSceneChildren)
        for child in scene.rootNode.childNodes {
            print("======\(child.name!)======")
            print(child.position)
        }
        print(document.flowerNumber)
        
        for node in document.listSceneChildren {
            let name = node.name.components(separatedBy: "-").first!
            print("获取花名：\(name)")
            var flag = true
            for child in scene.rootNode.childNodes {
                if child.name == node.name {
                    // 已经存在
                    flag = false
                    break
                }
            }
            if flag {
                let flowerFile = SCNScene(named: FlowerKind2FileName[name]!)!
                let flower = flowerFile.rootNode.childNode(withName: node.name, recursively: true)!
    //                flower.name = node.name
                flower.position = FCDocument.ModelPosition2SCNVector3(node.position)
                flower.rotation = FCDocument.ModelRotate2SCNVector4(node.rotate)
                scene.rootNode.addChildNode(flower)
            }
        }
        
    }
    
    func makeCoordinator() -> ArrangeView.Coordinator {
        Coordinator(self, scene: $scene)
    }
    
    class Coordinator: NSObject, SCNSceneRendererDelegate {
        
        var parent: ArrangeView
        
        @Binding var scene: SCNScene

        init(_ parent: ArrangeView, scene: Binding<SCNScene>) {
            self.parent = parent
            self._scene = scene
        }
        
        let angles: [CGFloat] = [0, 90, 180, 270]
        var panStartZ = CGFloat()
        var lastPanLocation = SCNVector3()
        
        @objc func startFrontCamera() {
            parent.view.pointOfView = parent.cameraFrontNode
            parent.view.allowsCameraControl = true
//            parent.view.removeGestureRecognizer(parent.panGesture)
            
            print("startFrontCamera")
        }
        
        @objc func startSideCamera() {
            parent.view.pointOfView = parent.cameraSideNode
            parent.view.allowsCameraControl = true
//            parent.view.addGestureRecognizer(parent.panGesture)
            
            print("startSideCamera")
        }
        
        @objc func removeChildByName() {
            // 删除选中的花/花瓶
            let node = scene.rootNode.childNode(withName: parent.document.selectedNodeName, recursively: true)
            if node != nil {
                node!.removeFromParentNode()
                parent.document.removeChildByName(node!.name!)
            }
        }
        
        @objc func handleTap(_ tapGesture: UITapGestureRecognizer) {
            let location = tapGesture.location(in: parent.view)
            let hitResults = parent.view.hitTest(location,options: nil)
            print("==hitResults==")
            print(hitResults)
            if hitResults.count > 0 {
                let resultName = hitResults[0].node.name!
                print("-resultName- = \(resultName)")
                for node in parent.document.listSceneChildren {
                    if node.name == resultName {
                        parent.document.selectSCNNode(resultName)
                        
                        let material = hitResults[0].node.geometry!.firstMaterial!
                        
                        // highlight it
                        SCNTransaction.begin()
                        SCNTransaction.animationDuration = 0.2
                        
                        // on completion - unhighlight
                        SCNTransaction.completionBlock = {
                            SCNTransaction.begin()
                            SCNTransaction.animationDuration = 0.2
                            
                            material.emission.contents = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
                            
                            SCNTransaction.commit()
                        }
                        material.emission.contents = CGColor(red: 0, green: 1, blue: 0, alpha: 1)
                        SCNTransaction.commit()
                        return
                    }
                }
                print("未触碰到花")
                return
            }
            print("未触碰到实体")
        }

        
        @objc func handlePan(_ panGesture: UIPanGestureRecognizer){
//            print("selectedNodeName=\(parent.document.selectedNodeName)")
            let node = scene.rootNode.childNode(withName: parent.document.selectedNodeName, recursively: true) ?? nil
            if node == nil { return }

            let location = panGesture.location(in: parent.view) // 点击位置，二维
            let hitNodeResult = parent.view.hitTest(location, options: nil).first ?? nil
            // 寻找当前选中的目标
            
            switch panGesture.state {
            case .began:
                print("begin")
                if hitNodeResult == nil {
                    // 如果触碰处没有实体
                    print("--no node--")
                }
                else {
//                    print("node:\(String(describing: name))")
                    lastPanLocation = hitNodeResult!.worldCoordinates
                    panStartZ = CGFloat(parent.view.projectPoint(lastPanLocation).z)
//                    parent.nodesSelected[name!] = true
                }
                
            case .changed:
                //Moving the dice behind the finger
                print("changed")
                let worldTouchPosition = parent.view.unprojectPoint(SCNVector3(location.x, location.y, panStartZ))
                let movementVector = SCNVector3(
                    worldTouchPosition.x - lastPanLocation.x,
                    worldTouchPosition.y - lastPanLocation.y,
                    worldTouchPosition.z - lastPanLocation.z
                )
                
                node!.runAction(SCNAction.move(by: movementVector, duration: 0))
                self.lastPanLocation = worldTouchPosition

            case .ended:
                print("ended")
                print(node!.position)
                print(node!.rotation)
                parent.document.updateSceneChild(node!.name!, node!.position, node!.rotation)
            default:
                break
            }
        }
    }
}
