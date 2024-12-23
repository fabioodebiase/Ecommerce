<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="com.DAO.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop</title>
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
<%
Utente user = (Utente) session.getAttribute("user");
if (user == null || session == null || ("admin@gmail.com".equals(user.getEmail()) && "admin".equals(user.getPassword()))) {
response.sendRedirect("login.jsp");
return;
}
List<Prodotto> listaProdotti = ProdottoDAO.getAllProdotti();
    %>
    <header class="user-header">
        <h1 class="welcome-message">Benvenuto, <%= user.getUsername() %></h1>
        <nav class="action-buttons">
            <a href="ordini.jsp" class="btn">Ordini</a>
            <a href="carrello.jsp" class="btn">Carrello</a>
            <a href="Logout" class="btn">Logout</a>
        </nav>
    </header>
    <main class="main-content">
        <h2>Lista prodotti</h2>
        <div class="product-list">
            <%
            if (listaProdotti != null && !listaProdotti.isEmpty()) {
            for (Prodotto prodotto : listaProdotti) {
            if (prodotto.getQuantitaDisponibile() == 0) {
            %>
            <div class="product-item">
                <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>" alt="<%= prodotto.getNomeProdotto() %>" class="product-image" style="width:200px">
                <p class="product-name"><%= prodotto.getNomeProdotto() %></p>
                <p style="color:red">Prodotto Sold Out!</p>
            </div>
            <%
            } else {
            %>
            <div class="product-item">
                <a href="Prodotto?id=<%= prodotto.getIdProdotto() %>" class="product-link">
                    <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>" alt="<%= prodotto.getNomeProdotto() %>" class="product-image" style="width:200px">
                    <p class="product-name"><%= prodotto.getNomeProdotto() %></p>
                </a>
            </div>
            <%
            }
            }
            } else {
            %>
            <p class="no-products">Nessun prodotto disponibile al momento.</p>
            <%
            }
            %>
        </div>
    </main>
</body>
</html>