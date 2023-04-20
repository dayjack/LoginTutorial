//
//  SignUpView.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/20.
//

import SwiftUI
import Alamofire

struct SignUpView: View {
    
    @State var inputId: String = ""
    @State var inputPwd: String = ""
    @State var isEditing: Bool = false
    @State var isIdDuplicated: Bool = false
    
    @State private var booltext = ""
    let urlString = "https://example.com/myAPIEndpoint"
    
    var body: some View {
        
        let binding = Binding<String>(
            get: { self.inputId },
            set: {
                self.inputId = $0
                self.textFieldChanged($0)
            }
        )
        
        NavigationStack {
            VStack {
                HStack {
                    Text("아이디를 입력하세요")
                        .padding()
                    TextField("", text: binding)
                        .padding()
                        .background(.green.opacity(0.3))
                    Text(isIdDuplicated ? "Id가 중복입니다." : "Id가 중복이 아닙니다.")
                        .padding()
                    
                }
                .padding(40)
                HStack {
                    Text("비밀번호를 입력하세요")
                        .padding()
                    SecureField("비밀번호 입력란", text: $inputPwd)
                        .padding()
                        .background(.green.opacity(0.3))
                }
                .padding(40)
                
                NavigationLink {
                    UserListView()
                } label: {
                    Button {
                        print("버튼 클릭")
                    } label: {
                        Text("회원가입 완료")
                    }
                }
            }
        }
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension SignUpView {
    private func textFieldChanged(_ text: String) {
        print(text)
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
}
