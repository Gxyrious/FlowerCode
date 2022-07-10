//
//  MyImageView.swift
//  IOSFlowerClassifier
//
//  Created by onevfall on 2022/7/3.
//
import SwiftUI
struct MyImageView: View{
    @Binding var isShoot: Bool
    var body : some View {
        GeometryReader { geometry in
            let widthOfFatherView = geometry.size.width
            let heightOfFatherView = geometry.size.height
            ZStack { //为了保证返回的是某个明确的View类型
                if (isShoot){
                    Image(uiImage: global_UIimage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit) //或是.fill
                }
                else{
                    Text("此页面不应该出现")
                }
                reshoot
                    .offset(x: 0.4 * widthOfFatherView, y: -0.45 * heightOfFatherView)
                    .foregroundColor(.black)
                    .font(.headline)
            }
        }
    }
    var reshoot: some View {
        Button {
            isShoot = false
        } label: {
            Text("重拍")
                .foregroundColor(Color(red: 0.6523, green: 0.6992, blue: 0.5586))
                .padding()
        }
    }
}
