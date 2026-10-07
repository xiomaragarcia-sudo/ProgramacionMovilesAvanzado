//
//  ResultadoViewController.swift
//  Venta a plazos de electrodomesticos
//
//  Created by Tecsup on 7/10/26.
//

import UIKit

class ResultadoViewController: UIViewController {

    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var igvLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var interesesLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var cuotaLabel: UILabel!

    var venta: VentaModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let v = venta else { return }
        subtotalLabel.text = String(format: "S/. %.2f", v.subtotal)
        igvLabel.text = String(format: "S/. %.2f", v.igv)
        baseLabel.text = String(format: "S/. %.2f", v.base)
        interesesLabel.text = String(format: "S/. %.2f", v.intereses)
        totalLabel.text = String(format: "S/. %.2f", v.total)
        cuotaLabel.text = String(format: "S/. %.2f", v.cuota)
    }
}
