//
//  JobDetailsTabsDetailsView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 12/01/24.
//

import SwiftUI

struct JobDetailsTabsDetailsView: View {

    // MARK: - Properties

    var selectedTabType: JobDetailsTabsType
    var details: [String]?

    // MARK: - Body

    var body: some View {
        mainView
    }

    // MARK: - Subviews

    private var mainView: some View {
        Group {
            Text(titleText)
                .font(.poppins(.bold, size: .large))
                .foregroundColor(.appPrimaryColor)
                .padding(.bottom, 10)

            if let details = details {
                ForEach(details, id: \.self) { detail in
                    Text((selectedTabType != .about ? "• " : "") + detail)
                        .font(.poppins(.regular, size: .medium))
                        .foregroundColor(.appGrayColor)
                }
            } else {
                Text((selectedTabType != .about ? "N/A" : NSLocalizedString("noDataProvided", comment: "")))
                    .font(.poppins(.regular, size: .medium))
                    .foregroundColor(.appGrayColor)
            }
        }
    }


    private var titleText: String {
        switch selectedTabType {
        case .about:
            return NSLocalizedString("aboutThisJob", comment: "")
        case .qualifications:
            return NSLocalizedString("qualifications", comment: "")
        case .responsibilities:
            return NSLocalizedString("responsibilities", comment: "")
        }
    }
}

struct JobDetailsTabsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsTabsDetailsView(selectedTabType: .about, details: [""])
    }
}
