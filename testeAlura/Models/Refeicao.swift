//
//  Refeicao.swift
//  testeAlura
//
//  Created by Pablo Luiz on 01/06/22.
//

import UIKit

class Refeicao: NSObject {
    var nome: String
    var felicidade: Int
    var itens: Array<Item> = []
    
    init(nome: String, felicidade: Int, itens: [Item]) {
        self.nome = nome
        self.felicidade = felicidade
        self.itens = itens
    }
    
    func totalDeCalorias() -> Double{
        var total = 0.0
        
        for item in itens {
            total += item.calorias
        }
        return total
    }
}
