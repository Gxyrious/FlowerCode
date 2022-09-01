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
    var buttonOne = UIButton(type:UIButton.ButtonType.system)//设置按钮位置与尺寸
    var buttonTwo = UIButton(type:UIButton.ButtonType.system)//设置按钮位置与尺寸
    var panGesture=UIPanGestureRecognizer() // 移动手势
    var tapGesture=UITapGestureRecognizer() // 触碰手势
//    var progressBar1 = UIStackView()
//    var progressBar2 = UIStackView()
//    var pgView1 = UIProgressView()
//    var pgView2 = UIProgressView()
//    var rotateAngle: Float = 0 // 范围[-180,180]
//    var nodeScale: Float = 1.1
//    var rotateAngles: BoneValues
   
    func makeUIView(context: Context) -> SCNView {
        // 初始化
        print("==makeUIView==")
        view.scene = scene
        view.autoenablesDefaultLighting = true
        view.allowsCameraControl = true
        // 添加创作背景板
        let sceneAroundFile = SCNScene(named: "CreateScene.dae")!
        let sceneAround = sceneAroundFile.rootNode.childNode(withName: "Sketchfab_model", recursively: true)!
        sceneAround.name = "dsfsdgsdfg"
        scene.rootNode.addChildNode(sceneAround)
        
//        花瓶
//        let vaseScene = SCNScene(named: "huaping.dae")!
//        let vase = vaseScene.rootNode.childNode(withName: "huaping", recursively: true)!
//        vase.name = "huaping"
//        vase.scale=SCNVector3(4,4,4)
//        vase.position=SCNVector3(0,0,0) // 左右 上下 前后
//        scene.rootNode.addChildNode(vase)
        
//         添加model中的花
        for var node in document.listSceneChildren {
            if !node.isDisplayed {
                let name = node.name.components(separatedBy: "-").first! // 获取花名
                print("获取花名：\(name)和\(node.name)")
                let flowerFile = SCNScene(named: "\(name).dae")!
                let flower = flowerFile.rootNode.childNode(withName: "youjiali", recursively: true) ?? flowerFile.rootNode
                flower.name = node.name
                flower.position = FCDocument.ModelPosition2SCNVector3(node.position)
                flower.rotation = FCDocument.ModelRotate2SCNVector4(node.rotate)
                scene.rootNode.addChildNode(flower)
            }
            node.display()
        }
        
        // 添加一些测试的花
//        let flowerSet = SCNScene(named: "flowerSet.dae")!
////        let myNode = flowerSet.rootNode.childNode(withName: "Sketchfab_model-001", recursively: true)!
////        scene.rootNode.addChildNode(myNode)
//        let eucalyptus1 = flowerSet.rootNode.childNode(withName: "eucalyptus1", recursively: true)!
//        scene.rootNode.addChildNode(eucalyptus1)
//
//        let eucalyptus2 = flowerSet.rootNode.childNode(withName: "eucalyptus2", recursively: true)!
//        scene.rootNode.addChildNode(eucalyptus2)
//
//        let babybreath1 = flowerSet.rootNode.childNode(withName: "babybreath1", recursively: true)!
//        scene.rootNode.addChildNode(babybreath1)
//
//        let nigella1 = flowerSet.rootNode.childNode(withName: "nigella1", recursively: true)!
//        scene.rootNode.addChildNode(nigella1)
//
//        let nigella3 = flowerSet.rootNode.childNode(withName: "nigella3", recursively: true)!
//        scene.rootNode.addChildNode(nigella3)
//
//        let nigella4 = flowerSet.rootNode.childNode(withName: "nigella4", recursively: true)!
//        scene.rootNode.addChildNode(nigella4)
//
//        let larkspur = flowerSet.rootNode.childNode(withName: "larkspur", recursively: true)!
//        scene.rootNode.addChildNode(larkspur)
//
//        let astrantia = flowerSet.rootNode.childNode(withName: "astrantia", recursively: true)!
//        scene.rootNode.addChildNode(astrantia)
//
//        let astrantia1 = flowerSet.rootNode.childNode(withName: "astrantia1", recursively: true)!
//        scene.rootNode.addChildNode(astrantia1)
//
//        let astrantia2 = flowerSet.rootNode.childNode(withName: "astrantia2", recursively: true)!
//        scene.rootNode.addChildNode(astrantia2)


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
        sideLightNode.light = omniLight
        sideLightNode.position=modelSideLightNode.position
        sideLightNode.rotation=modelSideLightNode.rotation
        
        let frontLightNode = SCNNode()
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
        buttonOne.frame = CGRect(x:280,y:50,width:80,height:30)//设置按钮背景色
        buttonOne.backgroundColor=UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)//设置按钮标题
        buttonOne.setTitle("正面镜头", for: UIControl.State())
        buttonOne.setTitleColor(UIColor.white,for: UIControl.State())//添加到当前视图
        self.view.addSubview(buttonOne)
        buttonOne.addTarget(
            context.coordinator,
            action :#selector(context.coordinator.buttonOnetouchBegin),
            for :UIControl.Event.touchUpInside
        )
        
        /// 创建UIButton实例用于移动花
        buttonTwo.frame = CGRect(x:180,y:50,width:80,height:30)//设置按钮背景色
        buttonTwo.backgroundColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
        buttonTwo.setTitle("侧面镜头", for: UIControl.State())
        buttonTwo.setTitleColor(UIColor.white,for: UIControl.State())//添加到当前视图
        self.view.addSubview(buttonTwo)
        buttonTwo.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.buttonTwotouchBegin),
            for: .touchUpInside
        )
        
        // 创建进度条调整花的旋转问题
//        progressBar1.axis = .horizontal
//        progressBar1.distribution = .fill
//        progressBar1.spacing = 10
//        progressBar1.frame = CGRect(x: 45, y: 660, width: 300, height: 20)
        // -----
        // minus按钮
        let uiButtonMinus1 = UIButton(type: UIButton.ButtonType.custom)
        uiButtonMinus1.setBackgroundImage(
            UIImage(systemName: "minus.circle")?
                .withTintColor(
                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
                    renderingMode: .alwaysOriginal
                ),
            for: .normal
        )
//        uiButtonMinus1.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.minusAngle),
//            for: .touchUpInside
//        )
//        progressBar1.addArrangedSubview(uiButtonMinus1)
//        // 进度条
//        pgView1.setProgress((rotateAngle + 180) / 360, animated: false)
//        pgView1.transform = CGAffineTransform(scaleX: 1.0,y: 0.2)
//        pgView1.progressTintColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
//        progressBar1.addArrangedSubview(pgView1)
        // plus按钮
        let uiButtonPlus1 = UIButton(type: UIButton.ButtonType.system)
        uiButtonPlus1.setBackgroundImage(
            UIImage(systemName: "plus.circle")?
                .withTintColor(
                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
                    renderingMode: .alwaysOriginal
                ),
            for: .normal
        )
//        uiButtonPlus1.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.plusAngle),
//            for: .touchUpInside
//        )
//        progressBar1.addArrangedSubview(uiButtonPlus1)
        // -----
        // 创建进度条调整花的旋转问题
//        progressBar2.axis = .horizontal
//        progressBar2.distribution = .fill
//        progressBar2.spacing = 10
//        progressBar2.frame = CGRect(x: 45, y: 700, width: 300, height: 20)
        // minus按钮
        let uiButtonMinus2 = UIButton(type: UIButton.ButtonType.custom)
        uiButtonMinus2.setBackgroundImage(
            UIImage(systemName: "minus.circle")?
                .withTintColor(
                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
                    renderingMode: .alwaysOriginal
                ),
            for: .normal
        )
//        uiButtonMinus2.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.minusScale),
//            for: .touchUpInside
//        )
//        progressBar2.addArrangedSubview(uiButtonMinus2)
        // 进度条
//        pgView2.setProgress((nodeScale + 180) / 360, animated: false)
//        pgView2.transform = CGAffineTransform(scaleX: 1.0,y: 0.2)
//        pgView2.progressTintColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
//        progressBar2.addArrangedSubview(pgView2)
        // plus按钮
        let uiButtonPlus2 = UIButton(type: UIButton.ButtonType.system)
        uiButtonPlus2.setBackgroundImage(
            UIImage(systemName: "plus.circle")?
                .withTintColor(
                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
                    renderingMode: .alwaysOriginal
                ),
            for: .normal
        )
//        uiButtonPlus2.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.plusScale),
//            for: .touchUpInside
//        )
//        progressBar2.addArrangedSubview(uiButtonPlus2)
        // -----
        
        // 添加到view
//        self.view.addSubview(progressBar1)
//        self.view.addSubview(progressBar2)

        
        // 设置背景
        scene.background.contents=UIImage(named: "background.jpg")
        
        // 设置代理
        view.delegate = context.coordinator
        
        return view
    }

    func updateUIView(_ view: SCNView, context: Context) {
        // 该函数何时被触发？
        print("==updateUIView==")
        
        print(document.listSceneChildren)
        print(document.flowerNumber)
        
//        for var node in document.listSceneChildren {
//            if !node.isDisplayed {
//                let name = node.name.components(separatedBy: "-").first!
//                print("获取花名：\(name)")
//                let flowerFile = SCNScene(named: "\(name).dae")!
//                let flower = flowerFile.rootNode
//                flower.name = node.name
//                flower.position = FCDocument.ModelPosition2SCNVector3(node.position)
//                flower.rotation = FCDocument.ModelRotate2SCNVector4(node.rotate)
//                scene.rootNode.addChildNode(flower)
//            }
//            node.display()
//        }
        
    }
    
    func makeCoordinator() -> ArrangeView.Coordinator {
        Coordinator(self, scene: $scene)
    }
    
    class Coordinator: NSObject, SCNSceneRendererDelegate {
        
        var parent: ArrangeView
        
        @Binding var scene: SCNScene
        
//        @EnvironmentObject var document: FCDocument

        init(_ parent: ArrangeView, scene: Binding<SCNScene>) {
            self.parent = parent
            self._scene = scene
        }
        
        let angles: [CGFloat] = [0, 90, 180, 270]
        var panStartZ = CGFloat()
        var lastPanLocation = SCNVector3()
        var positionDice1 = SCNVector3(x: -4, y: 7, z: 7.4)
        var positionDice2 = SCNVector3(x: -2, y: 7, z: 7.4)
        var durationOfReturn = Double()
        var f1 = false
        var f2 = false
        
//        @objc func minusAngle() {
//            var selectedChild: String? = nil
//            for key in parent.nodesSelected.keys {
//                if parent.nodesSelected[key] == true {
//                    selectedChild = key
//                }
//            }
//            if selectedChild == nil { return }
//            guard let child = parent.view.scene?.rootNode.childNode(withName: selectedChild!, recursively: true) else { return }
//            parent.rotateAngle -= 10
//            if parent.rotateAngle < -180 { parent.rotateAngle = -180 }
//            parent.pgView1.setProgress((parent.rotateAngle + 180) / 360, animated: false)
//            child.rotation = SCNVector4(0,1,0,.pi * parent.rotateAngle / 180.0)
//            print("rotate-angle=\(parent.rotateAngle)")
//        }
        
//        @objc func plusAngle() {
//            var selectedChild: String? = nil
//            for key in parent.nodesSelected.keys {
//                if parent.nodesSelected[key] == true {
//                    selectedChild = key
//                }
//            }
//            if selectedChild == nil { return }
//            guard let child = parent.view.scene?.rootNode.childNode(withName: selectedChild!, recursively: true) else { return }
//            parent.rotateAngle += 10
//            if parent.rotateAngle > 180 { parent.rotateAngle = 180 }
//            parent.pgView1.setProgress((parent.rotateAngle + 180) / 360, animated: false)
//            child.rotation = SCNVector4(0,1,0,.pi * parent.rotateAngle / 180.0)
//            print("rotate-angle=\(parent.rotateAngle)")
//        }
        
//        @objc func minusScale() {
//            var selectedChild: String? = nil
//            for key in parent.nodesSelected.keys {
//                if parent.nodesSelected[key] == true {
//                    selectedChild = key
//                }
//            }
//            if selectedChild == nil { return }
//            guard let child = parent.view.scene?.rootNode.childNode(withName: selectedChild!, recursively: true) else { return }
//            parent.nodeScale = child.scale.z
//            parent.nodeScale -= 0.1
//            if parent.nodeScale < 0.1 { parent.nodeScale = 0.1 }
//            parent.pgView2.setProgress((parent.nodeScale - 0.1) / 2, animated: false)
//            child.scale = SCNVector3(parent.nodeScale,parent.nodeScale,parent.nodeScale)
//            print("node-scale=\(parent.nodeScale)")
//        }
        
//        @objc func plusScale() {
//            var selectedChild: String? = nil
//            for key in parent.nodesSelected.keys {
//                if parent.nodesSelected[key] == true {
//                    selectedChild = key
//                }
//            }
//            if selectedChild == nil { return }
//            guard let child = parent.view.scene?.rootNode.childNode(withName: selectedChild!, recursively: true) else { return }
//            parent.nodeScale = child.scale.z
//            parent.nodeScale += 0.1
//            if parent.rotateAngle > 2.1 { parent.nodeScale = 2.1 }
//            parent.pgView2.setProgress((parent.nodeScale - 0.1) / 2, animated: false)
//            child.scale = SCNVector3(parent.nodeScale,parent.nodeScale,parent.nodeScale)
//            print("node-scale=\(parent.nodeScale)")
//        }
        
        @objc func buttonOnetouchBegin(){
            parent.view.pointOfView = parent.cameraFrontNode
            parent.view.allowsCameraControl = true
//            parent.view.removeGestureRecognizer(parent.panGesture)
            
            print("buttonOnetouchBegin")
        }
        
        @objc func buttonTwotouchBegin(){
            parent.view.pointOfView = parent.cameraSideNode
            parent.view.allowsCameraControl = true
//            parent.view.addGestureRecognizer(parent.panGesture)
            
            print("buttonTwotouchBegin")
        }
        
        @objc func handleTap(_ tapGesture: UITapGestureRecognizer) {
            let location = tapGesture.location(in: parent.view)
            let hitResults = parent.view.hitTest(location,options: nil)
            print("==hitResults==")
            print(hitResults)
            if hitResults.count > 0 {
                let resultName = hitResults[0].node.name!
                print("-resultName- = \(resultName)")
//                if resultName == "Sketchfab_model"  {
//                    return
//                }
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
                        material.emission.contents = CGColor(red: 1, green: 0, blue: 0, alpha: 1)
                        SCNTransaction.commit()
                        return
                    }
                }
                print("未触碰到花")
                return
            }
            print("未触碰到实体")
        }
        
        /// Handle PanGesture for localTranslate and applyForce to dice
        /// - Parameter panGesture: A discrete gesture recognizer that interprets panning gestures.
        @objc func handlePan(_ panGesture: UIPanGestureRecognizer){
            // Getting nodes from MainScene.scn
//            guard let drawingNode = parent.scene.rootNode.childNode(withName: "drawingNode", recursively: true) else { return }
//            var name: String? = nil
//            for (key,value) in parent.nodesSelected {
//                if value == true {
//                    name = key
//                    break
//                }
//            }
//            if name == nil { return }
            print("selectedNodeName=\(parent.document.selectedNodeName)")
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
            default:
                break
            }
        }
    }
}
