from Core.Conexion import Conexion

class Base():
	sql={}
	sql[1]="1"
	
	def __init__(self):

		connect=Conexion("Test","postgres","6374","localhost")
		for campo in self.sql:
			connect.query("uno")
			connect.execute()
		#campos=("Nombre","Grupo")
		#campos_where={"Nombre":"jesus"}
		#connect.select("Alumno",campos,campos_where)

base=Base()