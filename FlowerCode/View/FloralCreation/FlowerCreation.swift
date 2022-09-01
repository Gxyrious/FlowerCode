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

let picSide: CGFloat = 40

let fImageUrlSet: [String:[String]] = [
    "MeiGui": ["MeiGui-1", "MeiGui-2", "MeiGui-3", "MeiGui-4", "MeiGui-5", "MeiGui-6"],
    "BaiZhang": ["BaiZhang-1", "BaiZhang-2", "BaiZhang-3", "BaiZhang-4", "BaiZhang-5"],
    "YuJinXiang": ["YuJinXiang-1", "YuJinXiang-2", "YuJinXiang-3", "YuJinXiang-4", "YuJinXiang-5"],
    "AnShu": ["AnShu-1","AnShu-2"],
    "ManTianXing": ["ManTianXing-1", "ManTianXing-2"],
    "HeiZhongCao": ["HeiZhongCao-1", "HeiZhongCao-2", "HeiZhongCao-3"],
    "DaXingQin": ["DaXingQin-1", "DaXingQin-2", "DaXingQin-3"]
]

let FlowerKind2FileName: [String:String] = [
    "MeiGui": "flowerSet_meigui.dae",
    "BaiZhang": "flowerSet_baizhang.dae",
    "YuJinXiang": "flowerSet_yujinxiang.dae",
    "AnShu": "flowerSet.dae",
    "ManTianXing": "flowerSet.dae",
    "HeiZhongCao": "flowerSet.dae",
    "DaXingQin": "flowerSet.dae"
]

let vImageUrlSet: [String] = [
    "Vase-1", "Vase-2", "Vase-3", "Vase-4", "Vase-5"
]

struct FlowerCreation: View {
    
//    init(isTabViewHidden: Bool ) {
//        isTabViewHidden = isTabViewHidden
//        selectionScene = SCNScene(named: "flowerSet_rose.dae")!
//        selectNode = selectionScene.rootNode.childNode(withName: "MeiGui-1", recursively: true)!
//    }
    
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
    @State var selectionScene: SCNScene = SCNScene(named: "flowerSet.dae")!
    
    @State var selectNode: SCNNode = SCNScene(named: "flowerSet.dae")!
        .rootNode.childNode(withName: "AnShu-1", recursively: true)!
    
    @State var selectKind: String = "AnShu" {
        didSet {
            // 先选定哪个文件
            let daeFileName = FlowerKind2FileName[selectKind]!
            print("111111111111111111111111111daeFileName-\(daeFileName)")
            
            for child in selectionScene.rootNode.childNodes {
                child.removeFromParentNode()
            }
            print(selectionScene.rootNode.childNodes)
            let newScene = SCNScene(named: daeFileName)!
            for child in newScene.rootNode.childNodes {
                selectionScene.rootNode.addChildNode(child)
            }
            print(selectionScene.rootNode.childNodes)
//            selectionScene = SCNScene(named: daeFileName)!
            selectForm = "\(selectKind)-1"
        }
    }
    
    @State var selectForm: String = "AnShu-1" {
//        willSet {
//            // set之前
//            print("2222222222")
//        }
        didSet {
            // set之后
            print("3333333333")
            selectNode = selectionScene.rootNode.childNode(withName: selectForm, recursively: true)!.clone()
            print("sceneName = \(selectNode.name!)")
        }
        
    }
    
    // 花材编辑数据
//    @State var valueOfBones = BoneValues()
        
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
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        Button {
                                            selectKind = "MeiGui"
                                        } label: {
                                            Image("material_1").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "BaiZhang"
                                        } label: {
                                            Image("material_2").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "YuJinXiang"
                                        } label: {
                                            Image("material_3").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "AnShu"
                                        } label: {
                                            Image("material_3").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "ManTianXing"
                                        } label: {
                                            Image("material_4").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "HeiZhongCao"
                                        } label: {
                                            Image("material_5").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "DaXingQin"
                                        } label: {
                                            Image("material_6").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "111"
                                        } label: {
                                            Image("material_7").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        Button {
                                            selectKind = "111"
                                        } label: {
                                            Image("material_8").resizable().frame(width: picSide,height: picSide).padding(10)
                                        }
                                        // 添加新的花材
                                    }
                                }
                                ScrollView(.horizontal) {
                                    HStack {
                                        let fImageUrlList = fImageUrlSet[selectKind]!
                                        ForEach(fImageUrlList, id: \.self) { fImageUrl in
                                            Button {
                                                selectForm = fImageUrl
                                            } label: {
                                                Image(fImageUrl).resizable().frame(width: picSide,height: picSide).padding(10)
                                            }
                                        }
                                    }
                                }
                                Divider()
                                    .foregroundColor(Color.black)
                                
                                VStack {
                                    MaterialModification(selectNode: $selectNode, selectForm: $selectForm)
//                                    if selectKind == "BaiHe" {
//                                        MaterialModification(
//                                            myScene: $selectionScene,
//                                            selectForm: selectKind
//                                        )
//                                    }
//                                    else if selectKind == "MeiGui" {
//                                        MaterialModification(
//                                            myScene: $selectionScene,
//                                            selectForm: selectKind
//                                        )
//                                    }
//                                    else if selectKind == "YouJiaLi"{
//                                        // 空3D视图
//                                    }
//                                    else {
//                                        // 空3D视图
//                                    }
                                    Spacer()
                                    Button {
                                        let kind = selectKind
                                        // 编号从1开始
                                        // MeiGui-1的form加到里面去之后与1不再有关系，而是会根据已有的node重新编号
                                        document.addFlowerByOne(kind)
                                        let childName = "\(kind)-\(document.flowerNumber[kind]!)"
//                                                child.name = childName
                                        document.addSceneChild(childName, selectNode.position, selectNode.rotation)
//                                                scene.rootNode.addChildNode(child) // 导致一次update
                                        showFlowerChoice = false
                                        // document也会导致一次update（好像是2次）
                                    } label: {
                                        Text("确认")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
                                    }
                                    Spacer()
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

//struct BoneValues {
//    public var valueOfBone1: Int
//    public var valueOfBone2: Int
//    public var valueOfBone3: Int
//    init() {
//        valueOfBone1 = 0
//        valueOfBone2 = 0
//        valueOfBone3 = 0
//    }
//}

struct MaterialModification: UIViewRepresentable {
    
    @Binding var selectNode: SCNNode
    var scene = SCNScene()
    
    @Binding var selectForm: String
    
    var cameraFrameNode = SCNNode(geometry: SCNFloor())
    
    var view = SCNView()
    
    func makeUIView(context: Context) -> some UIView {
        
        cameraFrameNode.isHidden = true
        cameraFrameNode.camera = SCNCamera()
        view.pointOfView = cameraFrameNode
        view.allowsCameraControl = true
        
//        let omniLight = SCNLight()
//        omniLight.type = SCNLight.LightType.omni
//        omniLight.color = UIColor(white:1.0,alpha:1.0)
//        let omniLightNode = SCNNode()
//        omniLightNode.light = omniLight
//        omniLightNode.position = SCNVector3(x:0,y:8,z:5)
//        scene.rootNode.addChildNode(omniLightNode)
        
        scene.background.contents = UIColor(red: 0.906, green: 0.91, blue: 0.882, alpha: 1)
        
        scene.rootNode.addChildNode(selectNode)
        print(selectNode.name!)
        print(selectForm)
        
        view.scene = scene
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("MaterialChooseView-updateUIView()-started")
        print("selectForm = \(selectForm)")
        print("selectNode.name = \(selectNode.name!)")
        
        let sceneChildren = scene.rootNode.childNodes
        for child in sceneChildren {
            child.removeFromParentNode()
        }
        
        let newNode = SCNScene(named: FlowerKind2FileName[selectForm.components(separatedBy: "-").first!]!)!.rootNode.childNode(withName: selectForm, recursively: true)!
        
        
        scene.rootNode.addChildNode(newNode)
//        let deleteChild = scene.rootNode.childNode(withName: <#T##String#>, recursively: <#T##Bool#>)
    }
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject {
//        var parent: MaterialModification
//        init(_ parent: MaterialModification) {
//            self.parent = parent
//        }
//    }
}

