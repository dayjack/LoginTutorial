//
//  SignUpView.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/20.
//

import SwiftUI
import Alamofire
import CryptoKit

struct SignUpView: View {
    
    @State var inputId: String = ""
    @State var inputPwd: String = ""
    @State var isEditing: Bool = false
    @State var isIdDuplicated: Bool = false
    @State var isSignedUp: Bool = false
    @State var showingAlert: Bool = false
    
    @State private var booltext = ""
    let urlString = "https://example.com/myAPIEndpoint"
    
    var body: some View {
        
        let binding = Binding<String>(
            get: { self.inputId },
            set: {
                self.inputId = $0
                self.textFieldChanged()
            }
        )
        
        NavigationStack {
            VStack {
                idView(binding: binding)
                pwdView()
                Button {
                    if inputPwd.checkCanbePwd() == .none {
                        signup()
                    } else {
                        showingAlert = true
                    }
                } label: {
                    Text("회원가입")
                }
            }
        }
        .fullScreenCover(isPresented: $isSignedUp) {
            UserListView()
        }
        .alert("회원가입 실패", isPresented: $showingAlert) {
            Button("확인") {}
        } message: {
            Text("회원가입에 실패하였습니다.\n회원가입 양식을 한번 더 확인해주세요")
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

// MARK: - extension httpd logic
extension SignUpView {
    
    // MARK: - Id 중복 체크 로직
    private func textFieldChanged() {
        let urlString = "http://35.72.228.224/adaStudy/signup.php?id=\(inputId)"
        AF.request(urlString).responseString { response in
            if let data = response.value {
                if data == "true" {
                    print("response true")
                    isIdDuplicated = true
                } else if data == "false" {
                    print("response false")
                    isIdDuplicated = false
                }
            }
        }
    }
    
    // MARK: - Signup
    private func signup() {
        
        let original = self.inputPwd
        let data = original.data(using: .utf8)
        let sha256 = SHA256.hash(data: data!)
        let shaData = sha256.compactMap{String(format: "%02x", $0)}.joined()
        
        let urlString = "http://35.72.228.224/adaStudy/signup.php?id=\(inputId)&pwd=\(shaData)"
        AF.request(urlString).responseString { response in
            if let data = response.value {
                if data == "true" {
                    print("signup true")
                    self.isSignedUp = true
                } else if data == "false" {
                    print("signup false")
                    showingAlert = true
                }
            }
        }
    }
}


// MARK: - extension View
extension SignUpView {
    
    func idView(binding: Binding<String>) -> some View {
        return VStack(alignment: .leading) {
            Text("아이디를 입력하세요")
                .font(.system(.title3))
                .fontWeight(.bold)
                
            TextField("아이디 입력란", text: binding)
                .padding()
                .background()
                .cornerRadius(10)
            if self.inputId.count < 4 {
                Label("Id는 4자 이상으로 설정해주세요" , systemImage: "x.circle")
                    .font(.system(.callout))
                    .foregroundColor(.red)
            } else {
                Label(isIdDuplicated ? "Id가 중복입니다." : "Id가 중복이 아닙니다." , systemImage: isIdDuplicated ? "x.circle" : "checkmark.circle")
                    .font(.system(.callout))
                    .foregroundColor(isIdDuplicated ? .red : .green)
            }
        }
        .padding(40)
        .background(.gray.opacity(0.2))
        .cornerRadius(20)
        .padding()
    }
    
    func pwdView() -> some View {
        return VStack(alignment: .leading) {
            Text("비밀번호를 입력하세요")
                .font(.system(.title3))
                .fontWeight(.bold)
            SecureField("비밀번호 입력란", text: $inputPwd)
                .padding()
                .background()
                .cornerRadius(10)
            switch inputPwd.checkCanbePwd() {
            case .noNumber:
                Label("적어도 하나의 숫자를 포함해야합니다." , systemImage: "x.circle")
                    .font(.system(.callout))
                    .foregroundColor(.red)
            case .noUpper:
                Label("적어도 하나의 대문자를 포함해야합니다." , systemImage: "x.circle")
                    .font(.system(.callout))
                    .foregroundColor(.red)
            case .lessCount:
                Label("비밀번호는 4자리이상이어야합니다." , systemImage: "x.circle")
                    .font(.system(.callout))
                    .foregroundColor(.red)
            case .none:
                Label("비밀번호로 설정가능합니다." , systemImage: "checkmark.circle")
                    .font(.system(.callout))
                    .foregroundColor(.green)
            }
        }
        .padding(40)
        .background(.gray.opacity(0.2))
        .cornerRadius(20)
        .padding()
    }
}
