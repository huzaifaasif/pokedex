//
//  ViewController.swift
//  pokedex
//
//  Created by Huzaifa Asif on 2017-08-24.
//  Copyright © 2017 Huzaifa Asif. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
   
    @IBOutlet weak var collection:UICollectionView!
    var pokemon = [Pokemon]()       //pokemon array
    var musicPlayer:AVAudioPlayer!
    var searchMode: Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredPokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let charmander = Pokemon(name: "Charmander", pokedexId: 4)
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        parsePokemonCSV()
        musicPlay()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func musicPlay(){
        
        let path = Bundle.main.path(forResource: "PokedexMusic", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = 5
            //musicPlayer.play()
        }
        
        catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")  //specifying the path
        
        do{
            let csv = try CSV(contentsOfURL: path!)    //storing the contents of the CSV file
            let rows = csv.rows
            
            for row in rows {
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]
                
                let pokeObject = Pokemon(name: name!, pokedexId: pokeId!)
                
                pokemon.append(pokeObject)
            }
            
            dump(pokemon)
            
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            if searchMode {
                cell.configureCell(filteredPokemon[indexPath.row])
            }
            else{
                cell.configureCell(pokemon[indexPath.row])
            }
            
            return cell
        }
        
        return UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke:Pokemon!
        
        if searchMode {
            poke = filteredPokemon[indexPath.row]
        }
        
        else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailedVC", sender: poke)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchMode{
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    @IBAction func musicButton(_ sender: UIButton) {
        
        if musicPlayer.isPlaying{
            
            sender.alpha=0.2
            musicPlayer.pause()
            
        }
        else{
            
            sender.alpha=1.0
            musicPlayer.play()
            
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            searchMode = false
            
            dismissKeyboard()
        }
        else{
            searchMode = true
            let searchBarText = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter( {$0.name.range(of: searchBarText) != nil} )
        }
        
        collection.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailedVC" {
            if let destination = segue.destination as? PokemonDetailedVC {
                if let poke = sender as? Pokemon {
                   destination.pokemon = poke
                    print("HolAaAA")
                }
            }
        }
    }
    


}

