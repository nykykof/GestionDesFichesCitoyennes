<%@ page import="java.util.*"%>
<%@ page import="utile.DateBean"%>
<jsp:useBean id="laDate" class="utile.DateBean" scope="session" />
<!DOCTYPE  HTML>
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
String dateDemandemysql = laDate.getAnnee()+ "/" + laDate.getMois() + "/" + laDate.getJour();

%>
<%@ include file="ligneIdentification.jspf" %> 


 <!--
*partie 1
* Vous   ajoutez une table comprenant un formulaire avec
*	un champ input texte "Objet"  (max 100 caractères).
*	Un champ textArea  "Description" ( 100 colonnes, 15 lignes) 
*	Et deux boutons "valider" et "abandonner"
* Le bouton "valider" appelle la page gestionBasedemande.jsp avec le contenu du formulaire, 
* cette page enregistre cette fiche dans la table "fiche", avec une référence au citoyen qui l'écrit.
* Le bouton "abandonner" vous ramène à une page d'accueil, par exemple "mesInformationsPersonelles.jsp", ou une autre
* vous passez aussi en paramètre : dateDemande et dateDemandemysql

 -->
<form name="commande" method="get" action="gestionBaseDemande.jsp">
<table style= "min-width:800px;"  class="Casebleu1"> 
<tr> 
  <td colspan="2"> <strong>Pour une connexion remplissez les 2 premiers champs.  
    Pour une nouvelle inscription  remplissez les 4  champs</strong></td>
</tr>

	<tr>
		<td>
		<label for="objet"> Objet: </label>
		<input type="text" name="objet" max="100">
		</td>
	</tr>
	<tr>
		<td>
		<label for="description"> Description: </label><br>
		<textarea rows="15" cols="100" name="description"></textarea>
		</td>
	</tr>
 <tr> 
    <td > 
    	<a href="mesInformationsPersonnelles.jsp">
    	<button name ="abandonner" type="button" value="abandonner"style="width: 120px"> 
    		Abandonner
        </button> </a>
        
        <button name ="valider" type="submit" value="valider"style="width: 120px"> 
     			Valider 
        </button> 
        <button name ="ajoutdoc" type="submit"> 
     			Validez en ajoutant un document 
        </button> 
     </td> 
 </tr> 
   
</table></form>

 <!--
*partie 2
* Rajoutez  dans le formulaire de la page deposerUneDemande.jsp un bouton supplémentaire  
  " validez en ajoutant un document",  de nom "ajoutdoc"
   il appelle aussi la page gestionBasedemande.jsp
   il permettra de savoir qu'il faut joindre un document 
  (pdf, word, excel, jpg, etc..) à la  fiche.
*

fait en haut
-->




<table  class="CaseGrise1" style= "width:800;" > 
<tr> <td class="Casebleu14">
 Si vous voulez illustrer vos propos par une photo, vous cliquez sur "valider en ajoutant une photo".
Attention sa taille doit être inférieure à 200 koctets, vous avez des logiciels pour réduire la taille d'une image :
waibeImage, image resizer, light image resizer, etc.. Pour les documents, la limite est de 500 koctets.  
</td>
</tr>
 </table>   
  </body>
</html>
