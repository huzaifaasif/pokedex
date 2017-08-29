//
//  PokeCell.swift
//  pokedex
//
//  Created by Huzaifa Asif on 2017-08-24.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    func configureCell(_ pokemon: Pokemon){
        nameLabel.text = pokemon.name
        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
        
        layer.cornerRadius = 5.0
    }
    
    
    
}
