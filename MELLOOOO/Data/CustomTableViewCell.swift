//
//  CustomTableViewCell.swift
//  MELLOOOO
//
//  Created by COTEMIG on 19/08/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblSubtitulo: UILabel!
    @IBOutlet weak var lblDetalhe: UILabel!
    @IBOutlet weak var lblOutro: UILabel!
    
    func popularDados(item: FraseMotResponse){
        lblTitulo.text = item.toString()
    }
}
