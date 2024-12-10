<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="com.DAO.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>adminHome</title>
</head>
<body>
<%
Utente user = (Utente) session.getAttribute("user");
if (user == null || session==null || !user.getEmail().equals("admin@gmail.com") && !user.getPassword().equals("admin")) {
  response.sendRedirect("login.jsp");
  return;
}

List<Prodotto> listaProdotti = ProdottoDAO.getAllProdotti();
String name = "";
  if (user != null) {
    name = user.getUsername();
  }
%>
  <h1>Benvenuto, <%= name %> </h1>

  <h1>Lista prodotti</h1>

  <a href="inserisciProdotto.jsp">
    <button>Inserisci Prodotto</button>
  </a>

  <a href = "carrello.jsp"><button>Vai al carrello</button></a>
  <a href = "Logout">Logout</a>
  <%
  if (listaProdotti != null && !listaProdotti.isEmpty()) {
    for (Prodotto prodotto : listaProdotti) {
  %>
    <a href = "Prodotto?id=<%=prodotto.getIdProdotto()%>">
      <div>
        <p><%= prodotto.getNomeProdotto() %></p>
        <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>" alt="<%= prodotto.getNomeProdotto() %>" width="200">
        <a href = "modificaProdotto?idProdotto=<%=prodotto.getIdProdotto()%>">Modifica </a>
        <a href = "eliminaProdotto?idProdotto=<%=prodotto.getIdProdotto()%>">Elimina </a>
      </div>
    </a>
  <%
    }
  } else {
  %>
  <p>Nessun prodotto disponibile al momento.</p>
  <%
    }
  %>
</body>
</html>
