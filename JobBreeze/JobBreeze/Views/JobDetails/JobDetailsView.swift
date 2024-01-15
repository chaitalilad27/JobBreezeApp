//
//  JobDetailsView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 10/01/24.
//
import SwiftUI

struct JobDetailsView: View {

    // MARK: - Properties

    var jobDetails: JobDetailsDataModel
    var tabTypes: [JobDetailsTabsType] = JobDetailsTabsType.allCases
    @State private var isLiked: Bool = false
    @State private var selectedTabType: JobDetailsTabsType = .about

    // MARK: - Body

    var body: some View {
        MainView
    }

    // MARK: - Subviews

    private var MainView: some View {
        VStack(spacing: 0) {
            ScrollView {
                EmployerDetailsView
            }
            BottomBarView
        }
        .background(Color.appLightWhiteColor.ignoresSafeArea(.all))
        .navigationBarStyle(title: "")
    }

    private var EmployerDetailsView: some View {
        VStack(alignment: .center, spacing: CustomSize.small.rawValue) {
            EmployerLogoView
            JobTitleView
            EmployerInfoView
            TabsTitleView
            TabsDetailsView
        }
        .padding(CustomSize.medium.rawValue)
    }

    private var EmployerLogoView: some View {
        ImageView(
            imageURL: jobDetails.employerLogo ?? "",
            placeHolderImageName: "jobPlaceholder",
            size: 80,
            placeholderImageSize: 80,
            cornerRadius: CustomSize.large.rawValue
        )
    }

    private var JobTitleView: some View {
        Text(jobDetails.jobTitle ?? "")
            .font(.poppins(.bold, size: .large))
            .foregroundColor(.appPrimaryColor)
            .lineLimit(2)
    }

    private var EmployerInfoView: some View {
        HStack {
            Text(jobDetails.employerName ?? "")
                .font(.poppins(.medium, size: .medium))
                .foregroundColor(.primary)
                .lineLimit(1)

            HStack(spacing: 4) {
                Image(systemName: "location")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.appGrayColor)

                Text(jobDetails.jobCountry ?? "")
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGrayColor)
                    .lineLimit(1)
            }
        }
    }

    private var BottomBarView: some View {
        HStack(spacing: 20) {
            LikeToggleButton
            ApplyButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(CustomSize.small.rawValue)
        .background(Color.white)
    }

    private var LikeToggleButton: some View {
        ToggleImageView(
            selectedImageName: "heart.fill",
            unSelectedImageName: "heart",
            size: CGSize(width: 45, height: 40),
            selectedImageColor: .appLightBlueColor,
            unSelectedImageColor: .appLightBlueColor,
            isSelected: $isLiked
        ) {}
        .padding(5)
    }

    private var ApplyButton: some View {
        Button(action: {
            openJobLink()
        }) {
            HStack {
                Spacer()
                Text(NSLocalizedString("applyForJob", comment: ""))
                    .font(.poppins(.bold, size: .medium))
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
        }
        .background(Color.appPrimaryColor)
        .cornerRadius(CustomSize.medium.rawValue)
    }

    // MARK: - Tabs Title View

    private var TabsTitleView: some View {
        JobDetailsTabsTitleView(tabTypes: tabTypes, selectedTabType: $selectedTabType)
    }

    // MARK: - Tabs Details View

    private var TabsDetailsView: some View {
        VStack(alignment: .leading, spacing: 0) {
            switch selectedTabType {
            case .about:
                JobDetailsTabsDetailsView(selectedTabType: selectedTabType, details: [jobDetails.jobDescription ?? ""])
            case .qualifications:
                JobDetailsTabsDetailsView(selectedTabType: selectedTabType, details: jobDetails.jobHighlights?.qualifications)
            case .responsibilities:
                JobDetailsTabsDetailsView(selectedTabType: selectedTabType, details: jobDetails.jobHighlights?.responsibilities)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(CustomSize.small.rawValue)
        .background(Color.white.ignoresSafeArea(.all))
        .cornerRadius(CustomSize.medium.rawValue)
    }

    // MARK: - Methods

    private func openJobLink() {
        if let url = URL(string: jobDetails.jobGoogleLink ?? "") {
            UIApplication.shared.open(url)
        }
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView(
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
