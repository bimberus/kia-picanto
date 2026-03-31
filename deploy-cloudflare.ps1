# Skrypt do wdrożenia strony na Cloudflare Pages z custom domain
# Użycie: .\deploy-cloudflare.ps1

Write-Host "=== Deployment strony Kia Picanto na Cloudflare Pages ===" -ForegroundColor Green
Write-Host ""

# Krok 1: Logowanie lub użycie API tokena
Write-Host "Krok 1: Autoryzacja Cloudflare" -ForegroundColor Yellow
Write-Host "Opcja A: Zaloguj się przez przeglądarkę"
Write-Host "  wrangler login"
Write-Host ""
Write-Host "Opcja B: Użyj API tokena"
Write-Host "  Set environment variable: `$env:CLOUDFLARE_API_TOKEN='your-token'"
Write-Host "  Get token from: https://dash.cloudflare.com/profile/api-tokens"
Write-Host ""

$continue = Read-Host "Czy jesteś zalogowany lub masz ustawiony API token? (y/n)"
if ($continue -ne 'y') {
    Write-Host "Przerwano. Zaloguj się najpierw." -ForegroundColor Red
    exit
}

# Krok 2: Deploy projektu
Write-Host ""
Write-Host "Krok 2: Deployment projektu na Cloudflare Pages" -ForegroundColor Yellow
Write-Host "Wykonuję: wrangler pages deploy . --project-name=kia-picanto --branch=master"
wrangler pages deploy . --project-name=kia-picanto --branch=master

if ($LASTEXITCODE -ne 0) {
    Write-Host "Błąd podczas deploymentu!" -ForegroundColor Red
    exit
}

# Krok 3: Dodanie custom domain
Write-Host ""
Write-Host "Krok 3: Dodawanie custom domain: kia.lichocki.eu" -ForegroundColor Yellow
Write-Host "Wykonuję: wrangler pages domains add kia.lichocki.eu --project-name=kia-picanto"
wrangler pages domains add kia.lichocki.eu --project-name=kia-picanto

if ($LASTEXITCODE -ne 0) {
    Write-Host "Uwaga: Możliwe że domena już istnieje lub wymaga ręcznej konfiguracji" -ForegroundColor Yellow
}

# Krok 4: Informacje o DNS
Write-Host ""
Write-Host "Krok 4: Konfiguracja DNS" -ForegroundColor Yellow
Write-Host "Cloudflare powinien automatycznie skonfigurować DNS dla lichocki.eu"
Write-Host "Jeśli domena nie jest zarządzana przez Cloudflare, dodaj ręcznie:"
Write-Host "  Type: CNAME"
Write-Host "  Name: kia"
Write-Host "  Target: kia-picanto.pages.dev"
Write-Host ""
Write-Host "=== Deployment zakończony ===" -ForegroundColor Green
Write-Host "Twoja strona powinna być dostępna pod: https://kia.lichocki.eu"
Write-Host "Pages URL: https://kia-picanto.pages.dev"
