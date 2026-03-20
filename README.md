# hmm -- Frame-Check Loop for Claude Code

A Claude Code skill that activates adversarial reasoning before you respond to external input. Leads, emails, proposals, objections, requests -- anything from someone who has something to gain from how you respond.

## What it does

When you type `/hmm` before processing external input, Claude runs a structured frame-check loop instead of responding directly. It:

1. **Identifies the designed response** -- what is this input trying to make you do?
2. **Strips the volunteered frame** -- forgets their claims and asks what actually matters
3. **Names the expected reply** -- writes the response they prepared for, then does something else
4. **Drafts from your frame** -- builds the response from your realities, not their framing
5. **Post-draft validation** -- three checks that catch frame drift, hidden angles, and dependency on unverified claims
6. **Restart trigger** -- if any check fails, the draft is discarded and rebuilt from scratch

## Install

Copy the `hmm/` folder into your Claude Code skills directory:

```bash
# Global (available in all projects)
cp -r hmm/ ~/.claude/skills/hmm/

# Project-scoped (available in one project)
cp -r hmm/ .claude/skills/hmm/
```

That's it. `/hmm` is now available as a skill.

## Usage

When you have external input to process -- a vendor email, a negotiation, a proposal, a sales pitch -- paste or describe it and invoke the skill:

```
/hmm

Here's the email from the supplier:
"We're offering 15% off if you sign by Friday..."
```

Claude will run the full frame-check loop before responding.

## How it compares to default reasoning

The difference isn't speed or word count -- it's structure. Here's a side-by-side using a generic scenario.

### Scenario

> A SaaS vendor emails you: "We're consolidating pricing tiers next quarter. Your current plan ($800/mo) is being discontinued. We'd like to offer you a smooth transition to our Growth plan at $1,200/mo -- that's 20% below list price, locked in for 12 months if you sign by March 30."

---

### Without hmm (default Claude response)

> "This is a reasonable offer. The 20% discount brings the Growth plan close to your current spend, and the 12-month lock protects against further increases. Key considerations:
> - The $400/mo increase is significant (~50% jump)
> - The 12-month commitment reduces flexibility
> - You should ask what features the Growth plan adds
> - Consider whether competitors offer better value
>
> I'd recommend negotiating for a longer lock period or a smaller increase."

The response is helpful but operates entirely inside the vendor's frame. It accepts the tier discontinuation as fact, treats the "20% discount" as a real concession, and organizes the analysis around their numbers.

---

### With hmm (frame-checked response)

The skill forces six checkpoints before delivery. Here's what changes:

**0a -- What is this input designed to make me do?**
Sign quickly. The deadline, the "discount," the framing of discontinuation -- all push toward a fast yes. The email is structured to make delay feel risky.

**0b -- Strip the frame. What do I actually need to know?**
- Is the tier actually being discontinued, or is this a retention play?
- What is the real market rate for equivalent service?
- What is my actual switching cost if I left?
- Do I have leverage I'm not using (contract terms, usage data, competitor quotes)?

**0b2 -- What do they expect me to do?**
They expect me to negotiate within their frame -- maybe ask for 25% off instead of 20%, or request 18 months instead of 12. A counteroffer that still results in a signed contract by March 30.

**Draft (from my frame):**
Don't negotiate the number yet. First, verify the discontinuation claim independently (check their public pricing page, ask other customers, review your contract for price-protection clauses). Second, get a competing quote -- even if you don't intend to switch, it establishes your BATNA. Third, if you do engage, anchor on your current price as the baseline, not their "discounted" Growth price.

**0x -- What am I not seeing?**
The vendor may be under pressure to lock in annual commitments before their quarter ends. The March 30 deadline might be their constraint, not yours. If true, waiting past that date could yield a better offer, not a worse one.

**0c -- Frame check:** Draft is organized around my questions (is the discontinuation real, what's my leverage, what's the market rate) -- not their numbers. Passes.

**0d -- Stress test:** If the "20% discount" is fabricated (list price was never $1,500), the draft still works because it doesn't depend on their numbers being real. Passes.

---

### Structural comparison

| Dimension | Default | With hmm |
|---|---|---|
| Reasoning checkpoints | 0 (freeform) | 6 (named, sequential) |
| Frame source | Accepts input frame | Builds independent frame |
| Assumptions tested | 0 | 3-5 (per checkpoint) |
| Restart triggers | None | 3 (0x, 0c, 0d can each force a restart) |
| Volunteered claims treated as fact | Most | Zero until verified |
| Response anchored to | Their numbers | Your position and independent realities |

### What the metrics actually are

These are structural observations, not experimental benchmarks. No controlled study has been run. The value is architectural: the skill forces a reasoning structure that default prompting skips. Whether that structure produces better outcomes depends on the scenario -- it's most valuable when the input is adversarial or when the stakes of accepting a bad frame are high.

For low-stakes or non-adversarial input (a coworker asking a genuine question, a factual lookup), this skill adds overhead without benefit. Use it when someone has something to gain from how you respond.

## How it works internally

The skill uses Claude Code's hook system:

1. **Activation**: creates `/tmp/.hmm-active` as a marker file
2. **Hook injection**: a system hook detects the marker and injects frame-check reminders as Claude reads files and gathers context
3. **Scratchpad**: Claude writes evolving reasoning to `/tmp/hmm-scratch.md`, re-reading it between each context-gathering step to build adversarial awareness incrementally
4. **Checkpoints**: six named steps (0a, 0b, 0b2, 0x, 0c, 0d) each with explicit pass/fail criteria
5. **Restart mechanism**: three post-draft checks can each independently trigger a full restart from step 0b
6. **Cleanup**: removes temp files after delivery

## License

MIT. Use it however you want.
