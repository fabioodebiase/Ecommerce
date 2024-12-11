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
int totale = 0;
List<Prodotto> carrello = (List<Prodotto>) session.getAttribute("carrello");

    if (carrello != null && !carrello.isEmpty()) {

    for (Prodotto prodotto : carrello) {
    %>
    <div>
        <p>Prodotto:<%= prodotto.getNomeProdotto() %></p>
        <p>Prezzo:<%= prodotto.getPrezzo() %></p>
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
    <p>Totale: <%=totale%></p>
    <% if (utente.getUsername().equals("admin")){ %>
    <a href="adminHome.jsp">Vai alla home</a>
    <% } else { %>
    <a href="home.jsp">Vai alla home</a>
    <% } %>
</body>
</html>