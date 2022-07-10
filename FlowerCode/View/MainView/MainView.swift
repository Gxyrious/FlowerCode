//
//  MainView.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/11.
//

import SwiftUI

struct MainView: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var curTab: MainViewTab = .floralKnowledge
    @State var isTabViewHidden: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TabView(selection: $curTab) {
                    FlowerKnowledge(isTabViewHidden: $isTabViewHidden)
                        .tag(MainViewTab.floralKnowledge)
                    FloralWorks()
                        .tag(MainViewTab.floralWorks)
                    FlowerCreation(isTabViewHidden: $isTabViewHidden)
                        .tag(MainViewTab.floralCreation)
                    CommunityDiscussion()
                        .tag(MainViewTab.communityDiscussion)
                    PersonalCenter()
                        .tag(MainViewTab.personalCenter)
                }
            }
            VStack {
                Spacer()
                if !isTabViewHidden {
                    MainViewTabBar(curTab: $curTab)
                }
            }
        }
        
        .ignoresSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum MainViewTab: String, CaseIterable {
    case floralKnowledge = "花艺知识"
    case floralWorks = "花艺作品"
    case floralCreation = "插花制作"
    case communityDiscussion = "社区交流"
    case personalCenter = "个人中心"
}
