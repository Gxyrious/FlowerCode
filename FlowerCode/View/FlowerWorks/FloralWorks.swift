//
//  FloralWorks.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/11.
//

import SwiftUI
import UIKit

struct FloralWorks: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var curTab: FlowerWorksTap = .basicDesign
    @State var isTabBarHidden: Bool = false
    var body: some View {
        VStack {
            if !isTabBarHidden {
                FlowerWorksTabBar(curTab: $curTab)
            }
            TabView(selection: $curTab) {
                BasicDesign(isTabViewHidden: $isTabBarHidden)
                    .tag(FlowerWorksTap.basicDesign)
                AdvancedDesign()
                    .tag(FlowerWorksTap.advancedDesign)
                TopDesignList()
                    .tag(FlowerWorksTap.topDesignList)
            }
        }
        .background(Color(red: 0.906, green: 0.910, blue: 0.882))

    }
}

struct FloralWorks_Previews: PreviewProvider {
    static var previews: some View {
        FloralWorks()
    }
}

enum FlowerWorksTap: String, CaseIterable {
    case basicDesign = "基础花作"
    case advancedDesign = "进阶花作"
    case topDesignList = "作品榜"
}
