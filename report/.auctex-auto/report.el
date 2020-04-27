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
    "sec:org8d31234"
    "sec:orgb56dc09"
    "org6d215bf"
    "org25f096b"
    "org0063f6d"
    "sec:org1f4806e"
    "org5ff7d68"
    "sec:orgf099317"
    "org6c25acf"
    "sec:org7f8467c"
    "orgab4b653"
    "sec:org0cf50bd"
    "sec:orgbe0ade8"
    "org64a6dd0"
    "org6f0e195"
    "fig:org2def6d4"
    "sec:orga8a3729"
    "orgf6e827d"
    "sec:orgbd9d114"
    "orge00c5cb"
    "org1090609"
    "org4299e1e"
    "sec:orgc66295f"
    "org4f1a86e"
    "sec:orgb237d8c"
    "org4f7b9f9")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

