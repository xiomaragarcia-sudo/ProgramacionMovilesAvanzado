//
//  ViewController+Relacion.swift
//  apple_lab11_01_UIKIT_CoreData
//
//  Created by Tecsup on 4/11/26.
//

import UIKit
import CoreData

extension ViewController {

    // MARK: - Paso 11: Buscar contactos por nombre
    func buscarContactos(texto: String) -> [Contacto] {
        let request: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        request.predicate = NSPredicate(format: "nombre CONTAINS[cd] %@", texto)
        request.sortDescriptors = [NSSortDescriptor(key: "nombre", ascending: true)]
        return (try? conexion().fetch(request)) ?? []
    }

    // MARK: - Paso 12: Probar relación Uno a Muchos
    func probarRelacion() {
        let contexto = conexion()
        
        let grupo = NSEntityDescription.insertNewObject(forEntityName: "Grupo", into: contexto) as! Grupo
        grupo.nombre = "Amigos"
        
        if let primero = contactos.first {
            primero.grupo = grupo
        }
        
        do {
            try contexto.save()
            print("El grupo \(grupo.nombre ?? "") tiene \(grupo.contactos?.count ?? 0) contacto(s)")
        } catch {
            print("Error al guardar la relación: \(error)")
        }
    }

    // MARK: - Paso 12: Filtrar contactos por grupo
    func contactosDelGrupo(_ nombreGrupo: String) -> [Contacto] {
        let request: NSFetchRequest<Contacto> = Contacto.fetchRequest()
        request.predicate = NSPredicate(format: "grupo.nombre == %@", nombreGrupo)
        return (try? conexion().fetch(request)) ?? []
    }

}
