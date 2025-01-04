<html>
<head>
    <title>Registrazione</title>
    <link rel="stylesheet" href="signUp.css">
</head>
<body>

<main>
    <div class = "container">
        <span class = "title">Crea Account</span>
            <form action="SignUp" method="POST">
                <div class="signUp-container">
                <div class = "input-container">
                    <span class = "title-input"><label for="username">Username</label></span>
                    <input type="text" class = "input" name="username" id="username">
                </div>
                <div class = "input-container">
                    <span class = "title-input"><label for="email"> Email</label></span>
                    <input type="email" class = "input" name="email" id="email">
                </div>
                <div class = "input-container">
                    <span class = "title-input"><label for="password">Password</label></span>
                    <input type="password" class = "input" name="password" id="password">
                </div>


                <div class = "submit-container">
                    <input type="submit" class = "submit" value="Registrati">
                </div>
                    <span>Sei gia' registrato?
                    <a href="login.jsp">Clicca qui per accedere</a>
                </span>
                </div>


            <%
            if (request.getAttribute("errore") != null){
            %>
            <p style="color:red">Errore: <%= request.getAttribute("errore") %></p>
            <% } %>
            </form>
        </div>
</main>
</body>
</html>