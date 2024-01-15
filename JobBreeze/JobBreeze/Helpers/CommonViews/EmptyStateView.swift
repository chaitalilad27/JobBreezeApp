//
//  EmptyStateView.swift
//  NewsFlasher
//
//  Created by Chaitali Lad on 13/07/23.
//

import SwiftUI

enum EmptyStateContent {
    case noInternet
    case noDataAvailable
    case somethingWentWrong
    case custom(title: String, message: String, imageName: String, buttonTitle: String)
    case none

    var title: String {
        switch self {
        case .noInternet:
            return "No Internet!"
        case .noDataAvailable, .somethingWentWrong:
            return "Oops!"
        case .custom(let title, _, _, _):
            return title
        case .none:
            return ""
        }
    }

    var message: String {
        switch self {
        case .noInternet:
            return "There is no internet connection\nPlease try again"
        case .noDataAvailable:
            return "No data found"
        case .somethingWentWrong:
            return "Something went wrong\nPlease try again"
        case .custom(_, let message, _, _):
            return message
        case .none:
            return ""
        }
    }

    var imageName: String {
        switch self {
        case .noInternet:
            return "noInternet"
        case .noDataAvailable:
            return "noDataFound"
        case .somethingWentWrong:
            return "apiError"
        case .custom(_, _, let imageName, _):
            return imageName
        case .none:
            return ""
        }
    }

    var buttonTitle: String {
        switch self {
        case .noInternet, .somethingWentWrong:
            return "Try again"
        case .noDataAvailable:
            return "Refresh"
        case .custom(_, _, _, let buttonTitle):
            return buttonTitle
        case .none:
            return ""
        }
    }
}

struct EmptyStateView: View {
    @Binding var content: EmptyStateContent
    let retryAction: () -> Void
    let contentWidth = UIScreen.main.bounds.width - 50
    private let imageSize: CGFloat = UIScreen.main.bounds.width * 0.53

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()

            Text(content.title)
                .font(.poppins(.bold, size: CustomSize.xLarge))
                .foregroundColor(Color.appPrimaryColor)

            Text(content.message)
                .frame(width: contentWidth)
                .font(.poppins(.regular, size: CustomSize.large))
                .foregroundColor(Color.appGrayColor)
                .multilineTextAlignment(.center)

            Image(content.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)

            Button(action: retryAction) {
                Text(content.buttonTitle)
                    .font(.poppins(.regular, size: CustomSize.large))
                    .foregroundColor(Color.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 25)
            }
            .background(Color.appPrimaryColor)
            .cornerRadius(.infinity)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
