//
//  ViewController.swift
//  CalculadoraIMC
//
//  Created by Tecsup on 16/09/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weigthTextField: UITextField!
    
    
    @IBOutlet weak var heighTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "Introduce tu Peso y Altura"
    }

    @IBAction func CalcularResultado(_ sender: Any) {
        //Obtener los valores de  peso y altura
        let weigth = Double(weigthTextField.text ?? "") ?? 0
        let heigh = Double(heighTextField.text ?? "") ?? 0
        
        //Verificar si los valores de entrada son válidos
        if weigth == 0 || heigh == 0 {
            resultLabel.text = "Por favor introduce valores válidos"
            return
        }
        
        //Calcular el IMC (usamos la formula estandar)
        let bmi =  weigth / (heigh * heigh)
        
        //Determinar si el peso es adecuado segun el IMC
        var status = ""
        if bmi < 18.5 {
            status = "Bajo peso"
        } else if bmi < 24.9 {
            status = "Peso saludable"
        } else if bmi < 34.9 {
            status = "Sobrepeso"
        } else {
            status = "Obeso"
        }
        
        //Mostrar el resultado
        resultLabel.text = "Tu IMC es \(String(format: "%.2f", bmi)) y tu estado es \(status)"
    }
    
}

