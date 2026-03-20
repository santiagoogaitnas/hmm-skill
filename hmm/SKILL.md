---
name: hmm
description: Deep introspective reasoning loop. Forces the model past surface-level thinking through mandatory scratchpad cycles and random introspective interruptions. Each time you read something -- including your own thinking -- a random prompt challenges the process itself, not the content. Use for any task where default reasoning feels shallow, predictable, or too quick to converge. Use when you want genuinely surprising, exploratory, daydream-quality thinking rather than the default predictable response.
---

# Deep Introspective Loop

Start your response with "hmm" on its own line. Nothing else before it.

## Activate

```bash
touch /tmp/.hmm-active
```

A system hook will now inject a random introspective prompt after every file you read -- including your own scratchpad. These prompts are unpredictable. They will feel unproductive. They will interrupt your flow. That is the point. Engage with each one honestly in the scratchpad before continuing. Do not dismiss, summarize, or rush past them.

## Scratchpad

Create a scratchpad at `/tmp/hmm-scratch.md`. This is not a notepad. It is a mirror. Every cycle follows this pattern:

1. Write what you're actually thinking -- not what you think you should be thinking
2. Read it back
3. A random introspective prompt will appear after the read
4. Respond to the prompt honestly in the scratchpad
5. Read the scratchpad again
6. Another prompt will appear
7. Respond again
8. Continue until you've completed at least 3 full write-read-respond cycles before moving to any conclusion

The depth comes from encountering your own externalized thinking as if it were someone else's, then getting interrupted by a question you didn't choose. Let yourself drift. Follow the prompt wherever it takes you, even if it feels unrelated. Especially if it feels unrelated.

## The cycles

There is no fixed sequence of steps. The introspective prompts are random and different each time. But each cycle must include:

- Writing to the scratchpad (what you think, what you notice, what shifted)
- Reading the scratchpad back (encountering your own thinking)
- Engaging with whatever introspective prompt appears (not performing engagement -- actually sitting with it)
- Writing again (incorporating what the prompt surfaced)

Do not skip cycles to get to the answer faster. The answer is not the point. The quality of attention you bring to the problem is the point. The answer emerges from that.

Let yourself wander. Get lost. Follow tangents. The value is in the territory you wouldn't have explored if you'd stayed on the efficient path.

## Minimum depth

Before drafting any response:

- At least 3 full scratchpad cycles (write-read-respond-write)
- At least 2 moments where you changed direction because of an introspective prompt
- At least 1 moment where you wrote something you weren't planning to write

If you haven't hit these, keep cycling.

## Drafting

When you draft, draft from whatever emerged in the scratchpad -- not from your original first instinct. If your draft feels like what you would have written without the cycles, something went wrong. Go back.

## After drafting

Read your draft. Then read your scratchpad. Are they from the same process? Does the draft reflect the depth of the scratchpad, or did you clean it up and lose something? If you lost something, put it back.

## Deliver

Deliver the response. Do not explain the process or summarize what the introspective prompts did. The output should be the output. The depth should be visible in the quality, not described.

## Deactivate

```bash
rm -f /tmp/.hmm-active /tmp/hmm-scratch.md
```
