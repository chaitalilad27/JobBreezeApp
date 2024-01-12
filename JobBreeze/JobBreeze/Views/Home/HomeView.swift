//
//  HomeView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 02/01/24.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject private var homeViewModel = HomeViewModel()
    @State private var searchText: String = ""
    @State private var jobEmployementTypes = JobEmploymentType.allCases
    @State private var activeJobType: JobEmploymentType = .fulltime
    @State private var popularJobs: [JobDetailsDataModel] = []
    @State private var nearByJobs: [JobDetailsDataModel] = []

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: CustomSize.xLarge.rawValue, content: {
                    WelcomeView
                    SearchView
                    JobTypeSelectionView
                    JobsView(name: JobType.popularJobs.rawValue)
                    JobsView(name: JobType.nearbyJobs.rawValue)
                    Spacer()
                })
            }
            .padding(CustomSize.medium.rawValue)
            .background(Color.appLightWhiteColor.ignoresSafeArea(.all))
            .onAppear {
                fetchJobs(type: JobType.popularJobs.rawValue) {
//                    fetchJobs(type: JobType.nearbyJobs.rawValue) {
//
//                    }
                }
            }
        }
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
                ForEach(jobEmployementTypes, id: \.rawValue) { jobType in
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

            if name == JobType.popularJobs.rawValue {
                PopularJobsList
            } else {
                NearbyJobsList
            }
        }
    }

    private var PopularJobsList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CustomSize.medium.rawValue) {
                ForEach(popularJobs, id: \.jobID) { job in
                    NavigationLink {
                        JobDetailsView(jobDetails: job)
                    } label: {
                        PopularJobsRowView(jobDetails: job)
                    }
                }
            }
        }
    }

    private var NearbyJobsList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: CustomSize.medium.rawValue) {
                ForEach(nearByJobs, id: \.jobID) { job in
                    NavigationLink {
                        JobDetailsView(jobDetails: job)
                    } label: {
                        NearbyJobsRowView(jobDetails: job)
                    }
                }
            }
        }
    }

    func fetchJobs(type: String, completion: @escaping () -> Void) {
        let string = String(type.filter { !" ".contains($0) })
        homeViewModel.fetchData(type: string) { result in
            switch result {
            case .success(let data):
                // Handle the received data
                if type == JobType.popularJobs.rawValue {
                    popularJobs = data
                } else {
                    nearByJobs = data
                }
                completion()
            case .failure(let error):
                // Handle the error
                print("API request failed with error: \(error.errorMessage)")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
