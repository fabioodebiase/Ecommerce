<%@ page import="com.entities.Utente" %>
<%@ page import="com.entities.Prodotto" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Carrello</title>
</head>
<body>
<%
Utente utente = (Utente) session.getAttribute("user");
List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

    if (carrello != null && !carrello.isEmpty()) {
    for (Prodotto prodotto : carrello) {
    %>
    <div>
        <p><%= prodotto.getNomeProdotto() %></p>
        <img src="<%= request.getContextPath() %>/<%= prodotto.getImagePath() %>"
             alt="<%= prodotto.getNomeProdotto() %>" width="200">
    </div>
    <%
    }
    } else {
    %>
    <p>Il carrello e' vuoto.</p>
    <%
    }
    %>
    <a href="home.jsp">Vai alla home</a>
</body>
</html>