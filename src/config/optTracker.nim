import std/strutils

type
  CopyOptTracker[T] = object
    value: T
    set = false

  OptTracker*[T] = ref CopyOptTracker[T]


func initOptTracker*[T](initValue: T): OptTracker[T] {.inline.} =
  OptTracker[T](value: initValue)

func get*[T](opt: OptTracker[T]): T = opt.value

func set*[T](opt: OptTracker[T], value: T) =
  opt.value = value
  opt.set = true

func setParse*[T](opt: OptTracker[T], value: string) =
  when T is bool:
    opt.set(parseBool(value))
  elif T is enum:
    opt.set(parseEnum[T](value))
  # Other types are unimplemented

func setBoolArg*(opt: OptTracker[bool], value: string) =
  if value == "":
    opt.set(true)
  else:
    opt.setParse(value)

func isSet*[T](opt: OptTracker[T]): bool = opt.set
