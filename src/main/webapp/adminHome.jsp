<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="com.DAO.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Home</title>
  <link rel="stylesheet" href="css/adminHome.css">
</head>
<body>
<%
Utente user = (Utente) session.getAttribute("user");
if (user == null || session == null || (!"admin@gmail.com".equals(user.getEmail()) && !"admin".equals(user.getPassword()))) {
response.sendRedirect("login.jsp");
return;
}

List<Prodotto> listaProdotti = ProdottoDAO.getAllProdotti();
  String username = user != null ? user.getUsername() : "";
  %>

  <header class="admin-header">
    <h1>Benvenuto, <%= username %></h1>
    <div class="action-buttons">
      <a href="ordiniAdmin.jsp" class="btn">Ordini</a>
      <a href="Logout" class="btn">Logout</a>
    </div>
  </header>

  <main class="main-content">
    <div class="title-list">
      <h2>Lista prodotti</h2>
      <a href="inserisciProdotto.jsp" class="btn">Inserisci Prodotto</a>
    </div>
    <section class="product-list">
      <%
      if (listaProdotti != null && !listaProdotti.isEmpty()) {
      for (Prodotto prodotto : listaProdotti) {
      %>
      <div class="product-item">
        <% if (prodotto.getQuantitaDisponibile() == 0) { %>
        <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>" alt="<%= prodotto.getNomeProdotto() %>" class="product-image" style="width:200px">
        <p class="product-name"><%= prodotto.getNomeProdotto() %></p>
        <div class="product-controls">
          <a href="modificaProdotto?idProdotto=<%= prodotto.getIdProdotto() %>" class="btn btn-edit">Modifica</a>
          <a href="eliminaProdotto?idProdotto=<%= prodotto.getIdProdotto() %>" class="btn btn-delete">Elimina</a>
        </div>
        <p style="color:red">Prodotto Sold Out!</p>
        <% } else { %>
        <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>" alt="<%= prodotto.getNomeProdotto() %>" class="product-image" style="width:200px">
        <p class="product-name"><%= prodotto.getNomeProdotto() %></p>
        <div class="product-controls">
          <a href="modificaProdotto?idProdotto=<%= prodotto.getIdProdotto() %>" class="btn btn-edit">Modifica</a>
          <a href="eliminaProdotto?idProdotto=<%= prodotto.getIdProdotto() %>" class="btn btn-delete">Elimina</a>
        </div>
        <% } %>
      </div>
      <%
      }
      } else {
      %>
      <p class="no-products">Nessun prodotto disponibile al momento.</p>
      <%
      }
      %>
    </section>
  </main>

</body>
</html>
