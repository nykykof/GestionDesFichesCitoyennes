<%@ page import="java.util.*"%>
<%@ page import="utile.DateBean"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.swing.JFileChooser"%>
<%@ page import="java.io.File"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>
<jsp:useBean id="laDate" class="utile.DateBean" scope="session" />
<!DOCTYPE HTML>
<html>
  <head> 
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Document transférés par un citoyen</title>
   <link type="text/css" href="../style/deco.css" rel="stylesheet" >
 
 <%!
 String trouveSuffixe (String fichier) {	
	 String suffixe;
	 int pos = fichier.lastIndexOf(".");
      if (pos > -1) 
      	     suffixe= fichier.substring(pos);
       else 
      	suffixe= fichier;
      return suffixe ;
 } 
 %>
  <style>
  img{
  	width:50px;
  	height:50px;
  }
  </style> 
</head>
  
<body   class= "CaseGrise" >
  <%@ include file="accesmenuFiche.jspf" %>  
  <%   
String  placeDocument = "../images/";
String nom= (String)session.getAttribute("nom");
int idfiche = 0;
String dateDemande = laDate.getJour() + "/" + laDate.getMois() + "/" + laDate.getAnnee();    
%>
<%@ include file="ouvreBase2.jsp" %>      
<table border="1" style= "width:400;" class="Casebleu1" >  
<tr>
<td width="400"> Demandeur ou service :  nom : <%=  nom %>  </td>
<td>Date :  <%=dateDemande%> </td>
</tr>
</table>



<!--  
* Donner la liste, des documents que la personne a téléchargés, un document par ligne.
*
* Sur cette ligne, vous mettez d'abord un icône donnant le type de document, par exemple pour le pdf : pdf.jpg ,
* pour une image une vignette de l'image (petite image), inutile de le faire pour tous les documents possibles.
* Puis le nom du fichier de ce document, associé à un lien html sur le fichier, 
* de façon qu'en cliquant dessus on puisse lire le document. 
-->
<%
int idPersonne = (int)session.getAttribute("id");
ResultSet rs = null;
PreparedStatement pst = null;
pst = conn1.prepareStatement("select * from document where proprietaire=?");
pst.setInt(1, idPersonne);
rs = pst.executeQuery();
//rs.next();
%>
<table style="width:100%;">
<%
int i=1;
	while(rs.next()){
		String surffixe = " ";
		String imageACharger = " ";
		if(rs.getString("nom")!=null){
			surffixe = trouveSuffixe(rs.getString("nom"));
			if(surffixe.equals("pdf"))
			{
				imageACharger = "pdf.jpg";
			}else if(surffixe.equals("jpg") || surffixe.equals("jpeg") || surffixe.equals("png"))
			{
				imageACharger = rs.getString("nom");
			}else{
				imageACharger = "fichier.png";
			}
		
		
		if(i%2==0){
	
%>
	<tr style="background-color:#eee">
		<td><img alt="image document" src="<%=placeDocument+imageACharger%>"></td>
		<td><a href="<%=placeDocument+rs.getString("nom")%>"><%=rs.getString("nom")%></a></td>
	</tr>
	<%
		}else{
	%>
	<tr style="background-color:#fff">
		<td><img alt="image document" src="<%=placeDocument+imageACharger%>"></td>
		<td><a href="<%=placeDocument+rs.getString("nom")%>"><%=rs.getString("nom")%></a> </td>
	</tr>
	<%
		}
		}
		i++;
		
	}
	%>
</table>
</body>
</html>
