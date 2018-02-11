
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*"%>
<%@ page import="utile.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql2" %>

<%@ include file="ouvreBase2.jsp" %>  
<%
Statement stmt = conn1.createStatement();
ResultSet rset = null;
PreparedStatement pstmt=null;
String mailCitoyen = null;
String reponse = request.getParameter("reponse");
String objet = null;
String description =null;

String valider = request.getParameter("valider");
int id = ((Integer)(session.getAttribute("id"))).intValue();
String mail=(String)session.getAttribute("mail");
int numFiche  =  (request.getParameter("numFiche")!=null)? Integer.parseInt(request.getParameter("numFiche")):0;
int numDemande  =  (request.getParameter("numDemande")!=null)? Integer.parseInt(request.getParameter("numDemande")):0;
int num=0, num2=0;


pstmt= conn1.prepareStatement
    ("SELECT  mail, objet, description FROM personne , fiche  where fiche.demandeur = personne.id and fiche.id=?"); 
pstmt.setInt(1,numFiche);
rset = pstmt.executeQuery();
if (rset.next()) {
	mailCitoyen =rset.getString("mail");
	objet =rset.getString("objet");
	description =rset.getString("description");
}

  // envoi mail au citoyen 
  String objetMail ="Réponse à votre  fiche Citoyenne ";
  String mailMairie = "ogor.robert@gmail.com";
  String contenu = "Bonjour \r\n";
  contenu = contenu + "voici le contenu et la reponse  de votre fiche, elle a été enregistée sous le numéro " + numFiche +"\r\n";
  contenu = contenu + "objet : " + objet +"\r\n";
  contenu = contenu + "description : " + description +"\r\n";
  contenu = contenu + "reponse : " + reponse +"\r\n";
  contenu = contenu + "Si nous apportons une autre reponse vous en serez averti"  +"\r\n";
  contenu = contenu + "Cordialement, La mairie";
  GereCitoyen.envoieMail(objetMail, mailMairie, mailCitoyen, contenu);
  


// en scriplet  inscription de la reponse par un administrateur et retour administration  
 if ( (valider != null) && (reponse != null))  { 
 
  PreparedStatement pstselect = null;
  ResultSet rsetselect = null;
  pstselect = conn1.prepareStatement("select id from reponse where fiche = ? and texte=?");
  pstselect.setInt(1, numFiche);
  pstselect.setString(2, reponse);
  rsetselect= pstselect.executeQuery();
  
  if(!rsetselect.next()){
	  
	  PreparedStatement pstmupdate = null;
	  pstmupdate = conn1.prepareStatement("UPDATE  fiche  set reponse=?  where id =?");
	  pstmupdate.setString(1, reponse);
	  pstmupdate.setInt(2, numFiche);
	  pstmupdate.executeUpdate();
	  	  
	  pstmt= conn1.prepareStatement("INSERT INTO  reponse(fiche,datereponse,texte) VALUES(?,NOW(),?)"); 	 
	  pstmt.setInt(1,numFiche);
	  pstmt.setString(2,reponse);
	  pstmt.executeUpdate();
  }

	 	 	 	  	  
  response.sendRedirect("gereDemandeCitoyen.jsp");
    } 

 %>


  <!--  en jstl  inscription de la reponse par un administrateur et retour administration  -->
 
 <%--  <c:if test="${(param.valider != null) and (param.reponse != null) }" >
 <sql2:update var="result" dataSource="DonneesBase">
    update  fiche set reponse="${param.reponse}"  where id= ${param.numFiche}
 </sql2:update>
  <c:redirect url="gereDemandeCitoyen.jsp"/>
</c:if> --%>

