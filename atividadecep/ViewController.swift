//
//  ViewController.swift
//  atividadecep
//
//  Created by COTEMIG on 19/06/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtResultado: UITextView!
    
    @IBOutlet weak var txtCep: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        self.txtResultado.text = ""
        guard let cep = txtCep.text,
              !cep.isEmpty && cep.count == 8 else {
            self.txtResultado.text = "Cep é obrigatório (com 8 digitos numéricos)"
            return
        }
        if let url = URL(string:"https://viacep.com.br/ws/\(cep)/json"){
            let urlSession = URLSession.shared
            urlSession.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                if let resultData = data {
                    do {
                        let localStruct = try JSONDecoder().decode(CepResponseData.self, from: resultData)
                        DispatchQueue.main.async {
                            self.txtResultado.text = localStruct.toString()
                            
                        }
                    } catch {
                        print("==> Erro no parser da struct")
                    }
                }
                if let resultError = error {
                    print("==> Erro na requisição: \(resultError)")
                }
                
            }.resume()
        }
    }
}

