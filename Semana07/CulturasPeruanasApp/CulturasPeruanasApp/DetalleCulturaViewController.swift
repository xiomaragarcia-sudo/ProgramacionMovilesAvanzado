//
//  DetalleCulturaViewController.swift
//  CulturasPeruanasApp
//
//  Created by Tecsup on 19/10/26.
//

import UIKit

class DetalleCulturaViewController: UIViewController {

    @IBOutlet weak var imgCultura: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var txtDescripcion: UILabel!
    
    var cultura: Cultura?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let c = cultura {
            lblNombre.text = c.nombre
            lblRegion.text = "Región: \(c.region)"
            txtDescripcion.text = c.descripcion
            imgCultura.image = c.imagen
        }
    }
}
