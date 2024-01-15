//
//  PopularJobsRowView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 08/01/24.
//

import SwiftUI

struct PopularJobsRowView: View {

    // MARK: - Properties

    var jobDetails: JobDetailsDataModel

    // MARK: - Body

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                EmployerLogoView
                JobDetailsView
            }
            Spacer()
        }
        .frame(width: 250)
        .padding(CustomSize.medium.rawValue)
        .background(Color.white)
        .cornerRadius(CustomSize.medium.rawValue)
    }

    // MARK: - Subviews

    private var EmployerLogoView: some View {
        ImageView (
            imageURL: jobDetails.employerLogo ?? "",
            placeHolderImageName: "jobPlaceholder",
            size: 30,
            placeholderImageSize: 25,
            cornerRadius: CustomSize.medium.rawValue
        )

    }

    private var JobDetailsView: some View {
        Group {
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
    }
}

struct PopularJobsRowView_Previews: PreviewProvider {
    static var previews: some View {
        PopularJobsRowView(
            jobDetails: JobDetailsDataModel(
                employerName: "TEKsystems",
                employerLogo: "https://www.teksystems.com/-/media/teksystems/images/logos/teksystems-logo.svg?iar=0&rev=7059329eede9499a9965f7b1d91cc97f",
                jobID: "iXki4pXSSRwAAAAAAAAAAA==",
                jobEmploymentType: "FULLTIME",
                jobTitle: "Python Developer (W2)",
                jobDescription: "Description:\n\nPython Developer in Houston Texas. W2 only. Contract. Hybrid.\n\nSkills:\n\nPython, React, Linux, Unix, API",
                jobCountry: "US",
                jobGoogleLink: "https://www.google.com/search?gl=us&hl=en&q=iXki4pXSSRwAAAAAAAAAAA%3D%3D&cs=1&ibp=htl;jobs#fpstate=tldetail&htivrt=jobs&htiq=iXki4pXSSRwAAAAAAAAAAA%3D%3D&htidocid=iXki4pXSSRwAAAAAAAAAAA%3D%3D",
                jobHighlights: JobHighlights(qualifications: [
                    "Python, React, Linux, Unix, API"
                ])
            )
        )
    }
}
