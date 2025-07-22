# Cyberpunk 2077 Modding

This repository is a collection of things I've created in relation to [Cyberpunk 2077](https://www.cyberpunk.net) modding. Here you can find my mods.

## Downloads

All mod releases can be found on [NexusMods](https://next.nexusmods.com/profile/NeverToxic/mods?gameId=3333) and [GitHub](https://github.com/Dunc4nNT/cyberpunk-2077-modding/releases). Detailed instructions can be found on their respective pages.

## Documentation

Documentation for mods can be found on the [website](https://dunc4nnt.github.io/cyberpunk-2077-modding).

## Mods

[More Levels](https://www.nexusmods.com/cyberpunk2077/mods/22768) - Increase the maximum player and street cred level, and alter the rate at which you earn XP. Cyberware capacity can scale with the increased level.

## Compiling

Continue reading if you want to clone this repository and run it locally. Otherwise skip to the [next section](#contributing).

It is expected you have Cyberpunk 2077 installed, a working [python 3.13](https://www.python.org/downloads/) installation, and dependencies for the individual mod you'd like to install. Individual mods can be found in the `src/mods` directory, where README's can be found as well detailing installation instructions including dependencies.

### Installing and Distributing Mods

To install a mod locally, as well as packing it for release, can use the CLI script `scripts/main.py`. Please change the working directory to `scripts/` before running the script. You must also first edit `config.py.example` to `config.py` and change values as you like.

To install a mod, which copies a mod into your game's directory, you can run the following:

```console
$ cd scripts/
$ py main.py install ../src/mods/MoreLevels/
```

To pack a mod for release:

```console
$ cd scripts/
$ py main.py pack ../src/mods/MoreLevels/ 1.2.0
```

Both `install` and `pack` can take various arguments, refer to the help command for documentation.

```console
$ cd scripts/
$ py main.py -h
$ py main.py install -h
$ py main.py pack -h
```

## Contributing

If you'd like to help in the development of a mod, please read how you can [contribute](./.github/CONTRIBUTING.md).

## Support

See [SUPPORT.md](./.github/SUPPORT.md) for my contact information.

## Acknowledgements

<!-- TODO: acknowledgements -->

## Licensing

Copyright © 2025-2025 Dunc4nNT

This repository is licensed under the Mozilla Public License 2.0 (MPL 2.0). See [LICENSE](./LICENSE) for more information.
