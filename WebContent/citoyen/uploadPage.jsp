<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<TITLE>Chargement d'un fichier chez l'utilisateur</TITLE>
<link type="text/css" href="../style/deco.css" rel="stylesheet" >

</head>
<body>
 	<%	 
	if ( request.getParameter("tropgrand")!=null ) { %>
		  <h3> Attention votre fichier doit faire moins de 350 koctets </h3>
	<%	  }  %>
 
 <FORM  ENCTYPE="multipart/form-data" ACTION="uploadGestion.jsp" METHOD=post>
  <br><br><br>
  <div style="text-align:center;">
   <table  style="border:1px solid black" class="Casebleu1"> 
     <tr>
		<td colspan="2"><p align=  "center"><B>Chargement de votre fichier</B> </td>
		</tr> <tr>
		<td>
		<p> <b> Choisissez le fichier à transmettre, sa taille ne doit pas dépasser 350 koctets  </b></p>	
        <td><INPUT NAME="F1" TYPE="file"></td>
	</tr> <tr>
	     <td colspan="2"> <p align="right"><INPUT TYPE="submit" VALUE="Envoyez le fichier" ></p></td>
	</tr>
  </table>
     </div>   
 </FORM>
</body>
</html>