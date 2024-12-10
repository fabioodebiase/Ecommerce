<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="com.DAO.ProdottoDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <title>Shop</title>
</head>
<body>
<%
Utente user = (Utente) session.getAttribute("user");
List<Prodotto> listaProdotti = ProdottoDAO.getAllProdotti();

    if (user != null) {
    String username = user.getUsername();
    %>
    <h1>Benvenuto, <%= username %></h1>

    <% if (username.equals("admin")) { %>
    <a href="inserisciProdotto.jsp">
        <button>Inserisci Prodotto</button>
    </a>
    <% } %>

    <%
    } else {
    %>
    <h1>Utente non autenticato</h1>
    <a href="login.jsp">Clicca qui per effettuare il login</a>
    <%
    }
    %>

    <h1>Lista prodotti</h1>

    <a href = "carrello.jsp"><button>Vai al carrello</button></a>
    <a href = "Logout">Logout</a>
    <%
    if (listaProdotti != null && !listaProdotti.isEmpty()) {
    for (Prodotto prodotto : listaProdotti) {
    %>
    <a href = "Prodotto?id=<%=prodotto.getIdProdotto()%>">
        <div>
            <p><%= prodotto.getNomeProdotto() %></p>
            <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>"
                 alt="<%= prodotto.getNomeProdotto() %>" width="200">
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