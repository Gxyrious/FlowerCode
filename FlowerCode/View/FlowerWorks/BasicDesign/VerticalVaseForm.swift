//
//  VerticalVaseForm.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/6/10.
//

import SwiftUI

struct VerticalVaseForm: View {
    @State var curTab: BasicDesignTab = .basicIntroduction
    var body: some View {
        HStack(spacing: 0) {
            BasicDesignTabBar(curTab: $curTab)
            TabView(selection: $curTab) {
                BasicIntroduction()
                    .tag(BasicDesignTab.basicIntroduction)
                KeyPoints()
                    .tag(BasicDesignTab.keyPoints)
                DesignProcess()
                    .tag(BasicDesignTab.designProcess)
                Comments()
                    .tag(BasicDesignTab.comments)
            }
        }
    }
}

struct VerticalVaseForm_Previews: PreviewProvider {
    static var previews: some View {
        VerticalVaseForm()
    }
}

struct BasicIntroduction: View {
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Image("vertical_case_index")
                    .padding(.leading, 20)
                Spacer()
                Image("vertical_vase_introduction_background")
            }
            .padding(.bottom, 666)
            VStack {
                Image("vertical_vase_introduction_body")
            }
            .padding(.top, 88)
            HStack {
                Spacer()
                Image("vertical_vase_introduction_flower")
                    .padding(.bottom, 580)
            }
        }
        .background(Color(red: 0.906, green: 0.910, blue: 0.882))
        .ignoresSafeArea()
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
