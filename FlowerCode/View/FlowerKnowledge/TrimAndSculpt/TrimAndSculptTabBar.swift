//
//  TrimAndSculptTabBar.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/18.
//

import SwiftUI

struct TrimAndSculptTabBar: View {
    @Binding var curTab: TrimAndSculptTab
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        let textWidth: CGFloat = 20
        let textHeight: CGFloat = 100
        let textSize: CGFloat = 18
        VStack(alignment: .center, spacing: 10) {
            Button {
                curTab = .basicPrinciple
            } label: {
                Text("基本原理")
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight, alignment: .bottom)
                    .padding([.leading, .trailing],25)
            }
            Spacer()
            Button {
                curTab = .basicForm
            } label: {
                Text("基本形式")
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight)
                    .padding([.leading, .trailing],25)
            }
            Spacer()
            Button {
                curTab = .arrangeCategory
            } label: {
                Text("插花类别")
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight)
                    .padding([.leading, .trailing])
            }
            Spacer()
            Button {
                curTab = .makeTechnique
            } label: {
                Text("制作技巧")
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight)
                    .padding([.leading, .trailing])
            }
        }
        .foregroundColor(.white)
        .background(Color("cyan"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back_item_white")
                }
            }
        }

    }
}
//
//struct TrimAndSculptTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TrimAndSculptTabBar()
//    }
//}
