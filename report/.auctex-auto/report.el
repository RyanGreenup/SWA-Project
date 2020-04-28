(TeX-add-style-hook
 "report"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("biblatex" "citestyle=numeric" "bibstyle=numeric" "hyperref=true" "backref=true" "maxcitenames=3" "url=true" "backend=biber" "natbib=true")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "inputenc"
    "fontenc"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref"
    "minted"
    "/home/ryan/Dropbox/profiles/Templates/LaTeX/ScreenStyle"
    "biblatex")
   (LaTeX-add-labels
    "sec:org5889f8b"
    "sec:orgef2694a"
    "orgf1d9527"
    "org95bbb17"
    "org63ce22b"
    "sec:orgaeea5c7"
    "orga63e2eb"
    "sec:orgf12e89e"
    "orgffe6a83"
    "sec:orga10ba78"
    "org767ccba"
    "sec:org78aeca1"
    "sec:org8dd440e"
    "org664252a"
    "org30c2135"
    "fig:org17e811a"
    "sec:org0126d40"
    "orga2403c8"
    "sec:orgd753a49"
    "org7d9831b"
    "org0738fac"
    "org0be2314"
    "sec:org98d0be7"
    "org117420a"
    "sec:org84fb543"
    "org12ed2c0"
    "sec:orgd350321"
    "sec:orge2d3b55"
    "orge7aaa1b"
    "sec:orge8b56d4"
    "org3d51644"
    "tab:org9c45940"
    "sec:org15aa7b6"
    "eq:org00a6e2d"
    "eq:1"
    "org610e916"
    "sec:org56bfa76"
    "orgae26287"
    "sec:orgf497726"
    "org9630c55"
    "sec:org2b0c16d")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

