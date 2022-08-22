//
//  TipDetail.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/20.
//

import SwiftUI

struct TipDetail: View {
    var tip: Tip
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                           ZStack {
                               tip.image
                                       .resizable()
                                       .aspectRatio(contentMode: .fill)
                                       .frame(width: geometry.size.width, height: geometry.size.height)
                                       .offset(y: geometry.frame(in: .global).minY/9)
                                       .clipped()
                           }
                       }.frame(height: 400)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center){
                Text(tip.title)
                    .font(.title)
                }

                Divider()

                Text(tip.content)
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
        
    }
}

struct TipDetail_Previews: PreviewProvider {
    static var previews: some View {
        TipDetail(tip:tips[0])
    }
}
