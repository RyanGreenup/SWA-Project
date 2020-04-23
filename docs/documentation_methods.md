# Documentation
> [home](./index.md)

## Wiki
So I'm thinking of just hosting a wiki using [*MediaWiki](https://www.mediawiki.org/wiki/MediaWiki) with an /Apache2/ server, if I do, I'll post the link in the discord server.

## MkDocs
For the most part we can use [MkDocs](https://www.mkdocs.org/) for documentation, and keep the documentation on the `gh-pages` branch of the repo.

### Setting it up
It's super easy:

1. Install python3
2. Install MkDocs [as described here](https://www.mkdocs.org/#installation)
  + I forget whether to do this through your package manager `apt`/`pacman`/`brew`... or through `pip3`, I think `pip3` is the way to go.
3. Install the Extensions [as described here](https://facelessuser.github.io/pymdown-extensions/installation/)
  + look in the `yaml` [here](../mkdocs.yml) to see what's been enabled thus far.


## Org-Mode
I'll probably upload upload `org` files to track tasks etc. so it would be helpful to set Emacs up to streamline working with `org-mode`, It can be done with vim as well.

We can always just `pandoc` them into *HTML* anway.


