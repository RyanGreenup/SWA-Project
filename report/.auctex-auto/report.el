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
    "sec:org15f7f19"
    "sec:org9bc11a3"
    "org633a170"
    "org819c0ea"
    "org60d94a7"
    "sec:orgc4ba99c"
    "org757bae2"
    "sec:orgaea8ce1"
    "org8f3631d"
    "sec:org36d192f"
    "orgd8ce8ad"
    "sec:org6ab7cef"
    "sec:orgd257802"
    "org71cc833"
    "org9e28206"
    "fig:orgbdf83e3"
    "sec:org12a0da2"
    "org735e31f"
    "sec:org11b2c15"
    "org285d0b9"
    "sec:orgbf8bece"
    "org4421305"
    "sec:org67efab0"
    "org41ad471"
    "sec:org940f258"
    "sec:org929aa2c"
    "org08465e9"
    "sec:orgf226b11"
    "org5bbe2f1"
    "tab:org6a18bae"
    "sec:org8c54e11"
    "eq:1"
    "org436a180"
    "sec:org391e280"
    "org68040ee"
    "sec:org5944025"
    "org81dbafa"
    "sec:org354c9c2"
    "sec:orgf4ba33d"
    "sec:org98f87ea"
    "org0f8930f"
    "sec:orge30455f"
    "org4da21ab"
    "sec:orgc92e2c0"
    "org335befb"
    "sec:orge9bf351"
    "sec:org4adc570"
    "org565de53"
    "orgfeb6f62"
    "sec:orgd83bf66"
    "orgce37a67"
    "sec:org35bfb74"
    "org518648e"
    "sec:org821d5f0"
    "sec:orgdeb087f"
    "sec:org767c443"
    "orgfdbae5b"
    "sec:org778efc8"
    "tfidf"
    "orgdf6d597"
    "sec:org6828859"
    "orgc20e987"
    "sec:org2673104"
    "orgf5baf82"
    "sec:orgb1931e7"
    "sec:orgba0ab10"
    "cos"
    "org900c05c"
    "sec:org16fa9ca"
    "org4600fe4"
    "sec:org652d47b"
    "orgf7a5363"
    "fig:orgb522eda"
    "sec:org53cd7ed"
    "org814c66c"
    "tab:org8c72d1e"
    "sec:org9e36c04"
    "orgfa7f613"
    "orge6da008"
    "org0a7296a"
    "fig:org8a3f8dc"
    "fig:orgf3bdc72"
    "sec:org7388c25"
    "sec:org30a205c"
    "orga372a6b"
    "tab:orgc5d8f30"
    "sec:orgb169a5a"
    "orgf2091a1"
    "sec:org933b3fd"
    "sec:org9f53b51"
    "sec:org70bff06"
    "sec:orgcb05ee2"
    "orgfdcdc0b"
    "org946dec1"
    "fig:org232ec1f"
    "fig:org1447f1e"
    "fig:org84c57b3"
    "sec:org676cee8"
    "sec:org1479462"
    "sec:orgd2900dd"
    "org3e294f5"
    "org3ea97ae"
    "fig:org63305fb"
    "fig:org3510f8e"
    "sec:org50766e7"
    "sec:org27d8915"
    "sec:org8b65b6c"
    "org7207e53"
    "sec:orgdb343c8"
    "sec:org7d02af4"
    "orgc5b30d4"
    "sec:org45717a5"
    "org7966b39"
    "sec:org9db0401"
    "orgf7744d4"
    "sec:orgd5e1792"
    "org2465e3f"
    "fig:org6bf3aae"
    "sec:org4857c22"
    "org18166e4"
    "orgdf96d84"
    "fig:orgf2fa832"
    "sec:org8909c8f"
    "org773d036"
    "sec:org598c1d2"
    "sec:org28f5d90"
    "sec:org2badfc4"
    "sec:org857d803"
    "tab:org89fe1a8"
    "sec:org8e5ebac"
    "tab:org2d48cd5"
    "sec:org2468ed8"
    "tab:org09aeae1"
    "sec:orgaa945e0"
    "fig:orgceeec4d")
   (LaTeX-add-bibliographies
    "/home/ryan/Dropbox/Studies/Papers/references"))
 :latex)

