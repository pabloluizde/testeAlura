//
//  RemoveReficaoViewController.swift
//  testeAlura
//
//  Created by Pablo Luiz on 24/06/22.
//

import UIKit


class RemoveRefeicaoViewController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(_ refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        
        let botaoCancelar = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        let botaoRemover = UIAlertAction(title: "remover", style: .destructive, handler: handler)
        alerta.addAction(botaoRemover)
        
        alerta.addAction(botaoCancelar)
        
        controller.present(alerta, animated: true, completion: nil)
    }
}
