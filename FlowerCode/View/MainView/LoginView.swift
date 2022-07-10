//
//  LoginView.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/7.
//

import SwiftUI
import UIKit

struct LoginView: View {
    
    @ObservedObject var document: FlowerCode
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    @State private var input_username: String = ""
    @State private var input_password: String = ""
    
    @State private var ifShowAlert = false
    
    
    var body: some View {
        GeometryReader { geometry in
            let widthOfFatherView = geometry.size.width
            let heightOfFatherView = geometry.size.height
            LazyVStack(alignment: .center) {
                ZStack(alignment: .center) {
                    Image("login")
                }
                VStack {
                    VStack {
                        HStack {
                            Text("账号")
                                .foregroundColor(Color(white: 0.8))
                            TextField("", text: $input_username)
                        }
                        .frame(width: widthOfFatherView * 0.8, height: heightOfFatherView * 0.07, alignment: .leading)
                            
                        Path { path in
                            path.move(to: CGPoint(x: widthOfFatherView * 0.1, y: 0))
                            path.addLine(to: CGPoint(x: widthOfFatherView * 0.9, y: 0))
                        }
                        .stroke(.white)
                    }
                    VStack {
                        HStack {
                            Text("密码")
                                .foregroundColor(Color(white: 0.8))
                            TextField("", text: $input_password)
                            Spacer()
                            Image("ic_eye_on")
                        }
                        .frame(width: widthOfFatherView * 0.8, height: heightOfFatherView * 0.07, alignment: .leading)
                        
                        Path { path in
                            path.move(to: CGPoint(x: widthOfFatherView * 0.1, y: 0))
                            path.addLine(to: CGPoint(x: widthOfFatherView * 0.9, y: 0))
                        }
                        .stroke(.white)
                    }
                    HStack {
                        Spacer()
                        Button {
                            // 跳转忘记账号或密码
                        } label: {
                            Text("忘记账号或密码？")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .underline()
                                .padding(.trailing)
                        }

                    }
                }
                Button {
                    //
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                        Text("登陆")
                            .foregroundColor(Color(red: 0.659, green: 0.553, blue: 0.443, opacity: 1))
                    }
                }
                .frame(width: 311, height: 48, alignment: .center)
                .padding()
                Button {
                    // 跳转新用户注册
                } label: {
                    Text("新用户注册")
                        .foregroundColor(.white)
                        .underline()
                        .font(.subheadline)
                }
            }
        }
        .background(Color("LoginViewColor"))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(document: FlowerCode())
    }
}
