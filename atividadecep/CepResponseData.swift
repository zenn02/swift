//
//  CepResponseData.swift
//  atividadecep
//
//  Created by COTEMIG on 26/06/23.
//

import Foundation
struct CepResponseData: Codable{
let cep,
    logradouro,
    complemento,
    bairro,
    localidade,
    uf,
    ibge,
    gia,
    ddd,
    siafi: String?

public func toString() -> String {
    return "\(cep!) -> \(logradouro!), \(bairro!), \(localidade!) \(uf!), DDD: \(ddd!)"
}
}
