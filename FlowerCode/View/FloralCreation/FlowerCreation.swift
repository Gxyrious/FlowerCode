//
//  FloralCreation.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI
import SceneKit

let material_scale_in_modification: [String:Float] = ["baihe": 10, "youjiali": 0.4]
let material_scale_in_3d: [String:Float] = ["baihe": 2, "youjiali":0.3]
let material_position_in_3d: [String:SCNVector3] = ["baihe": SCNVector3(0,0,-0.5), "youjiali": SCNVector3(0,0,0)]
let material_position_in_modification: [String:SCNVector3] = ["baihe": SCNVector3(0.2,0,0), "youjiali": SCNVector3(-1.1,0.2,0)]

//var flower_number: [String:Int] = ["baihe":0,"meigui":0,"youjiali":0]

struct FlowerCreation: View {
    @Binding var isTabViewHidden: Bool
    @State var scene: SCNScene = SCNScene()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    
    private var users: FetchedResults<User>
    
    @EnvironmentObject var document: FCDocument
    
//    @State var nodesSelected = [String:Bool]()
    // sheet栏对应State变量
    @State var showFlowerChoice: Bool = false
    @State var showVaseChoice: Bool = false
    @State var showBackgroundChoice: Bool = false
    @State var showARView: Bool = false
    @State var showIdentificationView: Bool = false
    
    // 花材编辑窗口
    @State var selectionScene: SCNScene? = nil
    @State var selectedMaterial: String? = nil {
        didSet {
            if selectedMaterial != nil {
                let sceneName: String = selectedMaterial! + ".dae"
                self.selectionScene = SCNScene(named: sceneName)
            }
        }
    }
    
    // 花材编辑数据
    @State var valueOfBones = BoneValues()
        
    var body: some View {
        GeometryReader { geometry in
            let widthOfFatherView = geometry.size.width
            let heightOfFatherView = geometry.size.height
            ZStack {
                VStack(spacing: 0) {
                    ZStack {
                        ArrangeView(scene: $scene) // 传入
                        Button {
                            self.isTabViewHidden = false
                        } label: {
                            Image("basic_design_back")
                        }
                        .offset(x: -widthOfFatherView * 0.4, y: -heightOfFatherView * 0.4)
                        Button {
                            print("开始保存")
                            for user in users {
                                print("username = \(user.username!) & password = \(user.password!)")
                                if user.username == document.username {
                                    let modelData = document.getModelData()
                                    user.model = modelData
                                    do {
                                        try viewContext.save()
                                        print("保存成功")
                                    } catch {
                                        print("保存失败，错误：\(error)")
                                    }
                                }
                            }
                        } label: {
                            Text("保存")
                                .padding(6)
                                .padding(.horizontal, 10)
                                .font(.system(size: 15))
                                .foregroundColor(Color.white)
                                .background(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
                        }
                        .offset(x: -widthOfFatherView * 0.2, y: -heightOfFatherView * 0.405)
                        .sheet(isPresented: $showARView) {
                            VStack {
                                ARView()
                                Text("HELLOWORLD")
                            }
                        }
                        
                        Button {
                            self.showIdentificationView = true
                        } label: {
                            Image("flower_identification")
                        }
                        .offset(x: widthOfFatherView * 0.38, y: -heightOfFatherView * 0.28)
                        .sheet(isPresented: $showIdentificationView) {
//                            FlowerIdentificationView(
//                                scene: $document.scene,
//                                nodesSelected: $nodesSelected,
//                                showIdentificationView: $showIdentificationView)
                        }
                        Button {
                            // 自动生成
//                            let baihe1 = scene.rootNode.childNode(withName: "baihe-1", recursively: true)
//                            let baihe2 = scene.rootNode.childNode(withName: "baihe-2", recursively: true)
//                            let baihe3 = scene.rootNode.childNode(withName: "baihe-3", recursively: true)
//                            let youjiali = scene.rootNode.childNode(withName: "youjiali-1", recursively: true)
//                            withAnimation(.easeInOut(duration: 2.0)) {
//                                baihe1?.position = SCNVector3(0.29,0.8,-0.05)
//                                baihe2?.position = SCNVector3(0.27,0.7,-0.05)
//                                baihe3?.position = SCNVector3(0.27,1.0,-0.05)
//                                baihe1?.rotation = SCNVector4(0,1,0,.pi * Double(40) / 180)
//                                baihe2?.rotation = SCNVector4(0,1,0,.pi * Double(-40) / 180)
//                                baihe3?.rotation = SCNVector4(0,1,0,.pi * Double(0) / 180)
//                                youjiali?.position = SCNVector3(0.25,1.0,-0.05)
//                                youjiali?.rotation = SCNVector4(0,1,0,.pi * Double(0) / 180)
//                            }

                        } label: {
                            Image("auto_generate")
                        }
                        .offset(x: widthOfFatherView * 0.38, y: -heightOfFatherView * 0.15)

                    }
                    HStack {
                        Button {
                            self.showFlowerChoice = true
                        } label: {
                            Image("floral_creation_flower")
                        }
                        .sheet(isPresented: $showFlowerChoice) {
                            VStack(spacing: 5) {
                                // 搜索栏
                                HStack(spacing: 10) {
                                    Button {
                                        selectedMaterial = "baihe"
                                    } label: {
                                        Image("material_1").padding(10)
                                    }
                                    Button {
                                        selectedMaterial = "youjiali"
                                    } label: {
                                        Image("material_2").padding(10)
                                    }
                                    Button {
                                        selectedMaterial = "haiyu"
                                    } label: {
                                        Image("material_3").padding(10)
                                    }
                                    Button {
                                        selectedMaterial = "HongZhang"
                                    } label: {
                                        Image("material_4").padding(10)
                                    }
                                }
                                HStack(spacing: 10) {
                                    Image("material_5").padding(10)
                                    Image("material_6").padding(10)
                                    Image("material_7").padding(10)
                                    Image("material_8").padding(10)
                                }
                                Divider()
                                    .foregroundColor(Color.black)
                                if selectedMaterial == nil {
                                    Spacer()
                                } else {
                                    // 选中后才有确定键
                                    VStack {
                                        if selectedMaterial == "baihe" {
                                            MaterialModification(
                                                myScene: $selectionScene,
//                                                valueOfBones: $valueOfBones,
                                                materialName: selectedMaterial!
                                            )
                                        }
                                        else if selectedMaterial == "youjiali" {
                                            MaterialModification(
                                                myScene: $selectionScene,
                                                materialName: selectedMaterial!
                                            )
                                        }
                                        else if selectedMaterial == "haiyu"{
                                            // 空3D视图
                                        }
                                        else {
                                            // 空3D视图
                                        }
                                        Spacer()
                                        Button {
                                            if let child = selectionScene?.rootNode {
                                                let materialName = selectedMaterial!
                                                document.addFlowerByOne(materialName)
                                                let childName = "\(materialName)-\(document.flowerName[materialName]!)"
                                                child.name = childName
                                                document.addSceneChild(childName, child.position, child.rotation)
                                                scene.rootNode.addChildNode(child)
                                                child.name = childName
                                                showFlowerChoice = false
                                                selectedMaterial = nil
                                            }
                                        } label: {
                                            Text("确认")
                                                .font(.system(size: 20))
                                                .foregroundColor(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            .background(Color(red: 0.906, green: 0.91, blue: 0.882))
                        }
                        
                        Button {
                            self.showVaseChoice = true
                        } label: {
                            Image("floral_creation_vase")
                        }
                        .sheet(isPresented: $showVaseChoice) {
                            Text("请选择花器")
                        }
                        
                        Button {
                            self.showBackgroundChoice = true
                        } label: {
                            Image("floral_creation_background")
                        }
                        .sheet(isPresented: $showBackgroundChoice) {
                            Text("请选择背景")
                        }
                    }
                    .ignoresSafeArea(.all)
                    .frame(width: widthOfFatherView)
                    .padding(.bottom, 10)
                    .background(Color(red: 0.655, green: 0.702, blue: 0.561))
                }
            }
            .onAppear {
                self.isTabViewHidden = true
            }
            .onDisappear {
                self.isTabViewHidden = false
            }
            .ignoresSafeArea(.all)
        }
    }
}

struct BoneValues {
    public var valueOfBone1: Int
    public var valueOfBone2: Int
    public var valueOfBone3: Int
    init() {
        valueOfBone1 = 0
        valueOfBone2 = 0
        valueOfBone3 = 0
    }
}

struct MaterialModification: UIViewRepresentable {
    
    
    @Binding var myScene: SCNScene?
//    @Binding var valueOfBones: BoneValues
    
//    var progressBar1 = UIStackView()
//    var progressBar2 = UIStackView()
//    var progressBar3 = UIStackView()

    var cameraFrameNode = SCNNode(geometry: SCNFloor())
    var view = SCNView()
//    var pgView1 = UIProgressView()
//    var pgView2 = UIProgressView()
//    var pgView3 = UIProgressView()
    let materialName: String
    
    func makeUIView(context: Context) -> some UIView {
        view.scene = myScene
        // 设置背景色
        view.scene?.background.contents = UIColor(red: 0.906, green: 0.91, blue: 0.882, alpha: 1)
        // 获取材料
        guard let material = myScene?.rootNode else { return view }
        material.position = material_position_in_modification[materialName] ?? SCNVector3(0,0,0)
        material.name = materialName
        myScene?.rootNode.addChildNode(material)
        
        // ==================================================
        cameraFrameNode.isHidden = true
        cameraFrameNode.camera = SCNCamera()
        view.pointOfView = cameraFrameNode
        cameraFrameNode.position = SCNVector3(x: 0, y: 1, z: 3)
        view.allowsCameraControl = true
        
        let omniLight=SCNLight()
        omniLight.type=SCNLight.LightType.omni
        omniLight.color=UIColor(white:1.0,alpha:1.0)
        let omniLightNode=SCNNode()
        omniLightNode.light=omniLight
        omniLightNode.position=SCNVector3(x:0,y:8,z:5)
        myScene?.rootNode.addChildNode(omniLightNode)
        // ==================================================
//        self.progressBar1.axis = .horizontal
//        progressBar1.distribution = .fill
//        progressBar1.spacing = 10
//        self.progressBar1.frame = CGRect(x: 40, y: 400, width: 300, height: 20)

//        let uiButtonMinus1 = UIButton(type: UIButton.ButtonType.system)
//        uiButtonMinus1.setBackgroundImage(
//            UIImage(systemName: "minus.circle")?
//                .withTintColor(
//                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
//                    renderingMode: .alwaysOriginal
//                ),
//            for: .normal
//        )
//        uiButtonMinus1.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.minusAngle1),
//            for: .touchUpInside)
//        progressBar1.addArrangedSubview(uiButtonMinus1)

//        pgView1.setProgress((Float(valueOfBones.valueOfBone1) + 180) / 360, animated: false)
//        pgView1.transform = CGAffineTransform(scaleX: 1.0,y: 0.2)
//        pgView1.progressTintColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
        
//        self.progressBar1.addArrangedSubview(pgView1)
        
//        let uiButtonPlus1 = UIButton(type: UIButton.ButtonType.system)
//        uiButtonPlus1.setBackgroundImage(
//            UIImage(systemName: "plus.circle")?
//                .withTintColor(
//                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
//                    renderingMode: .alwaysOriginal
//                ),
//            for: .normal)
//        uiButtonPlus1.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.plusAngle1),
//            for: .touchUpInside
//        )
//        progressBar1.addArrangedSubview(uiButtonPlus1)
//        view.addSubview(progressBar1)
        // ==================================================
//        self.progressBar2.axis = .horizontal
//        progressBar2.distribution = .fill
//        progressBar2.spacing = 10
//        self.progressBar2.frame = CGRect(x: 40, y: 440, width: 300, height: 20)

//        let uiButtonMinus2 = UIButton(type: UIButton.ButtonType.system)
//        uiButtonMinus2.setBackgroundImage(
//            UIImage(systemName: "minus.circle")?
//                .withTintColor(
//                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
//                    renderingMode: .alwaysOriginal
//                ),
//            for: .normal
//        )
//        uiButtonMinus2.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.minusAngle2),
//            for: .touchUpInside)
//        progressBar2.addArrangedSubview(uiButtonMinus2)

//        pgView2.setProgress((Float(valueOfBones.valueOfBone2) + 180) / 360, animated: false)
//        pgView2.transform = CGAffineTransform(scaleX: 1.0,y: 0.2)
//        pgView2.progressTintColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
        
//        self.progressBar2.addArrangedSubview(pgView2)
        
//        let uiButtonPlus2 = UIButton(type: UIButton.ButtonType.system)
//        uiButtonPlus2.setBackgroundImage(
//            UIImage(systemName: "plus.circle")?
//                .withTintColor(
//                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
//                    renderingMode: .alwaysOriginal
//                ),
//            for: .normal)
//        uiButtonPlus2.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.plusAngle2),
//            for: .touchUpInside
//        )
//        progressBar2.addArrangedSubview(uiButtonPlus2)
//        view.addSubview(progressBar2)
        // ==================================================
//        self.progressBar3.axis = .horizontal
//        progressBar3.distribution = .fill
//        progressBar3.spacing = 10
//        self.progressBar3.frame = CGRect(x: 40, y: 480, width: 300, height: 20)

//        let uiButtonMinus3 = UIButton(type: UIButton.ButtonType.system)
//        uiButtonMinus3.setBackgroundImage(
//            UIImage(systemName: "minus.circle")?
//                .withTintColor(
//                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
//                    renderingMode: .alwaysOriginal
//                ),
//            for: .normal
//        )
//        uiButtonMinus3.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.minusAngle3),
//            for: .touchUpInside)
//        progressBar3.addArrangedSubview(uiButtonMinus3)
//
//        pgView3.setProgress((Float(valueOfBones.valueOfBone3) + 180) / 360, animated: false)
//        pgView3.transform = CGAffineTransform(scaleX: 1.0,y: 0.2)
//        pgView3.progressTintColor = UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1)
//
//        self.progressBar3.addArrangedSubview(pgView3)
//
//        let uiButtonPlus3 = UIButton(type: UIButton.ButtonType.system)
//        uiButtonPlus3.setBackgroundImage(
//            UIImage(systemName: "plus.circle")?
//                .withTintColor(
//                    UIColor(red: 0.6523, green: 0.6992, blue: 0.5586, alpha: 1),
//                    renderingMode: .alwaysOriginal
//                ),
//            for: .normal)
//        uiButtonPlus3.addTarget(
//            context.coordinator,
//            action: #selector(context.coordinator.plusAngle3),
//            for: .touchUpInside
//        )
//        progressBar3.addArrangedSubview(uiButtonPlus3)
//        view.addSubview(progressBar3)
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("MaterialChooseView-updateUIView()-started")
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: MaterialModification
        init(_ parent: MaterialModification) {
            self.parent = parent
        }
        // ==================================================
//        @objc func minusAngle1() {
//            parent.valueOfBones.valueOfBone1 -= 10
//            if parent.valueOfBones.valueOfBone1 < -180 {
//                parent.valueOfBones.valueOfBone1 = -180
//            }
            // 设置进度条
//            parent.pgView1.setProgress((Float(parent.valueOfBones.valueOfBone1+180)/360), animated: true)
            // 设置花材
//            guard let bone1 = parent.view.scene?.rootNode.childNode(withName: "Bone", recursively: true) else { return }
            
//            bone1.rotation = SCNVector4(0,1,0,.pi * Double(parent.valueOfBones.valueOfBone1) / 180.0)
//            print(parent.valueOfBones.valueOfBone1)
//            print("成功旋转")
//        }
//        @objc func plusAngle1() {
//            parent.valueOfBones.valueOfBone1 += 10
//            if parent.valueOfBones.valueOfBone1 > 180 {
//                parent.valueOfBones.valueOfBone1 = 180
//            }
//            // 设置进度条
//            parent.pgView1.setProgress((Float(parent.valueOfBones.valueOfBone1+180)/360), animated: true)
//            // 设置花材
//            guard let bone1 = parent.view.scene?.rootNode.childNode(withName: "Bone", recursively: true) else { return }
//            bone1.rotation = SCNVector4(0,1,0, .pi * Double(parent.valueOfBones.valueOfBone1) / 180.0)
//        }
        // ==================================================
//        @objc func minusAngle2() {
//            parent.valueOfBones.valueOfBone2 -= 10
//            if parent.valueOfBones.valueOfBone2 < -180 {
//                parent.valueOfBones.valueOfBone2 = -180
//            }
//            // 设置进度条
//            parent.pgView2.setProgress((Float(parent.valueOfBones.valueOfBone2+180)/360), animated: true)
//            // 设置花材
//            guard let bone2 = parent.view.scene?.rootNode.childNode(withName: "Bone-001", recursively: true) else { return }
//            bone2.rotation = SCNVector4(0,1,0,.pi * Double(parent.valueOfBones.valueOfBone2) / 180.0)
//            print(parent.valueOfBones.valueOfBone2)
//            print("成功旋转")
//        }
//        @objc func plusAngle2() {
//            parent.valueOfBones.valueOfBone2 += 10
//            if parent.valueOfBones.valueOfBone2 > 180 {
//                parent.valueOfBones.valueOfBone2 = 180
//            }
//            // 设置进度条
//            parent.pgView2.setProgress((Float(parent.valueOfBones.valueOfBone2+180)/360), animated: true)
//            // 设置花材
//            guard let bone2 = parent.view.scene?.rootNode.childNode(withName: "Bone-001", recursively: true) else { return }
//            bone2.rotation = SCNVector4(0,1,0,.pi * Double(parent.valueOfBones.valueOfBone2) / 180.0)
//        }
        // ==================================================
//        @objc func minusAngle3() {
//            parent.valueOfBones.valueOfBone3 -= 10
//            if parent.valueOfBones.valueOfBone3 < -180 {
//                parent.valueOfBones.valueOfBone3 = -180
//            }
//            // 设置进度条
//            parent.pgView3.setProgress((Float(parent.valueOfBones.valueOfBone3+180)/360), animated: true)
//            // 设置花材
//            guard let bone3 = parent.view.scene?.rootNode.childNode(withName: "Bone-002", recursively: true) else { return }
//            bone3.rotation = SCNVector4(0,1,0,.pi * Double(parent.valueOfBones.valueOfBone3) / 180.0)
//            print(parent.valueOfBones.valueOfBone3)
//            print("成功旋转")
//        }
//        @objc func plusAngle3() {
//            parent.valueOfBones.valueOfBone3 += 10
//            if parent.valueOfBones.valueOfBone3 > 180 {
//                parent.valueOfBones.valueOfBone3 = 180
//            }
//            // 设置进度条
//            parent.pgView3.setProgress((Float(parent.valueOfBones.valueOfBone3+180)/360), animated: true)
//            // 设置花材
//            guard let bone3 = parent.view.scene?.rootNode.childNode(withName: "Bone-002", recursively: true) else { return }
//            bone3.rotation = SCNVector4(0,1,0,.pi * Double(parent.valueOfBones.valueOfBone3) / 180.0)
//        }
    }
}

