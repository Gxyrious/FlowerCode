//
//  WorkDetail.swift
//  FlowerCode
//
//  Created by 昏影终 on 2022/8/21.
//

import SwiftUI

struct WorkDetail: View {
    @State var curTab: BasicDesignTab = .basicIntroduction
    var work: Work
    var body: some View {
        HStack(spacing: 0) {
            WorkDetailTabBar(curTab: $curTab)
            TabView(selection: $curTab) {
                WorkIntro(work: work)
                    .tag(BasicDesignTab.basicIntroduction)
                WorkKey(work: work)
                    .tag(BasicDesignTab.keyPoints)
                WorkProcess(work: work)
                    .tag(BasicDesignTab.designProcess)
            }
        }
    }
}

struct WorkDetail_Previews: PreviewProvider {
    static var previews: some View {
        WorkDetail(work: basicworks[0])
    }
}


struct KeyPoints: View {
    var body: some View {
        Text("插制要点")
    }
}

struct DesignProcess: View {
    var body: some View {
        Text("插制要点")
    }
}

struct Comments: View {
    var body: some View {
        Text("评论")
    }
}
