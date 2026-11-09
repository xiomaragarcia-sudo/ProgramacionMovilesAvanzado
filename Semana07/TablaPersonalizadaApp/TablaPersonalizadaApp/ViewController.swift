//
//  ViewController.swift
//  TablaPersonalizadaApp
//
//  Created by Tecsup on 14/10/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // definir los arrglos que carguen los nombres e imagenes
    var personasArreglo = ["Jaime Gomez","Juan León","Silvia Montoya","Theo Diaz","Elliot Garamendi"]
    var personasImagenarreglo = ["avatar1","avatar2","avatar3","avatar4","avatar5"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personasArreglo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "miCell", for: indexPath) as? PersonasTableViewCell else {
            return UITableViewCell()
        }
        cell.personaNombre.text = personasArreglo[indexPath.row]
        cell.PersonaImagen.image = UIImage(named: personasImagenarreglo[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alerta = UIAlertController(title: "El Docente que Selecciono es : ", message: "\(personasArreglo[indexPath.row])", preferredStyle: UIAlertController.Style.alert)
        // activar el botón OK
        alerta.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action: UIAlertAction) in
        }))
        self.present(alerta, animated: true, completion: nil)
    }
}

