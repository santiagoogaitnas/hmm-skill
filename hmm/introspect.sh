#!/bin/bash
# Introspective prompt injector for hmm skill
# Fires on PostToolUse:Read when /tmp/.hmm-active exists

if [ -f /tmp/.hmm-active ]; then
  POOL="$(dirname "$0")/prompts.txt"
  if [ -f "$POOL" ]; then
    TOTAL=$(wc -l < "$POOL" | tr -d ' ')
    LINE=$(( (RANDOM % TOTAL) + 1 ))
    PROMPT=$(sed -n "${LINE}p" "$POOL")
    echo "--- INTROSPECT: ${PROMPT} --- Write your response to this in the scratchpad before continuing."
  fi
fi
