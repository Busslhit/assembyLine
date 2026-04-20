#!/usr/bin/env bash
set -euo pipefail
CONFIG_FILE="$(dirname "$0")/../pass_ons.conf"
INPUT_CHAIN="$*"

# Split by the '>' character
IFS='>' read -r -a STATIONS <<< "$INPUT_CHAIN"
PREV_OUTPUT=""

for station in "${STATIONS[@]}"; do
    # Regex extraction for model, prompt, and macro
    MODEL=$(echo "$station" | grep -oP '\(\K[^\)]+' || echo "llama3")
    PROMPT=$(echo "$station" | grep -oP '\["\K[^"]+' || echo "")
    PASS_KEY=$(echo "$station" | grep -oP '\[\K[^"\]]+(?=\])' | head -1 || echo "")
    
    # Fetch macro from config
    HIDDEN_INSTR=$(grep "^$PASS_KEY|" "$CONFIG_FILE" | cut -d'|' -f2- || echo "")
    
    # Construct Context-Aware Prompt
    FINAL_PROMPT="### AI ASSEMBLY LINE CONTEXT\n"
    if [ -n "$PROMPT" ]; then FINAL_PROMPT+="PRIMARY GOAL: $PROMPT\n"; fi
    if [ -n "$PREV_OUTPUT" ]; then FINAL_PROMPT+="\n### PREVIOUS MODEL OUTPUT:\n$PREV_OUTPUT\n"; fi
    if [ -n "$HIDDEN_INSTR" ]; then FINAL_PROMPT+="\n### YOUR SPECIFIC TASK (REFINEMENT):\n$HIDDEN_INSTR\n"; fi

    # Call Ollama
    PREV_OUTPUT=$(echo -e "$FINAL_PROMPT" | ollama run "$MODEL")
done

# Final result JSON for OpenClaw
printf '{"reply":"%s"}\n' "$(echo "$PREV_OUTPUT" | sed 's/"/\\"/g' | tr -d '\r')"
