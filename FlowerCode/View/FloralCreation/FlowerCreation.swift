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

let kImageUrlList: [String] = [
    "MeiGui", "BaiZhang", "YuJinXiang", "AnShu", "ManTianXing", "HeiZhongCao", "DaXingQin"
]

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
    "DaXingQin": "flowerSet.dae",
    "Vase": "vaseSet.dae"
]

let vImageUrlSet: [String] = [
    "Vase-1", "Vase-2", "Vase-3", "Vase-4", "Vase-5"
]

let bkImageUrlSet: [String] = [
    "background-1", "background-2", "background-3", "background-4", "background-5"
]

struct FlowerCreation: View {
    
    @Binding var isTabViewHidden: Bool
    
    @State var scene: SCNScene = SCNScene()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    
    private var users: FetchedResults<User>
    
    @EnvironmentObject var document: FCDocument
    
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
            print("daeFileName-\(daeFileName)")

            for child in selectionScene.rootNode.childNodes {
                child.removeFromParentNode()
            }
            print(selectionScene.rootNode.childNodes)
            let newScene = SCNScene(named: daeFileName)!
            for child in newScene.rootNode.childNodes {
                selectionScene.rootNode.addChildNode(child)
            }
            print(selectionScene.rootNode.childNodes)

            selectForm = "\(selectKind)-1"
        }
    }
    
    var selectVaseScene: SCNScene = SCNScene(named: "vaseSet.dae")!
    
    @State var selectVaseNode: SCNNode = SCNScene(named: "vaseSet.dae")!
        .rootNode.childNode(withName: "Vase-1", recursively: true)!
    
    @State var vaseKind: String = "Vase-1" {
        didSet {
            selectVaseNode = SCNScene(named: "vaseSet.dae")!
                .rootNode.childNode(withName: vaseKind, recursively: true)!
        }
    }
    
    @State var selectBackground: String = "background-1" {
        didSet {
            scene.background.contents = UIImage(named: "\(selectBackground).jpg")
        }
    }
    
    @State var selectForm: String = "AnShu-1" {
        didSet {
            selectNode = selectionScene.rootNode.childNode(withName: selectForm, recursively: true)!.clone()
            //            print("sceneName = \(selectNode.name!)")
            print("selectForm=\(selectForm)")
            //            selectNode = allFlowerSet.rootNode.childNode(withName: selectForm, recursively: true)!.clone()
        }
    }
    
    init(isTabViewHidden: Binding<Bool>) {
        self._isTabViewHidden = isTabViewHidden
    }
        
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
                            FlowerIdentificationView(
//                                scene: $scene,
                                showIdentificationView: $showIdentificationView)
                        }
                        Button {
                            // 自动生成
                            document.autoGenerate()
                            let setNotFlower: Set<String> = ["side-light", "front-light"]
                            for child in scene.rootNode.childNodes {
                                if !setNotFlower.contains(child.name!) {
                                    // 动画效果无法呈现，可能要做成帧形式才行
                                    withAnimation(.easeInOut(duration: 2)) {
                                        child.position = SCNVector3(0,0,0)
                                    }
                                }
                            }
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
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        // 添加新的花材
                                        ForEach(kImageUrlList, id: \.self) { kImageUrl in
                                            Button {
                                                selectKind = kImageUrl
                                            } label: {
                                                Image(kImageUrl)
                                                    .resizable()
                                                    .frame(width: picSide,height: picSide)
                                                    .padding(10)
                                            }
                                        }
                                    }
                                }
                                ScrollView(.horizontal) {
                                    HStack {
                                        let fImageUrlList = fImageUrlSet[selectKind]!
                                        ForEach(fImageUrlList, id: \.self) { fImageUrl in
                                            Button {
                                                selectForm = fImageUrl
                                            } label: {
                                                Image(fImageUrl)
                                                    .resizable()
                                                    .frame(width: picSide,height: picSide)
                                                    .padding(10)
                                            }
                                        }
                                    }
                                }
                                Divider()
                                    .foregroundColor(Color.black)
                                
                                VStack {
                                    MaterialModification(selectNode: $selectNode, selectForm: $selectForm)
                                    Spacer()
                                    Button {
                                        // 编号从1开始
                                        // MeiGui-1的form加到里面去之后与1不再有关系，而是会根据已有的node重新编号
                                        document.addFlowerByOne(selectKind)
                                        let childName = "\(selectKind)-\(document.flowerNumber[selectKind]!)"
                                        document.addSceneChild(childName, selectNode.position, selectNode.rotation)
//                                        scene.rootNode.addChildNode(child) // 导致一次update
                                        showFlowerChoice = false
                                        print(document.listSceneChildren)
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
                            VStack {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        // 添加新的花瓶
                                        ForEach(vImageUrlSet, id: \.self) { vImageUrl in
                                            Button {
                                                vaseKind = vImageUrl
                                            } label: {
                                                Image(vImageUrl)
                                                    .resizable()
                                                    .frame(width: picSide,height: picSide)
                                                    .padding(10)
                                            }
                                        }
                                    }
                                }
                                
                                Divider()
                                    .foregroundColor(Color.black)
                                
                                VStack {
                                    MaterialModification(selectNode: $selectVaseNode, selectForm: $vaseKind)
                                    Spacer()
                                    Button {
                                        document.removeOneVase()
                                        for index in 1 ..< 6 {
                                            let vase = scene.rootNode.childNode(withName: "Vase-\(index)", recursively: true)
                                            if (vase != nil) {
                                                vase!.removeFromParentNode()
                                            }
                                        }
                                        document.addSceneChild(vaseKind, selectVaseNode.position, selectVaseNode.rotation)
                                        showVaseChoice = false
                                        print(document.listSceneChildren)
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
                            self.showBackgroundChoice = true
                        } label: {
                            Image("floral_creation_background")
                        }
                        .sheet(isPresented: $showBackgroundChoice) {
                            VStack {
                                ScrollView(.horizontal) {
                                    HStack(spacing: 10) {
                                        // 选择背景
                                        ForEach(bkImageUrlSet, id: \.self) { bkImageUrl in
                                            Button {
                                                selectBackground = bkImageUrl
                                            } label: {
                                                Image(bkImageUrl)
                                                    .resizable()
                                                    .frame(width: picSide,height: picSide)
                                                    .padding(10)
                                            }
                                        }
                                    }
                                }
                                
                                Divider()
                                    .foregroundColor(Color.black)
                                VStack {
                                    Image(uiImage: UIImage(named: "\(selectBackground).jpg")!)
                                        .resizable()
                                        .frame(width: picSide * 5, height: picSide * 5)
                                    Spacer()
                                    Button {
                                        showBackgroundChoice = false
                                    } label: {
                                        Text("确认")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
                                    }

                                }
                                
                            }
                            .background(Color(red: 0.906, green: 0.91, blue: 0.882))
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
        
        scene.background.contents = UIColor(red: 0.906, green: 0.91, blue: 0.882, alpha: 1)
        
        scene.rootNode.addChildNode(selectNode)
        print(selectNode.name!)
        print(selectForm)
        
        view.scene = scene
        
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
//        let allFlowerSet: SCNScene = SCNScene()
//
//        let flowerSet = SCNScene(named: "flowerSet.dae")!
//        let flowerSetNode = flowerSet.rootNode.childNode(withName: "RootNode-001", recursively: true)!
////        allFlowerSet.rootNode.addChildNode(flowerSetNode)
//        let eucalyptus1 = flowerSetNode.childNode(withName: "AnShu-1", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(eucalyptus1)
//
//        let eucalyptus2 = flowerSetNode.childNode(withName: "AnShu-2", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(eucalyptus2)
//
//        let babybreath1 = flowerSetNode.childNode(withName: "ManTianXing-1", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(babybreath1)
//
//        let nigella1 = flowerSetNode.childNode(withName: "ManTianXing-2", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(nigella1)
//
//        let nigella3 = flowerSetNode.childNode(withName: "HeiZhongCao-1", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(nigella3)
//
//        let nigella4 = flowerSetNode.childNode(withName: "HeiZhongCao-2", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(nigella4)
//
//        let astrantia = flowerSetNode.childNode(withName: "DaXingQin-1", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(astrantia)
//
//        let astrantia1 = flowerSetNode.childNode(withName: "DaXingQin-2", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(astrantia1)
//
//        let astrantia2 = flowerSetNode.childNode(withName: "DaXingQin-3", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(astrantia2)
//
//
//        let flowerSet_meigui = SCNScene(named: "flowerSet_meigui.dae")!
//        let meiguiNode = flowerSet_meigui.rootNode.childNode(withName: "Empty-002_9", recursively: true)!
////        allFlowerSet.rootNode.addChildNode(meiguiNode)
//        let meigui1 = meiguiNode.childNode(withName: "MeiGui-1", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(meigui1)
//
//        let meigui2 = meiguiNode.childNode(withName: "MeiGui-2", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(meigui2)
//
//        let meigui3 = meiguiNode.childNode(withName: "MeiGui-3", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(meigui3)
//
//        let meigui4 = meiguiNode.childNode(withName: "MeiGui-4", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(meigui4)
//
//        let meigui5 = meiguiNode.childNode(withName: "MeiGui-5", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(meigui5)
//
//        let meigui6 = meiguiNode.childNode(withName: "MeiGui-6", recursively: true)!
//        allFlowerSet.rootNode.addChildNode(meigui6)
        
        print("MaterialChooseView-updateUIView()-started")
        print("selectForm = \(selectForm)")
        print("selectNode.name = \(selectNode.name!)")
        
        let sceneChildren = scene.rootNode.childNodes
        for child in sceneChildren {
            child.removeFromParentNode()
        }
//        let newRootNode = allFlowerSet.rootNode
        
//        let newNode = newRootNode.childNode(withName: selectForm, recursively: true)?.clone()
        let newFile = FlowerKind2FileName[selectForm.components(separatedBy: "-").first!]!
        let newScene = SCNScene(named: newFile)!
        let newNode = newScene.rootNode.childNode(withName: selectForm, recursively: true)!
        scene.rootNode.addChildNode(newNode)
        
//        scene.rootNode.addChildNode(selectNode)
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

