<%@ page isELIgnored="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>identification créateur de fiche d'intervention</title>
    <link type="text/css" href="style/deco.css" rel="stylesheet" >
   <style type="text/css">
      td
         {  width:300px;}
     </style>
</head>
<body>
  <img src="image/logo.jpg"  width="500">    
   <h3> Service de relation avec les Citoyens</h3>
    <h3> Gestion des fiches citoyens</h3>
 <!--  avant l'identification on efface toutes les données des sessions précédentes -->
 <% session.invalidate(); %>
 
<!-- 
****   Affichage d'un message si le parametre "erreur" est présent
****   Affichage d'un message si le parametre "finsession" est présent
-->
 <% if(request.getParameter("finsession")!=null){	
 %>
 <h3 style="color:red"> Vous avez perdu votre session</h3>
 <%} %>
 
 <% if(request.getParameter("erreur")!=null){	
 %>
 <h3 style="color:red"> Veuillez vérifier vos paramètres d'identification</h3>
 <%} %>
 
 
 


  <h2> Veuillez vous identifier  ou créer un compte</h2>
  <!-- <form name="commande" method="get" action="identiteCitoyen.jsp">
<table style= "width:500;"  class="Casebleu1"> 
<tr> 
  <td colspan="2"> <strong>Pour une connexion remplissez les 2 premiers champs.  
    Pour une nouvelle inscription  remplissez les 4  champs</strong></td>
</tr>


****   un  "input text" pour l'identifiant, mini  4 caractères maxi 10 caractères
        un "input password" pour le mot de passe

 




****       un  "input text"  pour le nom   mini  4 caractères maxi 10 caractères
           un  "input email" un pour le mail, avec vérification de la syntaxe, maxi 30 caractères
           expression régulière possible   "[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"          

	<tr>
		<td>
		<label for="identifiant"> Identifiant: </label>
		<input type="text" name="identifiant" min="4" max="10" required>
		</td>
	</tr>
	<tr>
		<td>
		<label for="motPasse"> Mot de passe: </label>
		<input type="password" name="motPasse" min="4" max="10" required>
		</td>
	</tr>
	<tr>
		<td>
		<label for="nom"> Nom: </label>
		<input type="text" name="nom" min="4" max="10">
		</td>
	</tr> 
	<tr>
		<td>
		<label for="mail"> Email: </label>
		<input type="email" name="mail" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
		</td>
	</tr>
 <tr> 
    <td colspan="2"> <button name ="connexion" type="submit" 
             value="se connecter"style="width: 120px"> se connecter </button> </td> 
 </tr>   
</table></form>  -->
<tags:formulaire couleur="#c0ebe7" action="identiteCitoyen.jsp" methode="get" taille="30" 
identifiant="text" motPasse="password" nom="text" mail="email"  soumettre="submit" />

</body></html>
