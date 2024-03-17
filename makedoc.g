##  this creates the documentation, needs: GAPDoc and AutoDoc packages, pdflatex
##
##  Call this with GAP from within the package directory.
##

if fail = LoadPackage("AutoDoc", ">= 2019.04.10") then
    Error("AutoDoc 2019.04.10 or newer is required");
fi;

AutoDoc(rec(
    scaffold := rec(
        includes := [
            "intro.xml",
            "data.xml",
            "examples.xml",
            "functionality.xml"],
        bib := "smallsemi.bib"),
    gapdoc := rec(main := "smallsemi.xml"),
    extract_examples := true,
));
QUIT;
