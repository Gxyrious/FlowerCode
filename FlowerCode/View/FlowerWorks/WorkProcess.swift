//
//  WorkProcess.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/22.
//

import SwiftUI

struct WorkProcess: View {
    var work:Work

    var body: some View {
        ScrollView{
        VStack(alignment: .center, spacing: 30){
            ForEach(work.steps,id: \.self){step in
                Text(step.dp)
                    .fontWeight(.heavy)
                    .font(.body)
                    .lineSpacing(15)
                    .foregroundColor(Color("cyan"))
                Image(step.ign)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
              }
        }
        .padding(.leading,30)
        .padding(.trailing,30)
    }
    }
}

struct WorkProcess_Previews: PreviewProvider {
    static var previews: some View {
        WorkProcess(work: basicworks[0])
    }
}
