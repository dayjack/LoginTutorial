//
//  lightBlueBtnModifier.swift
//  LoginTutorial
//
//  Created by ChoiYujin on 2023/04/21.
//

import Foundation
import SwiftUI

struct lightBlueBtnModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24))
            .padding()
            .foregroundColor(.white)
            .background(.blue.opacity(0.4))
            .cornerRadius(12)
    }
}
