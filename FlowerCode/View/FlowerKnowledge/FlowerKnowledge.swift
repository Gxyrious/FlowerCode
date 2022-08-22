//
//  FloralKnowledge.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI
import UIKit

struct FlowerKnowledge: View {
    
    // Binding值无法被赋值
    @Binding var isTabViewHidden: Bool
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let widthOfFatherView = geometry.size.width
                let heightOfFatherView = geometry.size.height
                
                HStack {
                    ZStack(alignment: .leading) {
                        Image("floral_knowledge_background_1")
                        NavigationLink {
                            FlowerMap()
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            VStack {
                                Text("花草图鉴")
                                    .font(.system(size: 34))
                                Text("· map ·")
                                    .font(.system(size: 24))
                            }
                        }
                        .isDetailLink(false)
                        .foregroundColor(Color(red: 0.237, green: 0.237, blue: 0.237))
                        .padding([.leading], 30)
                    }
                    Spacer()
                }
                .frame(width: widthOfFatherView, height: heightOfFatherView * 0.1, alignment: .leading)
                
                HStack {
                    Spacer()
                    ZStack(alignment: .trailing) {
                        Image("floral_knowledge_background_2")
                        NavigationLink {
                            FlowerMaintenance()
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            VStack {
                                Text("花材养护")
                                    .font(.system(size: 34))
                                Text("· maintenance ·")
                                    .font(.system(size: 24))
                            }
                        }
                        .isDetailLink(false)
                        .foregroundColor(Color(red: 0.237, green: 0.237, blue: 0.237))
                        .padding([.trailing], 15)
                    }
                }
                .frame(width: widthOfFatherView, height: heightOfFatherView*0.95, alignment: .trailing)
//                .onAppear { self.tabBar.isHidden = true }
//                .onDisappear { self.tabBar.isHidden = false }

                HStack {
                    ZStack(alignment: .leading) {
                        Image("floral_knowledge_background_3")
                        NavigationLink {
                            TrimAndSculpt()
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            VStack {
                                Text("修剪和造型")
                                    .font(.system(size: 34))
                                Text("· Trim&Sculpt·")
                                    .font(.system(size: 24))
                            }
                        }
                        .foregroundColor(Color(red: 0.237, green: 0.237, blue: 0.237))
                        .padding([.leading], 5)
                    }
                    Spacer()
                }
                .frame(width: widthOfFatherView, height: heightOfFatherView * 1.5, alignment: .leading)
//                .onAppear { self.tabBar.isHidden = true }
//                .onDisappear { self.tabBar.isHidden = false }
                
                Image("floral_knowledge_background_4")
                                .frame(width: widthOfFatherView, height: heightOfFatherView * 2, alignment: .trailing)
            }
            .background(Color("background"))
        }
    }
}

//struct FloralKnowledge_Previews: PreviewProvider {
//    static var previews: some View {
//        FlowerKnowledge(isTabViewHidden:false)
//    }
//}
