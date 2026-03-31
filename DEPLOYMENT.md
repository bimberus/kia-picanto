# Deployment Kia Picanto na Cloudflare Pages

## Repozytorium GitHub
https://github.com/bimberus/kia-picanto

## Deployment

### Opcja 1: Automatyczny deployment przez GitHub Actions

1. Ustaw secrets w repozytorium:
   - Przejdź do: https://github.com/bimberus/kia-picanto/settings/secrets/actions
   - Dodaj secrets z repozytorium `bimberus/giedy-cloudflared`:
     - `CLOUDFLARE_API_TOKEN`
     - `CLOUDFLARE_ACCOUNT_ID`

2. Push do brancha `master` automatycznie wdroży stronę

### Opcja 2: Lokalny deployment przez Wrangler

1. Zaloguj się do Cloudflare:
   ```powershell
   wrangler login
   ```

2. Uruchom skrypt deploymentu:
   ```powershell
   .\deploy-cloudflare.ps1
   ```

   Lub ręcznie:
   ```powershell
   # Deploy projektu
   wrangler pages deploy . --project-name=kia-picanto --branch=master
   
   # Dodaj custom domain
   wrangler pages domains add kia.lichocki.eu --project-name=kia-picanto
   ```

### Opcja 3: Ręcznie przez Cloudflare Dashboard

1. Przejdź do: https://dash.cloudflare.com/
2. Workers & Pages → Create application → Pages → Connect to Git
3. Wybierz repozytorium: `bimberus/kia-picanto`
4. Ustawienia build:
   - Build command: (brak)
   - Build output directory: `.`
   - Root directory: `/`
5. Po utworzeniu, dodaj custom domain w zakładce "Custom domains"

## Konfiguracja DNS

Cloudflare automatycznie skonfiguruje DNS jeśli domena `lichocki.eu` jest zarządzana przez Cloudflare.

Jeśli nie, dodaj ręcznie rekord:
- **Type**: CNAME
- **Name**: kia
- **Target**: kia-picanto.pages.dev
- **Proxy status**: Proxied (pomarańczowa chmurka)

## URLs

- **Production**: https://kia.lichocki.eu
- **Pages URL**: https://kia-picanto.pages.dev
- **GitHub**: https://github.com/bimberus/kia-picanto

## Notatki

- Projekt używa prostego HTML/CSS/JS - nie wymaga build process
- Wszystkie pliki są deployowane bezpośrednio
- Zdjęcia znajdują się w głównym katalogu i katalogu `backup/`
