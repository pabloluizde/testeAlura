//
//  Item.swift
//  testeAlura
//
//  Created by Pablo Luiz on 01/06/22.
//

import UIKit

class Item: NSObject {
    var nome: String
    var calorias: Double
    
    init(nome: String, calorias: Double){
        self.nome = nome
        self.calorias = calorias
    }
}
