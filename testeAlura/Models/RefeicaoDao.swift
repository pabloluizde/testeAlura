//
//  RefeicaoDao.swift
//  testeAlura
//
//  Created by Pablo Luiz on 27/06/22.
//

import Foundation


class RefeicaoDao {
    
    func save(_ refeicoes: [Refeicao]) {
        guard let caminho = recuperaCaminho() else {return}
        
        do{
            let dados = try NSKeyedArchiver.archivedData(withRootObject: refeicoes, requiringSecureCoding: false)
            try dados.write(to: caminho)
        } catch {
            print(error.localizedDescription)
        }}
        
        func recuperaCaminho() -> URL? {
            guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return nil}
            let caminho = diretorio.appendingPathComponent("refeicao")
             return caminho
        }
    func recupera() -> [Refeicao] {
        guard let caminho = recuperaCaminho() else {return []}
        
        do {
            let dados = try Data(contentsOf: caminho)
            guard let refeicaoSalva = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dados) as? Array<Refeicao> else {return []}
            return refeicaoSalva
        } catch {
            print(error.localizedDescription)
            return []
        }}
    
}
