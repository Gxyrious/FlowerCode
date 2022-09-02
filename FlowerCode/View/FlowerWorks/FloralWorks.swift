//
//  FloralWorks.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/11.
//

import SwiftUI
import UIKit

struct FloralWorks: View {
    
//    init() {
//        UITabBar.appearance().isHidden = true
//    }
    @State var curTab: FlowerWorksTap = .basicDesign
    @State var isTabBarHidden: Bool = false
    @Binding var isTabViewHidden: Bool

    var body: some View {
        NavigationView {
        VStack {
//            if !isTabBarHidden {
            FlowerWorksTabBar(curTab: $curTab)
//            }
            TabView(selection: $curTab) {
                WorkList(isTabBarHidden:$isTabBarHidden, isTabViewHidden: $isTabViewHidden,items:basicworks)
                    .ignoresSafeArea(.all)
                    .tag(FlowerWorksTap.basicDesign)
                WorkList(isTabBarHidden:$isTabBarHidden, isTabViewHidden: $isTabViewHidden,items:advancedworks)
                    .ignoresSafeArea(.all)
                    .tag(FlowerWorksTap.advancedDesign)
//                WorkList(isTabBarHidden:$isTabBarHidden, isTabViewHidden: $isTabViewHidden,items:basicworks)
//                    .tag(FlowerWorksTap.topDesignList)
//                    .ignoresSafeArea(.all)
            }
            .ignoresSafeArea(.all)

        }
    }
    }
}

//struct FloralWorks_Previews: PreviewProvider {
//    static var previews: some View {
//        FloralWorks()
//    }
//}

enum FlowerWorksTap: String, CaseIterable {
    case basicDesign = "基础花作"
    case advancedDesign = "进阶花作"
    case topDesignList = "作品榜"
}
