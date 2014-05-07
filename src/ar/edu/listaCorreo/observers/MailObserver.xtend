package ar.edu.listaCorreo.observers

import ar.edu.listaCorreo.observers.PostObserver
import ar.edu.listaCorreo.Postimport ar.edu.listaCorreo.senders.MessageSender
import ar.edu.listaCorreo.senders.Mail

class MailObserver implements PostObserver {
	MessageSender messageSender

	new(MessageSender pMessageSender) {
		messageSender = pMessageSender
	}

	override send(Post post) {
		val lista = post.destino
		var mailsDeDestino = lista.getMailsDestino(post).join(",")
		var mail = new Mail
		mail.from = post.emisor.mail
		mail.titulo = "[" + lista.encabezado + "] nuevo post"
		mail.message = post.mensaje
		mail.to = mailsDeDestino
		messageSender.send(mail)
	}

}
