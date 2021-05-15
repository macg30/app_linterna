//
//  ViewController.swift
//  U02PG AHORCADO
//
//  Created by C2JHC8 on 02/05/2021.
//

import UIKit

class ViewController: UIViewController {
    // Carácterísticas
    @IBOutlet weak var imagenDeArbol: UIImageView!
    @IBOutlet weak var etiquetaDePalabraCorrecta: UILabel!
    @IBOutlet weak var etiquetaDePuntuación: UILabel!
    @IBOutlet var colecciónDeEtiquetasDeLetras: [UIButton]!
    let alfabetoInglés = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var colecciónDeColores = ["AMARILLO", "AZUL", "GRIS", "ROJO", "VERDE"]
    let movimientosIncorrectosPermitidos = 5
    var rondasGanadas = 0 {
        didSet {
            if colecciónDeColores.isEmpty {
                etiquetaDePalabraCorrecta.text = "¡Juego terminado!"
                if let colección = colecciónDeEtiquetasDeLetras {
                    for letra in colección {
                        letra.isEnabled = false
                    }
                }
            } else {
                nuevaRonda()
            }
        }
    }
    var rondasPerdidas = 0 {
        didSet {
            if colecciónDeColores.isEmpty {
                etiquetaDePalabraCorrecta.text = "¡Juego terminado!"
                if let colección = colecciónDeEtiquetasDeLetras {
                    for letra in colección {
                        letra.isEnabled = false
                    }
                }
            } else {
                nuevaRonda()
            }
        }
    }
    var rondaActual: Juego!
    
    
    
    // Comportamientos
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /* Se ponen los textos de los títulos de las
        etiquetas con las letras del abecedario inglés */
        if let colección = colecciónDeEtiquetasDeLetras {
            for (índice, etiquetaDeLetra) in colección.enumerated() {
                etiquetaDeLetra.setTitle(String(alfabetoInglés[alfabetoInglés.index(alfabetoInglés.startIndex, offsetBy: índice)]), for: .normal)
            }
        }
        nuevaRonda()
    }
    @IBAction func letraPresionada(_ sender: UIButton) {
        sender.isEnabled = false
        rondaActual.usuarioAdivinaLaLetra((Character(sender.title(for: .normal)!.uppercased())))
        actualizarEstadoDelJuego()
    }
    func nuevaRonda() {
        if let colección = colecciónDeEtiquetasDeLetras {
            for letra in colección {
                letra.isEnabled = true
            }
        }
        rondaActual = Juego(palabra: colecciónDeColores.removeFirst(), movimientosIncorrectosRestantes: movimientosIncorrectosPermitidos, colecciónDeLetrasAdivinadas: [])
        actualizarIU()
    }
    func actualizarIU() {
        imagenDeArbol.image = UIImage(named: "Tree \(rondaActual.movimientosIncorrectosRestantes)")
        etiquetaDePalabraCorrecta.text = rondaActual.palabraFormateada
        etiquetaDePuntuación.text = "Rondas ganadas: \(rondasGanadas) - Rondas perdidas: \(rondasPerdidas)"
    }
    func actualizarEstadoDelJuego() {
        if rondaActual.movimientosIncorrectosRestantes == 0 {
            rondasPerdidas += 1
        } else if rondaActual.palabra == rondaActual.palabraFormateada {
            rondasGanadas += 1
        } else {
            actualizarIU()
        }
    }
}
