//
//  segundaViewController.swift
//  MELLOOOO
//
//  Created by COTEMIG on 19/08/23.
//

import UIKit

class SegundaViewController: UIViewController {
    
    var ocupado = false
    var delegate: FraseMotResponseProtocol?
    private var fraseData: FraseMotResponse? = nil
    @IBOutlet weak var btnSalva: UIButton!
    
    @IBOutlet weak var Resultado: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSalvar.isEnabled = false
     
    }

    @IBAction func consultar(_ sender: Any) {
          self.btnSalvar.isEnabled = false
                 self.fraseData = nil
                 campoResultado.text = " "

                 if ocupado {
                     return
                 }

                 ocupado = true
                 
                 let url = "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en"


                 if let customURL = URL(string: url) {
                     let request = URLSession.shared

                     request.dataTask(with: customURL) { [weak self] data, response, error in
                         guard let self = self else {
                             return
                         }

                         if let erro = error {
                             self.campoResultado.text = "Erro na requisição"
                         } else {
                             if let dados = data {
                                 do {
                                     let item = try JSONDecoder().decode(FraseMotResponse.self, from: dados)
                                     self.fraseData = item

                                     DispatchQueue.main.async { [weak self] in
                                         guard let self = self else { return }
                                         self.campoResultado.text = item.toString()
                                         self.btnSalvar.isEnabled = true
                                     }
                                 } catch {
                                     self.campoResultado.text = "Erro no parsing"
                                 }
                             }
                         }

                         self.ocupado = false
                     }.resume()
                 } else {
                     self.ocupado = false
                 }
             }

    
    
   
    @IBAction func salvar(_ sender: Any) {
            if let item = self.fraseData,
                      let localDelegate = self.delegate {
                      localDelegate.salvar(item: item)
                      self.navigationController?.popViewController(animated: true)
                  }
              }
          }

