//
//  PokemonDetaileVC.swift
//  pokedex
//
//  Created by Huzaifa Asif on 2017-08-31.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import UIKit

class PokemonDetailedVC: UIViewController {

    private var _pokemon:Pokemon!
    
    var pokemon:Pokemon{
        get{
            return _pokemon
        }
        set{
            _pokemon = newValue
        }
    }
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textLabel.text = _pokemon.name
        
    }

   

}
