from std/appdirs import getConfigDir
import std/[paths, parsecfg]


func getVal*[T](cfg: Config, section, key: string, parser: proc, default: T): T =
  let val = cfg.getSectionValue(section, key)

  try:
    return parser(val)
  except ValueError:
    return default


let configFile* = $(getConfigDir() / Path("fletchling") / Path("config.ini"))
