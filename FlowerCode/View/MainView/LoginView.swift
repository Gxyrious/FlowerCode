//
//  LoginView.swift
//  FLORALCREATION
//
//  Created by 刘畅 on 2022/5/7.
//

import SwiftUI
import UIKit
import CoreData

struct LoginView: View {
    
//    @ObservedObject var document: FlowerCode
    @EnvironmentObject var modelData: ModelData
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.username, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    @State private var input_username: String = ""
    @State private var input_password: String = ""
    
    @State var isRegistering: Bool = false
    @State var registerState: Bool = true
    
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
                            Text(isRegistering ? "新的账号" : "账号")
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
                            Text(isRegistering ? "新的密码" : "密码")
                                .foregroundColor(Color(white: 0.8))
                            SecureField("", text: $input_password)
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
                            print("忘记账号或密码")
                        } label: {
                            Text(isRegistering ? "        " : "忘记账号或密码")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding(.trailing)
                        }

                    }
                }
                Button {
                    print("input = \(input_username) & \(input_password)")
                    if input_username == "" || input_password == "" {
                        modelData.alertIllegal.toggle()
                    }
                    else {
                        if !isRegistering {
                            // 登陆
                            for user in users {
                                print("id=\(user.id),name=\(user.username!),pw=\(user.password!)")
                                if user.username == input_username && user.password == input_password {
                                    // 密码正确，登陆成功，弹出提示
                                    modelData.alertSuccessLogIn.toggle()
                                    print("登陆成功")
                                    modelData.username = input_username
                                    modelData.password = input_password
                                    modelData.isLoggedIn = true
                                }
                            }
                            // 登陆失败，弹出警告
                            if !modelData.isLoggedIn {
                                modelData.alertFailLogIn.toggle()
                                print("账号不存在或密码错误")
                                input_password = ""
                            }
                        }
                        else {
                            // 注册
    //                        let fetchRequest = NSFetchRequest<User>(entityName: "User")
                            registerState = true
                            for user in users {
                                print("id=\(user.id),name=\(user.username!),pw=\(user.password!)")
                                if user.username == input_username {
                                    // 用户名已存在，弹出警告
                                    modelData.alertFailRegister.toggle()
                                    print("用户名已存在")
                                    registerState = false
                                }
                            }
                            if registerState {
                                let newUser = User(context: viewContext)
                                newUser.username = input_username
                                newUser.password = input_password
                                newUser.id = Int16(users.count + 1)
                                do {
                                    try viewContext.save()
                                    isRegistering = false // 注册成功
                                    modelData.alertSuccessRegister.toggle()
                                    input_username = ""
                                    input_password = ""
                                } catch {
//                                    let nsError = error as NSError
    //                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                    // 注册失败，弹出警告
                                    modelData.alertUnknown.toggle()
                                    print("未知错误，注册失败")
                                    input_password = ""
                                }
                            }
                        }
                    }

                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                        Text(isRegistering ? "注册" : "登陆")
                            .font(.system(size: 20))
                            .foregroundColor(Color(red: 0.659, green: 0.553, blue: 0.443, opacity: 1))
                    }
                }
                .frame(width: 311, height: 48, alignment: .center)
                .padding()
                Button {
                    // 翻转注册和登录
                    withAnimation {
                        isRegistering.toggle()
                    }
                } label: {
                    Text(isRegistering ? "已有账号 点击登录" : "新用户注册")
                        .foregroundColor(.white)
                        .underline()
                        .font(.subheadline)
                }
                
                
            }
            
//            .alert(isPresented: $alertSuccess) {
//                Alert(title: Text("登陆成功"), message: Text("欢迎你，\(input_username)"))
//            }
//            .alert(isPresented: $alertFailLogIn) {
//                Alert(title: Text("登陆失败"), message: Text("账号不存在或密码错误"))
//            }
//            .alert(isPresented: $alertFailRegister) {
//                Alert(title: Text("注册失败"), message: Text("该用户名\(input_username)已存在"))
//            }
//            .alert(isPresented: $alertUnknown) {
//                Alert(title: Text("注册失败"), message: Text("未知错误"))
//            }
        }
        .background(Color("cyan"))
        
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(document: FlowerCode())
//    }
//}
