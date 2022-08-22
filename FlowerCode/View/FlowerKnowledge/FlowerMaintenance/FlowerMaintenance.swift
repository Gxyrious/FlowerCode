//
//  FlowerMaintenance.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct FlowerMaintenance: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        //NavigationView {
            List {
                ForEach(tipCategories.keys.sorted(), id: \.self) { key in
                    TipRow(categoryName: key, items: tipCategories[key]!)
                }
                .listRowInsets(EdgeInsets())
                .padding(.bottom,20)
            }
            .navigationTitle("花材养护")
        //}
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("flower_map_back")
                }
            }
        }

    }
}

struct FlowerMaintenance_Previews: PreviewProvider {
    static var previews: some View {
        FlowerMaintenance()
    }
}
