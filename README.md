# Pull to Refresh Animation

This Flutter project showcases a custom pull-to-refresh implementation inspired by the bKash app's smooth and engaging animation.

## Preview

https://github.com/user-attachments/assets/54571159-6805-41bd-b16b-5d602a8a7bbc

## Features

- Smooth pull-to-refresh animation
- Rive-powered vector animations
- Custom physics and gesture handling
- bKash-inspired design

## Download

[Download APK](https://github.com/chayanforyou/bkash_pull_to_refresh_animation/releases/latest)

## How It Works

Pull-to-refresh is built from scratch in `lib/pull_refresh/`, with no refresh package:

- `pull_refresh_controller.dart` - Refresh state (idle, refreshing, finishing) and timing
- `pull_refresh_physics.dart` - Pull resistance, speed cap, and spring back
- `pull_refresh_scroll_view.dart` - Scroll view wired to the controller and physics
- `pull_refresh_indicator.dart` - Drives the Rive animation from pull distance and state

## Packages Used

- **rive** - For real-time interactive animation
- **sizer** - For screen-relative sizes
- **carousel_slider** - For the banner carousel
