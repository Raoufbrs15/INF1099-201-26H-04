#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"

function Test-ItemExists {
    param(
        [string]$Path
    )

    if (Test-Path $Path) {
        return ":heavy_check_mark:"
    }

    return ":x:"
}

function Start-PostgresLab {
    docker rm -f postgres-lab 2>$null | Out-Null

    docker run -d -q `
        --name postgres-lab `
        -e POSTGRES_PASSWORD=postgres `
        -e POSTGRES_DB=ecole `
        postgres | Out-Null
}

function Wait-PostgresReady {
    param(
        [int]$MaxAttempts = 15,
        [int]$DelaySeconds = 1
    )

    for ($i = 0; $i -lt $MaxAttempts; $i++) {
        $status = docker exec postgres-lab pg_isready 2>$null
        if ($status -match "accepting connections") {
            return $true
        }

        Start-Sleep -Seconds $DelaySeconds
    }

    return $false
}

function Initialize-PostgresDatabase {
    docker exec postgres-lab psql -U postgres -c "CREATE DATABASE ecole;" 2>$null | Out-Null
}

function Stop-PostgresLab {
    docker rm -f postgres-lab 2>$null | Out-Null
}

function Test-LoadDB {
    param(
        [string]$StudentID
    )

    Start-PostgresLab

    try {
        $ready = Wait-PostgresReady
        if (-not $ready) {
            return ":x:"
        }

        Initialize-PostgresDatabase

        Push-Location $StudentID
        try {
            pwsh ./load-db.ps1 *> "$StudentID-db.txt"
            return ":heavy_check_mark:"
        }
        finally {
            Pop-Location
        }
    }
    catch {
        return ":x:"
    }
    finally {
        Stop-PostgresLab
    }
}

function Get-StudentPaths {
    param(
        [string]$StudentID
    )

    return @{
        README   = "$StudentID/README.md"
        Images   = "$StudentID/images"
        DDL      = "$StudentID/DDL.sql"
        DML      = "$StudentID/DML.sql"
        DQL      = "$StudentID/DQL.sql"
        DCL      = "$StudentID/DCL.sql"
        DBScript = "$StudentID/load-db.ps1"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README = Test-ItemExists -Path $Paths.README
        Images = Test-ItemExists -Path $Paths.Images
        DDL    = Test-ItemExists -Path $Paths.DDL
        DML    = Test-ItemExists -Path $Paths.DML
        DQL    = Test-ItemExists -Path $Paths.DQL
        DCL    = Test-ItemExists -Path $Paths.DCL
    }
}

function Get-GitHubAvatarLink {
    param(
        [string]$GitHubID,
        [string]$AvatarID
    )

    return "[<image src='https://avatars0.githubusercontent.com/u/{1}?s=460&v=4' width=20 height=20></image>](https://github.com/{0})" -f $GitHubID, $AvatarID
}

function Write-ParticipationHeader {
    Write-Output "# Participation"
    Write-Output ""

    Write-Output "| Table des matières            | Description                                             |"
    Write-Output "|-------------------------------|---------------------------------------------------------|"
    Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
    Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

    Write-Output ""
    Write-Output "## Légende"
    Write-Output ""
    Write-Output "| Signe              | Signification                 |"
    Write-Output "|--------------------|-------------------------------|"
    Write-Output "| :heavy_check_mark: | Prêt à être corrigé           |"
    Write-Output "| :x:                | Fichier inexistant            |"

    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    Write-Output "|:hash:| Boréal :id: | README.md | images | DDL.sql | DML.sql | DQL.sql | DCL.sql | :mouse_trap: DB | :wood: log |"
    Write-Output "|------|-------------|-----------|--------|---------|---------|---------|---------|-----------------|------------|"
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.README -eq ":heavy_check_mark:" -and
        $Checks.Images -eq ":heavy_check_mark:" -and
        $Checks.DDL    -eq ":heavy_check_mark:" -and
        $Checks.DML    -eq ":heavy_check_mark:" -and
        $Checks.DQL    -eq ":heavy_check_mark:" -and
        $Checks.DCL    -eq ":heavy_check_mark:"
    )
}

function Write-StudentRow {
    param(
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [hashtable]$Checks,
        [string]$DbStatus,
        [string]$LogLink,
        [string]$ReadmePath
    )

    Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Checks.DDL) | $($Checks.DML) | $($Checks.DQL) | $($Checks.DCL) | $DbStatus | $LogLink |"
}

function Write-Summary {
    param(
        [int]$SuccessCount,
        [int]$TotalCount
    )

    $COUNT = "\$\frac{$SuccessCount}{$TotalCount}\$"

    if ($TotalCount -gt 0) {
        $STATS = [math]::Round(($SuccessCount * 100.0 / $TotalCount), 2)
    }
    else {
        $STATS = 0
    }

    $SUM = "\$\displaystyle\sum_{i=1}^{$TotalCount} s_i\$"

    Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $SuccessCount |"
}

