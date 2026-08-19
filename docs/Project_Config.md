# Project Config

This file summarizes the public project configuration for Coffee Journal.

## Runtime

- Framework: Flutter / Dart
- Target experience: mobile-first Flutter app
- Current public platform focus: Flutter Web preview and iOS prototype
- Package name: `coffee_journal`
- App version: `0.1.0+1`
- Dart SDK: `^3.8.0`

## Main Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

Current local preview convention:

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 5180
```

Local preview URL:

```text
http://127.0.0.1:5180
```

## Environment Variables

Environment variables are defined from `.env`.

Use `.env.example` as the template:

```bash
cp .env.example .env
```

Public template variables:

| Name | Purpose | Required for MVP |
|---|---|---|
| `APP_ENV` | App environment name, such as `development`. | No |
| `DEBUG` | Enables local debug behavior. | No |
| `AI_MODEL` | Placeholder model name for future AI message generation. | No |
| `AI_API_KEY` | Future AI API key. Do not commit real keys. | No |
| `REMOVE_BG_API_KEY` | Optional remove.bg key for MVP cutout processing. Do not commit real keys. | No |
| `SUPABASE_URL` | Future Supabase project URL. | No |
| `SUPABASE_ANON_KEY` | Future Supabase anon key. Do not commit real keys. | No |
| `STORAGE_BUCKET` | Future cloud storage bucket name. | No |

If `.env` is missing or not loaded, the app falls back safely and keeps MVP flows available.

## Dependencies

Core dependencies:

- `flutter_riverpod`: feature state and repositories
- `go_router`: app routing and record flow routes
- `flutter_dotenv`: local environment configuration
- `image_picker`: gallery image selection
- `path_provider`: local app document directory
- `http`: cutout API request pipeline
- `web`: browser local storage support for Web preview
- `flutter_svg`: SVG assets
- `isar` / `isar_flutter_libs`: reserved local database dependency

Test and lint:

- `flutter_test`
- `flutter_lints`

## Local Data

Coffee records are persisted locally.

- iOS / desktop-style builds: app document directory
- Web preview: browser localStorage
- Stored records include saved, edited, and soft-deleted Coffee Records

Current MVP storage is intentionally lightweight. It is designed so the app can later migrate to Isar, SQLite, Supabase, or another storage layer without rewriting the UI.

## Photo And Cutout

Photo flow:

1. User selects a photo from the gallery.
2. The original photo is saved locally.
3. The Coffee Record stores the original photo URL/path.
4. If `REMOVE_BG_API_KEY` is configured, background removal runs in the background.
5. Successful cutout output is saved and stored as `cutoutPhotoUrl`.
6. Journal and Coffee Memory prefer cutout output, then original photo, then fallback sticker.

Cutout fields:

- `photoUrl`: original selected photo
- `cutoutPhotoUrl`: transparent cutout result
- `cutoutStatus`: `idle`, `processing`, `success`, or `failed`
- `cutoutUpdatedAt`: last cutout status update time

Failure behavior:

- Record saving never waits for cutout.
- Cutout failure does not block the user.
- The app keeps showing the original photo when cutout is unavailable.

## iOS Notes

The iOS project includes:

- Flutter Runner project
- iOS Widget prototype under `ios/CoffeeJournalWidget`
- Photo Library usage description in `ios/Runner/Info.plist`
- URL scheme and widget bridge scaffolding

The current Widget is a prototype / preview, not a fully verified App Store production widget.

## Assets

Tracked public assets include:

- paper texture background
- coffee sticker images
- navigation SVG icons
- latte placeholder SVG

The current coffee sticker is a transparent PNG design asset. Real user photos are not automatically perfect cutouts unless the cutout API is configured and succeeds.

## Public Documentation

Tracked public docs:

- `README.md`: project overview for GitHub
- `docs/AI_Product_Workflow.md`: AI product manager workflow
- `docs/MVP_Release_Checklist.md`: MVP status and release boundary
- `docs/Project_Config.md`: this configuration summary

Local-only docs may exist in the workspace but are excluded from the public GitHub repo.

## Git Notes

The public repo is intentionally concise for portfolio presentation.

Local-only files excluded from Git include:

- detailed sprint log
- detailed internal product docs
- local platform folders not needed for public portfolio display
- real `.env` files

Never commit real API keys, local user data, selected photos, or generated cutout files.
