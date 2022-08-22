//
//  InfoDetail.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/19.
//

import SwiftUI

struct InfoDetail: View {
    var info: Info
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                           ZStack {
                               info.image
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: geometry.size.width, height: geometry.size.height)
                                       .offset(y: geometry.frame(in: .global).minY/9)
                                       .clipped()
                           }
                       }.frame(height: 400)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center){
                Text(info.title)
                    .font(.title)
                }

                Divider()

                Text(info.content)
            }
            .padding()

        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("close-line")
                })
         )
        .navigationTitle(info.title)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct InfoDetail_Previews: PreviewProvider {

    static var previews: some View {
        InfoDetail(info: infos[0])
    }
}
