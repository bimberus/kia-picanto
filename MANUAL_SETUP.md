# MANUAL SETUP REQUIRED

Token API który podałeś wydaje się być niepełny lub nieprawidłowy.

## Szybka konfiguracja przez Cloudflare Dashboard (5 minut):

1. **Zaloguj się do Cloudflare Dashboard**
   https://dash.cloudflare.com/

2. **Przejdź do Workers & Pages**
   https://dash.cloudflare.com/?to=/:account/workers-and-pages

3. **Kliknij "Create application" → "Pages" → "Connect to Git"**

4. **Wybierz repozytorium GitHub:**
   - `bimberus/kia-picanto`
   - Branch: `master`

5. **Ustawienia build:**
   - Framework preset: `None`
   - Build command: (zostaw puste)
   - Build output directory: `.`
   - Root directory: `/`

6. **Kliknij "Save and Deploy"**

7. **Dodaj Custom Domain:**
   - Po deploymencie, przejdź do zakładki "Custom domains"
   - Kliknij "Set up a custom domain"
   - Wprowadź: `kia.lichocki.eu`
   - Cloudflare automatycznie skonfiguruje DNS

## Gotowe!

Strona będzie dostępna pod:
- https://kia.lichocki.eu (po konfiguracji DNS - 1-2 minuty)
- https://kia-picanto.pages.dev (natychmiast)

---

## Alternatywnie - Automatyczny deployment przez GitHub Actions:

Jeśli masz pełny API Token i Account ID:

```bash
# Ustaw secrets:
gh secret set CLOUDFLARE_API_TOKEN --body "YOUR_FULL_TOKEN" --repo bimberus/kia-picanto
gh secret set CLOUDFLARE_ACCOUNT_ID --body "YOUR_ACCOUNT_ID" --repo bimberus/kia-picanto

# Następny push automatycznie wdroży stronę
git push
```
