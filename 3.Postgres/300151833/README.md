# 📚 TP 03 - Base de Données Bibliothèque Universitaire
# Ton Nom
# Ton Matricule

---

Ce travail consiste à concevoir et normaliser une base de données pour une bibliothèque universitaire.

---

## 🎯 **Objectifs**
1. Identifier les entités du système
2. Définir les relations et cardinalités
3. Appliquer les formes normales (1FN, 2FN, 3FN)
4. Concevoir un diagramme Entité/Relation
5. Préparer la base pour une implémentation SQL

---

# 🚀 Étapes du projet

## Étape 1 : Analyse du système

Le système de bibliothèque permet :

- Gestion des membres
- Gestion des livres
- Gestion des emprunts
- Gestion des paiements
- Gestion des employés

---

## Étape 2 : Identification des entités

Les entités principales sont :

- Membre
- Adresse
- Livre
- Catégorie
- Auteur
- Emprunt
- Ligne_Emprunt
- Paiement
- Employé

---

## Étape 3 : Relations

- Un membre peut effectuer plusieurs emprunts
- Un membre peut avoir plusieurs adresses
- Un emprunt contient plusieurs livres
- Un livre appartient à une catégorie
- Un auteur peut écrire plusieurs livres
- Un emprunt peut avoir un paiement
- Un employé gère les emprunts

---

## Étape 4 : Diagramme E/R

<details>
<summary>🖼️ Diagramme</summary>

![Diagramme](images/diagramme.png)

</details>

---

## Étape 5 : Première forme normale (1FN)

- Suppression des groupes répétés
- Données atomiques

Exemple :

```sql
Membre(id_membre, nom, email)
Adresse(id_adresse, rue, ville, id_membre)
Livre(id_livre, titre, id_categorie)
