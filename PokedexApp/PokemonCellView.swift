//
//  PokemonCellView.swift
//  PokedexApp
//
//  Created by KingGhidorah01 on 11/03/24.
//

import SwiftUI
struct PokemonCellView: View {
    let pokemon: PokemonModel
    let viewModel: PokemonViewModel
    var body: some View {
        ZStack{
            Rectangle().foregroundColor(viewModel.getColorBassedOnType(type: pokemon.type))
                .cornerRadius(25)
            VStack{
                AsyncImage(url: URL(string: pokemon.imageUrl)) { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .shadow(radius: 12)
                
                Text(pokemon.name)
                    .font(.body)
                    .foregroundColor(.white)
            }
        }
    }
}
