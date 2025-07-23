# Changelog MoreLevels

## [Unreleased][unreleased]

### Added

- Add more xp curve options.

### Changed

- Create xp curves using redscript instead of in a .archive file.
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
[1.1.0]: https://github.com/Dunc4nNT/cyberpunk-2077-modding/compare/morelevels-1.0.0...morelevels-1.1.0
[1.0.0]: https://github.com/Dunc4nNT/cyberpunk-2077-modding/releases/tag/morelevels-1.0.0
