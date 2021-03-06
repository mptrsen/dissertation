% -------------------------------------------------------------------
%  @LaTeX-class-file{
%     filename        = "Dissertate.cls",
%     version         = "2.0",
%     date            = "25 March 2018",
%     codetable       = "ISO/ASCII",
%     keywords        = "LaTeX, Dissertate",
%     supported       = "Send email to suchow@post.harvard.edu.",
%     docstring       = "Class for a dissertation."
% --------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{Dissertate}[2014/03/25 v2.0 Dissertate Class]
\LoadClass[12pt, a4paper, openright]{book}

%
% Options
%
\RequirePackage{etoolbox}

% Line spacing: dsingle/ddouble
%   Whether to use single- or doublespacing.
\newtoggle{DissertateSingleSpace}
\togglefalse{DissertateSingleSpace}
\DeclareOption{dsingle}{
    \toggletrue{DissertateSingleSpace}
    \ClassWarning{Dissertate}{Single-spaced mode on.}
}
\DeclareOption{ddouble}{\togglefalse{DissertateSingleSpace}}

\ProcessOptions\relax

% Line Spacing
%   Define two line spacings: one for the body, and one that is more compressed.
\iftoggle{DissertateSingleSpace}{
    \newcommand{\dnormalspacing}{1.2}
    \newcommand{\dcompressedspacing}{1.0}
}{
    \newcommand{\dnormalspacing}{2.0}
    \newcommand{\dcompressedspacing}{1.2}
}

% Block quote with compressed spacing
\let\oldquote\quote
\let\endoldquote\endquote
\renewenvironment{quote}
    {\begin{spacing}{\dcompressedspacing}\oldquote}
    {\endoldquote\end{spacing}}

% Itemize with compressed spacing
\let\olditemize\itemize
\let\endolditemize\enditemize
\renewenvironment{itemize}
    {\begin{spacing}{\dcompressedspacing}\olditemize}
    {\endolditemize\end{spacing}}

% Enumerate with compressed spacing
\let\oldenumerate\enumerate
\let\endoldenumerate\endenumerate
\renewenvironment{enumerate}
    {\begin{spacing}{\dcompressedspacing}\oldenumerate}
    {\endoldenumerate\end{spacing}}

% Text layout.
\RequirePackage[a4paper]{geometry}
\geometry{bindingoffset=1cm}
\usepackage{ragged2e}
\RaggedRight
\RequirePackage{graphicx}
\usepackage{fixltx2e}
\parindent 12pt
\RequirePackage{lettrine}
\RequirePackage{setspace}
\RequirePackage{verbatim}

% Fonts.
\RequirePackage{color}
\RequirePackage{xcolor}
\usepackage{hyperref}
\RequirePackage{url}
\RequirePackage{amssymb}
\RequirePackage{mathspec}
\setmathsfont(Digits,Latin,Greek)[Numbers={Proportional}]{EB Garamond}
\setmathrm{EB Garamond}
\AtBeginEnvironment{tabular}{\addfontfeature{RawFeature=+tnum}}
\widowpenalty=10000
\clubpenalty=10000
\setromanfont[Numbers=OldStyle, Ligatures={Common, TeX}, Scale=1.0]{EB Garamond}
\newfontfamily{\smallcaps}[RawFeature={+c2sc,+scmp}]{EB Garamond}
\setsansfont[Scale=MatchLowercase, BoldFont={Lato Bold}]{Lato Regular}
\setmonofont[Scale=MatchLowercase]{Source Code Pro}
\RequirePackage[labelfont={bf,sf,footnotesize,singlespacing},
                textfont={sf,footnotesize,singlespacing},
                justification={justified,RaggedRight},
                singlelinecheck=false,
                margin=0pt,
                figurewithin=chapter,
                tablewithin=chapter]{caption}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\RequirePackage{microtype}
\RequirePackage{booktabs}
\RequirePackage{rotating}
\RequirePackage{ccicons} % for CC license icons


% Headings and headers.
\RequirePackage{fancyhdr}
\RequirePackage[tiny, md, sc]{titlesec}
\setlength{\headheight}{15pt}
\pagestyle{plain}
\RequirePackage{titling}

% Front matter.
\setcounter{tocdepth}{1}
\usepackage[titles]{tocloft}
\usepackage[titletoc]{appendix}
\usepackage{pdfpages} % for adding entire PDF pages to the appendix
\usepackage{emptypage} % clear page after each chapter
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\normalsize \scshape}
%\renewcommand\listfigurename{Listing of figures}
%\renewcommand\listtablename{Listing of tables}

% Endmatter
\renewcommand{\setthesection}{\arabic{chapter}.A\arabic{section}}

% References.
\renewcommand\bibname{References}
%\RequirePackage[super,comma,numbers]{natbib}
\RequirePackage[authoryear]{natbib}
\RequirePackage{bibentry}
\RequirePackage{chapterbib}
\nobibliography*
\renewcommand{\bibnumfmt}[1]{[#1]}
\RequirePackage[palatino]{quotchap}
\renewcommand*{\chapterheadstartvskip}{\vspace*{-0.5\baselineskip}}
\renewcommand*{\chapterheadendvskip}{\vspace{1.3\baselineskip}}

% An environment for paragraph-style section.
\providecommand\newthought[1]{%
   \addvspace{1.0\baselineskip plus 0.5ex minus 0.2ex}%
   \noindent\textsc{#1}%
}

% Align reference numbers so that they do not cause an indent.
\newlength\mybibindent
\setlength\mybibindent{0pt}
\renewenvironment{thebibliography}[1]
    {\chapter*{\bibname}%
     \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
     \list{\@biblabel{\@arabic\c@enumiv}}
          {\settowidth\labelwidth{\@biblabel{999}}
           \leftmargin\labelwidth
            \advance\leftmargin\dimexpr\labelsep+\mybibindent\relax\itemindent-\mybibindent
           \@openbib@code
           \usecounter{enumiv}
           \let\p@enumiv\@empty
           \renewcommand\theenumiv{\@arabic\c@enumiv}}
     \sloppy
     \clubpenalty4000
     \@clubpenalty \clubpenalty
     \widowpenalty4000%
     \sfcode`\.\@m}
    {\def\@noitemerr
      {\@latex@warning{Empty `thebibliography' environment}}
     \endlist}

% Some definitions.
\def\authorBirthplace#1{\gdef\authorBirthplace{#1}}
\def\advisor#1{\gdef\advisor{#1}}
\def\coadvisorOne#1{\gdef\coadvisorOne{#1}}
\def\coadvisorTwo#1{\gdef\coadvisorTwo{#1}}
\def\committeeInternal#1{\gdef\committeeInternal{#1}}
\def\committeeInternalOne#1{\gdef\committeeInternalOne{#1}}
\def\committeeInternalTwo#1{\gdef\committeeInternalTwo{#1}}
\def\committeeExternal#1{\gdef\committeeExternal{#1}}
\def\degreeyear#1{\gdef\degreeyear{#1}}
\def\degreemonth#1{\gdef\degreemonth{#1}}
\def\degreeterm#1{\gdef\degreeterm{#1}}
\def\degree#1{\gdef\degree{#1}}
\def\department#1{\gdef\department{#1}}
\def\field#1{\gdef\field{#1}}
\def\university#1{\gdef\university{#1}}
\def\universitycity#1{\gdef\universitycity{#1}}
\def\universitystate#1{\gdef\universitystate{#1}}
\def\programname#1{\gdef\programname{#1}}
\def\pdOneName#1{\gdef\pdOneName{#1}}
\def\pdOneSchool#1{\gdef\pdOneSchool{#1}}
\def\pdOneYear#1{\gdef\pdOneYear{#1}}
\def\pdTwoName#1{\gdef\pdTwoName{#1}}
\def\pdTwoSchool#1{\gdef\pdTwoSchool{#1}}
\def\pdTwoYear#1{\gdef\pdTwoYear{#1}}
% School name and location
%--------------------------------------------------
% \university{Monsters University}
% \universitycity{Monstropolis}
% \universitystate{Earth}
%-------------------------------------------------- 

% School color found from university's graphic identity site:
% http://isites.harvard.edu/icb/icb.do?keyword=k75408&pageid=icb.page392732
\definecolor{SchoolColor}{rgb}{0.5, 0.5, 0.5} % Crimson
\definecolor{chaptergrey}{rgb}{0.5, 0.5, 0.5} % for chapter numbers

\hypersetup{
    colorlinks,
    citecolor=SchoolColor,
    filecolor=black,
    linkcolor=black,
    urlcolor=SchoolColor,
}

% Formatting guidelines found in:
% http://www.gsas.harvard.edu/publications/form_of_the_phd_dissertation.php
\renewcommand{\frontmatter}{
	\input{frontmatter/personalize}
	\maketitle
	\abstractpage
	\copyrightpage
	\currentpdfbookmark{\contentsname}{contents}
	\tableofcontents
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listfigurename}
	\listoffigures
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listtablename}
	\listoftables
	\cleardoublepage
	\dedicationpage
	\acknowledgments
}

\renewcommand{\maketitle}{
	\thispagestyle{empty}
	\vspace*{\fill}
	\vspace{100pt}
	\begin{center}
	\Huge \textcolor{SchoolColor}{\thetitle} \normalsize \\
	\vspace{100pt}
	\textsc{a dissertation presented \\
	by\\
	\theauthor \\
	from\\
	\authorBirthplace\\
	to\\
	the \department\\
	\vspace{12pt}
	in partial fulfillment of the requirements\\
	for the doctoral degree of\\ \degree\\
	%in the subject of\\ \field\\
	\vspace{12pt}
	\university\\ \universitycity, \universitystate\\
	\degreemonth\ \degreeyear}
	\end{center} \vspace*{\fill}
}

\newcommand{\copyrightpage}{
	\cleardoublepage
	\thispagestyle{empty}
	\vspace*{\fill}
	\scshape \noindent \small \href{https://creativecommons.org/licenses/by-nc-nd/4.0}{\ccbyncsaeu} ~ \small \degreeyear\hspace{3pt}-- \theauthor
	\vspace*{\fill}
	\rm
	\cleardoublepage
}

\newcommand{\abstractpage}{
	\newpage
	\pagenumbering{roman}
	\setcounter{page}{1}
	\pagestyle{fancy}
	\lhead{Thesis advisor: \advisor} \rhead{\theauthor}
	\renewcommand{\headrulewidth}{0.0pt}
	\vspace*{35pt}
	\begin{center}
	\Large \textcolor{SchoolColor}{\thetitle} \normalsize \\
	\vspace*{20pt}
	\scshape Abstract \\ \rm
	\end{center}
	\input{frontmatter/abstract}
	\vspace*{\fill}
	\newpage \lhead{} \rhead{}
	\cfoot{\thepage}
}

\newcommand{\dedicationpage}{
	\newpage \thispagestyle{fancy} \vspace*{\fill}
	\scshape \noindent \input{frontmatter/dedication}
	\vspace*{\fill} \newpage \rm
	\cleardoublepage
}

\newcommand{\acknowledgments}{
	\addcontentsline{toc}{chapter}{Acknowledgments}
	\chapter*{Acknowledgments}
	\noindent
	\input{frontmatter/thanks}
	\vspace*{\fill}
	\cleardoublepage
	\setcounter{page}{1}
	\pagenumbering{arabic}

}


\renewcommand{\backmatter}{
	\input{endmatter/personalize}
	%\addcontentsline{toc}{chapter}{\bibname}
	%\bibliographystyle{apalike2}
	%\bibliography{references}
	\cleardoublepage
	\include{endmatter/declaration}
	\cleardoublepage
	\include{endmatter/cv}
	\cleardoublepage
	\include{endmatter/colophon}
}
