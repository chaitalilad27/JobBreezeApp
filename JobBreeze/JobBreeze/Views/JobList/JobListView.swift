//
//  JobListView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 12/01/24.
//

import SwiftUI
import SwiftUIPullToRefresh

struct JobListView: View {

    // MARK: - Properties

    @StateObject var viewModel: JobListViewModel

    // MARK: - Body

    var body: some View {
        VStack {
            if !viewModel.jobList.isEmpty {
                JobsScrollView
            } else if viewModel.isFetchingData {
                ActivityIndicatorView()
            } else {
                EmptyStateContentView
            }
        }
        .opacity(viewModel.isInitialFetching ? 0 : 1)
        .toast(isPresented: $viewModel.showToast, message: viewModel.toastMessage)
        .background(Color.appLightWhiteColor.ignoresSafeArea(.all))
        .navigationBarStyle(title: "")
    }

    // MARK: - Subviews

    private var JobsScrollView: some View {
        RefreshableScrollView(
            loadingViewBackgroundColor: Color.appWhiteColor,
            onRefresh: { done in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    viewModel.refreshJobList {
                        done()
                    }
                }
            }
        ) {
            JobListItemView
        }
    }

    private var JobListItemView: some View {
        VStack(spacing: CustomSize.medium.rawValue) {
            ForEach(viewModel.jobList, id: \.jobID) { job in
                NavigationLink {
                    JobDetailsView(jobDetails: job)
                } label: {
                    NearbyJobsRowView(jobDetails: job)
                        .onAppear {
                            // Fetch more news when the last news item appears
                            if viewModel.jobList.last?.jobID == job.jobID {
                                viewModel.loadMoreJobList()
                            }
                        }
                }
            }
        }
        .padding(.horizontal, 10)
    }

    private var EmptyStateContentView: some View {
        EmptyStateView(
            content: $viewModel.emptyStateContent,
            retryAction: {
                viewModel.refreshJobList {}
            }
        )
    }
}

struct JobListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JobListView(viewModel: .init(JobEmploymentType.fulltime.rawValue))
        }
    }
}
