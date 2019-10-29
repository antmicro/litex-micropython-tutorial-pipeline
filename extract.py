import tuttest
import sys
snippets = tuttest.get_snippets(sys.argv[1])

code = []
code.append(snippets['setup']['text'])
code.append("export HDMI2USB_UDEV_IGNORE=1 SKIP_IMAGE=1")
code.append(snippets['enter and build']['text'])
#code.append("export RENODE_NETWORK=none")
#code.append(snippets['simulate']['text'] + "--disable-xwt -e s -e 'sleep 5' -e q")


local = True if len(sys.argv) >= 3 else False
if local:
  # for local development, when the repo exists
  # and was (most probably) built already
  # remove two first lines from script, as we don't want to clone the repo
  # we will pull instead
  lines = code[0].split('\n')
  lines[0] = 'cd litex-buildenv'
  lines[1] = 'git pull'
  code[0] = '\n'.join(lines)

print("\n\n".join(code))
