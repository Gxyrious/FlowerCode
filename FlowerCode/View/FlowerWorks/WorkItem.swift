//
//  workItem.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/21.
//

import SwiftUI

struct WorkItem: View {
    var work: Work
    
    var body: some View {
//        VStack(alignment: .center) {
//            work.image
//                .renderingMode(.original)
//                .resizable()
//                .frame(width: 100, height: 130)
//                .padding(.top,-20)
//                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
//                    .fill(Color(red: 210/256, green: 223/256, blue: 217/256))
//                    .frame(width: 130, height: 200))
//
//            Text(work.name)
//                .foregroundColor(Color("secondaryText"))
//                .font(.body)
//                .frame(width: 130)
//                .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
//                    .fill(Color(.white))
//                    .frame(width: 130, height: 60))
//        }
//        .padding(25)
//        .frame(width: 130, height: 180)
        ZStack(alignment: .center)
        {
            Image("workItemBg")
                .frame(width: 130, height: 220)
            VStack(alignment: .center){
                work.image
                    .resizable()
                    .frame(width: 120, height: 160)
                VStack(alignment: .leading){
                    Text(work.name)
                        .font(.subheadline)
                            .foregroundColor(.primary)
                    HStack{
                        ForEach(work.floNames,id: \.self){name in
                            Text(name)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.leading,-22)
            }

        }
        .frame(width: 130, height: 200)
    }
}

struct WorkItem_Previews: PreviewProvider {
    static var previews: some View {
        WorkItem(work:basicworks[0])
    }
}
