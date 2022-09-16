def _make_symlink_impl(ctx):
  # Create the symlink (use run_shell so it runs remotely)
  sym = ctx.actions.declare_symlink(ctx.label.name + ".sym")
  ctx.actions.run_shell(
    outputs = [sym],
    command = "ln -s $1 $2",
    arguments = [ctx.attr.link_target, sym.path],
  )

  # Check that the symlink exists and points to the right place.
  out = ctx.actions.declare_file(ctx.label.name + ".out")
  ctx.actions.run_shell(
    inputs = [sym],
    outputs = [out],
    command = "[[ -L $1 && $(readlink $1) == $2 ]] && touch $3",
    arguments = [sym.path, ctx.attr.link_target, out.path],
  )

  return DefaultInfo(files = depset([out]))

make_symlink = rule(
  implementation = _make_symlink_impl,
  attrs = {
    "link_target": attr.string(mandatory = True),
  },
)
