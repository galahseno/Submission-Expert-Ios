//
//  GameRow.swift
//  SubmissionExpert
//
//  Created by Galah Seno on 05/03/24.
//

import SwiftUI
import CachedAsyncImage
import Home
import Shared

struct GameRowView: View {
    var gameModel: GameModel

    var body: some View {
        HStack {
            imageGame
            content
        }
    }
}

extension GameRowView {

    var imageGame: some View {
        CachedAsyncImage(url: URL(string: gameModel.backgroundImage)) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
        } placeholder: {
            ProgressView()
                .frame(maxWidth: 100, alignment: .center)
        }
        .cornerRadius(10)
        .scaledToFit()
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(gameModel.name)
                .font(.headline)
                .bold()
                .lineLimit(3)

            Text(gameModel.released)
                .font(.caption)
                .foregroundStyle(.secondary)

            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(gameModel.rating))
                    .font(.subheadline)
            }.frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
