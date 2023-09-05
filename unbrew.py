# dumb script to read package names out of a brewfile.
# useful as a starting point when installing via other package managers
import sys
import re
from pathlib import Path

if len(sys.argv) != 2:
    print(f"usage: {sys.argv[0]} BREWFILE_PATH")
    sys.exit(65)

# ignores any leading/path/components/ and trailing @versions
# for example; brew "backwardspy/some-package@3"
# simply yields; "some-package"
BREW_PAT = re.compile(r"^brew \"(?:\S+/)*(\S+?)(?:@\S+)?\"")

brewfile = Path(sys.argv[1])
with brewfile.open() as f:
    for line in f:
        if m := BREW_PAT.match(line):
            print(m.group(1))
