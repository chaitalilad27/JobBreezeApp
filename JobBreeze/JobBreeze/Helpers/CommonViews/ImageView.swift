//
//  ImageView.swift
//  JobBreeze
//
//  Created by Chaitali Lad on 13/07/23.
//

import SwiftUI
import Kingfisher

struct ImageView: View {
    // URL of the image
    let imageURL: String

    // Fade duration of the image view
    let fadeDuration: TimeInterval = 0.25

    // Placeholder of the image
    let placeHolderImageName: String

    // Size of the image view
    let size: CGFloat

    // Size of the placeholder image
    let placeholderImageSize: CGFloat

    // Corner radius of the image view
    let cornerRadius: CGFloat

    var body: some View {
        KFImage.url(URL(string: imageURL))
            .placeholder({
                Image(placeHolderImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: placeholderImageSize, height: placeholderImageSize)
            })
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: fadeDuration)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .padding(5)
            .background(Color.appWhiteColor)
            .cornerRadius(cornerRadius)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Costco_Wholesale_logo_2010-10-26.svg/2560px-Costco_Wholesale_logo_2010-10-26.svg.png", placeHolderImageName: "", size: 50, placeholderImageSize: 40, cornerRadius: 12)
    }
}
