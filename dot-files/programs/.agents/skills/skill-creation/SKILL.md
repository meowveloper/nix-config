---
name: skill-creation
description: 'Help user create a new skill step-by-step when steps are unclear. Discuss one small step, do and test it together, save to file, then next. Use when user says create a skill but cannot describe it well.'
---

# Skill Creation

> Status: blank. Built step-by-step with user.

## Rules
- No question tool in this loop. Use plain text with short A/B/C choices.
- Why: popups break flow.
- Save each surprise at once. Why: doing shows hidden steps.
- Do live, show result, confirm it is correct, then save. Always show what will be saved before saving.
- Why: untested text is a guess. (Guess = idea not tried yet.)
- Save checks, not values. Strip names, numbers, keys before saving.
- Why: values expire next session. Checks still work. Secrets leak from files.
- Before cost action, list options + cost, confirm. Then do the live test.
- Why: stops wrong spend during testing. (Cost = credits, money, delete, send.)
- Before doing, confirm approach + tool. Then do the live test.
- Why: wrong tool wastes work even with no cost.

## Steps

### Step 1 - Start small
1. Write goal in 1 sentence + 1 real example.
2. Make blank file `skills/<name>/SKILL.md` if missing.
3. Find real first action by doing, not guessing.
4. Pick smallest test you can do in 5 min.

Why: real first step is often hidden until you try it.
