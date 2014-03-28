% Pakete laden
\ProvidesClass{hpibpthesis}[2013/06/12 v1.0 HPI Bachelor Thesis]

% support english option:
\RequirePackage{ifthen}
\newboolean{document_english}\setboolean{document_english}{false}
\DeclareOption{english}{\setboolean{document_english}{true}}
\ProcessOptions\relax
\newcommand{\ifenglish}{\ifthenelse{\boolean{document_english}}}

\ifenglish{}{%
\PassOptionsToClass{ngerman}{scrreprt}%
\PassOptionsToPackage{language=ngerman}{biblatex}%
}
\LoadClass[a4paper,12pt,headings=small,bibliography=numbered,listof=numbered,numbers=noenddot]{scrreprt}

\RequirePackage[utf8]{inputenc}

\ifenglish{\RequirePackage[english,ngerman]{babel}}{
% breaks hyphenation
%\RequirePackage[ngerman,english]{babel}
%\selectlanguage{ngerman}
\RequirePackage{ngerman}
\RequirePackage[ngerman]{translator}
}
\RequirePackage{csquotes}
\RequirePackage{color}
\RequirePackage[pdftex]{graphicx}
%\RequirePackage{fancybox}
\RequirePackage{tabularx}
\RequirePackage{amsmath}
%\RequirePackage{microtype}
%\RequirePackage[T1]{fontenc}
% Korrekte Trennung von Wörten mit Bindestrich:
\RequirePackage[shortcuts]{extdash}

\usepackage{enumitem}

% Struktur:
\setcounter{tocdepth}{1}
\setcounter{secnumdepth}{1}
\usepackage{titlesec}
\titleformat{\subsubsection}[hang]{\bfseries\itshape}{\thesubsubsection}{1em}{}

\let\origitemize\itemize
\def\itemize{\origitemize\itemsep0pt}
% Listings
\RequirePackage{listings}
\ifenglish{}{\renewcommand{\lstlistingname}{Quelltext}}
\definecolor{stringcolor}{rgb}{0.1,0.1,0.1}
\definecolor{commentcolor}{rgb}{0.6,0.6,0.6}
\lstset{
  inputencoding=latin1,
  numbers=left,
  stepnumber=1,
  numbersep=10pt,
%   basicstyle=\scriptsize \ttfamily,
  basicstyle=\scriptsize \ttfamily,
  stringstyle=\sffamily \color{stringcolor},
  commentstyle= \sffamily \color{commentcolor},
  breakautoindent=true,
  breaklines=true,
  breakatwhitespace=false,
  tabsize=2,
  language=python
}

% Neue Informationsbefehle
\renewcommand{\title}[1]{\gdef\@title{#1}%
   \hypersetup{pdftitle={\@title}}}
\newcommand{\othertitle}[1]{\gdef\@othertitle{#1}}
\newcommand{\@othertitle}{\ifi}
\renewcommand{\author}[1]{\gdef\@author{#1}%
   \hypersetup{pdfauthor={\@author}}}
\renewcommand{\subject}[1]{\gdef\@subject{#1}%
   \hypersetup{pdfsubject={\@subject}}}
\newcommand{\place}[1]{\gdef\@place{#1}}
\newcommand{\@place}{\ifi}
\newcommand{\professor}[1]{\gdef\@professor{#1}}
\newcommand{\@professor}{\ifi}
\newcommand{\supervisors}[1]{\gdef\@supervisors{#1}}
\newcommand{\@supervisors}{\ifi}
\newcommand{\institut}[1]{\gdef\@institut{#1}}
\newcommand{\@institut}{\ifi}
\newcommand{\organisation}[1]{\gdef\@organisation{#1}}
\newcommand{\@organisation}{\ifi}
\newcommand{\worktype}[1]{\gdef\@worktype{#1}}
\newcommand{\@worktype}{\ifi}
\newcommand{\tenderdate}[1]{\gdef\@tenderdate{#1}}
\newcommand{\@tenderdate}{\ifi}

% Abfragebefehle für Informationen
\newcommand{\getauthor}{\@author{}}
\newcommand{\gettitle}{\@title}
\newcommand{\getothertitle}{\@othertitle}
\newcommand{\getsubject}{\@subject}
\newcommand{\getdate}{\@date}
\newcommand{\getplace}{\@place}
\newcommand{\getprofessor}{\@professor}
\newcommand{\getsupervisors}{\@supervisors}
\newcommand{\getinstitut}{\@institut}
\newcommand{\getorganisation}{\@organisation{}}
\newcommand{\getworktype}{\@worktype{}}
\newcommand{\gettenderdate}{\@tenderdate}

% Einstellungen rund um Fußnoten und Literaturverzeichnis
\RequirePackage{remreset}
\@removefromreset{footnote}{chapter}
\RequirePackage[
  backend=biber,
  %autocite=footnote,
  citestyle=numeric
]{biblatex}

% Seitenränder:
\usepackage{geometry}
\geometry{a4paper, top=28mm, left=30mm, right=25mm, bottom=28mm, head=15mm, headsep=5mm, footskip=12mm}

% Schrift wechseln (primär für Listings)
% TODO: check if needed
\renewcommand{\ttdefault}{pcr}

% Zeilenhöhe
\RequirePackage{setspace}
\renewcommand{\onehalfspacing}{%
  \setstretch{1.5}%  default
  \ifcase \@ptsize \relax % 10pt
    \setstretch {1.5}%
  \or % 11pt
    \setstretch {1.5}%
  \or % 12pt
    \setstretch {1.5}%
  \fi
}
\onehalfspacing

% Seitenformatierung:
\usepackage{scrpage2}
\usepackage{textarea}
\pagestyle{scrheadings}
\clearscrheadings
\renewcommand*{\chapterpagestyle}{scrheadings} % auch auf Kapitelanfangsseiten Kopfzeilen
\ifoot{\gettitle}
\ihead{\getauthor}
\ohead{\headmark}
\ofoot{\pagemark}
\automark[chapter]{chapter}
\renewcommand*{\chapterheadstartvskip}{\vspace*{-\topskip}} % Kleinere Kapitelfreiräume
\setheadsepline{0.25mm}


% content group definitions
% \definecontentblockstate{name}{<display>{color}{endspace}
\RequirePackage{changepage}
\newcommand*{\definecontentblockstate}[4]{
% Define boolean to hide the contentgroup borders
\newboolean{hide_#1group}
\setboolean{hide_#1group}{#2}
% Define border color
\definecolor{#1group}{rgb}{#3}
% Store space lenght after content
\expandafter\def\csname #1group_space \endcsname{\vspace{#4}}
% Define environement to define content group
\newenvironment*{#1content}[1]%
{\ifthenelse{\boolean{hide_#1group}}{}{

\noindent\fcolorbox{#1group}{white}{\parbox{0.9\textwidth}{##1}}
\begin{adjustwidth}{1em}{0pt}

}}%
{\ifthenelse{\boolean{hide_#1group}}{}{%
\end{adjustwidth}%
\csname #1group_space \endcsname}}
}

\newcommand{\contentpart}[2][plan]{\begin{#1content}{#2}\end{#1content}}
\newcommand{\subcontentpart}[2][plan]{\begin{#1content}{#2}\end{#1content}}


% PDF/URL-Einstellungen:
\usepackage[
    pdftex,
    a4paper,
    setpagesize,
    hyperfootnotes,
    colorlinks=true,
    linkcolor=black,
    citecolor=black,
    filecolor=black,
    urlcolor=black,
    bookmarks=true,
    bookmarksopen=true,
    bookmarksopenlevel=3,
    plainpages=false,
    pdfpagelabels=true,
    unicode]{hyperref}

% glossar and acronym handling:
\RequirePackage[acronym,
  nonumberlist,
  numberedsection,
  toc]{glossaries}

% Standardwerte:
\organisation{Hasso-Plattner-Institut}
\ifenglish{\worktype{Bachelor thesis}}{\worktype{Bachelorarbeit}}
\date{\today}
\tenderdate{\today}
\subject{Informatik}

%Titelseite:
\renewcommand{\maketitle}[1][0]{
\setcounter{page}{#1}
\begin{titlepage}
\begin{center}

\vfill{
  \begin{large} \getworktype\end{large}

  \bigskip

  \begin{LARGE} \textbf{''\gettitle''} \end{LARGE}

  \begin{large} \textbf{''\getothertitle''} \end{large}

  \bigskip
}

\vfill{
  \ifenglish{to obtain the academic degree}{zur Erlangung des akademischen Grades}\\
  "`Bachelor of Science"' (B.Sc.)\\
  \ifenglish{in the course IT Systems Engineering at the}{im Studiengang IT-Systems Engineering am}

  \vspace{0.5cm}

  \begin{large}\getorganisation\end{large}

  \bigskip

\includegraphics[height=2.5cm]{./common/hpi-logo.pdf} \hspace{1cm}
\includegraphics[height=2.5cm]{./common/uni-potsdam-logo.pdf}
}

\vfill{
  \ifenglish{at the chair}{im Fachgebiet} \textbf{\getsubject}\\
  \ifenglish{supervised by}{betreut durch} \\ \getprofessor,\\ \getsupervisors \\
  \ifenglish{submitted on}{eingereicht am} \gettenderdate \\
}

\vfill{
  \ifenglish{by}{von} \\
  \large\textbf{\getauthor} \normalsize\\
  \getplace, \getdate
}
\end{center}
\end{titlepage}
}

\endinput
