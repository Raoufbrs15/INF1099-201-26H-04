#!/usr/bin/env pwsh

# --------------------------------------
# Student Participation Report
# --------------------------------------

# Charger les étudiants (équivalent du source bash)
. ../.scripts/students.ps1

Write-Output "# Participation au $(Get-Date -Format 'dd-MM-yyyy HH:mm')"
Write-Output ""

# Table des matières
Write-Output "| Table des matières            | Description                                             |"
Write-Output "|-------------------------------|---------------------------------------------------------|"
Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

Write-Output ""
Write-Output "## Légende"
Write-Output ""
Write-Output "| Signe              | Signification                 |"
Write-Output "|--------------------|-------------------------------|"
Write-Output "| :heavy_check_mark: | Prêt à être corrigé / Fichier créé |"
Write-Output "| :x:                | Projet inexistant / Fichier manquant |"

Write-Output ""
Write-Output "## :a: Présence"
Write-Output ""
Write-Output "|:hash:| Boréal :id:                | README.md    | images | 1FN.txt | 2FN.txt | 3FN.txt |"
Write-Output "|------|----------------------------|--------------|--------|---------|---------|---------|"

$i = 0
$s = 0

foreach ($entry in $STUDENTS) {

    $parts = $entry -split "\|"
    $ID = $parts[0]
    $GITHUB = $parts[1]
    $AVATAR = $parts[2]

    $URL = "[${GITHUB}](https://github.com/${GITHUB}) <image src='https://avatars0.githubusercontent.com/u/${AVATAR}?s=460&v=4' width=20 height=20></image>"

    $FILE = "$ID/README.md"
    $FOLDER = "$ID/images"

    # Fichiers à tester
    $FILE_1FN = "$ID/1FN.txt"
    $FILE_2FN = "$ID/2FN.txt"
    $FILE_3FN = "$ID/3FN.txt"

    # Vérification
    $CHECK_1FN = if (Test-Path $FILE_1FN) { ":heavy_check_mark:" } else { ":x:" }
    $CHECK_2FN = if (Test-Path $FILE_2FN) { ":heavy_check_mark:" } else { ":x:" }
    $CHECK_3FN = if (Test-Path $FILE_3FN) { ":heavy_check_mark:" } else { ":x:" }

    $OK = "| $i | [$ID](../$FILE) :point_right: $URL | :heavy_check_mark: | :x: | $CHECK_1FN | $CHECK_2FN | $CHECK_3FN |"
    $FULL_OK = "| $i | [$ID](../$FILE) :point_right: $URL | :heavy_check_mark: | :heavy_check_mark: | $CHECK_1FN | $CHECK_2FN | $CHECK_3FN |"
    $KO = "| $i | [$ID](../$FILE) :point_right: $URL | :x: | :x: | $CHECK_1FN | $CHECK_2FN | $CHECK_3FN |"

    if (Test-Path $FILE) {
        if (Test-Path $FOLDER -PathType Container) {
            Write-Output $FULL_OK
            $s++
        } else {
            Write-Output $OK
        }
    } else {
        Write-Output $KO
    }

    $i++

    $COUNT = "`$\frac{$s}{$i}$"
    $STATS = [math]::Floor(($s * 100) / $i)
    $SUM = "`$\displaystyle\sum_{i=1}^{$i} s_i$"
}

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"
