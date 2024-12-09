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
Prodotto prodotto = (Prodotto) request.getAttribute("prodotto");
%>
<form action = "Ordine" method = "POST">
    <p><%=prodotto.getNomeProdotto()%></p>
    <p>Prezzo: <%=prodotto.getPrezzo()%></p>
    <p>Quantita' disponibili: <%=prodotto.getQuantitaDisponibile()%></p>
    <img src="<%=request.getContextPath()%>/<%= prodotto.getImagePath()%>" width="200">

    <!--input hidden per passare parametri alla servlet degli ordini -->
    <input type = "hidden" name = "idUtente" value = "<%=user.getIdUtente()%>">
    <input type = "hidden" name = "idProdotto" value = "<%=prodotto.getIdProdotto()%>">
    <input type="hidden" name="quantita" value="<%= prodotto.getQuantitaDisponibile() %>">

    <input type = "submit" value = "Aggiungi agli ordini">
</form>

</body>
</html>