//
//  Curso.swift
//  apple_lab11_02_SwiftUI_SwiftData
//
//  Created by Tecsup on 4/11/26.
//

import Foundation
import SwiftData

// DEMOSTRACIÓN: relación 1 a muchos (un Curso tiene muchos Alumnos)
@Model
class Curso {
    var nombre: String
    
    // deleteRule: qué pasa con los alumnos si se borra el curso
    //  .nullify -> los alumnos quedan sin curso
    //  .cascade -> también se borran los alumnos
    //  .deny    -> no deja borrar el curso mientras tenga alumnos
    @Relationship(deleteRule: .nullify, inverse: \Alumno.curso)
    var alumnos: [Alumno] = []
    
    init(nombre: String) {
        self.nombre = nombre
    }
}
