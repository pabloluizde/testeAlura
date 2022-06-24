//
//  RefeicoesTableViewController.swift
//  testeAlura
//
//  Created by Pablo Luiz on 08/06/22.
//

import Foundation
import UIKit


class RefeicoesTableViewController: UITableViewController, AddRefeicaoDelegate{
    
    var refeicoes = [Refeicao(nome: "Macarrao", felicidade: 5, itens: [])]
    
    override func viewDidLoad() {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicaoSalva = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else {return}
            refeicoes = refeicaoSalva
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = "Prato: \(refeicao.nome)"
        celula.detailTextLabel?.text = "Satisfação: \(refeicao.felicidade)"
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            
            guard let indexPath = tableView.indexPath(for: celula) else {
                return
            }
            let refeicao = refeicoes[indexPath.row]
            
            
            RemoveRefeicaoViewController(controller: self).exibe(refeicao, handler: {alert in self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
        }
    }
    
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
        let caminho = diretorio.appendingPathComponent("refeicao")
        
        do{
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }
       
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            viewController.delegate = self
        }
    }
}
