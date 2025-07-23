import argparse
import shutil
from pathlib import Path

from config import (
    ARCHIVEXL_FOLDER_NAME,
    CP2077_FOLDER,
    DIST_FOLDER,
    LICENSE_FILE,
    REDSCRIPT_FOLDER_NAME,
    TEMP_FOLDER,
    WOLVENKIT_FOLDER_NAME,
)


def _copy_mod_files(
    mod_name: str, reds_path: Path, wkit_path: Path, archivexl_path: Path, license_file: Path, out_dir: Path
) -> None:
    if reds_path.exists():
        reds_out_path: Path = Path(out_dir / "r6/scripts" / mod_name)
        reds_out_path.mkdir(parents=True, exist_ok=True)

        shutil.copytree(reds_path, reds_out_path, dirs_exist_ok=True)

        if license_file.exists():
            shutil.copy(license_file, reds_out_path)

    wkit_path /= f"{mod_name}/packed"
    if wkit_path.exists():
        wkit_out_path: Path = Path(out_dir / "archive/pc/mod")
        wkit_out_path.mkdir(parents=True, exist_ok=True)

        for wkit_file in wkit_path.glob("**/*.archive*"):
            shutil.copy(wkit_file, wkit_out_path)

    if archivexl_path.exists():
        archivexl_out_path: Path = Path(out_dir / "archive/pc/mod")
        archivexl_out_path.mkdir(parents=True, exist_ok=True)

        for archivexl_file in archivexl_path.glob("**/*.archive.xl"):
            shutil.copy(archivexl_file, archivexl_out_path)


def install_mods(parser: argparse.ArgumentParser, args: argparse.Namespace) -> None:
    mod_path: Path = Path(args.mod_directory)
    game_path: Path = Path(args.game_directory)
    mod_name: str = args.mod_name or mod_path.name
    reds_path: Path = mod_path / Path(args.redscript_folder_name or REDSCRIPT_FOLDER_NAME)
    wkit_path: Path = mod_path / Path(args.wolvenkit_folder_name or WOLVENKIT_FOLDER_NAME)
    archivexl_path: Path = mod_path / Path(args.archivexl_folder_name or ARCHIVEXL_FOLDER_NAME)
    license_file: Path = Path(args.license_file or LICENSE_FILE)

    _copy_mod_files(
        mod_name=mod_name,
        reds_path=reds_path,
        wkit_path=wkit_path,
        archivexl_path=archivexl_path,
        license_file=license_file,
        out_dir=game_path,
    )

    print(f"Successfully installed {mod_name} into {game_path.resolve()}.")


def pack_mods(parser: argparse.ArgumentParser, args: argparse.Namespace) -> None:
    mod_path: Path = Path(args.mod_directory)
    mod_version: str = args.version
    mod_name: str = args.mod_name or mod_path.name
    temp_path: Path = Path(args.temp_directory / Path(f"{mod_name}-{mod_version}"))
    dist_path: Path = Path(args.destination) / mod_name
    reds_path: Path = mod_path / Path(args.redscript_folder_name or REDSCRIPT_FOLDER_NAME)
    wkit_path: Path = mod_path / Path(args.wolvenkit_folder_name or WOLVENKIT_FOLDER_NAME)
    archivexl_path: Path = mod_path / Path(args.archivexl_folder_name or ARCHIVEXL_FOLDER_NAME)
    license_file: Path = Path(args.license_file or LICENSE_FILE)

    temp_path.mkdir(parents=True, exist_ok=True)

    _copy_mod_files(
        mod_name=mod_name,
        reds_path=reds_path,
        wkit_path=wkit_path,
        archivexl_path=archivexl_path,
        license_file=license_file,
        out_dir=temp_path,
    )

    dist_file: Path = dist_path / Path(f"{mod_name}-{mod_version}")

    shutil.make_archive(str(dist_file), "zip", temp_path)

    shutil.rmtree(temp_path)

    print(f"Successfully packed {mod_name} for release as {dist_file.resolve()}")


def install_args(
    parser: argparse.ArgumentParser,
) -> None:
    parser.set_defaults(func=install_mods)

    parser.add_argument(
        "mod_directory",
        help="The mod's directory.",
    )
    parser.add_argument(
        "--game-directory",
        "-game-dir",
        help="The game's directory. Defauls to config.CP2077_FOLDER",
        default=CP2077_FOLDER,
    )
    parser.add_argument(
        "--mod-name",
        help="The name of the mod to use for output directories. Defaults to the mod's directory name.",
    )
    parser.add_argument(
        "--redscript-folder-name",
        "-reds",
        help="The name of the folder rescript files are stored in. Defaults to config.REDSCRIPT_FOLDER_NAME",
        default=REDSCRIPT_FOLDER_NAME,
    )
    parser.add_argument(
        "--wolvenkit-folder-name",
        "-wkit",
        help="The name of the folder wolvenkit files are stored in. Defaults to config.WOLVENKIT_FOLDER_NAME",
        default=WOLVENKIT_FOLDER_NAME,
    )
    parser.add_argument(
        "--archivexl-folder-name",
        "-archivexl",
        help="The name of the folder archivexl files are stored in. Defaults to config.ARCHIVEXL_FOLDER_NAME",
        default=ARCHIVEXL_FOLDER_NAME,
    )
    parser.add_argument(
        "--license-file",
        "-license",
        help="License file to include if --include-license is true. Defaults to config.LICENSE_FILE",
        default=LICENSE_FILE,
    )


def pack_args(
    parser: argparse.ArgumentParser,
) -> None:
    parser.set_defaults(func=pack_mods)

    parser.add_argument(
        "mod_directory",
        help="The mod's directory.",
    )
    parser.add_argument(
        "version",
        help="Version of the mod.",
    )
    parser.add_argument(
        "destination",
        help="Destination directory for packed files.",
        nargs="?",
        default=DIST_FOLDER,
    )
    parser.add_argument(
        "--mod-name",
        help="The name of the mod to use for output directories. Defaults to the mod's directory name.",
    )
    parser.add_argument(
        "--temp-directory",
        "-temp",
        help="Temporary directory prepare release files. Defaults to config.TEMP_FOLDER",
        default=TEMP_FOLDER,
    )
    parser.add_argument(
        "--redscript-folder-name",
        "-reds",
        help="The name of the folder rescript files are stored in. Defaults to config.REDSCRIPT_FOLDER_NAME",
        default=REDSCRIPT_FOLDER_NAME,
    )
    parser.add_argument(
        "--wolvenkit-folder-name",
        "-wolvenkit",
        help="The name of the folder wolvenkit files are stored in. Defaults to config.WOLVENKIT_FOLDER_NAME",
        default=WOLVENKIT_FOLDER_NAME,
    )
    parser.add_argument(
        "--archivexl-folder-name",
        "-archivexl",
        help="The name of the folder archivexl files are stored in. Defaults to config.ARCHIVEXL_FOLDER_NAME",
        default=ARCHIVEXL_FOLDER_NAME,
    )
    parser.add_argument(
        "--license-file",
        help="License file to include if --include-license is true. Defaults to config.LICENSE_FILE",
        default=LICENSE_FILE,
    )


def core(parser: argparse.ArgumentParser, args: argparse.Namespace) -> None:
    parser.print_help()


def parse_args() -> tuple[argparse.ArgumentParser, argparse.Namespace]:
    parser: argparse.ArgumentParser = argparse.ArgumentParser("cp2077_scripts")
    parser.set_defaults(func=core)

    subparser: argparse._SubParsersAction[argparse.ArgumentParser] = parser.add_subparsers()  # type: ignore[reportPrivateUsage]

    install_parser: argparse.ArgumentParser = subparser.add_parser(
        name="install", help="Install mods to the cp2077 directory."
    )
    install_args(install_parser)
    pack_parser: argparse.ArgumentParser = subparser.add_parser(name="pack", help="Pack mods for a release.")
    pack_args(pack_parser)

    return parser, parser.parse_args()


def main() -> None:
    parser, args = parse_args()
    args.func(parser, args)


if __name__ == "__main__":
    main()
