<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="java.util.*"%>
<%@ page import="utile.DateBean"%>
<%@ page import="java.sql.*"%>
<%@ include file="ouvreBase2.jsp" %>
<jsp:useBean id="laDate" class="utile.DateBean" scope="session" />
<!DOCTYPE HTML >
<html>
<head> 
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Demande Citoyenne Mairie Loc-Maria-Plouzané</title>
     <link type="text/css" href="../style/deco.css" rel="stylesheet" >
</head>
 <body   class= "CaseGrise" >

<%@ include file="accesmenuFiche.jspf" %>  
<%    
String nom= (String)session.getAttribute("nom");
String identifiant= (String)session.getAttribute("identifiant");
String dateDemande = laDate.getJour() + "/" + laDate.getMois() + "/" + laDate.getAnnee(); 
%>
<%@ include file="ligneIdentification.jspf" %> 

<!-- 
*	 une ligne par fiche, 
*   cette  ligne comprend : le numéro de la fiche (id), l'objet de la fiche, 
*                la date de création de la fiche. 
*     Pour que ce soit plus lisible, alternez entre deux couleurs sur les lignes.
*	Avec le numéro de la fiche vous mettez 
*          un lien vers la page d'affichage du contenu de la fiche : ficheCitoyenne.jsp
-->

 <table style= "min-width:800px;"  class="Casebleu1"> 
<tr> 
  <th>id</th>
  <th>objet</th>
  <th>date creation</th>
  <th>detail </th>
</tr>
<% 
	int i = 0;
	int id = (int)session.getAttribute("id");
	ResultSet rs = null;
	PreparedStatement pst = null;
	pst = conn1.prepareStatement("select * from fiche where demandeur=?");
	pst.setInt(1, id);
	rs = pst.executeQuery();
	
	while(rs.next()){
		if(i%2==0){
%>
	<tr style="background-color:#eee">
		<td><%=rs.getInt("id")%></td>
		<td><%=rs.getString("objet")%></td>
		<td><%=rs.getString("datedemande")%></td>
		<td><a href="ficheCitoyenne.jsp?numeroDemande=<%=rs.getInt("id")%>">detail</a></td>
	</tr>
	
<%
		}else{
%>
	<tr style="background-color:#fff">
		<td><%=rs.getInt("id")%></td>
		<td><%=rs.getString("objet")%></td>
		<td><%=rs.getString("datedemande")%></td>
		<td><a href="ficheCitoyenne.jsp?numeroDemande=<%=rs.getInt("id")%>">detail</a></td>
	</tr>

<%
		}
		i++;
	}
%>
</table>

  </body>
</html>
