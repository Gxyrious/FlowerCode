//
//  CommunityDiscovery.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/6/9.
//

import SwiftUI

struct CommunityDiscovery: View {
    var body: some View {
         ScrollView {
             HStack(spacing: 0) {
                 VStack {
                     Image("community_post_1")
                     Image("community_post_3")
                     Image("community_post_5")
                     Spacer()
                 }
                 VStack {
                     Image("community_post_2")
                     Image("community_post_4")
                     Spacer()
                 }
             }
         }
         .background(Color(red: 0.906, green: 0.910, blue: 0.882))

    }
}

struct CommunityDiscovery_Previews: PreviewProvider {
    static var previews: some View {
        CommunityDiscovery()
    }
}
