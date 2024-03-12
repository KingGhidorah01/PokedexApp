//
//  PokemonModel.swift
//  PokedexApp
//
//  Created by KingGhidorah01 on 11/03/24.
//

import Foundation

struct PokemonModel: Codable, Hashable{
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}
                
