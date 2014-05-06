package ar.edu.listaCorreo

import org.junit.Before
import org.junit.Test
import org.junit.Assert

class TestSuscripcion {

	Lista listaProfes
	Lista listaAlumnos
	Miembro dodain
	Miembro nico
	Miembro deby
	Miembro alumno
	Miembro fede

	@Before
	def void init() {
		/** Listas de correo */
		listaAlumnos = Lista.listaAbierta()
		listaProfes = Lista.listaCerrada()
		/** Profes */
		dodain = new Miembro("fernando.dodino@gmail.com")
		nico = new Miembro("nicolas.passerini@gmail.com")
		deby = new Miembro("debyfortini@gmail.com")
		/** Alumnos **/
		alumno = new Miembro("alumno@uni.edu.ar")
		fede = new Miembro("fede@uni.edu.ar")
		/** en la lista de profes están los profes */
		listaProfes.agregarMiembro(dodain)
		listaProfes.agregarMiembro(nico)
		/** en la de alumnos hay alumnos y profes */
		listaAlumnos.agregarMiembro(dodain)
		listaAlumnos.agregarMiembro(fede)
	}
		
	@Test
	def void suscripcionAListaAbiertaEsAutomatica() {
		Assert.assertFalse(listaAlumnos.estaSuscripto(deby))
		listaAlumnos.suscribir(deby)
		Assert.assertTrue(listaAlumnos.estaSuscripto(deby))		
	}

	@Test
	def void suscripcionAListaCerradaNoEsAutomatica() {
		Assert.assertFalse(listaProfes.estaSuscripto(deby))
		listaProfes.suscribir(deby)
		Assert.assertFalse(listaProfes.estaSuscripto(deby))		
	}

	@Test
	def void suscripcionYAprobacionDeListaCerrada() {
		Assert.assertFalse(listaAlumnos.estaSuscripto(deby))
		listaProfes.suscribir(deby)
		listaProfes.aprobarSuscripcion(deby)		
		Assert.assertTrue(listaProfes.estaSuscripto(deby))
	}
	
	@Test(expected=typeof(UnsupportedOperationException))
	def void aprobarSuscripcionDeListaAbiertaNoTieneSentido() {
		listaAlumnos.aprobarSuscripcion(deby)		
	}
			
}