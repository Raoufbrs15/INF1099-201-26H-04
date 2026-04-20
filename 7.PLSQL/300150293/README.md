\# TP PostgreSQL - 300150293



\## Etudiant

\- Numero : 300150293

\- GitHub  : Amir1450



\## Lancer le projet

docker run -d --name tp\_postgres -e POSTGRES\_USER=etudiant -e POSTGRES\_PASSWORD=etudiant -e POSTGRES\_DB=tpdb -p 5432:5432 -v ${PWD}/init:/docker-entrypoint-initdb.d postgres:15



\## Lancer les tests

Get-Content tests\\test.sql | docker exec -i tp\_postgres psql -U etudiant -d tpdb



\## Structure

init/01-ddl.sql           -> Creation des tables

init/02-dml.sql           -> Donnees initiales

init/03-programmation.sql -> Fonctions, procedures, triggers

tests/test.sql            -> Tests complets

