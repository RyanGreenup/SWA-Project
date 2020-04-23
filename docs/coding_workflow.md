---
title: "Project Workflow"
---

# Workflow

## Working on code
So Ideally, we will break up discrete tasks into seperate scripts (or `.rmd` files maybe?) and commit really often, that way we can mostly all share different pieces of code and follow the changes that are occuring.

After writing a script, add something, anything to the documentation in `./docs` describing broadly what was done.

## The Report
The report will be submitted as a LaTeX document because that's what's expected for an academic report, but obviously we won't write in LaTeX as we go.

Instead I'd rather write it in `org-mode` as we go and then when all the work is done use `pandoc` or `ox-latex` to get typeset everything, I'm happy to deal with that part of it because I've got a LaTeX template that works.

If you're unfamiliar with `org-mode` don't worry, you can write in markdown and then do something like `xclip -o | pandoc -f markdown -t org | xclip` and it's just about seamless.

We should write the report as we go, but the report won't document how and why the code works, only the analysis so it will still be necessary to add to the documentation and/or wiki so everybody can follow what's going on.


## Managing bugs etc.
I mostly want to use *GitHub* Issues as much as I can, I intend to add a webhook to the discord server and failing that we can always just fall back onto `org-mode`.


