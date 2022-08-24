//
//  BasicDesign.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct WorkList: View {
    @Binding var isTabBarHidden: Bool
    @Binding var isTabViewHidden: Bool
    
    var gridItemLayout = Array(repeating: GridItem(.flexible(), spacing: 0, alignment: .center), count: 2)
    var items:[Work]
    
    var body: some View {
            HStack{
                ScrollView(.vertical) {
                    Spacer(minLength: 20)
                    LazyVGrid(columns: gridItemLayout,spacing: 40) {
                        ForEach(items){work in
                            NavigationLink(
                                destination: WorkDetail(work: work)
                                    .onAppear {
                                        isTabViewHidden = true
                                        isTabBarHidden=true
                                    }
                                    .onDisappear{
                                        isTabViewHidden = false
                                        isTabBarHidden = false
                                    }
                            )
                            {
                                WorkItem(work:work)
                            }
                            .isDetailLink(false)
                        }
                    }
                }
                .padding(.leading,20)
                .padding(.trailing,20)
            }
            .ignoresSafeArea(.all)
            .navigationBarHidden(true)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(red: 0.906, green: 0.910, blue: 0.882))
    }
}

//struct WorkList_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkList()
//    }
//}
