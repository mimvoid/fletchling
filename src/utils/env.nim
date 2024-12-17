from std/envvars import existsEnv, getEnv

proc getEnvValues*(envVars: varargs[string]): string =
  for i in items(envVars):
    if not existsEnv(i): continue
    return getEnv(i)

  return ""
