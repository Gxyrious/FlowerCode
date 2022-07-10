//
//  CommunityDiscussion.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct CommunityDiscussion: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    @State var curTab: CommunityDiscussionTab = .discover
    var body: some View {
        VStack {
            CommunityDiscussionTabBar(curTab: $curTab)
            TabView(selection: $curTab) {
                Text("follow")
                    .tag(CommunityDiscussionTab.follow)
                CommunityDiscovery()
                    .tag(CommunityDiscussionTab.discover)
            }
        }
        .background(Color(red: 0.906, green: 0.910, blue: 0.882))
    }
}

struct CommunityDiscussion_Previews: PreviewProvider {
    static var previews: some View {
        CommunityDiscussion()
    }
}

enum CommunityDiscussionTab: String, CaseIterable {
    case follow = "关注"
    case discover = "发现"
}
