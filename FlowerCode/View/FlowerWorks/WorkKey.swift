//
//  WorkKey.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/22.
//

import SwiftUI

struct WorkKey: View {
    var work:Work
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            ForEach(work.keys,id: \.self){key in
                Text(key)
                    .fontWeight(.heavy)
                    .font(.body)
                    .lineSpacing(15)
                    .foregroundColor(Color("cyan"))
                Divider()
                
              }
        }
        .padding(.leading,30)
        .padding(.trailing,30)
    }
}

struct WorkKey_Previews: PreviewProvider {
    static var previews: some View {
        WorkKey(work: basicworks[0])
    }
}
