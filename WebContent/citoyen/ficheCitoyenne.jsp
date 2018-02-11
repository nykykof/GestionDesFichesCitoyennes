
<%@ page import="java.util.*"%>
<%@ page import="utile.DateBean"%>
<%@ page import="java.sql.*"%>
<%@ include file="ouvreBase2.jsp"%>
<jsp:useBean id="laDate" class="utile.DateBean" scope="session" />
<!DOCTYPE HTML >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Demande Citoyenne Mairie Loc-Maria-Plouzanéé</title>
<link type="text/css" href="../style/deco.css" rel="stylesheet">
</head>
<style>
	.tableauReponse table,.tableauReponse th,.tableauReponse tr,.tableauReponse td{
	
		border:1px solid black;
		border-collapse: collapse;
	}
</style>
<body class="CaseGrise">
	<%@ include file="accesmenuFiche.jspf"%>
	<%  
int numFiche =    Integer.parseInt( request.getParameter("numeroDemande") );  
String nom= (String)session.getAttribute("nom");
String identifiant= (String)session.getAttribute("identifiant");
String mail=(String)session.getAttribute("mail");
String dateDemande = laDate.getJour() + "/" + laDate.getMois() + "/" + laDate.getAnnee();


%>
	<%@ include file="ligneIdentification.jspf"%>



	<!-- 
*  recherche des caractéristiques de la fiche dans la base 
-->

	<% 
 ResultSet rs = null;
 PreparedStatement pst = null;
 pst = conn1.prepareStatement("select * from fiche where id=?");
 pst.setInt(1, numFiche);
 rs = pst.executeQuery();
 rs.next();
 %>
<br/>
	<table style="width: 800px;" class="Casebleu">
		<tr>
			<td width="100" class="Casebleu1">
				<p>
					<b> Objet : </b>
				</p>
			</td>
			<!-- 
*              affichage  objet
-->
			<td><%=rs.getString("objet")%></td>
		</tr>
	</table>
	<p>Détail de votre demande</p>
	<table style="width: 800px;"class="Casebleu">
		<tr>

			<td>La date de création:</td>
			<td><%=rs.getString("datedemande")%></td>
		</tr>
		<tr>
			<!-- 
* et affichage  description et réponse
-->
			<td>Description:</td>
			<td><%=rs.getString("description")%></td>
		</tr>
	</table>
	<br/>
<% 
/**
	Partie de gestion du pseudo forum
*/
String reponse = request.getParameter("reponse");
String valider = request.getParameter("valider");
 int Fiche = Integer.parseInt(request.getParameter("numeroDemande"));
 if ( (valider != null) && (reponse != null) && (reponse.trim()!=null))  { 
	 
	  PreparedStatement pstselect = null;
	  ResultSet rsetselect = null;
	  /*
	  * on verifie que la reponse à insérer n'existait pas deja
	  */
	  pstselect = conn1.prepareStatement("select id from reponse where fiche = ? and texte=?");
	  pstselect.setInt(1, Fiche);
	  pstselect.setString(2, reponse);
	  rsetselect= pstselect.executeQuery();
	  if(!rsetselect.next()){
		 PreparedStatement pstinsert = null;
		 pstinsert= conn1.prepareStatement("INSERT INTO  reponse(fiche,datereponse,texte) VALUES(?,NOW(),?)"); 	 
		 pstinsert.setInt(1,Fiche);
		 pstinsert.setString(2,reponse);
		 pstinsert.executeUpdate();
	  }
	 
 } 

/*
	affichage des reponses existant en base
*/
 ResultSet rset = null;
 PreparedStatement pstreponse = null;
 pstreponse = conn1.prepareStatement("select * from reponse where fiche=?");
 pstreponse.setInt(1, numFiche);
 rset = pstreponse.executeQuery();
 // variable pour savoir si une fiche à deja reçu une reponse des administrateurs
 boolean aUneReponse = false;
 %>
	<table style="width: 800px;" class="tableauReponse">
		<tr>

			<th>Id</th>
			<th>Contenu de la reponse</th>
			<th>Date de la reponse</th>
		</tr>
		<% while(rset.next()){  aUneReponse = true;%>	
			<tr>	
				<td><%=rset.getInt("id")%></td>
				<td><%=rset.getString("texte")%></td>
				<td><%=rset.getString("datereponse")%></td>
			</tr>
		<%} %>
	</table>
	<% 
	// si la fiche n'a pas encore été traitée, l'auteur ne peut pas apporter de commentaire
	if(aUneReponse){ %>
	<form >
		<input type="hidden" name="numeroDemande" value="<%=numFiche%>">
		<table border="1" width="800" class="">
		<br/>
		<caption> Réagir à la reponse de l'administrateur</caption>
			<tr>
				<td colspan="2">Ecrivez votre reponse:</td>
			</tr>
			<tr>
				<td colspan="2"><textarea rows="10" cols="100" name="reponse"></textarea></td>
				
			</tr>
			<tr>
				</td>
				<td><input type="submit" value="Validez" name="valider"></td>
			</tr>
		</table>
	</form>
	<%}
	
	
	 
	/*  System.out.println(reponse);
	 System.out.println(valider);
	 System.out.println(request.getParameter("numeroDemande")); */
	%>
</body>
</html>
