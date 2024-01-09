//
//  PopularJobsRowView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import SwiftUI

struct PopularJobsRowView: View {

    var body: some View {

        HStack {
            VStack(alignment: .leading) {
                Image(systemName: "pencil")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.appWhiteColor)
                    .cornerRadius(CustomSize.medium.rawValue)

                Text("Company name")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGray2Color)
                    .padding(.bottom, 5)

                Text("Job name")
                    .font(.poppins(.medium, size: .large))
                    .foregroundColor(.appPrimaryColor)

                Text("US")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGray2Color)
            }

            Spacer()
        }
        .frame(width: 250)
        .padding(CustomSize.medium.rawValue)
        .background(Color.white)
        .cornerRadius(CustomSize.medium.rawValue)
    }
}

struct PopularJobsRowView_Previews: PreviewProvider {
    static var previews: some View {
        PopularJobsRowView()
    }
}
