# Changelog MoreLevels

## [Unreleased][unreleased]

### Added

- Add clear error messages for missing dependencies.
- Add toggle for XP multipliers so it's easy to change between saves, while remembering the previously set values.
- Add toggle for custom cyberware capacity increase per level. This allows for compatibility with other mods changing the same value.

### Changed

- Moved hardcoded UI values to translatable .archive file using wolvenkit and archivexl.

## [Version 1.2.0][1.2.0]

### Added

- Add more xp curve options.
- Add option to increase cyberware capacity per level.

### Changed

- Create xp curves using redscript instead of in a .archive file.
- Larger range of xp multiplier options (0.05 - 5.0 instead of 0.5 - 5.0).
- Use `Character.PlayerCyberwareSystem_inline11.value` instead of hardcoding 3 cyberware per level.
- Refactor code.

### Fixed

- Fixed - hopefully - users missing alternative xp curve. They're now created differently, and in a different location, so the .archive file is no longer necessary either. 

## [Version 1.1.0][1.1.0]

### Added

- Add increased maximum StreetCred level.
- Add xp curve for levels above 60.

### Changed

- Mod Settings is now an optional dependency.

## [Version 1.0.0][1.0.0] - 2025-07-17

### Added

- Add increased level cap.
- Add settings page through Mod Settings.
- Add XP multiplier sliders.
- Add cyberware cap scaling past 500 with increased levels.

[unreleased]: https://github.com/Dunc4nNT/cyberpunk-2077-modding/compare/morelevels-1.1.0...HEAD
[1.2.0]: https://github.com/Dunc4nNT/cyberpunk-2077-modding/compare/morelevels-1.1.0...morelevels-1.2.0
[1.1.0]: https://github.com/Dunc4nNT/cyberpunk-2077-modding/compare/morelevels-1.0.0...morelevels-1.1.0
[1.0.0]: https://github.com/Dunc4nNT/cyberpunk-2077-modding/releases/tag/morelevels-1.0.0
