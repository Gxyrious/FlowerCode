//
//  TrimAndSculpt.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/18.


import SwiftUI

struct TrimAndSculpt: View {
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var curTab: TrimAndSculptTab = .basicPrinciple
    let values=categories.sorted(by: {$0.0 < $1.0}) //字典按key的顺序排序 顺序为：制作技巧 基本原理 基本形式 插花类别


    
    var body: some View {
        HStack() {
            TrimAndSculptTabBar(curTab: $curTab)
            TabView(selection: $curTab) {
                InfoList(items:values.map {$0.value}[1])
                    .tag(TrimAndSculptTab.basicPrinciple)
                    .padding(0)
                InfoList(items:values.map {$0.value}[2])
                    .tag(TrimAndSculptTab.basicForm)
                    .padding(0)
                InfoList(items:values.map {$0.value}[3])
                    .tag(TrimAndSculptTab.arrangeCategory)
                    .padding(0)
                InfoList(items:values.map {$0.value}[0])
                    .tag(TrimAndSculptTab.makeTechnique)
                    .padding(0)
                }
            .padding(.leading,-15)
            }
        }
}

struct TrimAndSculpt_Previews: PreviewProvider {
    static var previews: some View {
        TrimAndSculpt()
    }
}

enum TrimAndSculptTab: String, CaseIterable {
    case basicPrinciple = "基本原理"
    case basicForm = "基本形式"
    case arrangeCategory = "插花类别"
    case makeTechnique = "制作技巧"
}
