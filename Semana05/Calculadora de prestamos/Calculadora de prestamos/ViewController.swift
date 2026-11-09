//
//  ViewController.swift
//  Calculadora de prestamos
//
//  Created by Tecsup on 5/10/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var montoTextField: UITextField!
    @IBOutlet weak var tasaTextField: UITextField!
    @IBOutlet weak var plazoTextField: UITextField!
    
    @IBOutlet weak var cuotaLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cuotaLabel.text = "Cuota mensual: S/ 0.00"
        totalLabel.text = "Monto total: S/ 0.00"
    }

    @IBAction func calcularPrestamo(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let montoText = montoTextField.text, let P = Double(montoText), P > 0,
              let tasaText = tasaTextField.text, let tasaAnual = Double(tasaText), tasaAnual > 0,
              let plazoText = plazoTextField.text, let anos = Double(plazoText), anos > 0 else {
            
            cuotaLabel.text = "Ingresa números válidos"
            totalLabel.text = ""
            return
        }
        
        let r = (tasaAnual / 100.0) / 12.0
        let n = anos * 12.0
        
        let factor = pow(1.0 + r, n)
        let M = P * (r * factor) / (factor - 1.0)
        let montoTotal = M * n
        
        cuotaLabel.text = String(format: "Cuota mensual: S/ %.2f", M)
        totalLabel.text = String(format: "Monto total: S/ %.2f", montoTotal)
    }
}


