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
    @EnvironmentObject var document: FCDocument

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TabView(selection: $curTab) {
                    FlowerKnowledge(isTabViewHidden: $isTabViewHidden)
                        .tag(MainViewTab.floralKnowledge)
                    FloralWorks(isTabViewHidden: $isTabViewHidden)
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
                if !isTabViewHidden && document.isShowTabBar {
                    MainViewTabBar(curTab: $curTab)
                }
            }
        }
        .ignoresSafeArea(.all)
        .overlay {
            if (!document.isLoggedIn) {
                withAnimation() {
                    LoginView()
                }
            }
        }
        .alert(Text("登陆成功"), isPresented: $document.alert.alertSuccessLogIn) {
            Button("确定") { }
        } message: {
            Text("欢迎你，\(document.username)")
        }
        .alert(Text("注册成功"), isPresented: $document.alert.alertSuccessRegister) {
            Button("确定") { }
        } message: {
            Text("请重新输入账号密码并登录")
        }
        .alert(Text("登陆失败"), isPresented: $document.alert.alertFailLogIn) {
            Button("确定") { }
        } message: {
            Text("账号不存在或密码错误")
        }
        .alert(Text("注册失败"), isPresented: $document.alert.alertFailRegister) {
            Button("确定") { }
        } message: {
            Text("该用户名已存在")
        }
        .alert(Text("注册失败"), isPresented: $document.alert.alertUnknown) {
            Button("确定") { }
        } message: {
            Text("未知错误")
        }
        .alert(Text("输入非法"), isPresented: $document.alert.alertIllegal) {
            Button("确定") { }
        } message: {
            Text("请输入合法的账号密码")
        }

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
