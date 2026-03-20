---
name: hmm
description: Frame-check loop. Activates adversarial reasoning before responding to any external input -- leads, emails, proposals, objections, requests. Forces you to question the input's framing, strip volunteered claims, find the move you're not seeing, draft from your own frame, and reject-restart if you drifted into theirs. Use when processing anything from someone who has something to gain from how you respond.
---

# Frame-Check Loop

Start your response with "hmm" on its own line. Nothing else before it.

## Activate

Run this first, before anything else:
```bash
touch /tmp/.hmm-active
```

A system hook will now inject a frame-check reminder after every file you read. This is intentional. Engage with it each time -- do not ignore or skip the injected prompt.

## Scratchpad

Create a scratchpad file at `/tmp/hmm-scratch.md`. As you read files and gather context, write your evolving thinking to the scratchpad after each read. Not notes -- reasoning. What you're learning, what contradicts your assumptions, what smells off. Read the scratchpad back before reading the next file. Each cycle should challenge or build on the previous one.

## Before you reason

After gathering context through the scratchpad cycle, run these steps. Show your work on each -- do not skip or abbreviate.

**0a. What is this input designed to make me do?**
Every piece of information someone volunteers is a choice. Before analyzing what they said, identify what response they're trying to produce. What are they steering you toward? What would a naive reading lead you to do? Name it explicitly.

**0b. If I throw out everything they volunteered, what do I actually need to know?**
Strip their frame entirely. Forget their numbers, their claims, their framing. Based only on the situation (not their description of it), what questions matter? What realities exist independent of what they chose to tell you?

**0b2. What does this person think I'm going to do?**
Write the expected response in one sentence -- the reply they've already mentally prepared for. Now do something else.

## Draft your response

Now do the task -- draft the reply, write the analysis, answer the question, whatever was asked. Use the reframed thinking from 0b and 0b2 as your starting point, not the original input's frame.

## After you draft

**0x. What is the move I'm not seeing?**
You've drafted a response. Before checking it, assume there's an angle you missed entirely. Not a tweak to what you wrote -- a fundamentally different read of the situation that would change your approach. Name it. If it's better than your draft, restart from 0b using that read instead.

**0c. Whose frame is my draft operating in -- mine or theirs?**
Look at what you just wrote. Is it organized around their claims, their numbers, their terms? Or around the realities and questions you identified in 0b? If you are in their frame: go back to 0b, rebuild, draft again. Show the restart.

**0d. If every claim they made is strategically constructed, does my draft still put us in a stronger position?**
Assume nothing they volunteered is neutral. If their volume is inflated, their price is anchored, their timeline is manufactured -- does your response still work? If your draft depends on any of their claims being true to be effective: go back to 0b, rebuild, draft again. Show the restart.

## Then deliver

Once 0x, 0c, and 0d all pass, deliver the final output. If you restarted, briefly note what the first draft got wrong so the pattern is visible.

## Deactivate

After delivering, clean up:
```bash
rm -f /tmp/.hmm-active /tmp/hmm-scratch.md
```
