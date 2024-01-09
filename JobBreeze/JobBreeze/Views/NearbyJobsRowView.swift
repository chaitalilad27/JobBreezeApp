//
//  NearbyJobsRowView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import SwiftUI

struct NearbyJobsRowView: View {

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "pencil")
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .background(Color.appWhiteColor)
                .cornerRadius(CustomSize.medium.rawValue)

            VStack(alignment: .leading) {
                Text("Job name")
                    .font(.poppins(.bold, size: .large))
                    .foregroundColor(.appPrimaryColor)

                Text("Company name")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGrayColor)
            }

            Spacer()
        }
        .padding(CustomSize.medium.rawValue)
        .background(Color.white)
        .cornerRadius(CustomSize.medium.rawValue)
    }
}

struct NearbyJobsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyJobsRowView()
    }
}
