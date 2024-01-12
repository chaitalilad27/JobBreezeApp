//
//  NearbyJobsRowView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import SwiftUI

struct NearbyJobsRowView: View {

    var jobDetails: JobDetailsDataModel

    var body: some View {
        HStack(spacing: 10) {
            ImageView(imageURL: jobDetails.employerLogo ?? "", placeHolderImageName: "jobPlaceholder", size: 50, placeholderImageSize: 40, cornerRadius: CustomSize.medium.rawValue)

            VStack(alignment: .leading) {
                Text(jobDetails.jobTitle ?? "")
                    .font(.poppins(.bold, size: .medium))
                    .foregroundColor(.appPrimaryColor)
                    .lineLimit(1)

                Text((jobDetails.jobEmploymentType?.rawValue ?? "").capitalized)
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGrayColor)
                    .lineLimit(1)
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
        NearbyJobsRowView(jobDetails: JobDetailsDataModel(employerName: "", employerLogo: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Costco_Wholesale_logo_2010-10-26.svg/2560px-Costco_Wholesale_logo_2010-10-26.svg.png", jobID: "", jobEmploymentType: .contractor, jobTitle: "Stocker", jobDescription: "", jobCountry: "", jobGoogleLink: "", jobRequiredSkills: [], jobHighlights: .init(qualifications: [])))
    }
}
