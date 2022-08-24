//
//  FlowerList.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct FlowerList: View {
    var pattern:Pattern
    var items:[Flower]
    var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: .center), count: 2)
    @EnvironmentObject var modelData: ModelData


    var body: some View {
        ScrollView(.vertical) {
            Text("花草图鉴")
                .frame(alignment: .center)
                .font(.largeTitle)
            Text("· map ·")
                .frame(alignment: .center)
                .font(.largeTitle)
            HStack {
                pattern.image
                    .resizable()
                    .frame(width: 150, height: 150)
                Text(pattern.description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding()
            }
            Spacer(minLength:30)
            Text(pattern.name)
                .font(.title)
                .foregroundColor(Color("secondaryText"))
            LazyVGrid(columns: gridItemLayout) {
                ForEach(items){flower in
                    NavigationLink(destination: FlowerDetail(flower: flower)
                        .onAppear{
                            modelData.tabBarHidden()
                        }
                        .onDisappear {
                            modelData.tabBarShown()
                        }
                    ) {
                        FlowerItem(flower:flower)
                    }
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FlowerList_Previews: PreviewProvider {
    static var previews: some View {
        FlowerList(pattern: patterns[0], items: Array(flowers.prefix(5)))
    }
}
