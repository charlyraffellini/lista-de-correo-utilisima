package ar.edu.listaCorreo.senders

static class MailSenderProvider {
	static MessageSender sender = null
	
	def static setInstance(MessageSender aSender){
		MailSenderProvider.sender = aSender
	}
	
	def static getInstance(){
		if(MailSenderProvider.sender == null)
			MailSenderProvider.setInstance(new StubMailSender)
		
		MailSenderProvider.sender
	}
}