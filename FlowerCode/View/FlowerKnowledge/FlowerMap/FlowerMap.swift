//
//  FlowerMap.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/11.
//

import SwiftUI

struct FlowerMap: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    let values=flowerCategories.sorted(by: {$0.0 < $1.0}) //字典按key的顺序排序 顺序为：团状花材  散状花材 特殊形状花材 线状花材
    
    @State var curTab: FlowerMapTab = .massMaterial
    var body: some View {
        HStack(spacing: 0) {
            FlowerMapTabBar(curTab: $curTab)
            TabView(selection: $curTab) {
                FlowerList(pattern:patterns[0], items: values.map {$0.value}[0])
                    .tag(FlowerMapTab.massMaterial)
                FlowerList(pattern:patterns[1], items: values.map {$0.value}[3])
                    .tag(FlowerMapTab.linearMaterial)
                FlowerList(pattern:patterns[2], items: values.map {$0.value}[1])
                    .tag(FlowerMapTab.scatteredMaterial)
                FlowerList(pattern:patterns[3], items: values.map {$0.value}[2])
                    .tag(FlowerMapTab.specialShapeMaterial)
            }
        }
    }
}

struct FlowerMap_Previews: PreviewProvider {
    static var previews: some View {
        FlowerMap()
    }
}

enum FlowerMapTab: String, CaseIterable {
    case massMaterial = "团状花材"
    case linearMaterial = "线状花材"
    case scatteredMaterial = "散状花材"
    case specialShapeMaterial = "特殊形状花材"
}
