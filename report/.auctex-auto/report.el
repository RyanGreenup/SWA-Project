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
    "sec:org923ceaf"
    "sec:orga774428"
    "org38a1a1e"
    "orgaacfb17"
    "org8a0be83"
    "sec:org69b6db9"
    "orge869ff2"
    "sec:org055e637"
    "orgfcb4b7f"
    "sec:org1beb564"
    "orgd9c62b5"
    "sec:orgb355fd2"
    "sec:orge1cf9dc"
    "orgbed7f89"
    "org4dbf5bc"
    "fig:org8c68029"
    "sec:orge9a99ec"
    "org663ad8c"
    "sec:org67ba161"
    "org0cdcdba"
    "org0127a6c"
    "org7aaa2e4"
    "sec:org890e867"
    "orgba356b3"
    "sec:orgd4ee0ae"
    "org55b4e44"
    "sec:orgbb7ae2a"
    "sec:orgaae2146"
    "sec:org6a5daec"
    "sec:org0a36535"
    "sec:org535150c")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

