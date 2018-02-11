<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<jsp:useBean id="gerelesCitoyen" class="utile.GereCitoyen"  scope="session" />

<!--- 
  **** les 4 propri�t�s du bean nom, identifiant, mail, motPasse doivent �tre initialis�es 
        par la page, en utilisant le "jsp:setProperty "
-->
<jsp:setProperty property="*" name="gerelesCitoyen"/>

 <%!
	ResultSet rset = null;
 %>
 <!--  definition de la base dans le bean et recherche du Citoyen  dans la base par le bean -->
<%
 	gerelesCitoyen.ouverture("demandecitoyen");
 /*
**  Recherche de la personne dans la base par le bean, m�thode recherchePersonne()
**
**      s'il n'est pas   trouv� et que le mail et le nom ne sont pas pr�sents
**                         appel � la page d'inscription "index.jsp"
**      s'il n'est pas   trouv� et que le mail et le nom sont pr�sents
**                         inscription m�thode inscrireUtilisateur()
*/               
if(!gerelesCitoyen.recherchePersonne())
{
	if( gerelesCitoyen.getMail()==null || gerelesCitoyen.getNom()==null){
%>	
<jsp:forward page="index.jsp">
	<jsp:param value="erreur" name="erreur"/>
</jsp:forward>
<%
	}else{
		gerelesCitoyen.inscrireUtilisateur();
	}
}

/*
** Arriv� ici, on sait que la personne est inscrite, on recherche ses caract�ristiques par recherchePersonne()
** et on met en variable de session, (gardez les m�mes noms pour la suite)
**              id, nom, prenom, mobile, fixe, rue, ville, eidentifiant, mail, fonction
*/
if(gerelesCitoyen.recherchePersonne())
{
	rset = gerelesCitoyen.getRset();
	session.setAttribute("id", rset.getInt("id"));
	session.setAttribute("nom", rset.getString("nom"));
	session.setAttribute("prenom", rset.getString("prenom"));
	session.setAttribute("mobile", rset.getString("mobile"));
	session.setAttribute("fixe", rset.getString("fixe"));
	session.setAttribute("rue", rset.getString("rue"));
	session.setAttribute("ville", rset.getString("ville"));
	session.setAttribute("identifiant", rset.getString("identifiant"));
	session.setAttribute("mail", rset.getString("mail"));
	session.setAttribute("fonction", rset.getString("fonction"));
}








/*
** si c'est un administrateur : appel � la page  "gereDemandeCitoyen.jsp"
** si c'est un citoyen appel � la page  mesInformationsPersonnelles.jsp
*/
if(rset.getString("fonction").equals("administrateur"))
{
	%>
	<jsp:forward page="citoyen/gereDemandeCitoyen.jsp"></jsp:forward>
	<%
}
if(rset.getString("fonction").equals("citoyen"))
{
	String chemin = "citoyen/mesInformationsPersonnelles.jsp";
	%>
	<jsp:forward page="<%=chemin%>"></jsp:forward>
	<%	
}

	
%>
