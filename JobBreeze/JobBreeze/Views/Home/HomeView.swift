//
//  HomeView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 02/01/24.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties

    @ObservedObject private var viewModel = HomeViewModel()

    // MARK: - Body

    var body: some View {
        NavigationStack {
            MainView
        }
    }

    // MARK: - Subviews

    private var MainView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: CustomSize.xLarge.rawValue) {
                WelcomeView
                SearchView
                JobTypeSelectionView
                JobsView(name: JobType.popularJobs.rawValue)
                JobsView(name: JobType.nearbyJobs.rawValue)
                Spacer()
            }
        }
        .padding(CustomSize.medium.rawValue)
        .toast(isPresented: $viewModel.showToast, message: viewModel.toastMessage)
        .background(Color.appLightWhiteColor.ignoresSafeArea(.all))
        .navigationBarStyle(title: "Job Breeze", displayMode: .inline)
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
            CustomTextField(placeholder: NSLocalizedString("whatAreYouLookingFor", comment: ""),
                            text: $viewModel.searchText,
                            font: .poppins(.regular, size: .medium),
                            height: 60,
                            backgroundColor: .appWhiteColor,
                            cornerRadius: CustomSize.medium.rawValue)

            Spacer()

            NavigationLink {
                JobListView(viewModel: .init(String(viewModel.searchText.filter { !" ".contains($0) })))
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.appWhiteColor)
                    .padding(CustomSize.medium.rawValue)
                    .background(Color.appPrimaryColor)
                    .cornerRadius(CustomSize.xxLarge.rawValue)
            }
        }
    }

    private var JobTypeSelectionView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: CustomSize.medium.rawValue) {
                ForEach(viewModel.jobEmploymentTypes, id: \.rawValue) { jobType in
                    NavigationLink {
                        JobListView(viewModel: .init(String(jobType.rawValue.filter { !" -".contains($0) })))
                    } label: {
                        Text(jobType.rawValue)
                            .font(.poppins(.medium, size: .medium))
                            .padding(.vertical, CustomSize.xSmall.rawValue)
                            .padding(.horizontal, CustomSize.medium.rawValue)
                            .foregroundColor(.appGray2Color)
                            .overlay(
                                RoundedRectangle(cornerRadius: CustomSize.xxLarge.rawValue)
                                    .strokeBorder(Color.appGray2Color, lineWidth: 1)
                            )
                    }
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

                NavigationLink {
                    JobListView(viewModel: .init(String(name.filter { !" ".contains($0) })))
                } label: {
                    Text(NSLocalizedString("showAll", comment: ""))
                        .font(.poppins(.medium, size: .medium))
                        .foregroundColor(.appGrayColor)
                }
            }

            if name == JobType.popularJobs.rawValue {
                PopularJobsList
            } else {
                NearbyJobsList
            }
        }
    }
    
    private var PopularJobsList: some View {
        Group {
            if viewModel.popularJobs.count > 0 {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: CustomSize.medium.rawValue) {
                            ForEach(viewModel.popularJobs, id: \.jobID) { job in
                                NavigationLink {
                                    JobDetailsView(jobDetails: job)
                                } label: {
                                    PopularJobsRowView(jobDetails: job)
                                }
                            }
                        }
                    }
                }
            } else if viewModel.isFetchingData {
                ActivityIndicatorView()
            } else {
                EmptyStateView(
                    content: $viewModel.popularJobsEmptyStateContent,
                    retryAction: {
                        viewModel.fetchJobs(type: JobType.popularJobs.rawValue, completion: { })
                    }
                )
            }
        }
    }

    private var NearbyJobsList: some View {
        Group {
            if viewModel.nearByJobs.count > 0 {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: CustomSize.medium.rawValue) {
                            ForEach(viewModel.nearByJobs, id: \.jobID) { job in
                                NavigationLink {
                                    JobDetailsView(jobDetails: job)
                                } label: {
                                    NearbyJobsRowView(jobDetails: job)
                                }
                            }
                        }
                    }
                }
            } else if viewModel.isFetchingData {
                ActivityIndicatorView()
            } else {
                EmptyStateView(
                    content: $viewModel.nearByJobsEmptyStateContent,
                    retryAction: {
                        viewModel.fetchJobs(type: JobType.nearbyJobs.rawValue, completion: { })
                    }
                )
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
