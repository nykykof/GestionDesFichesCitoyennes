package utile;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
public class portier implements Filter {
	private FilterConfig filterConfig = null;
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
		// si les attributs de session nom et identifiant sont absents
		// on dirige l'appel vers index.jsp avec si nécessaire un paramètre
		HttpSession session = hrequest.getSession();
		String nom = (String) session.getAttribute("nom");
		String identifiant = (String) session.getAttribute("identifiant");
		
		if(nom == null || identifiant == null)
		{
			hresponse.sendRedirect(hrequest.getContextPath()+"/index.jsp");
		}
		else{
			chain.doFilter(request, response);
		}
		
	}
	public void destroy() {
		this.filterConfig = null;
	}
}