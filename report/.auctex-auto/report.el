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
    "sec:org804c5c2"
    "sec:orgd7415b1"
    "org18c70b3"
    "orge37fed6"
    "org8214068"
    "sec:org4cd44c7"
    "org5348e8a"
    "sec:orgb49433d"
    "orgb993b6b"
    "sec:org50ae54f"
    "org3e3b3b7"
    "sec:org5883248"
    "sec:orgb96200d"
    "org7638036"
    "orgf1f434a"
    "fig:org6d2f3e0"
    "sec:org9f23f92"
    "org9b4e17a"
    "sec:org5b27e94"
    "orge7fb5bb"
    "org7f66bb4"
    "org14bc9ba"
    "sec:org3ee8df4"
    "org2df391f"
    "sec:orgefb7fb1"
    "org5e36f88")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"
    "references"))
 :latex)

