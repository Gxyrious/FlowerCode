//
//  FlowerMaintenanceRow.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct TipRow: View {
    var categoryName: String
    var items: [Tip]
    @EnvironmentObject var document: FCDocument

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title2)
                .padding(.leading, 15)
                .padding(.top, 15)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { tip in
                        NavigationLink {
                            TipDetail(tip:tip)
                                .onAppear{
                                    document.tabBarHidden()
                                }
                                .onDisappear {
                                    document.tabBarShown()
                                }
                        } label: {
                            TipItem(tip: tip)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

//struct TipRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TipRow(
//            categoryName: tips[0].category.rawValue,
//            items: Array(tips.prefix(2))
//        )
//    }
//}
