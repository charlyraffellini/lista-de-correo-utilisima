package ar.edu.listaCorreo.suscripcion

import ar.edu.listaCorreo.suscripcion.TipoSuscripcion
import ar.edu.listaCorreo.Miembro
import ar.edu.listaCorreo.Lista

class SuscripcionAbierta implements TipoSuscripcion {
	
	override suscribir(Miembro miembro, Lista lista) {
		lista.agregarMiembro(miembro)
	}
	
	override aprobarSuscripcion(Miembro miembro, Lista lista) {
		throw new UnsupportedOperationException("No se deben aprobar suscripciones de listas de suscripción abierta")
	}
	
}