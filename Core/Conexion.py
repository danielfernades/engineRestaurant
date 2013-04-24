import psycopg2
from Consultas import Consultas

class Conexion(Consultas):
	bd='default'
	password='default'
	host='default'
	user='default'
	conexion='default'

	def __init__(self,base,usuario,clave,servidor):
		self.bd=base
		self.passwor=clave
		self.host=servidor
		self.user=usuario
		Consultas.__init__(self)
		sql="dbname=%s user=%s password=%s host=%s" % (base,usuario,clave,servidor)
		try:
			self.conexion = psycopg2.connect(sql)
			print "conexion exitosa"
		except Exception, e:
			print e

	def consulta(self,query):
		
		try:
			consulta=self.conexion.cursor()
			consulta.execute(query)
			self.conexion.commit()
			print "consulta exitosa"
			return true
		except Exception, e:
			print query
			print e



		



