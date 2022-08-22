//
//  InfoList.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/19.
//

import SwiftUI

struct InfoList: View {
    var items: [Info]

    var body: some View {
                    List(items) { info in
                        InfoRow(info:info)
                    }
                    .colorMultiply(Color(red: 0.914, green: 0.933, blue: 0.875))
                    .padding(.top,0)
    }
}

struct InfoList_Previews: PreviewProvider {
    static var previews: some View {
        InfoList(
            items: Array(infos.prefix(2))
        )
    }
}
