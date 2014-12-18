#!/bin/sh

AUXDIR="build"
FILENAME="Thesis"

function run_latex(){
    "/usr/texbin/pdflatex" -synctex=1 -interaction=nonstopmode -output-directory="$AUXDIR" "$FILENAME".tex >/dev/null
}

function build(){
    if [ ! -d "$AUXDIR" ]; then
        mkdir "$AUXDIR"
    fi
    run_latex
    "/usr/texbin/bibtex" "$AUXDIR"/"$FILENAME".aux
    run_latex
    run_latex
    open "$AUXDIR"/"$FILENAME".pdf
}

function clean(){
    if [ -d "$AUXDIR" ]; then
        rm -rf "$AUXDIR"
    fi
}

if [ $# -eq 1 ]; then
    if [ $1 == "build" ]; then
        build
    elif [ $1 == "clean" ]; then
        clean
    else
        echo "Unknown command"
    fi
else
    echo "Please provide 1 parameter - clean or build"
fi

