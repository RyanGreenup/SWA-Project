(TeX-add-style-hook
 "report"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("ulem" "normalem") ("biblatex" "citestyle=numeric" "bibstyle=numeric" "hyperref=true" "backref=true" "maxcitenames=3" "url=true" "backend=biber" "natbib=true")))
   (add-to-list 'LaTeX-verbatim-environments-local "minted")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
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
    "sec:orgfc04194"
    "sec:org9dd0e1e"
    "org009e617"
    "org2a9bbc1"
    "org45faaa0"
    "sec:org5d3ebdf"
    "orgea7611c"
    "sec:org6062dd9"
    "org81b11c2"
    "sec:org416104c"
    "orgdd44daf"
    "sec:org91d5980"
    "sec:orgb6da90e"
    "orgc37fce0"
    "orgbedacb6"
    "fig:org168f792"
    "sec:org9fc8204"
    "orge29de2f"
    "sec:org4d8b19a"
    "org0cf9569"
    "org32a191a"
    "org18d78ff"
    "sec:org71503ef"
    "org9c4343a"
    "sec:orgd833ef9"
    "org94d606a"
    "sec:org5bcd431"
    "sec:orgd299648"
    "org03beae9"
    "sec:org4a47caf"
    "orge7a6c2a"
    "tab:org1055669"
    "sec:orgbbdf108"
    "eq:orga86b987"
    "eq:1"
    "org0b38e77"
    "sec:org38ad42d"
    "orge4fee83"
    "sec:org61cab4f"
    "orgde78bcf"
    "sec:org8349860"
    "sec:org8d97c81"
    "sec:orgf3135f6")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

