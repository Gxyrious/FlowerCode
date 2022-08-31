//
//  InfoRow.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/19.
//

import SwiftUI

struct InfoRow: View {
    var info:Info
    @EnvironmentObject var document: FCDocument

    var body: some View {
        NavigationLink(destination: InfoDetail(info:info)
            .onAppear{
                document.tabBarHidden()
            }
            .onDisappear {
                document.tabBarShown()
            }
        ) {
            HStack {
                Text(info.title)
                Spacer()
            }
            .padding()
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(info:infos[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
