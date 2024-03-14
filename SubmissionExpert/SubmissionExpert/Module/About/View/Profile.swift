//
//  Profile.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 05/03/24.
//

import SwiftUI

struct Profile: View {

    var body: some View {
        VStack(alignment: .center) {
            Image(uiImage: UIImage(imageLiteralResourceName: "profile"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
            Text("Galah Seno Adjie")
        }
    }
}
