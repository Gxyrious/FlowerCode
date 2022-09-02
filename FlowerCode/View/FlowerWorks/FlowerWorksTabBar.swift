//
//  FlowerWorksTabBar.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/6/8.
//

import SwiftUI

struct FlowerWorksTabBar: View {
    @Binding var curTab: FlowerWorksTap
    @State var showSearchPost: Bool = false
    var body: some View {
        let textSize: CGFloat = 18
        HStack {
            Button {
                curTab = .basicDesign
            } label: {
                if curTab == FlowerWorksTap.basicDesign {
                    Text(FlowerWorksTap.basicDesign.rawValue)
                        .font(.bold(.system(size: textSize))())
                        .foregroundColor(Color(white: 0))
                }
                else {
                    Text(FlowerWorksTap.basicDesign.rawValue)
                        .font(.system(size: textSize))
                        .foregroundColor(Color(white: 0.7))
                }
            }
            .padding(.leading, 40)

            Button {
                curTab = .advancedDesign
            } label: {
                if curTab == FlowerWorksTap.advancedDesign {
                    Text(FlowerWorksTap.advancedDesign.rawValue)
                        .font(.bold(.system(size: textSize))())
                        .foregroundColor(Color(white: 0))
                }
                else {
                    Text(FlowerWorksTap.advancedDesign.rawValue)
                        .font(.system(size: textSize))
                        .foregroundColor(Color(white: 0.7))
                }
            }

//            Button {
//                curTab = .topDesignList
//            } label: {
//                if curTab == FlowerWorksTap.topDesignList {
//                    Text(FlowerWorksTap.topDesignList.rawValue)
//                        .font(.bold(.system(size: textSize))())
//                        .foregroundColor(Color(white: 0))
//                }
//                else {
//                    Text(FlowerWorksTap.topDesignList.rawValue)
//                        .font(.system(size: textSize))
//                        .foregroundColor(Color(white: 0.7))
//                }
//            }

            Button {
                self.showSearchPost.toggle()
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.bold(.system(size: textSize * 1.2))())
                    .padding(.trailing, 30)
                    .foregroundColor(Color(white: 0))
            }
            .sheet(isPresented: $showSearchPost) {
                Text("Search")
            }
            .offset(x: 50)
        }
    }
}

//struct FlowerWorksTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        FlowerWorksTabBar()
//    }
//}
