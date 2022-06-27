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
    
    @IBOutlet weak var itensTableView: UITableView?
    
    //MARK: - Atributos
    var delegate: AddRefeicaoDelegate?
    var itens: [Item] = [Item(nome: "Molho", calorias: 200.0)]
    var itemSelecionado: [Item] = []
    
    //MARK: - IBOutlets
    
    @IBOutlet var nomeTextField: UITextField?
    @IBOutlet var felicidadeTextField: UITextField?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionarItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        navigationItem.rightBarButtonItem = botaoAdicionarItem
    
        do{
            guard let diretorio = recuperaDiretorio() else{return}
            let dados = try Data(contentsOf: diretorio)
            
           let itensSalvos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as! [Item]
            itens = itensSalvos
            
        } catch{
            print(error.localizedDescription)
        }
        
    }
    
    @objc func adicionarItem() {
        let adicionaItemViewController = AddViewController(delegate: self)
        navigationController?.pushViewController(adicionaItemViewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        
        if let itensTableView = itensTableView {
            itensTableView.reloadData()
        } else {
            Alerta(controller: self).exibe(title: "Desculpe", mensagem: "Não foi possivel atualizar a tabela")
        }
        do {
            let dados = try NSKeyedArchiver.archivedData(withRootObject: itens, requiringSecureCoding: false)
            guard let caminho = recuperaDiretorio() else {return }
            try dados.write(to: caminho)
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func recuperaDiretorio() -> URL? {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return nil}
        let caminho = diretorio.appendingPathComponent("itens")
        
        return caminho
        
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
    
    func recuperaRefeicao() -> Refeicao? {
        guard let nomeDaRefeicao = nomeTextField?.text else {
            Alerta(controller: self).exibe(title: "Atenção", mensagem: "Erro ao ler o campo nome")
            return nil
        }
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            Alerta(controller: self).exibe(title: "Atenção", mensagem: "Erro ao ler o campo satisfação")
            return nil
        }
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade,itens: itemSelecionado)
        
        refeicao.itens = itemSelecionado
        
        return refeicao
    
        
    }
    
    //MARK: - IBActionS
    
    @IBAction func adicionar(_ sender: Any) {
        
        if let refeicao = recuperaRefeicao() {
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)
        } else {
            Alerta(controller: self).exibe(title: "Alerta", mensagem: "Erro ao ler")
        }
    }
}

