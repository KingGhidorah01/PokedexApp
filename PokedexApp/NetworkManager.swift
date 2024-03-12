//
//  NetworkManager.swift
//  PokedexApp
//
//  Created by KingGhidorah01 on 11/03/24.
//

import Foundation
 
enum APError: Error{
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
    
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let baseURL = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    init (){}
    func getListOfPokemon(completed: @escaping (Result<[PokemonModel], APError>) -> Void){
            guard let url = URL(string: NetworkManager.baseURL)else{
                completed(.failure(.invalidURL))
                return 
            }
            
            let task = URLSession.shared.dataTask(with: url){ data, _, error in
                guard let data = data?.parseData(removeString: "null,")else {
                    completed(.failure(.decodingError))
                    return
                }
                do{
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode([PokemonModel].self, from: data)
                    completed(.success(decodedResponse))
                }catch{
                    print("Debug: error \(error.localizedDescription)")
                    completed(.failure(.decodingError))
                }
            }
            task.resume()
        }

}


extension Data{
    func parseData(removeString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

struct MockData {
    static let pokemon = PokemonModel(id: 123, attack: 99, defense: 99, description: "There is a bud on this Pokémon’s back. To support its weight,\nIvysaur’s legs and trunk grow thick and strong.\nIf it starts spending more time lying in the sunlight,\nit’s a sign that the bud will bloom into a large flower soon.", name: "Eve", imageUrl:"https://firebasestorage.googleapis.com/v0/b/pokedex-bb36f.appspot.com/o/pokemon_images%2F62294490-1131-48DD-81E3-D328E54FAD12?alt=media&token=8aa9f6b8-3ee2-43a1-a48e-6e2218afc528", type: "poison")
}
