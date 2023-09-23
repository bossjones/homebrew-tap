#!/bin/sh
#
# Pre-commit hook runs brew style --fix on all staged ruby file
#
# File should be .git/hooks/pre-commit and executable
FILES_PATTERN='.*\.rb'

EXIT_STATUS=0
wipe="\033[1m\033[0m"
yellow='\033[1;33m'
# carriage return hack. Leave it on 2 lines.
cr='
'
for f in $(git diff --cached --name-only | grep -E $FILES_PATTERN)
do
  brew style --fix $f
  if [ $? -ne 0 ]; then
    # Build the list of unencrypted files if any
    BROKEN_FILES="$f$cr$BROKEN_FILES"
    EXIT_STATUS=1
  fi
done
if [ ! $EXIT_STATUS = 0 ] ; then
  echo '# COMMIT REJECTED'
  echo '# Looks brew style --fix needs to run again:'
  echo '#'
  while read -r line; do
    if [ -n "$line" ]; then
      echo -e "#\t${yellow}unencrypted:   $line${wipe}"
    fi
  done <<< "$BROKEN_FILES"
  echo '#'
  echo "# Please try to fix the formula styles them with 'brew style --fix <file>'"
  echo "#   (or force the commit with '--no-verify')."
  exit $EXIT_STATUS
fi
exit $EXIT_STATUS
