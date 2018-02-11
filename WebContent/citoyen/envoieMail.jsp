<%@ page import="java.util.*"%>
<%@ page import="utile.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="ouvreBase2.jsp"%>
<% 
String envoyeurconnu = request.getParameter("envoyeurconnu");
/*

Pour envoyer un mail, il faut en général disposer d'un opérateur (serveur et port) 
  qui dispose d'un serveur d'envoi de mail (serveur SMTP), et d'un compte chez cet opérateur.
   
Une exception est parfois permise, par exemple si vous êtes sur un réseau local derrière une 
 livebox (ou autre), dans ce cas vous avez la possibilité d'envoyer un mail 
 sans vous identifier et sans donner l'opérateur, en effet la livebox a son opérateur, 
 et si vous y êtes connecté c'est que vous y avez un compte. 
 Dans ce cas, utilisez   la méthode  de GéreCitoyen.envoieMail :

public static void envoieMail( String objet, String deLaPart, String pour , String contenu) 
   ici deLaPart  est une adresse mail correcte, que vous pouvez donner. 

Dans le cas plus général, par exemple si vous voulez passez par le serveur SMTP de l'école 
c'est la méthode de GereCitoyen.envoieMailSecure :

  public static void envoieMailSecure( String objet, String deLaPart, String pour , String contenu, String motpasse, String host, String port) {

   Dans ce cas, 
     host et port désignent le serveur smtp d'un opérateur et le port associé
    deLaPart  et  motpasse désignent une adresse mail et son mot de passe chez cet opérateur;

Dans cette méthode, au premier passage vous devrez donc donner ces indications.

Par la suite ces informations (deLaPart , motpasse, serveur, port) sont stockées 
  dans des variables de session et il est donc inutile de les demander.

Voici donc les trois parties de cette page :

1) Si à l'appel de la page,  les variables de session qui représentent  
           l'adresse mail et le mot de passe de l'expéditeur: ne sont pas connues 
           et que ces informations ne sont pas en paramètre  (envoyeurconnu = null) , 
     un formulaire est envoyé pour   demander 
          l'adresse mail, 
            le mot de passe, 
            le serveur,  par defaut     "z.imt.fr"  et 
            le port   par defaut  "587" , 
        ce formulaire a un bouton submit, de nom envoyeurconnu, 
        l'action de ce formulaire est la page courante.
   
Attention, l'envoi d'un formulaire, c'est une autre requête, 
    donc nouveaux paramètres, 
    or dans la première requête il y avait selon le cas un paramètre " nomDocument". 

Il faut donc faire suivre cette valeur ("partie "hidden")




2) Si à l'appel de la page,  
   les variables de session qui représentent  l'adresse mail et le mot de passe de l'expéditeur: 
	   ne sont pas connues, mais que vous revenez du formulaire, (envoyeurconnu présent) :
   Vous mettez les variables (adresseMail, motPasse, serveur, port) en session.
                       


3) Si les variables de session qui représentent  l'adresse mail et le mot de passe de l'expéditeur 
sont connues (vous venez de les créer ou vous les avez créées lors d'un autre appel), 
vous pouvez envoyer le mail.



Envoi du mail :
     Recherche dans la base de la dernière fiche de la personne connectée
     Recherche des caractéristiques de cette fiche et du mail de la personne connectée

     Le mail contient en objet, l'objet de la fiche.
     et en contenu, le texte que vous voulez et le champ description de la fiche.
        S'il y a eu un document avec la fiche, le nom de ce document

*/

// cas 1 : recueillir les informations sur le serveur smtp
String nomDocument = request.getParameter("nomDocument");
/* System.out.println("nom du doc"+nomDocument); */
if(envoyeurconnu==null)
{
%>
<form method="GET">
	<table style="min-width: 800px;" class="Casebleu1">
		<tr>
			<td colspan="2"><strong>Entrer les paramètres
					nécessaires pour le mail</strong></td>
		</tr>

		<tr>
			<td><label for="mail"> Email: </label> <input type="email"
				name="mail" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$">
			</td>
		</tr>
		<tr>
			<td><label for="motPasse"> Mot de passe: </label><br> <input
				type="password" name="motPasse"></td>
		</tr>
		<tr>
			<td><label for="serveur"> Serveur: </label><br> <input
				type="text" name="serveur"></td>
		</tr>
		<tr>
			<td><label for="port"> Port du serveur: </label><br> <input
				type="text" name="port" pattern="[0-9]{2,5}"> <input
				type="text" name="nomDocument" value="<%=nomDocument%>"></td>
		</tr>
		<tr>
			<td><a href="mesInformationsPersonnelles.jsp">
					<button name="abandonner" type="button" value="abandonner"
						style="width: 120px">Abandonner</button>
			</a> <input name="envoyeurconnu" type="submit" value="valider"
				style="width: 120px" /></td>
		</tr>

	</table>
</form>
<%
}
//cas 2 : definition des variables de session
else{
	session.setAttribute("mailEnvoyeurConnu", request.getParameter("mail"));
	session.setAttribute("motPasseEnvoyeurConnu", request.getParameter("motPasse"));
	session.setAttribute("serveurEnvoyeurConnu", request.getParameter("serveur"));
	session.setAttribute("portEnvoyeurConnu", request.getParameter("port"));
	String nomDoc = request.getParameter("nomDocument");
	System.out.println("nom du doc :"+nomDoc);
	session.setAttribute("docmise", nomDoc);
	//gestion de l'adresse du serveur
	if(session.getAttribute("serveurEnvoyeurConnu")!=null){
		session.setAttribute("serveurEnvoyeurConnu", "z.imt.fr");
		//System.out.println("ici");
	}/* else{
		session.setAttribute("serveurEnvoyeurConnu", "z.imt.fr");
		System.out.println("la");
	} */ 
	// gestion du port du serveur smtp
	if(session.getAttribute("portEnvoyeurConnu")!=null){
		session.setAttribute("portEnvoyeurConnu", "587");
	 }/* else{
		 session.setAttribute("portEnvoyeurConnu", "587");
	}  */

//cas 3 : envoie du mail
	ResultSet rset = null;
	PreparedStatement pst=null;
	String docmise =(String)session.getAttribute("docmise");
	int id = ((Integer)(session.getAttribute("id"))).intValue();
	
	pst = conn1.prepareStatement("SELECT * FROM fiche WHERE demandeur = ? ORDER BY id DESC");
	pst.setInt(1, id);
	rset = pst.executeQuery();
	rset.next();
	String objet = rset.getString("objet");
	String description = rset.getString("description");
	String pour = (String) session.getAttribute("mail");
	String deLaPart = (String) session.getAttribute("mailEnvoyeurConnu");
	String host = (String) session.getAttribute("serveurEnvoyeurConnu");
	String port = (String) session.getAttribute("portEnvoyeurConnu");
	String motpasse = (String)session.getAttribute("motPasseEnvoyeurConnu");
	String notreTextePerso = "";
	String contenu = null;
	String signature = " Ma signature";
	
	System.out.println("nom du doc"+nomDocument);
	if(docmise!=null && !docmise.trim().equals(""))
	{
	 contenu = notreTextePerso + "Nom du document : "+docmise;
	 System.out.println("******nom du doc"+docmise);
	}
	
	try{
		GereCitoyen.envoieMailSecure(objet,
				deLaPart, 
				pour, 
				contenu,
				motpasse, 
				host, 
				port,
				signature
				);
	%>	
		<jsp:forward page="mesInformationsPersonnelles.jsp"></jsp:forward>
	<%
	}catch(Exception e){
		System.out.print("mail non transmis. Cause");
	}
}
%>






