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
    
    @State var curTab: FlowerMapTab = .massMaterial
    var body: some View {
        HStack(spacing: 0) {
            FlowerMapTabBar(curTab: $curTab)
            TabView(selection: $curTab) {
                MassMaterial()
                    .tag(FlowerMapTab.massMaterial)
                LinearMaterial()
                    .tag(FlowerMapTab.linearMaterial)
                Text("散装花材")
                    .tag(FlowerMapTab.scatteredMaterial)
                Text("特殊形状花材")
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
