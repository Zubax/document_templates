Zubax Document Templates
========================

This repository contains templates for documents (LaTeX and such).
It is mostly intended for use as a submodule.

## Compiling LaTeX on Ubuntu

```bash
sudo apt-get install texlive-full lyx python-pygments
sudo apt-get install texmaker   # GUI IDE, optional
```

Then use the following helper script (which will probably require some modifications) to automate compilation:

```bash
#!/bin/bash

SRC=main

#rm -rf out &> /dev/null
mkdir out &> /dev/null
cp -fP *.bib out/ &> /dev/null

rm out/$SRC.pdf

pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex
cd out
bibtex $SRC
#biber $SRC
cd ..
pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex
pdflatex --halt-on-error --shell-escape -output-directory=out ../$SRC.tex

rm *.pdf*
```

Alternatively, use the Texmaker IDE.

## Using the Texmaker IDE

### Compilation

Modify the compilation command so that the command `pdflatex` (or another LaTeX compiler)
is invoked with the option `-shell-escape`,
otherwise the syntax coloring feature (and probably something else) will not work.
The compiler should be invoked twice during the compilation cycle in order to resolve the
internal references in the document.
An example of the resulting configuration is shown on the following screenshot:

![Texmaker configuration example](texmaker_config_example.png)

### Spell checking

Spell checking must be used!
The following instructions show how to configure it in Texmaker.

1. Get the dictionary file `en_US.oxt` from Open Office.
Try this link: <https://extensions.openoffice.org/en/project/en_US-dict>,
or Google [`"en_US.oxt"`](https://google.com/search?q="en_US.oxt").
2. Unarchive the file.
3. Copy both `en_US.aff` and `en_US.dic` to your default or preferred dictionary location.
Normally, the directory would be located at `/usr/share/myspell/dicts/`.
4. Navigate to Texmaker --> Options --> Configure Texmaker --> Editor --> Spelling dictionary
to select the extracted earlier `en_US.dic` as your preferred spelling dictionary.

The user-added words are kept in the Texmaker configuration file,
which is located at `~/.config/xm1/texmaker.ini`.
The parameter key is `Spell\Words=`.
You can use this knowledge to transfer the user-added words between different computers.

## Editing notes

Avoid inclusion of complex graphics in EPS format, because it tends to be rendered poorly by `pdflatex`.
Prefer the PDF format instead.

### Wolfram Mathematica

When exporting graphics from Wolfram Mathematica, try PDF first, and if it doesn't work
(the PDF export feature often breaks on complex graphics), resort to EPS.
Overall the exporting workflow should look like this:

1. Export the graphics from Mathematica to PDF (if it doesn't work, use EPS).
If annotations or other changes aren't necessary, the process ends here.
2. Open the exported file with Inkscape.
3. **Ungroup the graphics** (right click --> ungroup).
If the graphics file is a plot that contains grid lines, move them all the way to the back
(select the grid lines and press "End" on the keyboard).
This is mandatory, otherwise the quality of the exported image may suffer.
3. Edit the graphics as necessary (e.g. add annotations), and
save it as Inkscape SVG with extension `.inkscape.svg`.
4. **Delete the temporary file obtained in the step 1**. There is no need to keep temporary files.
The Inkscape file, however, should be kept under version control in order to make editing easier later.
5. Export the file from Inkscape into PDF and include it into the LaTeX file.

It is best to avoid grid lines when exporting via EPS; or, if they are still required, try to avoid making them
dotted or dashed, because these features tend to look ugly when exported through EPS.
