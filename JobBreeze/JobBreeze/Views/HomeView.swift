//
//  HomeView.swift
//  Tasks
//
//  Created by Chaitali Lad on 02/01/24.
//

import SwiftUI

struct HomeView: View {

    @State private var searchText: String = ""
    @State private var jobTypes = JobType.allCases
    @State private var activeJobType: JobType = .fullTime

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CustomSize.xLarge.rawValue, content: {
                WelcomeView
                SearchView
                JobTypeSelectionView
                JobsView(name: NSLocalizedString("popularJobs", comment: ""))
                JobsView(name: NSLocalizedString("nearbyJobs", comment: ""))
                Spacer()
            })
        }
        .padding(CustomSize.medium.rawValue)
        .background(Color.appLightWhiteColor.ignoresSafeArea(.all))

    }

    private var WelcomeView: some View {
        VStack(alignment: .leading) {
            Text("\(NSLocalizedString("hello", comment: "")) Chaitali")
                .font(.poppins(.regular, size: .large))
                .foregroundColor(.appSecondaryColor)

            Text(NSLocalizedString("findYourPerfectJob", comment: ""))
                .font(.poppins(.bold, size: .xLarge))
                .foregroundColor(.appPrimaryColor)
        }
    }

    private var SearchView: some View {
        HStack {
            CustomTextField(placeholder: NSLocalizedString("whatAreYouLookingFor", comment: ""), text: $searchText, font: .poppins(.regular, size: .medium), height: 60, backgroundColor: .appWhiteColor, cornerRadius: CustomSize.medium.rawValue)

            Spacer()

            Button {

            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.appWhiteColor)
            }
            .padding(CustomSize.medium.rawValue)
            .background(Color.appDarkBlueColor)
            .cornerRadius(CustomSize.xxLarge.rawValue)
        }
    }

    private var JobTypeSelectionView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CustomSize.medium.rawValue) {
                ForEach(jobTypes, id: \.rawValue) { jobType in
                    Button {
                        activeJobType = jobType
                    } label: {
                        Text(jobType.rawValue)
                            .font(.poppins(.medium, size: .medium))
                    }
                    .padding(.vertical, CustomSize.xSmall.rawValue)
                    .padding(.horizontal, CustomSize.medium.rawValue)
                    .foregroundColor(activeJobType == jobType ? .appPrimaryColor : .appGray2Color)
                    .overlay(
                        RoundedRectangle(cornerRadius: CustomSize.xxLarge.rawValue)
                            .strokeBorder(activeJobType == jobType ? Color.appPrimaryColor : Color.appGray2Color, lineWidth: 1)
                    )
                }
            }
        }
    }

    private func JobsView(name: String) -> some View {
        VStack {
            HStack {
                Text(name)
                    .font(.poppins(.medium, size: .large))
                    .foregroundColor(.appPrimaryColor)

                Spacer()

                Text(NSLocalizedString("showAll", comment: ""))
                    .font(.poppins(.medium, size: .medium))
                    .foregroundColor(.appGrayColor)
            }

            if name == NSLocalizedString("popularJobs", comment: "") {
                PopularJobsList
            } else {
                NearbyJobsList
            }
        }
    }

    private var PopularJobsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CustomSize.medium.rawValue) {
                ForEach(jobTypes, id: \.rawValue) { jobType in
                    PopularJobsRowView()
                }
            }
        }
    }

    private var NearbyJobsList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: CustomSize.medium.rawValue) {
                ForEach(jobTypes, id: \.rawValue) { jobType in
                    NearbyJobsRowView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
