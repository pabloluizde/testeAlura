//
//  RefeicoesTableViewController.swift
//  testeAlura
//
//  Created by Pablo Luiz on 08/06/22.
//

import Foundation
import UIKit


class RefeicoesTableViewController: UITableViewController{
    
    let refeicoes = [Refeicao(nome: "Macarrao", felicidade: 5), Refeicao(nome: "Temaki", felicidade: 5), Refeicao(nome: "Bife", felicidade: 5)]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
        return celula
    }
}
