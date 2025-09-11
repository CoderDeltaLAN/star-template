from importlib.metadata import PackageNotFoundError, version

try:
    __version__ = version("star-template-py")
except PackageNotFoundError:  # pragma: no cover
    __version__ = "0.0.0"  # pragma: no cover


def ping() -> str:
    return "pong"
