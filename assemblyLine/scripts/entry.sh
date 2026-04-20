#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR=".openclaw/workspace/skills/assemblyLine"
CMD="$*"

# Handle Template Generation: /assemblyLine template[N]
if [[ "$CMD" =~ template\[([0-9]+)\] ]]; then
    LEN="${BASH_REMATCH[1]}"
    TPL=""
    for ((i=1; i<=LEN; i++)); do
        TPL+="(model$i) + [\"prompt$i\" + [macro]]"
        if [ $i -lt $LEN ]; then TPL+=" > "; fi
    done
    echo "Use this template for a $LEN-step chain:"
    echo "/assemblyLine $TPL"

# Handle Help
elif [[ "$CMD" == "help" ]]; then
    cat "$ROOT_DIR/README.md"
    echo -e "\nAvailable Macros in pass_ons.conf:"
    cat "$ROOT_DIR/pass_ons.conf"

# Execute the Chain
else
    bash "$ROOT_DIR/scripts/run-chain.sh" "$CMD"
fi
