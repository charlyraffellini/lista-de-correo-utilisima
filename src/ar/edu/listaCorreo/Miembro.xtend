package ar.edu.listaCorreo
import ar.edu.listaCorreo.senders.MailSenderProvider
import ar.edu.listaCorreo.senders.Mail

class Miembro {
	
	@Property String mail
	@Property int mailsEnviados = 0

	new(String pMail) {
		mail = pMail
	}
		
	def void enviarMail(Post post){
		var mail = new Mail
		mail.from = post.emisor.mail
		mail.titulo = "nuevo post"
		mail.message = post.mensaje
		mail.to = this.mail
		MailSenderProvider.instance.send(mail)
	}
	
}