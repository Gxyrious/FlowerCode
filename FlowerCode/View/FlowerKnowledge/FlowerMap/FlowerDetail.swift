//
//  FlowerDetail.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct FlowerDetail: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var flower:Flower
    
    var body: some View {
        ScrollView(.vertical) {
            flower.image
                .resizable()
                .cornerRadius(10)
                .frame(width: 300, height: 300, alignment: .center)
            Text(flower.name)
                .font(.largeTitle)
            Divider()
            HStack{
                VStack(alignment: .center)
                {
                    Text(flower.smell)
                        .padding(3)
                        .font(.title2)
                    Text("气味浓度")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .center)
                {
                    Text(flower.humidity)
                        .padding(3)
                        .font(.title2)
                    Text("温度需求")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .center)
                {
                    Text(flower.maintenance)
                        .padding(3)
                        .font(.title2)
                    Text("养护难度")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            Divider()
            Text(flower.description)
                .padding()
                .font(.subheadline)
                .foregroundColor(.secondary)

        }
        .navigationTitle(flower.category.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        //        .navigationBarItems(leading:Image("back_item"))
                .navigationBarItems(trailing: Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image("close-line")
                        })
                 )
    }
}

struct FlowerDetail_Previews: PreviewProvider {
    static var previews: some View {
        FlowerDetail(
            flower: flowers[0]
        )
    }
}
