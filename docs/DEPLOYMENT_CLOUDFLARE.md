# Cloudflare Pages Deployment
Date: 2026-10-16
State: INFRASTRUCTURE_CREATED; PRODUCTION_DEPLOYMENT_PENDING.

## Observed Cloudflare owner state
Account: configured Cloudflare connection.
Existing and untouched project: ianeo-spatial-forge (forge.drthorne.uk).
New independent Direct Upload Pages project: creators-universe-lifesim.
Pages fallback hostname: creators-universe-lifesim.pages.dev.
Custom hostname: lifesim.drthorne.uk.
DNS: proxied CNAME lifesim.drthorne.uk -> creators-universe-lifesim.pages.dev.
Custom domain verification is active but Pages domain status was pending during last read. No deployment existed at last read.

Git-connected project creation returned Cloudflare error 8000011 (internal Git installation issue); used Direct Upload Pages project instead. Do NOT claim Git-native integration exists.

## CI deploy
Workflow: .github/workflows/deploy-pages.yml
Workflow uses pinned Godot 4.7.2 headless Web build, then wrangler@4 pages deploy.
Repo secrets expected: CLOUDFLARE_API_TOKEN (scoped Pages Write token) and CLOUDFLARE_ACCOUNT_ID.
At last check, repository had ZERO Actions secrets. Workflow is intentionally gated and cannot deploy yet. Never place token in public source, logs, docs or generated artifacts.

## Acceptance gates
1. Credentials provisioned securely into repository secrets, and least-privilege reviewed.
2. Dispatch deployment workflow and poll GitHub Actions jobs to success; record artifact/run SHA and logs.
3. Cloudflare Pages deployment exists and success/read-back confirms main branch.
4. DNS/Pages custom domain status reaches active.
5. HTTPS GET of custom domain returns real Godot build; browser/WebGL2 runtime launched on Redmi K70 (Creator device evidence).
6. Assets remain public-only; no private character data shipped.
