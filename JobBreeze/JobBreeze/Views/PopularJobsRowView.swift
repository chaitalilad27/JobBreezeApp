//
//  PopularJobsRowView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import SwiftUI

struct PopularJobsRowView: View {

    var jobDetails: JobDetailsDataModel

    var body: some View {

        HStack {
            VStack(alignment: .leading) {
                ImageView(imageURL: jobDetails.employerLogo ?? "", placeHolderImageName: "", size: 30, placeholderImageSize: 25, cornerRadius: CustomSize.medium.rawValue)

                Text(jobDetails.employerName ?? "")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGray2Color)
                    .lineLimit(1)
                    .padding(.bottom, 5)

                Text(jobDetails.jobTitle ?? "")
                    .font(.poppins(.medium, size: .large))
                    .foregroundColor(.appPrimaryColor)
                    .lineLimit(1)

                Text(jobDetails.jobCountry ?? "")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGray2Color)
                    .lineLimit(1)
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
        PopularJobsRowView(jobDetails: JobDetailsDataModel(employerName: "LinkedIn", employerLogo: "", jobID: "", jobEmploymentType: .contractor, jobTitle: "", jobDescription: "", jobCountry: "", jobGoogleLink: "", jobRequiredSkills: [], jobHighlights: .init(qualifications: [])))
    }
}
