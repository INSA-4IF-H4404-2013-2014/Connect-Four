#!/bin/bash
NUMHEXANOME="H4404"
NOMDULIVRABLE=$NUMHEXANOME"_Prolog"

./clean.sh
pdflatex "$NOMDULIVRABLE.tex"
#bibtex "$NOMDULIVRABLE"
#makeindex -s "litterature.ist" "$NOMDULIVRABLE"
#makeglossaries "$NOMDULIVRABLE"
pdflatex "$NOMDULIVRABLE.tex"
pdflatex "$NOMDULIVRABLE.tex"
./clean.sh
