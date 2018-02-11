<%@ page import="java.util.*"%>
<%@ page import="utile.DateBean"%>
<%@ page import="java.sql.*"%>
<%@ include file="ouvreBase2.jsp"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>
<jsp:useBean id="laDate" class="utile.DateBean" scope="session" />
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Demande Citoyenne Mairie Loc-Maria-Plouzané</title>
<link type="text/css" href="../style/deco.css" rel="stylesheet">
<style>
	.fiche table,.fiche th,.fiche tr,.fiche td{
	
		border:1px solid black;
		border-collapse: collapse;
	}
</style>
</head>
<body class="CaseGrise">

	<%@ include file="accesmenuFicheAdministration.jspf"%>
	<%
		String ajoutdoc = request.getParameter("ajoutdoc");
		String docmise = request.getParameter("docmise");
		String nom = (String) session.getAttribute("nom");
		String identifiant = (String) session.getAttribute("identifiant");
		String reponse = null;
		String objet = null;
		boolean traite = false;
		String description = null;
		int numboucle = 0;
		String dateDemande = laDate.getJour() + "/" + laDate.getMois() + "/" + laDate.getAnnee();
	%>
	<%
		ResultSet rs1 = null, rs2 = null;
		Statement stmt1 = conn1.createStatement();
		Statement stmt2 = conn1.createStatement();
		rs1 = stmt1.executeQuery("select * from fiche where reponse is NULL");
		rs2 = stmt2.executeQuery("select * from fiche where reponse is not NULL ");
	%>


	<table border="1" width="800" class="Casebleu1 fiche">
		<caption>Liste des fiches non traitées</caption>
		<thead>
			<tr>
				<th>id</th>
				<th>objet</th>
				<th>date creation</th>
				<th>Actionn</th>
			</tr>
		</thead>
		<%
			int i = 0;
			while (rs1.next()) {

				if (i % 2 == 0) {
		%>
		<tr style="background-color: #eee">
			<td><%=rs1.getInt("id")%></td>
			<td><%=rs1.getString("objet")%></td>
			<td><%=rs1.getString("datedemande")%></td>
			<td><a
				href="reponseFicheCitoyenne.jsp?idFiche=<%=rs1.getInt("id")%>">repondre</a></td>
		</tr>

		<%
			} else {
		%>
		<tr style="background-color: #fff">
			<td><%=rs1.getInt("id")%></td>
			<td><%=rs1.getString("objet")%></td>
			<td><%=rs1.getString("datedemande")%></td>
			<td><a
				href="reponseFicheCitoyenne.jsp?idFiche=<%=rs1.getInt("id")%>">repondre</a></td>
		</tr>

		<%
			}

				i++;
			}
		%>
	</table>
	<br>
	<table border="1" width="800" class="Casebleu1 fiche">
		<caption>Liste des fiches traitées</caption>
		<thead>
			<tr>
				<th>id</th>
				<th>objet</th>
				<th>date creation</th>
				<th>Action</th>
			</tr>
		</thead>
		<%
			i = 0;
			while (rs2.next()) {
				if (i % 2 == 0) {
		%>
		<tr style="background-color: #eee">
			<td><%=rs2.getInt("id")%></td>
			<td><%=rs2.getString("objet")%></td>
			<td><%=rs2.getString("datedemande")%></td>
			<td><a
				href="reponseFicheCitoyenne.jsp?idFiche=<%=rs2.getInt("id")%>">repondre</a></td>
		</tr>

		<%
			} else {
		%>
		<tr style="background-color: #fff">
			<td><%=rs2.getInt("id")%></td>
			<td><%=rs2.getString("objet")%></td>
			<td><%=rs2.getString("datedemande")%></td>
			<td><a
				href="reponseFicheCitoyenne.jsp?idFiche=<%=rs2.getInt("id")%>">repondre</a></td>
		</tr>

		<%
			}
				i++;
			}
		%>
	</table>

	<p>

		<!--
*	  une liste des fiches qui n'ont pas été traitées (champs réponse inexistant),
*	  une liste des fiches traitées.  
*  Dans ces deux listes vous mettez :
*	  une ligne par fiche, cette  ligne comprend : le numéro de la fiche (id), l'objet de la fiche, la date de création de la fiche. 
*     Pour que ce soit plus lisible, alternez entre deux couleurs sur les lignes.
*  Avec le numéro de la fiche vous mettez un lien vers la page "reponseFicheCitoyenne.jsp" qui permet d'écrire la réponse à  la fiche, 
-->
</body>
</html>
