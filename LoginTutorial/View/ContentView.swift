//
//  ContentView.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/19.
//

import SwiftUI
import Alamofire
import CryptoKit

struct ContentView: View {
    
    @State var inputId: String = ""
    @State var inputPwd: String = ""
    @State var isSignin: Bool = false
    @State var reponseString: String = "false"
    @State var showingAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 20) {
                signinView()
                signinandup()
                
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isSignin) {
            UserListView()
        }
        .alert("로그인 실패", isPresented: $showingAlert) {
            Button("확인") {
                inputId = ""
                inputPwd = ""
            }
        } message: {
            Text("로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 확인해주세요.")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Extension
extension ContentView {
    
    // MARK: - signin
    func signin() {
        let original = self.inputPwd
        let data = original.data(using: .utf8)
        let sha256 = SHA256.hash(data: data!)
        let shaData = sha256.compactMap{String(format: "%02x", $0)}.joined()
        let urlString = "http://35.72.228.224/adaStudy/signin.php?id=\(inputId)&pwd=\(shaData)"
        print(urlString)
        AF.request(urlString).responseString { response in
            if let data = response.value {
                if data == "true" {
                    print("response true")
                    isSignin = true
                } else if data == "false" {
                    print("response false")
                    isSignin = false
                    showingAlert = true
                }
            }
        }
        
        
    }
    
    // MARK: - idTextField
    func idTextField() -> some View {
        return VStack(alignment: .leading) {
            Text("아이디입력")
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding([.bottom, .horizontal])
            TextField("아이디를 입력해주세요.", text: $inputId)
                .padding()
                .background()
                .cornerRadius(12)
        }
    }
    
    // MARK: - pwdSecureField
    func pwdSecureField() -> some View {
        
        return VStack(alignment: .leading) {
            Text("비밀번호 입력")
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding()
            SecureField("비밀번호를 입력해주세요.", text: $inputPwd)
                .padding()
                .background()
                .cornerRadius(12)
        }
    }
    
    // MARK: - signinView
    func signinView() -> some View {
        
        return VStack(spacing: 16) {
            idTextField()
            pwdSecureField()
        }
        .font(.system(size: 20))
        .padding(.vertical, 32)
        .padding(.horizontal, 20)
        .background(.blue.opacity(0.4))
        .cornerRadius(12)
    }
    
    func signinandup() -> some View {
        return HStack {
            Button {
                signin()
            } label: {
                Text("로그인")
            }
            .lightBlueBtn()
            NavigationLink {
                SignUpView()
            } label: {
                Text("회원가입")
            }
            .lightBlueBtn()
        }
    }
}
