//
//  FontExtension.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 19/06/23.
//

import SwiftUI

// MARK: Font Extension
extension Font {
    enum PoppinsFont {
        case regular
        case medium
        case bold

        var value: String {
            switch self {
            case .regular:
                return "Poppins-Regular"
            case .medium:
                return "Poppins-Medium"
            case .bold:
                return "Poppins-Bold"
            }
        }
    }

    static func poppins(_ type: PoppinsFont, size: CustomSize) -> Font {
        return .custom(type.value, size: size.rawValue)
    }
}

enum CustomSize: CGFloat {
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case xxLarge

    var rawValue: CGFloat {
        switch self {
        case .xSmall:
            return 10
        case .small:
            return 12
        case .medium:
            return 16
        case .large:
            return 20
        case .xLarge:
            return 24
        case .xxLarge:
            return 32
        }
    }
}
