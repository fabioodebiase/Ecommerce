<html>
<header>
    <title>Login</title>
</header>
<body>
<h1>Login</h1>

<form action = "Login" method = "POST">
    <label for="email"> Email</label>
    <input type = "email" name = "email" id = "email">

    <label for="password"> Password</label>
    <input type = "password" name = "password" id = "password">

    <input type = "submit" value = "Accedi">
</form>
<%
if (request.getAttribute("errore") != null) { %>
<p style = "color:red"> <%= request.getAttribute("errore") %> </p>
<% } %>
<p>Non sei ancora registrato?<a href = "signUp.jsp">Clicca qui per registrarti</a></p>
</body>
</html>
