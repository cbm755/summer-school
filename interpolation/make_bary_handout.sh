#!/bin/sh

pdfnup --nup 2x1 \
    --frame false \
    --scale 1.05 \
    --offset '0cm 0cm' \
    --trim '0 0 4cm 0' --clip true \
    -o temp2.pdf \
    trefethen-barycentric.pdf 1-14


pdfnup --nup 3x1 \
    --frame false \
    --scale 0.94 \
    --offset '0cm 0cm' \
    --trim '1.8cm 0 5.2cm 0' --clip true \
    -o temp3.pdf \
    trefethen-barycentric.pdf 15-

pdftk temp2.pdf temp3.pdf cat output barycentric_handout.pdf

rm -f temp2.pdf temp3.pdf
