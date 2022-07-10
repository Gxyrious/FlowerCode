//
//  MassMaterial.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct MassMaterial: View {
    
    var body: some View {
        VStack {
            title
        }
    }
    var title: some View {
        ScrollView(.vertical) {
            Image("flower_map_title")
            HStack {
                Image("flower_map_image")
                Image("flower_map_description")
            }
            Image("mass_material_text")
            HStack {
                Image("flower_map_display_1")
                Image("flower_map_display_2")
            }
            HStack {
                Image("flower_map_display_3")
                Image("flower_map_display_4")
            }
            HStack {
                Image("flower_map_display_5")
                Image("flower_map_display_6")
            }
        }
    }
}

struct MassMaterial_Previews: PreviewProvider {
    static var previews: some View {
        MassMaterial()
    }
}
