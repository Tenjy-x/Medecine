<%@ page contentType="text/html;charset=UTF-8" import="Model.Patient" %>
<%
    String ctx = request.getContextPath();
    Patient p = (Patient) request.getAttribute("patient");
    String sexe = "M".equals(p.getSexe()) ? "Masculin" : "F".equals(p.getSexe()) ? "Féminin" : "—";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Dossier de <%= p.getNomComplet() %></title>
    <link rel="stylesheet" href="<%= ctx %>/assets/css/app.css">
</head>
<body>
<header class="barre-navigation">
    <a class="marque" href="<%= ctx %>/patients">Gestion des patients</a>
</header>
<main>
    <div class="carte">
        <div class="fiche-entete">
            <div>
                <h1><%= p.getNomComplet() %></h1>
                <span class="identifiant">Dossier patient n° <%= p.getId() %></span>
            </div>
            <img class="qr-code" src="<%= p.qrcodedir() %>" alt="QR code du patient">
        </div>
        <dl class="details">
            <div class="detail-item"><dt>Nom</dt><dd><%= p.getNom() %></dd></div>
            <div class="detail-item"><dt>Prénom</dt><dd><%= p.getPrenom() %></dd></div>
            <div class="detail-item"><dt>Date de naissance</dt><dd><%= p.getDateNaissance() %></dd></div>
            <div class="detail-item"><dt>Sexe</dt><dd><%= sexe %></dd></div>
            <div class="detail-item"><dt>Téléphone</dt><dd><%= p.getTelephone() == null ? "—" : p.getTelephone() %></dd></div>
            <div class="detail-item"><dt>Email</dt><dd><%= p.getEmail() == null ? "—" : p.getEmail() %></dd></div>
            <div class="detail-item pleine"><dt>Adresse</dt><dd><%= p.getAdresse() == null ? "—" : p.getAdresse() %></dd></div>
        </dl>
        <div class="detail-actions">
            <a class="btn btn-primaire" href="<%= ctx %>/patients/update?id=<%= p.getId() %>">Modifier</a>
            <a class="btn" href="<%= ctx %>/patients">Retour à la liste</a>
        </div>
    </div>
</main>
</body>
</html>
