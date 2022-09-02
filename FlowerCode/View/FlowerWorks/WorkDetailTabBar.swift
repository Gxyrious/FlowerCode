//
//  BasicDesignTabBar.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/6/10.
//

import SwiftUI

struct WorkDetailTabBar: View {
    @Binding var curTab: BasicDesignTab
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        let textWidth: CGFloat = 20
        let textHeight: CGFloat = 100
        let textSize: CGFloat = 18
        VStack(spacing: 0) {
            Button {
                curTab = .basicIntroduction
            } label: {
                Text(BasicDesignTab.basicIntroduction.rawValue)
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight * 1.4, alignment: .bottom)
                    .padding(.bottom, 30)
                    .padding([.leading, .trailing],20)
            }
            
            Spacer()
            
            Button {
                curTab = .keyPoints
            } label: {
                Text(BasicDesignTab.keyPoints.rawValue)
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing],20)
            }
            
            Spacer()
            
            Button {
                curTab = .designProcess
            } label: {
                Text(BasicDesignTab.designProcess.rawValue)
                    .font(.system(size: textSize))
                    .frame(width: textWidth, height: textHeight)
                    .padding([.top, .bottom], 20)
                    .padding([.leading, .trailing],20)
            }
            
        }
        .foregroundColor(Color(white: 1))
        .background(Color(red: 0.404, green: 0.533, blue: 0.477))
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("basic_design_back")
                }
            }
        }
    }
}

//struct WorkDetailTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkDetailTabBar()
//    }
//}

enum BasicDesignTab: String, CaseIterable {
    case basicIntroduction = "基本介绍"
    case keyPoints = "插制要点"
    case designProcess = "插制过程"
}
