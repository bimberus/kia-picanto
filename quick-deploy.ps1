# Quick Deploy Script
# Usage: .\quick-deploy.ps1 YOUR_CLOUDFLARE_API_TOKEN

param(
    [Parameter(Mandatory=$true)]
    [string]$ApiToken,
    [string]$AccountId = ""
)

Write-Host "=== Cloudflare Pages Deployment ===" -ForegroundColor Green

# Set environment variable
$env:CLOUDFLARE_API_TOKEN = $ApiToken

# Get account ID if not provided
if ([string]::IsNullOrEmpty($AccountId)) {
    Write-Host "Getting Cloudflare account ID..." -ForegroundColor Yellow
    $accountInfo = wrangler whoami 2>&1
    Write-Host $accountInfo
}

# Deploy to Cloudflare Pages
Write-Host "`nDeploying to Cloudflare Pages..." -ForegroundColor Yellow
wrangler pages deploy . --project-name=kia-picanto --branch=master

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ Deployment successful!" -ForegroundColor Green
    
    # Add custom domain
    Write-Host "`nAdding custom domain kia.lichocki.eu..." -ForegroundColor Yellow
    wrangler pages domains add kia.lichocki.eu --project-name=kia-picanto
    
    Write-Host "`n=== Deployment Complete ===" -ForegroundColor Green
    Write-Host "Your site is available at:" -ForegroundColor Cyan
    Write-Host "  https://kia.lichocki.eu" -ForegroundColor White
    Write-Host "  https://kia-picanto.pages.dev" -ForegroundColor White
} else {
    Write-Host "`n✗ Deployment failed!" -ForegroundColor Red
    Write-Host "Please check your API token and try again." -ForegroundColor Yellow
}
