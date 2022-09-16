load(":defs.bzl", "make_symlink")

make_symlink(
  name = "symlink",
  link_target = "some/path",
)

platform(
  name = "rbe_ubuntu1804_java11_platform",
  exec_properties = {
    "dockerNetwork": "standard",
    "dockerPrivileged": "true",
    "Pool": "default",
  },
  parents = ["@rbe_ubuntu1804_java11//config:platform"],
)
