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
    "sec:org39ce2a3"
    "sec:orgef0839f"
    "orgfec06b8"
    "org89e2677"
    "orgae8b70c"
    "sec:orgb679a83"
    "orga5caa48"
    "sec:org6e27135"
    "org2efb9f3"
    "sec:org685319e"
    "orgaf3bf4d"
    "sec:org1c272ac"
    "sec:org297260f"
    "org16ef971"
    "orgb361d2d"
    "fig:org100a61e"
    "sec:orga3d2e45"
    "orgb0e125b"
    "sec:org466af4e"
    "org5f7b8db"
    "org5ce2384"
    "org9b1d2f2"
    "sec:orgb95435c"
    "org7e52d94"
    "sec:org9d5a329"
    "org8f4cb9c"
    "sec:org42efe0d")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

