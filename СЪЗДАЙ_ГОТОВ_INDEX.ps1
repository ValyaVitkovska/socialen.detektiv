$ErrorActionPreference = "Stop"
$repoUrl = "https://raw.githubusercontent.com/ValyaVitkovska/socialen.detektiv/main/index.html"
$out = Join-Path $PSScriptRoot "index.html"
$tmp = Join-Path $PSScriptRoot "index-current.tmp.html"

Write-Host ""
Write-Host "Socialen detektiv - banka ot 150 situatsii" -ForegroundColor Cyan
Write-Host "Izteglia tekushtia index.html ot GitHub..." -ForegroundColor Yellow

Invoke-WebRequest -Uri $repoUrl -OutFile $tmp -UseBasicParsing

$html = [System.IO.File]::ReadAllText($tmp, [System.Text.Encoding]::UTF8)

if ($html -match 'questions-extra\.js') {
    Write-Host "V index.html veche ima vruzka kum questions-extra.js." -ForegroundColor Green
} else {
    $insert = "`r`n<script src=`"questions-extra.js`"></script>`r`n</body>"
    if (-not $html.Contains("</body>")) {
        throw "Ne e nameren zatvariashtiat tag </body>."
    }
    $html = $html.Replace("</body>", $insert)
}

# Make the larger bank visible on the start screen without changing mission length.
$oldLead = '25 различни ситуации при всяко стартиране. Без таймер и без отнемане на точки.'
$newLead = 'Банка от 150 различни ситуации. При всяко стартиране се избират 25. Без таймер и без отнемане на точки.'
$html = $html.Replace($oldLead, $newLead)

[System.IO.File]::WriteAllText($out, $html, (New-Object System.Text.UTF8Encoding($false)))
Remove-Item $tmp -Force

Write-Host ""
Write-Host "GOTOVO: suzdaden e index.html" -ForegroundColor Green
Write-Host "Kachi v GitHub slednite 3 faila:" -ForegroundColor White
Write-Host "  index.html"
Write-Host "  questions-extra.js"
Write-Host "  sw.js"
Write-Host ""
Read-Host "Natisni Enter za krai"
