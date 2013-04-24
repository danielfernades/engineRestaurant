class Consultas:

	sql=''
	sentencias={}

	def __init__(self):
		self.sql='default'
		self.sentencias= {"Seleccionar":"SELECT ",
					  "donde":" WHERE ",
					  "insertar":" INSERT INTO ",
					  "ignorar":" INSERT IGNORE INTO ",
					  "valores":" VALUES ",
					  "actualizar":"UPDATE ",
					  "limite":" LIMIT ",
					  "orden":" ORDER BY ",
					  "join":" INNER JOIN ",
					  "distinto":"SELECT DISTINCT ",
					  "entre":" BETWEEN ",
					  "patron":" LIKE ",
					  "dentro":" IN ",
					  "borrar":"DELETE FROM "
					  }
	

	def select(self,tabla,campos,where):
		self.sql=self.sentencias["Seleccionar"]
		self.separador(campos,",")
		self.sql+=' FROM '+tabla
		if len(where)!=0:
			self.sql+=self.sentencias["donde"]
			self.asociar(where," AND ")


	def distinto(self,tabla,campos,where):
		self.sql+=self.sentencias["distinto"]
		self.separador(campos,",")
		self.sql+=' FROM '+tabla
		if len(where)!=0:
			self.sql+=self.sentencias["donde"]
			self.asociar(where," AND ")


	def date(self,fecha,fechaInicio,fechaFinal,inicio):
		if inicio==true:
			self.sql+=self.sentencias['donde']
		else:
			self.sql+=" AND "
		self.sql+=fecha
		self.sql+=self.sentencias['entre']
		self.sql+=fechaInicio
		self.sql+=" AND "
		self.sql+=fechaFinal

	def like(self,campo,patron,comienzo):
		if comienzo==true:
			self.sql+=self.sentencias['donde']
		else:
			self.sql+=" AND "
		self.sql+=campo
		self.sql+=self.sentencias['patron']
		self.sql+=patron



	def asociar(self,campos,separador):
		ultimo=len(campos)
		contador=1
		for llave in campos.keys():
			if ultimo==contador:
    				self.sql+="%s = '%s'"%(llave,campos[llave])
			else:
				self.sql+="%s = %s"%(llave,campos[llave])+separador
				contador+=1


	def join(self,campos,tablas,camposjoin):
		self.sql+=self.sentencias['Seleccionar']
		self.asociar(campos)
		self.ejecucion+=" FROM "+parametros['tabla']+self.sentencias['join']+parametros['tabla2']
		self.sql+=" ON %s = %s"%(camposjoin['c1'],camposjoin['c2'])
		if len(where)!=0:
			self.sql+=self.sentencias["donde"]
			self.asociar(where," AND ")

	def delete(self,tabla,where):
		self.sql+=self.sentencias['borrar']
		self.sql+=tabla
		if len(where)!=0:
			self.sql+=self.sentencias["donde"]
			self.asociar(where," AND ")

	def whereINot(self,datos,parametros):
		if parametros['bandera']==true:
			self.sql+=self.sentencias['donde']
		else:
			self.sql+=' AND '
		self.sql+=parametros['campo']
		self.sql+=" NOT %s ("%(self.sentencias['dentro'],)
		self.separador(campos,',')
		self.sql+=')'

	def insert(self,tabla,campos):
		self.sql+="%s %s ("%(self.sentencias['insertar'],tabla)
		self.setInsert(campos)
		self.sql+="%s("%(self.sentencias['valores'])
		self.separador(campos,',')
		self.sql+=')'

	def setInsert(self,campos):
		ultimo=len(campos)
		contador=1
		for llave in campos.keys():
			if ultimo==contador:
    				self.sql+="%s)"%(llave,)
			else:
				self.sql+="%s %s"%(llave,separador)
				contador+=1

	def whereIn(datos,parametros):
		if parametros['bandera']==true:
			self.sql+=self.sentencias['donde']
		else:
			self.sql+=" AND "
		self.sql+=parametros['campo']
		self.sql+='%s('%(self.sentencias['dentro'])
		self.separadorCampos(datos,",")
		self.sql+=')'


	def separadorCampos(campos,separador):
		ultimo=len(campos)
		contador=1
		for llave in campos.keys():
			if ultimo==contador:
    				self.sql+="'%s')"%(campos[llave],)
			else:
				self.sql+="'%s' %s"%(campos[llave],separador)
				contador+=1

	def query(query):
		self.sql=query



	def execute(self):
		print self.sql
		self.sql=""

	def separador(self,campos,separador):
		ultimo=len(campos)
		contador=1
		campos_comas=''
		for campo in campos:
			if ultimo==contador:
				campos_comas+=campo
			else:
				campos_comas+=campo+separador
				contador+=1
		self.sql+=campos_comas



