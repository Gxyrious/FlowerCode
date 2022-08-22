//
//  FlowerItem.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct FlowerItem: View {
    var flower:Flower
    var body: some View {
        VStack(alignment: .center) {
            flower.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100)
            
            Text(flower.name)
                .foregroundColor(Color("secondaryText"))
                .font(.body)
        }
        .padding(25)
        .frame(width: 130, height: 180)
        .overlay(
             RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color.white, lineWidth: 1)
                .shadow(radius: 4)
                .cornerRadius(20)
        )
    }
}

struct FlowerItem_Previews: PreviewProvider {
    static var previews: some View {
        FlowerItem(flower: flowers[0])
    }
}
