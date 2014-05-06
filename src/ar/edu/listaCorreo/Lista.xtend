package ar.edu.listaCorreo

import java.util.ArrayList
import java.util.List
import ar.edu.listaCorreo.suscripcion.TipoSuscripcion
import ar.edu.listaCorreo.suscripcion.SuscripcionAbierta
import ar.edu.listaCorreo.suscripcion.SuscripcionCerrada

class Lista {
	@Property List<Miembro> miembros
	@Property TipoEnvio tipoEnvio
	@Property String encabezado
	@Property TipoSuscripcion tipoSuscripcion
	
	/**
	 * CONSTRUCTORES
	 
	 */
	 
	/** Constructor default: toda lista es abierta */
	new() {
		miembros = new ArrayList<Miembro>
		tipoEnvio = new ListaAbierta
		tipoSuscripcion = new SuscripcionAbierta
	}
	
	def static Lista listaAbierta() {
		new Lista
	}	

	def static Lista listaCerrada() {
		var lista = new Lista
		lista.tipoEnvio = new ListaRestringida
		lista.tipoSuscripcion = new SuscripcionCerrada
		lista
	}	

	/** 
	 * CASO DE USO: Suscripción
	 *  
	 **/
	def suscribir(Miembro miembro)  {
		tipoSuscripcion.suscribir(miembro, this)
	}
	
//  otra decisión de diseño podría ser no obligar a la lista abierta a aprobar suscripción
//  pero eso complica al test porque tiene que acceder al strategy 		
	def aprobarSuscripcion(Miembro miembro)  {
		tipoSuscripcion.aprobarSuscripcion(miembro, this)
	}
	
	def void agregarMiembro(Miembro miembro) {
		miembros.add(miembro)
	}

	/** 
	 * CASO DE USO: Envío de post
	 *  
	 **/
	def void enviar(Post post) {
		tipoEnvio.validarEnvio(post, this)
		this.getDestinatarios(post).forEach[ destinatario |
			destinatario.enviarMail(post)
		]
	}
		
	def Iterable<Miembro> getDestinatarios(Post post) {
		miembros.filter [ miembro | !miembro.equals(post.emisor) ]
	}
	
	def getMailsDestino(Post post) {
		getDestinatarios(post).map [ miembro | miembro.mail ]
	}
	
	def boolean estaSuscripto(Miembro miembro) {
		miembros.contains(miembro)	
	}
	
}