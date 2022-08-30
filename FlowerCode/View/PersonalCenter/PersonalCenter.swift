//
//  PersonalCenter.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct PersonalCenter: View {
    
    @EnvironmentObject var modelData: ModelData

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let widthOfFatherView = geometry.size.width // 390px
//                let heightOfFatherView = geometry.size.height // 844px
                VStack(spacing: 0) {
                    ZStack {
                        Image("person_center_background")
                        VStack {
                            Image("user_head_portrait")
                                .padding(.top, 30)
                            Text(modelData.username)
                                .foregroundColor(Color(white: 1))
                                .padding(.vertical, 2)
                            Text(modelData.signature)
                                .foregroundColor(Color(white: 0.7))
                        }
                    }
                    
                    Image("current_level")
                    
                    HStack {
                        NavigationLink {
                            Text("我的主页View")
                        } label: {
                            VStack {
                                Image("person_page")
                                Text("我的主页")
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                        }

                        NavigationLink {
                            Text("我的收藏View")
                        } label: {
                            VStack {
                                Image("person_stars")
                                Text("我的收藏")
                            }
                            .padding(.horizontal, 40)
                            .padding(.vertical, 5)
                        }
                    }
                    .padding(8)
                    .foregroundColor(Color(white: 0))
                    .background(Color(white: 1))
                    .cornerRadius(15)
                    .frame(width: widthOfFatherView * 0.9)
                    
                    NavigationLink {
                        Text("历史花作主界面")
                    } label: {
                        VStack(spacing: 0) {
                            HStack() {
                                Image("history_works")
                                    .padding(.leading, 20)
                                Text("历史花作")
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(.vertical, 15)
                            .frame(width: widthOfFatherView * 0.9)
                            .background(Color(red: 0.404, green: 0.533, blue: 0.477))

                            HStack {
                                Image("history_work_1")
                                    .background(Color(white: 0.9))
                                    .cornerRadius(20)
                                    .padding(.leading)
                                Image("history_work_2")
                                    .background(Color(white: 0.9))
                                    .cornerRadius(20)
                                    .padding(.leading)
                                    .padding(.trailing, 150)
                            }
                            .padding(30)
                            .frame(width: widthOfFatherView * 0.9)
                            .background(Color(white: 1))
                        }
                        .cornerRadius(15)
                        .frame(width: widthOfFatherView * 0.9)
                        .padding(.top, 10)
                    }
                    
                    NavigationLink {
                        Text("帮助界面")
                    } label: {
                        HStack {
                            Image("help")
                            Text("帮助")
                            Spacer()
                            Image("goto")
                        }
                        .padding()
                        .frame(width: widthOfFatherView * 0.9)
                        .foregroundColor(Color(white: 0))
                        .background(Color(white: 1))
                        .cornerRadius(15)
                        .padding(.top, 10)
                    }

                    NavigationLink {
                        Text("设置界面")
                    } label: {
                        HStack {
                            Image("settings")
                            Text("设置")
                            Spacer()
                            Image("goto")
                        }
                        .padding()
                        .frame(width: widthOfFatherView * 0.9)
                        .foregroundColor(Color(white: 0))
                        .background(Color(white: 1))
                        .cornerRadius(15)
                        .padding(.top, 10)
                    }

                    Spacer()
                }
                .background(Color(red: 0.906, green: 0.910, blue: 0.882))
            }
            .navigationBarHidden(true)
            .ignoresSafeArea()
        }
    }
}

struct PersonalCenter_Previews: PreviewProvider {
    static var previews: some View {
        PersonalCenter()
            .previewInterfaceOrientation(.portrait)
    }
}
