//
//  WorkIntro.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/21.
//

import SwiftUI

struct WorkIntro: View {
    var work: Work
    @EnvironmentObject var document: FCDocument

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading){
                    Text("难度系数")
                        .padding(3)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(work.difficulty)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("湿度要求")
                        .padding(3)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(work.humidity)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("养护指数")
                        .padding(3)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(work.maintenance)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .frame(width: 80, height: 200)
                .padding(.leading, 80)
                .padding(.top, 120)

                ZStack{
                    Image("vertical_vase_introduction_background")
                        .padding(.leading,30)
                    work.image
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding(.top,70)
                        .padding(.leading,30)
                }
            }
            .padding(.bottom, 666)
            ZStack(alignment:.top) {
                Image("IntroBg")
                    .resizable()
                    .frame(width: 370, height: 650)
                VStack(alignment: .leading){
                    Text(work.name)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("cyan"))
                        .padding(.bottom,30)
                    Text(work.description)
                        .padding(.bottom,35)
                    Text("花材")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("cyan"))
                        .padding(.bottom,15)
                    
                    HStack{
                        ForEach(work.floNames,id: \.self){name in
                            VStack(alignment: .center){
                                NavigationLink(destination: FlowerDetail(flower: nameFlowerDic[name]!)
                                    .onAppear{
                                        document.tabBarHidden()
                                    }
                                    .onDisappear {
                                        document.tabBarShown()
                                    }
                                ) {
                                    Image((nameFlowerDic[name]?.imageName)!)
                                        .resizable()
                                        .clipShape(Circle())
                                        .frame(width: 40, height:40)
                                }
                                Text(name)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                    }
                    .frame(width: 370)
                    .padding(.bottom,30)
                    
                    Text("花器")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("cyan"))
                        .padding(.bottom,15)
                    
                    VStack(alignment: .center){
                        Image(work.vaseNames)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 40, height:40)
                        Text(work.vaseNames)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                }
                .frame(width: 320, height: 500)
                .padding(.leading,50)
            }
            .padding(.top, 330)
        }
        .background(Color(red: 0.906, green: 0.910, blue: 0.882))
        .ignoresSafeArea()
    }
}

struct WorkIntro_Previews: PreviewProvider {
    static var previews: some View {
        WorkIntro(work:basicworks[0])
    }
}
