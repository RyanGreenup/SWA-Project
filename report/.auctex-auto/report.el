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
    "sec:org50dd8ed"
    "sec:orge20fd44"
    "org715e94c"
    "org2337af2"
    "orgd16643e"
    "sec:orgfd5a188"
    "orgebb9134"
    "sec:org2034e3a"
    "orgf7af30e"
    "sec:orgd1e6ffa"
    "org05224db"
    "sec:org4c8d06a"
    "sec:org8537dc5"
    "org1f37fd8"
    "org10c35ec"
    "fig:orgfa96dc0"
    "sec:org353bada"
    "orge1a3255"
    "sec:org59c6c86"
    "org77a75dc"
    "org03950ae"
    "orgfc5f6ea"
    "sec:org118849d"
    "org27e706b"
    "sec:org2b3ece7"
    "org070fe29"
    "sec:org9678d37"
    "sec:orgc26cd1e"
    "orge2d8eb5"
    "sec:orgd17fe3d"
    "org9026364"
    "tab:orgda60606"
    "sec:org7cd3cd8"
    "eq:orgb8b4beb"
    "eq:1"
    "org61a3b24"
    "sec:org9524a09"
    "org0909011"
    "sec:org3123fa2"
    "org17f909d"
    "sec:org6953fa5"
    "sec:orgace71d9"
    "sec:org9920ddd"
    "sec:orgc17bae0"
    "org5f322ed"
    "sec:org793023a"
    "sec:orgf976018"
    "tab:org0d93e6b")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

