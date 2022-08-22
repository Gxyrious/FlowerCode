//
//  FlowerMapTabBar.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct FlowerMapTabBar: View {
    @Binding var curTab: FlowerMapTab
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        let textWidth: CGFloat = 20
        let textHeight: CGFloat = 100
        let textSize: CGFloat = 18
        VStack(spacing: 0) {
//            Button {
//                self.presentationMode.wrappedValue.dismiss()
//            } label: {
//                Image("flower_map_back")
//            }
            Button {
                curTab = .massMaterial
            } label: {
                Text("团状花材")
                    .font(.system(size: textSize))
                    .frame(width: textWidth)
                    .padding([.leading, .trailing],25)
            }
            Spacer()
            Button {
                curTab = .linearMaterial
            } label: {
                Text("线状花材")
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight)
                    .padding([.leading, .trailing],25)
            }
            Spacer()
            Button {
                curTab = .scatteredMaterial
            } label: {
                Text("散状花材")
                    .font(.system(size: textSize))
                    .frame(width: textWidth)
                    .padding([.leading, .trailing],25)
            }
            Spacer()
            Button {
                curTab = .specialShapeMaterial
            } label: {
                Text("特殊形状花材")
                    .font(.system(size: textSize))
                    .frame(width: textWidth)
                    .padding([.leading, .trailing],25)
            }
        }
        .foregroundColor(Color("secondaryText"))
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.808, green: 0.706, blue: 0.682))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("flower_map_back")
                }
            }
        }

    }
}

//struct FlowerMapTabBar_Previews: PreviewProvider {
//    @State var curTab: FlowerMapTab = .massMaterial
//    static var previews: some View {
//        FlowerMapTabBar(curTab: $curTab)
//    }
//}
