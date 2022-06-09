//
//  ViewController.swift
//  testeAlura
//
//  Created by Pablo Luiz on 25/05/22.
//

import UIKit

protocol AddRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Atributos
    var delegate: AddRefeicaoDelegate?
    var itens: [String] = ["Molho", "Queijo", "Pepino", "Salsa"]
    
    //MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else {return}
        
        if celula.accessoryType == .none{
            celula.accessoryType = .checkmark
        } else {
            celula.accessoryType = .none
        }
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let linhaDeTabelas = indexPath.row
        let item = itens[linhaDeTabelas]
        celula.textLabel?.text = item
        
        return celula
    }
    
    //MARK: - IBActionS
    
    @IBAction func adicionar(_ sender: Any) {

        guard let nomeDaRefeicao = nomeTextField?.text else {
            return
        }
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return
        }
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade)
        print("comi \(refeicao.nome) e fiquei com a satisfação: \(refeicao.felicidade)")
        
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
}

