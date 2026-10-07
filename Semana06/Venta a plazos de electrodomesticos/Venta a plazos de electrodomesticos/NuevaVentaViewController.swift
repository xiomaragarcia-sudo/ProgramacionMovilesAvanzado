//
//  NuevaVentaViewController.swift
//  Venta a plazos de electrodomesticos
//
//  Created by Tecsup on 7/10/26.
//

import UIKit

class NuevaVentaViewController: UIViewController {

    @IBOutlet weak var electrodomesticoTextField: UITextField!
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var cantidadTextField: UITextField!
    @IBOutlet weak var mesesTextField: UITextField!
    @IBOutlet weak var interesTextField: UITextField!

    @IBAction func calcularTapped(_ sender: UIButton) {
        guard let precio = Double(precioTextField.text ?? ""),
              let cantidad = Double(cantidadTextField.text ?? ""),
              let meses = Double(mesesTextField.text ?? ""),
              let tasa = Double(interesTextField.text ?? ""),
              meses > 0 else {
            let alerta = UIAlertController(title: "Datos inválidos",
                                           message: "Revisa los campos numéricos.",
                                           preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .default))
            present(alerta, animated: true)
            return
        }

        let venta = VentaModel()
        venta.subtotal = precio * cantidad
        venta.igv = venta.subtotal * 0.18
        venta.base = venta.subtotal + venta.igv
        venta.intereses = venta.base * (tasa / 100) * meses
        venta.total = venta.base + venta.intereses
        venta.cuota = venta.total / meses

        performSegue(withIdentifier: "showResultado", sender: venta)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultado" {
            let destino = segue.destination as! ResultadoViewController
            destino.venta = sender as? VentaModel
        }
    }
}
