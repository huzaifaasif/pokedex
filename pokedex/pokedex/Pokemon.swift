//
//  Pokemon.swift
//  pokedex
//
//  Created by Huzaifa Asif on 2017-08-24.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import Foundation

class Pokemon {
    var _name:String!
    var _pokedexId:Int!
    
    init(name:String, pokedexId:Int){
        self._name = name
        _pokedexId = pokedexId
    }
    
    var name:String{
        return _name
    }
    
    var pokedexId:Int{
        return _pokedexId
    }
    
    
}
