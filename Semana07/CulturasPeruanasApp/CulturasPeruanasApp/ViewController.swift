//
//  ViewController.swift
//  CulturasPeruanasApp
//
//  Created by Tecsup on 19/10/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var listaCulturas: [Cultura] = [
            Cultura(nombre: "Moche", region: "La Libertad", descripcion: "Famosos por su cerámica escultórica y los huacos retratos.", imagen: UIImage(named: "moche")),
            Cultura(nombre: "Nazca", region: "Ica", descripcion: "Conocidos por los geoglifos gigantes en el desierto.", imagen: UIImage(named: "nazca")),
            Cultura(nombre: "Inca", region: "Cusco", descripcion: "La civilización más grande de América del Sur, creadores de Machu Picchu.", imagen: UIImage(named: "inca")),
            Cultura(nombre: "Chavín", region: "Áncash", descripcion: "Destacados por sus esculturas en piedra como el Lanzón Monolítico y las Cabezas Clavas.", imagen: UIImage(named: "chavin")),
            Cultura(nombre: "Paracas", region: "Ica", descripcion: "Reconocidos por sus finos mantos textiles y las trepanaciones craneanas.", imagen: UIImage(named: "paracas")),
            Cultura(nombre: "Tiahuanaco", region: "Puno / Bolivia", descripcion: "Famosos por la Puerta del Sol y sus construcciones de piedra monumental.", imagen: UIImage(named: "tiahuanaco"))
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaCulturas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "miCell", for: indexPath) as! CulturaTableViewCell
        let cultura = listaCulturas[indexPath.row]
        
        cell.culturaNombre.text = cultura.nombre
        cell.culturaImagen.image = cultura.imagen
        
        return cell
    }

    // NAVEGACIÓN Y PASO DE DATOS A PANTALLA 2
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetalle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let culturaSeleccionada = listaCulturas[indexPath.row]
                let destinoVC = segue.destination as! DetalleCulturaViewController
                destinoVC.cultura = culturaSeleccionada
            }
        }
    }
}

