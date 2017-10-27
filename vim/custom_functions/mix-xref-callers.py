# This has literally no error handling and only works for umbrella apps.
# Good luck.
from subprocess import check_output
import re
import vim

query = vim.eval("a:query")
output = check_output(["mix", "xref", "callers", query])
subapp_groups = re.split('==> ', output)[1:]

results = []
for grp in subapp_groups:
  subapp_lines = grp.split("\n")
  subapp_name = subapp_lines[0]
  occurrences = subapp_lines[1:-1]
  formatted_lines = map(
  lambda occurrence:
    "apps/{app_name}/{occurrence_path}".format(app_name=subapp_name, occurrence_path=occurrence),
  occurrences
  )
  results.extend(formatted_lines)

vim.command("cexpr []")
for result in results:
  vim.command("caddexpr('{result}')".format(result=result))

vim.command("copen")
