% Copyright (c) 2017  Zubax Robotics  <info@zubax.com>
%
% Distributed under GPL v3.
%
% Author: Pavel Kirienko <pavel.kirienko@zubax.com>
%
% READ THIS FIRST:
%   In order for this package to work, its local directory must be included into the graphics
%   path list as follows:
%
%       \graphicspath{{document_templates/documentation_template_latex/}}
%
%   Notice the slash at the end, it is required.

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{zubaxdoc}[2023/02/22 Zubax Documentation document class]

\LoadClass[a4paper,onecolumn,openany]{book}

\author{Zubax Robotics}

\RequirePackage[pagestyles]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{xcolor}
\RequirePackage{gensymb}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{enumitem}
\RequirePackage{multicol}
\RequirePackage{etoolbox}
\RequirePackage{amstext}
\RequirePackage[detect-all]{siunitx}
\RequirePackage[font={bf}]{caption}
\RequirePackage{threeparttablex}
\RequirePackage{tabularray}
\RequirePackage{makecell}
\RequirePackage{longtable}
\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{titling}
\RequirePackage[yyyymmdd]{datetime}
\RequirePackage{lastpage}
\RequirePackage{minted}
\RequirePackage{chngcntr}
\RequirePackage{changepage}
\RequirePackage{csquotes}
\RequirePackage{xparse}

%
% Minor definitions.
%
\definecolor{colorhyperlink}{RGB}{100,0,0}
\definecolor{colorzubaxred}{RGB}{224,0,0}    % Zubax red logo color
\definecolor{colorheaderbg}{RGB}{224,224,224}

\renewcommand{\dateseparator}{-}

\sisetup{range-phrase = \text{--}}

\newcommand\ZubaxCopyright{\copyright{} \the\year{} \href{http://zubax.com}{\@author}}

% Deferring configuration of the PDF metadata until the point where the document title (and author) are known.
\preto\frontmatter{\hypersetup{
    pdftitle={\@title{} -- \@author},
    pdfauthor={\@author}
}}

% Source code listings highlighting
\usemintedstyle{vs}
\setminted{
    frame=leftline,
    linenos,
    numberblanklines=false,
    fontsize=\footnotesize,
    xleftmargin=\dimexpr\leftskip-2mm\relax,
    framesep=2mm,
    autogobble
}
\renewcommand{\theFancyVerbLine}{\scriptsize \texttt \oldstylenums{\arabic{FancyVerbLine}}}

% List styling
\renewcommand{\labelitemi}{\textbullet}
\renewcommand{\labelitemii}{\textbullet}
\renewcommand{\labelitemiii}{\textbullet}
\renewcommand{\labelitemiv}{\textbullet}

\setlist[itemize,2]{leftmargin=2em}
\setlist[itemize,3]{leftmargin=3em}
\setlist[itemize,4]{leftmargin=4em}

\setlist[description]{leftmargin=\leftskip,labelindent=\dimexpr\leftskip+\parindent\relax}
\setlist[enumerate]{itemindent=0ex,leftmargin=\leftskip+1.4em,nosep}
\setlist[itemize]{itemindent=0ex,leftmargin=\leftskip+1em,nosep}

% Continuous footnote numbering
\counterwithout{footnote}{chapter}

% We don't need to clear double page, ever. Shall the need arise, we'll have to implement a cleaner fix.
\renewcommand{\cleardoublepage}{\clearpage}

%
% Font specification.
%
\RequirePackage[T1]{fontenc}
\RequirePackage{fourier}        % Main font: Utopia Regular (serif); the monospace is ugly, so we override it later
\renewcommand*\ttdefault{txtt}  % Overriding the monospace font

%
% Page layout (tricky).
%
\newcommand{\DefaultParskip}{0.9em}
\raggedbottom
\RequirePackage[a4paper]{geometry}
\special{papersize=210mm,297mm}  % https://en.wikibooks.org/wiki/LaTeX/Page_Layout
\setlength\columnsep{6mm}        % Multi-column envoronments only
\setlength\headheight{17mm}
\setlength{\parskip}{\DefaultParskip}
\setlength{\abovecaptionskip}{0.2em}
\parindent=0em
\renewcommand{\baselinestretch}{1}
\renewcommand{\arraystretch}{1.1}
\leftskip=17mm
\headsep=8mm
\footskip=12mm
\geometry{margin=18mm,top=20mm,bottom=20mm}

% Removes the left margin for the next paragraph
\newcommand{\NoLeftSkip}{\parindent=-\leftskip}

% Allowing larger emergency stretch in order to avoid overfull boxes. More on the emergencystretch feature here:
% https://tex.stackexchange.com/questions/241343/what-is-the-meaning-of-fussy-sloppy-emergencystretch-tolerance-hbadness
\appto\fussy{\emergencystretch 5em}

%
% Section formatting
%
\setcounter{secnumdepth}{3}      % Increase this to add deeper structures

\titleformat{\part}[display]{}{\centering\Large Part \thepart}{1em}{\centering\huge\bfseries}
\titleformat{\chapter}{\huge\bfseries}{}{0em}{\makebox[17mm][l]{\thechapter}\hangindent=\leftskip}
\titleformat{\section}{\Large\bfseries}{}{0em}{\makebox[17mm][l]{\thesection}\hangindent=\leftskip}
\titleformat{\subsection}{\bfseries}{}{0em}{\makebox[17mm][l]{\thesubsection}\hangindent=\leftskip}
\titleformat{\subsubsection}{\itshape}{}{0em}{\makebox[17mm][l]{\thesubsubsection}\hangindent=\leftskip}

% Starred sections
\titleformat{name=\chapter,numberless}{\huge\bfseries}{}{0em}{}
\titleformat{name=\section,numberless}{\Large\bfseries}{}{0em}{}

% {left}{before}{after}[right]
\titlespacing{\chapter}{0em}{0em}{0em}
\titlespacing{\section}{0em}{0em}{0em}
\titlespacing{\subsection}{0em}{0em}{0em}
\titlespacing{\subsubsection}{0em}{0em}{0em}

%
% Hyperlinks.
%
\hypersetup{
    colorlinks,
    citecolor=colorhyperlink,
    filecolor=colorhyperlink,
    linkcolor=colorhyperlink,
    urlcolor=colorhyperlink
}
\captionsetup{hypcap=false}

%
% Table of contents.
% Note that the title margins are defined in absolute units because we're using different font sizes.
%
\renewcommand{\contentsname}{Table of contents}
\renewcommand{\listfigurename}{List of figures}
\renewcommand{\listtablename}{List of tables}
\setcounter{tocdepth}{2}
\titlecontents{part}[0em]{\centering\bfseries}{}{}{}
\dottedcontents{chapter}[5mm]{\bfseries}{5mm}{1pc}
\dottedcontents{section}[14mm]{}{9mm}{1pc}
\dottedcontents{subsection}[25mm]{\footnotesize}{11mm}{1pc}

\dottedcontents{table}[3em]{}{3em}{1pc}
\dottedcontents{figure}[3em]{}{3em}{1pc}

% Custom styling of TOC, LOF, LOT.
% Using \sloppy in order to ensure that the maximum line length is not exceeded.
% Exceeding the line limit in two-column environments breaks the table of contents and wreaks havoc in general.
% More on this at https://kb.zubax.com/x/IYEh
\renewcommand\tableofcontents{%
    \thispagestyle{plain}%
    \sloppy%
    \section*{\contentsname}%
    \@starttoc{toc}%
    \fussy%
}
\renewcommand\listoffigures{%
    \thispagestyle{plain}%
    \sloppy%
    \section*{\listfigurename}%
    \@starttoc{lof}%
    \fussy%
}
\renewcommand\listoftables{%
    \thispagestyle{plain}%
    \sloppy%
    \section*{\listtablename}%
    \@starttoc{lot}%
    \fussy%
}

% Make links black in the TOC, LOF, LOT.
\preto\tableofcontents{\hypersetup{linkcolor=black}         \setlength{\parskip}{0em}}
\appto\tableofcontents{\hypersetup{linkcolor=colorhyperlink}\setlength{\parskip}{\DefaultParskip}}

\preto\listoffigures{\hypersetup{linkcolor=black}         \setlength{\parskip}{0em}}
\appto\listoffigures{\hypersetup{linkcolor=colorhyperlink}\setlength{\parskip}{\DefaultParskip}}

\preto\listoftables{\hypersetup{linkcolor=black}         \setlength{\parskip}{0em}}
\appto\listoftables{\hypersetup{linkcolor=colorhyperlink}\setlength{\parskip}{\DefaultParskip}}

%
% Table macros.
% This used to be based on "tabu" but it is no longer maintained, so now we use tabularray instead.
% https://ctan.math.illinois.edu/macros/latex/contrib/tabularray/tabularray.pdf
%
% To generate table rows programmatically, see this:
% https://tex.stackexchange.com/questions/676028/using-a-command-to-generate-a-table-row-in-tabularray
% For complex autogenerated tables you may have better luck with the standard "tabular" environment.
%

\SetTblrInner{rowsep=1pt, colsep=4pt}

% Use this wrapper environment to define tables in it.
% This environment provides proper placement of the table within the page, and the properly positioned caption.
% An optional [wide] parameter can be specified to align the table with the left margin instead of leftskip.
\NewDocumentEnvironment{ZubaxTableWrapper}{ o m }{%
    \ifthenelse{\equal{#1}{wide}}{
        \NoLeftSkip
        \begin{minipage}{\textwidth}  % Minipage is needed to prevent page breaks before the caption
    }{
        \begin{minipage}{\textwidth-\leftskip}  % Minipage is needed to prevent page breaks before the caption
    }
        \begin{ThreePartTable}
}{
            % https://github.com/Zubax/document_templates/pull/6#issuecomment-640133791
            \captionof{table}{#2}
        \end{ThreePartTable}
    \end{minipage}
}

\newenvironment{ZubaxCompactTable}[1]{
    \begin{tblr}{#1}
        \SetRow{colorheaderbg}
}{
    \end{tblr}
}

% Use this environment to define a table within the wrapper environment defined above.
\newenvironment{ZubaxWrappedTable}[2][\empty]{%
    \begin{tblr}{#2}
        \SetRow{colorheaderbg}
}{
    \end{tblr}
}

% This is a shortcut that places a table within the wrapper environment.
% Use it in all cases unless you need to define table notes, or if you need to customize something.
% An optional [wide] parameter can be specified to align the table with the left margin instead of leftskip.
\newenvironment{ZubaxSimpleTable}[3][]{
    \begin{ZubaxTableWrapper}[#1]{#2}
        \begin{ZubaxWrappedTable}{#3}
}{
        \end{ZubaxWrappedTable}
    \end{ZubaxTableWrapper}
}

%
% Page styling.
%
\newcommand\ChapterTitleWithNumber{%
    \ifthenelse{\equal{\thechapter}{0}}%
    {}%
    {\thechapter.\ }%
    \ifdefempty{\chaptertitle}%
    {\sectiontitle}%
    {\chaptertitle}%
}

\newcommand\PageNumberWithTotal{\thepage\if@mainmatter/\pageref*{LastPage}\fi}

\newcommand\ZubaxLogoBlack[1][15mm]{\includegraphics[width=#1]{zubax_logo_black}}
\newcommand\ZubaxLogo[1][15mm]{\includegraphics[width=#1]{zubax_logo}}

\newcommand\VerboseLinkToSupportForum{Support \& feedback: \href{https://forum.zubax.com}{forum.zubax.com}}

\newcommand\TitleWithDateBefore{\begin{footnotesize}\today\quad\end{footnotesize}{\@title}}
\newcommand\TitleWithDateAfter{{\@title}\begin{footnotesize}\quad\today\end{footnotesize}}

\renewpagestyle{plain}{
    \sethead%
        [\TitleWithDateAfter][][\ZubaxLogoBlack]     % even
        {\ZubaxLogoBlack}{}{\TitleWithDateBefore}    % odd

    \setfoot%
        [\PageNumberWithTotal][\small\VerboseLinkToSupportForum][\small\ZubaxCopyright]
        {\small\ZubaxCopyright}{\small\VerboseLinkToSupportForum}{\PageNumberWithTotal}

    \headrule
    \footrule
}
\newpagestyle{main}{
    \sethead%
        [\TitleWithDateAfter][][\ZubaxLogoBlack]     % even
        {\ZubaxLogoBlack}{}{\TitleWithDateBefore}    % odd

    \setfoot%
        [\PageNumberWithTotal][][\small\ChapterTitleWithNumber]
        {\small\ChapterTitleWithNumber}{}{\PageNumberWithTotal}

    \headrule
    \footrule
}
\newpagestyle{titlepage}{
    \setfoot{\ZubaxCopyright}{}{\VerboseLinkToSupportForum}
    \footrule
}

% Use the same style on pages that open new chapters.
\patchcmd{\chapter}{plain}{main}{}{}

% The document will switch to the proper page style automatically.
% We also take this opportunity to enforce \fussy in the main matter.
\preto\frontmatter{\twocolumn\pagestyle{plain}}
\preto\mainmatter{\onecolumn\pagestyle{main}\fussy}
\preto\backmatter{\onecolumn\pagestyle{plain}}

%
% Title page environment.
% Use "\BeginRightColumn" to switch to the right column.
%
\newcommand{\BeginRightColumn}{\vfill\eject}

\newcommand{\RenderTitlePageHeader}{%
    \renewcommand{\baselinestretch}{1}
    \begin{minipage}[b][25mm]{0.64\textwidth}
        \vfill
        \begin{flushleft}\begin{Huge}\@title\end{Huge}\end{flushleft}
        \vfill
        Revision \today
    \end{minipage}
    \hfill
    \begin{minipage}[b]{0.36\textwidth}
        \begin{flushright}
        \begin{small}
            \ZubaxLogo[60mm]\\\vspace{3mm}
            \textbf{\@author}\\
            Uus 12, Tallinn 10111, Estonia\\
            \href{mailto:info@zubax.com}{info@zubax.com}\\
            Q\&{}A: \href{https://forum.zubax.com}{forum.zubax.com}
        \end{small}
        \end{flushright}
    \end{minipage}
    % Without \hfill here, TeX complains that hbox is underfull,
    % despite the fact that the rule spans for \textwidth here. I have no idea why.
    \rule{\textwidth}{.4pt}\hfill\vspace{3mm}
}

\renewenvironment{titlepage}{%
    \leftskip=0mm\parindent=0mm
    \pagestyle{titlepage}\thispagestyle{titlepage}
    \twocolumn[%
        \begin{@twocolumnfalse}
            \RenderTitlePageHeader
        \end{@twocolumnfalse}
    ]
    % This is needed to allow LaTeX add more white spaces to avoid overflowing lines.
    % Extra white spaces in two-column environments are much less bad than overflowing lines.
    \emergencystretch 10em
    }{%
    \clearpage
}

\endinput
