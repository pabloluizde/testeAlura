//
//  ViewController.swift
//  testeAlura
//
//  Created by Pablo Luiz on 25/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    var tableViewController: RefeicoesTableViewController?
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    @IBAction func adicionar(_ sender: Any) {
//        if let nomeDaRefeicao = nomeTextField?.text , let felicidadeDaRefeicao = felicidadeTextField?.text{
//            let nome = nomeDaRefeicao
//            if let felicidade = Int(felicidadeDaRefeicao) {
//                let refeicao = Refeicao(nome: nome, felicidade: felicidade)
//                print("comi \(refeicao.nome) e fiquei com a felicidade: \(refeicao.felicidade)")
//            } else {
//                print("Erro ao criar")
//            }
//        }
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return
        }
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade)
        print("comi \(refeicao.nome) e fiquei com a felicidade: \(refeicao.felicidade)")
        
        tableViewController?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
}

