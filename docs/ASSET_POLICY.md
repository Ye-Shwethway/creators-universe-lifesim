# Asset Classification and Handling

## PUBLIC
Original code, procedural geometry, authored demo materials and third-party assets with independently verified redistribution licenses. Record author, source URL, exact license, changes and required attribution in assets/public/ASSET_CREDITS.md before adding external binaries.

## PRIVATE
Creator-approved character identity references, detailed canon, unreleased manuscripts, custom 3D models/textures, sensitive reference media, private save files and credentials. Do not commit to public Git; .gitignore is defense-in-depth, NOT an access control. Once committed, secrets may persist in history even if deleted later.

## Distribution
A private model embedded in a public APK or web bundle becomes extractable. Do not download private assets inside public runner jobs and then publish the output. Private variants require separate restricted build/asset pipelines and explicit Creator approval. Signed URLs are access controls for delivery, not DRM. Do not embed permanent credentials in clients.

## Initial MVP
Use authored procedural primitives and/or verified redistributable placeholder packs only. Avoid using the Creator's private images in CI. Store private master assets in a private Library/Drive vault; use object storage only if needed, with access control and cost guard. Keep game saves on user device initially.
