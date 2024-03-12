//
//  PokemonViewModel.swift
//  PokedexApp
//
//  Created by KingGhidorah01 on 11/03/24.
//

import SwiftUI

class PokemonViewModel: ObservableObject{
    @Published var listPokemon = [PokemonModel]()
    @Published var fileterdPokemon = [PokemonModel]()
    
    init(){
        getListPokemon()
    }
    
    func getListPokemon(){
        NetworkManager.shared.getListOfPokemon{ result in
            DispatchQueue.main.async{
                switch result {
                case .success(let listPokemon):
                    print("listaPokemon: \(listPokemon.count)")
                    self.listPokemon = listPokemon
                    self.fileterdPokemon = listPokemon
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    func filterPokemon(name: String){
        if name.isEmpty{
            fileterdPokemon = listPokemon
        }else{
            fileterdPokemon = listPokemon.filter({pokemon in
                pokemon.name.lowercased().contains(name.lowercased())
            })
        }
    }
    
    func getColorBassedOnType(type: String) -> Color {
        switch type{
        case "poison":
            return .purple
        case "fire":
            return .red
        case "water":
            return .blue
        case "bug", "grass":
            return .green
        case "flying":
            return .mint
        case "normal":
            return .pink
        case "electric":
            return .yellow
        case "ground":
            return .brown
        case "fairy", "psychic", "dragon":
            return .orange
        case "fighting":
            return .gray
        case "ice", "steel":
            return .teal
        default:
            return .white
        }
    }
}
