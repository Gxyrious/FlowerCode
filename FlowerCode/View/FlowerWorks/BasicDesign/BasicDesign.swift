//
//  BasicDesign.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/13.
//

import SwiftUI

struct BasicDesign: View {
    @Binding var isTabViewHidden: Bool
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical) {
                    HStack(spacing: 20) {
                        NavigationLink {
                            VerticalVaseForm()
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            Image("flower_work_display_1")
                        }
                        
                        NavigationLink {
                            Text("倾斜式瓶花")
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            Image("flower_work_display_2")
                        }
                    }
                    HStack(spacing: 20) {
                        NavigationLink {
                            Text("平卧式瓶花")
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            Image("flower_work_display_3")
                        }
                        NavigationLink {
                            Text("下垂式瓶花")
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            Image("flower_work_display_4")
                        }
                    }
                    HStack(spacing: 20) {
                        NavigationLink {
                            Text("直立式盆花")
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            Image("flower_work_display_5")
                        }
                        NavigationLink {
                            Text("倾斜式盆花")
                                .onAppear {
                                    isTabViewHidden = true
                                }
                                .onDisappear {
                                    isTabViewHidden = false
                                }
                        } label: {
                            Image("flower_work_display_6")
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color(red: 0.906, green: 0.910, blue: 0.882))
            .navigationBarHidden(true)
        }
    }
}

//struct BasicDesign_Previews: PreviewProvider {
//    static var previews: some View {
//        BasicDesign()
//    }
//}
