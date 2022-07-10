//
//  ContentView.swift
//  IOSFlowerClassifier
//
//  Created by 汪明杰 on 2022/7/2.
//

import SwiftUI
import SceneKit

//全局赋值
var global_UIimage: UIImage? = nil
//默认状态下，true为拍照状态；点击回到拍摄页面按钮又变为false状态；
//注意：点击导入模型按钮，则完全退出拍照等页面，直接回到模型页面

struct FlowerIdentificationView: View {
    @ObservedObject var events = UserEvents()
    @State var isShoot: Bool = false
    @State var openCameraRoll = false
    @Binding var scene: SCNScene
    @Binding var nodesSelected: [String:Bool]
    @Binding var showIdentificationView: Bool
    
    var body: some View {
        ZStack { //第一次进入程序就点击相册导出图片就会无法正常显示
            if (global_UIimage != nil && isShoot) {//当前既有图片，且点击拍照后
                VStack {
                    MyImageView(isShoot: $isShoot)
                    //显示机器学习模型验证结果
                    MLResultView(
                        scene: $scene,
                        nodesSelected: $nodesSelected,
                        showIdentificationView: $showIdentificationView
                    )
                }
            }
            else{
                CameraView(events: events, applicationName: "Camera")
//                    .edgesIgnoringSafeArea(.all)
            }
            
            CameraInterfaceView(
                events: events,
                isShoot: $isShoot,
                openCameraRoll: $openCameraRoll,
                showIdentificationView: $showIdentificationView
            )
//            .edgesIgnoringSafeArea(.all)
        }
    }
    
    var reshoot: some View {
        Button {
            isShoot = false
        } label: {
            Text("重拍")
                .padding()
                .foregroundColor(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
        }
    }
}

