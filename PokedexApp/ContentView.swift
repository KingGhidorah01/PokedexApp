//
//  ContentView.swift
//  PokedexApp
//
//  Created by KingGhidorah01 on 11/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = PokemonViewModel()
    @State private var pokemonToSearch = ""
    
    private let numberOfColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: numberOfColumns){
                    ForEach(viewModel.fileterdPokemon, id: \.self) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)){
                            PokemonCellView(pokemon: pokemon, viewModel: viewModel)
                        }
                    }
                }.padding(20)
            }//Scroll
            .searchable(text: $pokemonToSearch, prompt: "Search pokemon")
            .onChange(of: pokemonToSearch, { oldValue, newValue in
                withAnimation{
                    viewModel.filterPokemon(name: newValue)
                }
            })
            .navigationBarTitle("Pokedex", displayMode: .inline)
        }
    }
}

#Preview {
    ContentView()
}

