//
//  CommunityDiscussionTabBar.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/6/9.
//

import SwiftUI

struct CommunityDiscussionTabBar: View {
    @Binding var curTab: CommunityDiscussionTab
    @State var showAddPost: Bool = false
    @State var showSearchPost: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        let textSize: CGFloat = 18
        HStack {
            Button {
                // show add sheet
                self.showAddPost.toggle()
            } label: {
                Image(systemName: "plus.circle")
                    .font(.bold(.system(size: textSize * 1.2))())
                    .padding(.leading, 30)
                    .foregroundColor(Color(white: 0))
            }
            .sheet(isPresented: $showAddPost) {
                Text("Add")
            }
            Spacer()
            Button {
                curTab = .follow
            } label: {
                if curTab == CommunityDiscussionTab.follow {
                    Text("关注")
                        .font(.bold(.system(size: textSize))())
                        .foregroundColor(Color(white: 0))
                }
                else {
                    Text("关注")
                        .font(.system(size: textSize))
                        .foregroundColor(Color(white: 0.8))

                }
            }
            Button {
                curTab = .discover
            } label: {
                if curTab == CommunityDiscussionTab.discover {
                    Text("发现")
                        .font(.bold(.system(size: textSize))())
                        .foregroundColor(Color(white: 0))
                }
                else {
                    Text("发现")
                        .font(.system(size: textSize))
                        .foregroundColor(Color(white: 0.8))

                }
            }
            Spacer()
            Button {
                // show search sheet
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
        }
    }
}

//struct CommunityDiscussionTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        CommunityDiscussionTabBar()
//    }
//}
