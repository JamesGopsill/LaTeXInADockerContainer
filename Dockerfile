FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y texlive-full latexmk \
  && mkdir -p /usr/share/fonts/opentype/ \
  && mkdir -p /usr/share/fonts/truetype/

COPY ./fonts/opentype /usr/share/fonts/opentype
COPY ./fonts/truetype /usr/share/fonts/truetype

# refresh system font cache
RUN fc-cache -f -v \
  # Clean up
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /latex

WORKDIR /latex

CMD ["latexmk", "-pdflatex=xelatex", "-outdir=build", "-pdf", "-interaction=nonstopmode", "main.tex"]