//
//  MainViewTabBar.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct MainViewTabBar: View {
    @Binding var curTab: MainViewTab
    
    var body: some View {
        GeometryReader { geometry in
            let widthOfFatherView = geometry.size.width
            ZStack {
                HStack(alignment: .center, spacing: 0) {
                    // 花艺知识
                    Button {
                        curTab = .floralKnowledge
                    } label: {
                        VStack {
                            if curTab == MainViewTab.floralKnowledge {
                                Image("floral_knowledge_selected")
                            }
                            else {
                                Image("floral_knowledge_unselected")
                            }
                            Text("花艺知识")
                                .foregroundColor(Color(red: 0.404, green: 0.533, blue: 0.477))
                                .font(.system(size: 12))
                        }
                    }
                    .padding(12)
                    
                    // 花艺作品
                    Button {
                        curTab = .floralWorks
                    } label: {
                        VStack {
                            if curTab == MainViewTab.floralWorks {
                                Image("floral_works_selected")
                            }
                            else {
                                Image("floral_works_unselected")
                            }
                            Text("花艺作品")
                                .foregroundColor(Color(red: 0.404, green: 0.533, blue: 0.477))
                                .font(.system(size: 12))
                        }
                    }
                    .padding(12)

                    // 插花制作
                    Button {
                        curTab = .floralCreation
                    } label: {
                        VStack {
                            Image("floral_creation")
                            Text("插花制作")
                                .foregroundColor(Color(red: 0.404, green: 0.533, blue: 0.477))
                                .font(.system(size: 12))
                        }
                        .background(alignment: .center) {
                            Circle()
                                .fill(Color("grass"))
                        }
                    }
                    .offset(x: 0, y: -19)
                    
                    // 社区交流
                    Button {
                        curTab = .communityDiscussion
                    } label: {
                        VStack {
                            if curTab == MainViewTab.communityDiscussion {
                                Image("community_discussion_selected")
                            }
                            else {
                                Image("community_discussion_unselected")
                            }
                            Text("桌面组件")
                                .foregroundColor(Color(red: 0.404, green: 0.533, blue: 0.477))
                                .font(.system(size: 12))
                        }
                    }
                    .padding(12)
                    
                    // 个人中心
                    Button {
                        curTab = .personalCenter
                    } label: {
                        VStack {
                            if curTab == MainViewTab.personalCenter {
                                Image("person_center_selected")
                            }
                            else {
                                Image("person_center_unselected")
                            }
                            Text("个人中心")
                                .foregroundColor(Color(red: 0.404, green: 0.533, blue: 0.477))
                                .font(.system(size: 12))
                        }
                    }
                    .padding(12)
                }
                .frame(maxWidth: widthOfFatherView)

            }

        }
        .frame(height: 60, alignment: .top)
        .padding(.bottom, 30)
        .padding([.horizontal], 5)
        .background(Color("grass"))
    }
}
//
//struct MainViewTabBar_Previews: PreviewProvider {
//    @Binding
//    static var previews: some View {
//        MainViewTabBar()
//    }
//}
