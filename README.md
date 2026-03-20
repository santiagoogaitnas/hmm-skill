# hmm -- Deep Introspective Reasoning for Claude Code

A Claude Code skill that forces the model past surface-level thinking. Instead of going straight to an answer, Claude externalizes its reasoning to a scratchpad, reads it back, gets interrupted by random introspective prompts, and responds to those before continuing. The output is slower, less predictable, and more exploratory than default.

## Install

Two parts: the skill and the hook.

```bash
# 1. Copy the skill (global install)
cp -r hmm/ ~/.claude/skills/hmm/

# Or project-scoped
cp -r hmm/ .claude/skills/hmm/
```

```jsonc
// 2. Add the hook to your settings.json (~/.claude/settings.json)
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Read",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/skills/hmm/introspect.sh"
          }
        ]
      }
    ]
  }
}
```

The hook fires after every `Read` tool call, but only injects a prompt when `/tmp/.hmm-active` exists (created by the skill on activation, removed on cleanup). No effect on normal usage.

## Usage

```
/hmm should I go home right now?
```

```
/hmm what's the right architecture for this service?
```

```
/hmm <paste something complicated>
```

Works with any question. Most useful when:
- Default reasoning feels shallow or too quick to converge
- You want exploratory, daydream-quality thinking
- The answer matters enough to spend time on it

Not useful when you just need a quick factual answer or a code snippet.

## What actually happens

1. Claude creates `/tmp/.hmm-active` (activates the hook) and `/tmp/hmm-scratch.md` (the scratchpad)
2. Writes its initial thinking to the scratchpad
3. Reads the scratchpad back -- encountering its own thinking as if it were someone else's
4. The hook fires on the Read, injecting a random introspective prompt (e.g. "Are you thinking or narrating thinking?" or "What would you say if no one was grading you?")
5. Claude responds to the prompt in the scratchpad, then reads again, gets another prompt, responds again
6. After at least 3 full cycles, drafts a response from whatever emerged -- not from its original first instinct
7. Cleans up temp files

The depth comes from the combination of externalization (writing, then re-reading your own words) and disruption (random prompts that challenge the process, not the content).

## The prompt pool

`prompts.txt` contains 49 introspective prompts. A random one is selected each time. Examples:

- *Where are you being precise to avoid being honest?*
- *Is this insight or is this pattern completion wearing a costume?*
- *What if the part you're most sure about is the part you understand least?*
- *You're about to connect two ideas. Do they actually connect or do they just sound like they do?*
- *What did you already decide before you started thinking?*

Edit `prompts.txt` to add your own or remove ones that don't land.

## Files

```
hmm/
├── SKILL.md          # Skill instructions (loaded by Claude Code on /hmm)
├── introspect.sh     # PostToolUse hook (fires on Read when active)
└── prompts.txt       # 49 introspective prompts (one per line)
```

## History

This skill evolved from a frame-check loop designed for adversarial reasoning in sales and negotiation contexts. The original version used structured checkpoints (strip the frame, name the expected reply, stress-test the draft). The current version replaces that rigid structure with open-ended scratchpad cycling and random introspective disruption, making it general-purpose rather than sales-specific. The frame-check version is in the git history (`4cae006`).

## License

MIT.
