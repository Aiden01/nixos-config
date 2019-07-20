{}:
let
  withHome = x: builtins.getEnv "HOME" + x;
  path = [
    (withHome "/.local/bin")
    "/libexec"
  ];

in
{
  path = path;
}
