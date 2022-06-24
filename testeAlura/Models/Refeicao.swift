//
//  Refeicao.swift
//  testeAlura
//
//  Created by Pablo Luiz on 01/06/22.
//

import UIKit

class Refeicao: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(felicidade, forKey: "felicidade")
        aCoder.encode(itens, forKey: "itens")
    }
    
    required init?(coder aDecoder: NSCoder) {
        nome = aDecoder.decodeObject(forKey: "nome") as! String
        felicidade = aDecoder.decodeInteger(forKey: "felicidade")
        itens = aDecoder.decodeObject(forKey: "itens") as! Array<Item>
    }
    
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
    
    func detalhes() -> String {
        var mensagem = "Satisfação: \(felicidade)"
        
        for item in itens {
            mensagem += ", \(item.nome) - Calorias: \(item.calorias)"
        }
        return mensagem
    }
}
