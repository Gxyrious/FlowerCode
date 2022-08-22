//
//  FlowerMaintenanceItem.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct TipItem: View {
    var tip:Tip
    var body: some View {
        VStack(alignment: .center) {
            tip.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(tip.title)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct TipItem_Previews: PreviewProvider {
    static var previews: some View {
        TipItem(tip:tips[0])
    }
}
