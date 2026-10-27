# Expo Crossy Road (org-kids-lab fork)

Voxel road-crossing game: Expo SDK 54 + expo-router, React Native Web, three.js 0.182 via expo-gl/expo-three, GSAP 2 for tweens.

## Commands

A `Makefile` wraps the common commands (`make` lists them): `make install`, `make start` (web dev, `PORT=` overridable), `make fresh` (cleared Metro cache), `make build`, `make prod`, `make typecheck`, `make lint`. The underlying commands:

- Install: `npm install` (needs the `overrides` for `expo-three` → `three` in package.json; do not remove it). `bun.lock` also exists from upstream; keep both lockfiles in sync if dependencies change.
- Dev (web): `npx expo start --web` → http://localhost:8081
- Production web build: `npx expo export -p web` (outputs `dist/`)
- Type check: `npx tsc --noEmit -p .`. The codebase is mostly untyped JS-in-TS, so ~550 pre-existing errors are the baseline (most are "Property X does not exist on type 'Engine'"). Judge changes by "no new kind of error", not by zero errors.
- There is no automated test suite.

## Layout

- `src/app/index.tsx`: game screen; owns `Engine`, game state (`src/state.ts`), score.
- `src/GameEngine.ts`: render loop, tick, hero movement (`moveWithDirection`), collisions → game over, GPU warm-up.
- `src/CrossyGame.ts`: scene, camera, renderer, `CrossyGameMap` (pooled rows: 20 each of grass/water/road/railroad, recycled by `newRow`).
- `src/Row/*`: per-row logic (moving cars, trains, logs, lily pads, hazard checks).
- `src/CrossyPlayer.ts`: hero; GSAP hop timelines.
- `src/Node/*`, `src/ModelLoader.ts`: voxel model loading; `getNode()`/`getRandom()` return clones.
- `src/components/GestureView.tsx` (web) / `.native.tsx`: keyboard + swipe input.
- `src/GameSettings.ts`: tuning constants.

## Invariants

- **Per-frame motion must be multiplied by `dtScale`** (the `dt` argument of `tick`/`update`, where 1 = one 60 FPS frame, capped at 3). Never add raw `+= speed` in the tick path. Use `1 - (1 - k) ** dtScale` for per-frame easing.
- Hop/scale animations are GSAP (time-based). A new hop must kill the previous hop's timelines (`skipPendingMovement`).
- New materials, textures or models must be reachable by `Engine.warmUpGPU()` (via `ModelLoader` nodes' `models`, or present in the scene at load) or they'll cause a first-appearance frame hitch.
- Keyboard input hops on `keydown` and ignores `e.repeat`.
- Audio is muted on web (`AudioManager` `MUTED`).

## Gotchas

- `CI=1 npx expo start` disables Metro file watching, so it serves stale code after edits. Restart it, or don't set CI, when verifying changes.
- WSL2 in NAT mode: Windows `localhost:8081` may not forward; use the WSL IP or mirrored networking.
- Headless Chromium uses SwiftShader (CPU WebGL): fine for relative perf comparisons and spotting spikes, not absolute FPS.
- The GameOver banners ("Subscribe", "Free Gift", "Coins") are hardcoded placeholders in `src/screens/GameOverScreen.tsx`.

## Git

- `origin` = github.com/org-kids-lab/Expo-Crossy-Road (this fork, push here); `upstream` = EvanBacon/Expo-Crossy-Road.
- Conventional commit prefixes (`fix:`, `perf:`, `docs:` …).
