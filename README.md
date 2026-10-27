<!-- Banner Image -->

[![Expo](/.style/header.png)](https://crossyroad.expo.app/)

<p align="center">
  <a aria-label="try expo crossy road in the browser" href="https://crossyroad.expo.app/"><b>Try in the Browser</b></a>
</p>


[![Open in Expo Agent](https://agent.expo.dev/static/badge.svg)](https://agent.expo.dev/github/evanbacon/expo-crossy-road/tree/master)

  
---

This is **strictly** for educational purposes only.

## Models

I created the models using the open source project [MagicaVoxel](https://ephtracy.github.io/).

<!-- Expo: https://exp.host/@bacon/crossy-road -->

![Why did the chicken cross the road? Because, yolo](https://media.giphy.com/media/UAxmnxRLkmHEQ/200w_d.gif?raw=true "Preview Gif 😀 ...I love you")

[![reactnative.gallery](https://img.shields.io/badge/reactnative.gallery-%F0%9F%8E%AC-green.svg)](https://reactnative.gallery)

## Stack

- [Expo](http://expo.io) (ios, android, web)
- [React Native for web](https://baconbrix.gitbook.io/react-native-web/) (web)
- [React Native](http://reactnative.dev/) (ios, android)
- [THREE.js](https://threejs.org/) for rendering
- [GSAP](https://greensock.com/) for animating

## Getting started

```sh
make install   # npm install
make start     # web dev server → http://localhost:8081
make           # list all commands (build, prod, fresh, typecheck, lint, …)
```

`make start PORT=8090` uses another port. Without `make`:
`npm install` (or `bun install`) and `npx expo start --web`.

`package.json` contains an npm `overrides` entry for `expo-three` → `three`.
`expo-three@8` still declares `peer three@^0.166.0` while this project uses
`three@0.182.0`; without the override `npm install` fails with `ERESOLVE`.

Production web build:

```sh
make prod   # = npx expo export -p web (→ dist/) + npx serve dist
```

### Controls

| Action | Keyboard | Touch |
|---|---|---|
| Hop forward | `↑` / `W` / `Space` | tap or swipe up |
| Hop back | `↓` / `S` | swipe down |
| Hop left / right | `←` `→` / `A` `D` | swipe left / right |

Keyboard hops fire on key **press**; holding a key gives a single hop.

### Running in WSL2

If `http://localhost:8081` refuses to connect from the Windows browser, open
`http://<WSL IP>:8081` instead (the IP is shown as `exp://…` in the Metro
output), or enable `networkingMode=mirrored` under `[wsl2]` in
`%USERPROFILE%\.wslconfig` and run `wsl --shutdown`.

If the game runs in slow motion or stutters, check that the browser uses the
GPU: `chrome://gpu` should report WebGL as *Hardware accelerated*.

## Performance notes

- **Frame-rate independent movement.** The render loop passes `dtScale`
  (elapsed time ÷ one 60 FPS frame, capped at 3) through `tick`; all
  per-frame motion (cars, trains, logs, riding, camera easing) is scaled by
  it. Speeds are tuned for 60 FPS.
- **GPU warm-up.** `Engine.warmUpGPU()` compiles all shaders, uploads all
  textures and draws every model once into a 1×1 viewport before the first
  frame, so new object types don't stall a frame when they first appear.
- **Hop animations** are GSAP timelines. Starting a new hop kills the
  previous hop's timelines (`CrossyPlayer.skipPendingMovement`), otherwise
  the old landing tween pulls the hero backwards.

## Disclaimer

I am in no way associated with Hipster Whale.

I am using this copyrighted work under the [fair use/educational purpose doctrine](http://fairuse.stanford.edu/overview/academic-and-educational-permissions/non-coursepack/). For **free** community education.

## License

The game's source code is made available under the [MIT license](LICENSE). Some of the dependencies are licensed differently, with the BSD license, for example.

<!-- Footer -->

---

<p>
    <a aria-label="sponsored by my mommy" href="http://expo.io">
        <img src="https://img.shields.io/badge/I_EAT-SOYLENT-4630EB.svg?style=for-the-badge&logo=GITHUB&labelColor=000&logoColor=fff" target="_blank" />
    </a>
    <a aria-label="expo-crossy-road is free to use" href="/LICENSE" target="_blank">
        <img align="right" alt="License: MIT" src="https://img.shields.io/badge/License-MIT-success.svg?style=for-the-badge&color=33CC12" target="_blank" />
    </a>
</p>
