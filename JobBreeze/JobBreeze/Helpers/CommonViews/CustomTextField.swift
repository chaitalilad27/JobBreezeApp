//
//  CustomTextField.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 04/01/24.
//

import SwiftUI

struct CustomTextField: View {

    // MARK: - Properties

    var placeholder: String
    @Binding var text: String
    var font: Font = .body
    var height: CGFloat = 50
    var backgroundColor = Color.white
    var cornerRadius: CGFloat = 10

    // MARK: - Body

    var body: some View {
        TextField(NSLocalizedString(placeholder, comment: ""), text: $text)
            .font(font)
            .padding(CustomSize.medium.rawValue)
            .frame(height: height)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(placeholder: "Name", text: .constant(""))
    }
}
