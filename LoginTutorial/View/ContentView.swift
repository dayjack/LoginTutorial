//
//  ContentView.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/19.
//

import SwiftUI

struct ContentView: View {
    
    @State var idText: String = ""
    @State var pwdText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                TextField("아이디 입력", text: $idText)
                SecureField("비밀번호 입력", text: $pwdText)
                NavigationLink {
                    UserListView()
                } label: {
                    Text("로그인")
                }
            }
            .padding()
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

