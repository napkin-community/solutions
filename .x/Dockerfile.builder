FROM ubuntu:24.04

WORKDIR /napkin

# Install TeX Live
RUN apt update
RUN apt install -y biber texlive-base texlive-latex-recommended texlive-latex-extra texlive-science

# Setup Python
RUN apt install -y python3.12

# More Packages
RUN apt install -y latexmk asymptote ghostscript qpdf

# Compile Sources
COPY ./source /napkin/

RUN latexmk -pdflatex -interaction=nonstopmode -file-line-error ./Napkin.tex
RUN ./export-flowchart.sh
RUN python3 print-toc.py --parts --chapters --numbers > toc.txt
RUN python3 print-toc.py --qpdf | bash

RUN mkdir /output/
RUN mkdir /output/figures
RUN mkdir /output/Parts/
RUN cp Napkin.log /output/
RUN cp Napkin.pdf /output/
RUN cp asy/*.asy /output/figures/
RUN cp asy/*.pdf /output/figures/
RUN cp cover-art.png /output/
RUN cp cover-art.jpg /output/

RUN  mv flowchart.png /output/
RUN  mv toc.txt /output/
RUN  mv part-*.pdf /output/Parts
