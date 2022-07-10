//
//  File.swift
//  IOSFlowerClassifier
//
//  Created by 汪明杰 on 2022/7/2.
//

import SwiftUI
//修改版本
struct CameraInterfaceView: View, CameraActions {
    @ObservedObject var events: UserEvents
    
    @State var imageSelected = UIImage()
    @Binding var isShoot: Bool
    @Binding var openCameraRoll:Bool
    @Binding var showIdentificationView: Bool
    var body: some View {
        GeometryReader { geometry in
            let widthOfFatherView = geometry.size.width
            let heightOfFatherView = geometry.size.height
            ZStack {
                exitButton
                    .padding([.top, .leading], 15)
                if !isShoot {
                    photoLibraryButton
                        .offset(x: 10, y: 0.92 * heightOfFatherView)
                    captureButton
                        .offset(x: widthOfFatherView / 2 - 30, y: 0.92 * heightOfFatherView)
                }
            }
        }
    }
    private func rotate(){
        print("点击到rotate")
        self.rotateCamera(events: events)
    }
    private func flash(){
        print("点击到flash")
        self.changeFlashMode(events: events)
    }
    private func capture(){
        print("点击到capture")
        isShoot = true
        self.takePhoto(events: events)
        
    }
    var rotateButton: some View{
        Button("rotate", action: rotate)
    }
//    var flashButton: some View{
//        Button("flash", action: flash)
//    }
    var captureButton: some View {
        Button(action: capture) {
            Image("capture")
        }
    }
    var exitButton: some View {
        Button {
            showIdentificationView = false
            isShoot = false
        } label: {
            Image("identification_close_button")
        }

    }
    var photoLibraryButton: some View{
        ZStack(alignment: .bottomTrailing) {
            Button(action: {
                openCameraRoll = true
            }, label: {
                Image("photo_library")
        })
        }.sheet(isPresented: $openCameraRoll) {
            ImagePicker(isShoot: $isShoot, selectedImage: $imageSelected, sourceType:.photoLibrary)
//            ImagePicker(selectedImage: $imageSelected, sourceType:.photoLibrary)
        }

        
    }
}
