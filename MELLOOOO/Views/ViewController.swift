//
//  ViewController.swift
//  MELLOOOO
//
//  Created by COTEMIG on 19/08/23.
//

import UIKit

class ViewController: UIViewController {
    let userDefault = UserDefaults.standard
   
    let chaveLista = "chaveListas"

    @IBOutlet weak var tabela: UITableView!
    var lista: [FraseMotResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tabela.dataSource = self
        tabela.delegate = self
        
        self.carregarLista()
    }

    private func carregarLista(){
            guard let dados = userDefault.value(forKey: chaveLista) as? Data else {
                    return
                }
                do {
                    let items = try JSONDecoder().decode([FraseMotResponse].self, from: dados)
                    self.lista = items
                } catch {
                    print("===> Erro carregando dados do disco")
                }
            }

    
     @IBAction func consulta(_ sender: Any) {
          let vc = SegundaViewController()
               vc.delegate = self
               self.navigationController?.pushViewController(vc, animated: true)
           }

       }


    extension ViewController: UITableViewDataSource {
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return self.lista.count
          }

          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CustomTableViewCell else {
                  return UITableViewCell()
              }
              let item = self.lista[indexPath.row]
              cell.popularDados(item: item)
              return cell
          }
      }

      extension ViewController: UITableViewDelegate {
          func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 100.0
          }
      }

      extension ViewController: FraseMotResponseProtocol {
          func salvar(item: FraseMotResponse) {
              self.lista.append(item)
              do {
                  let serializado = try JSONEncoder().encode(self.lista)
                  userDefault.setValue(serializado, forKey: chaveLista)
              } catch {
                  self.lista.removeAll(where: { $0.quoteText == item.quoteText })
              }
              self.tabela.reloadData()
          }
      }
