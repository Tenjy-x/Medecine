<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="Model.Patient" %>
<%
    // Attribut envoyé par PatientController.updateForm() : mv.setAttribute("patient", patient)
    // Absent pour createForm() => formulaire vide
    Patient p = (Patient) request.getAttribute("patient");
    boolean creation = (p == null);
    if (creation) p = new Patient();
    String ctx = request.getContextPath();
    String action = creation ? ctx + "/patients/create" : ctx + "/patients/update";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%= creation ? "Nouveau patient" : "Modifier patient" %></title>
    <style>
        body  { font-family: Arial, sans-serif; background: #f4f6f8; margin: 0; padding: 24px; color: #222; }
        .carte { max-width: 700px; margin: 0 auto; background: #fff; border-radius: 8px;
                 padding: 24px; box-shadow: 0 1px 4px rgba(0,0,0,.08); }
        h1    { margin-top: 0; font-size: 22px; }
        .grille { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        .pleine { grid-column: 1 / -1; }
        label { display: block; font-size: 13px; color: #555; margin-bottom: 4px; }
        input, select { width: 100%; box-sizing: border-box; padding: 8px; border: 1px solid #d1d5db;
                        border-radius: 6px; font-size: 14px; }
        .boutons { margin-top: 20px; display: flex; gap: 8px; }
        .btn  { display: inline-block; padding: 8px 14px; border: 1px solid #d1d5db; border-radius: 6px;
                background: #fff; color: #222; text-decoration: none; font-size: 14px; cursor: pointer; }
        .btn-primaire { background: #2563eb; border-color: #2563eb; color: #fff; }
    </style>
</head>
<body>
<div class="carte">
    <h1><%= creation ? "Nouveau patient" : "Modifier le patient #" + p.getId() %></h1>

    <form method="post" action="<%= action %>">
        <% if (!creation) { %>
            <input type="hidden" name="id" value="<%= p.getId() %>">
        <% } %>

        <div class="grille">
            <div>
                <label for="nom">Nom *</label>
                <input id="nom" name="nom" required maxlength="100"
                       value="<%= p.getNom() != null ? p.getNom() : "" %>">
            </div>
            <div>
                <label for="prenom">Prénom *</label>
                <input id="prenom" name="prenom" required maxlength="100"
                       value="<%= p.getPrenom() != null ? p.getPrenom() : "" %>">
            </div>
            <div>
                <label for="dateNaissance">Date de naissance *</label>
                <input id="dateNaissance" name="dateNaissance" type="date" required
                       value="<%= p.getDateNaissance() != null ? p.getDateNaissance() : "" %>">
            </div>
            <div>
                <label for="sexe">Sexe</label>
                <select id="sexe" name="sexe">
                    <option value="">---</option>
                    <option value="M" <%= "M".equals(p.getSexe()) ? "selected" : "" %>>Masculin</option>
                    <option value="F" <%= "F".equals(p.getSexe()) ? "selected" : "" %>>Féminin</option>
                </select>
            </div>
            <div>
                <label for="telephone">Téléphone</label>
                <input id="telephone" name="telephone" maxlength="30"
                       value="<%= p.getTelephone() != null ? p.getTelephone() : "" %>">
            </div>
            <div>
                <label for="email">Email</label>
                <input id="email" name="email" type="email" maxlength="150"
                       value="<%= p.getEmail() != null ? p.getEmail() : "" %>">
            </div>
            <div class="pleine">
                <label for="adresse">Adresse</label>
                <input id="adresse" name="adresse" maxlength="255"
                       value="<%= p.getAdresse() != null ? p.getAdresse() : "" %>">
            </div>
        </div>

        <div class="boutons">
            <button class="btn btn-primaire" type="submit"><%= creation ? "Créer" : "Enregistrer" %></button>
            <a class="btn" href="<%= ctx %>/patients">Annuler</a>
        </div>
    </form>
</div>
</body>
</html>
