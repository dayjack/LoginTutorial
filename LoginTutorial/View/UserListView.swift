//
//  UserListView.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/19.
//

import SwiftUI
import Alamofire

struct UserListView: View {
    
    @State private var userData: [UserModel]?
    
    var body: some View {
        
        VStack {
            if let data = userData {
                ForEach(data, id: \.id) { object in
                    // data는 [UserModel] Type
                    // object는 UserModel Type
                    // UserModel의 프로퍼티 id를 불러오는 ForEach문
                    Text("Received data: \(object.id)")
                }
            } else {
                Text("Fetching data...")
            }
        }
        .onAppear {
            fetchData { result in
                switch result {
                case .success(let data):
                    userData = data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

extension UserListView {
    
    // MARK: - fetchData
    func fetchData(completion: @escaping (Result<[UserModel], AFError>) -> Void) {
        // 데이터를 받아올 링크
        AF.request("http://35.72.228.224/adaStudy/getUserList.php")
            .responseDecodable(of: [UserModel].self) { response in
                completion(response.result)
            }
    }
}
