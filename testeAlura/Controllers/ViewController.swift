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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var itensTableView: UITableView!
    
    //MARK: - Atributos
    var delegate: AddRefeicaoDelegate?
    var itens: [Item] = [Item(nome: "Molho", calorias: 200.0),Item(nome: "Queijo", calorias: 200.0),Item(nome: "Pimenta", calorias: 200.0)]
    var itemSelecionado: [Item] = []
    
    //MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionarItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionarItem
    }
    
    @objc func adicionarItem() {
        let adicionaItemViewController = AddViewController(delegate: self)
        navigationController?.pushViewController(adicionaItemViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        itensTableView.reloadData()
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else {return}
        
        
        if celula.accessoryType == .none{
            celula.accessoryType = .checkmark
            
            let linhaDeTabela = indexPath.row
            itemSelecionado.append(itens[linhaDeTabela])
        } else {
            celula.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let positions = itemSelecionado.index(of: item){
                itemSelecionado.remove(at: positions)
            }
        }
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        let linhaDeTabelas = indexPath.row
        let item = itens[linhaDeTabelas]
        celula.textLabel?.text = "Ingrediente: \(item.nome)"
        celula.detailTextLabel?.text = "Caloria: \(item.calorias)"
        
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
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade,itens: itemSelecionado)
        
        refeicao.itens = itemSelecionado
        print("comi \(refeicao.nome) e fiquei com a satisfação: \(refeicao.felicidade)")
        
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
}

