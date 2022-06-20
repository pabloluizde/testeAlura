//
//  Alerta.swift
//  testeAlura
//
//  Created by Pablo Luiz on 20/06/22.
//

import UIKit

class Alerta {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func exibe(title: String, mensagem: String) {
        let alerta = UIAlertController(title: title, message: mensagem, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        
        alerta.addAction(ok)
        controller.present(alerta, animated: true, completion: nil)
    }
}
