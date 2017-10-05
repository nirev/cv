%% Based on original template by Adrien Friggeri (github.com/afriggeri)
%% Modified by Guilherme de Maio (github.com/nirev)

\ProvidesClass{nirev-cv}[2017/08/03 CV class]
\NeedsTeXFormat{LaTeX2e}

\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption{academic}{\def\@cv@academic{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass[a4]{article}

\RequirePackage{titlesec}
\RequirePackage{comment}

%%%%%%%%%%
% Colors %
%%%%%%%%%%

\RequirePackage{xcolor}

\definecolor{white}{RGB}{255,255,255}

\definecolor{darkgray}{HTML}{333333}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{lightgray}{HTML}{999999}

\definecolor{green}{HTML}{C2E15F}
\definecolor{orange}{HTML}{FDA333}
\definecolor{purple}{HTML}{D3A4F9}
\definecolor{red}{HTML}{FB4485}
\definecolor{blue}{HTML}{6CE0F1}

\ifdefined\@cv@print
  \colorlet{green}{gray}
  \colorlet{orange}{gray}
  \colorlet{purple}{gray}
  \colorlet{red}{gray}
  \colorlet{blue}{gray}
  \colorlet{fillheader}{white}
  \colorlet{header}{gray}
\else
  \colorlet{fillheader}{gray}
  \colorlet{header}{white}
\fi
\colorlet{textcolor}{gray}
\colorlet{headercolor}{gray}

%%%%%%%%%
% Fonts %
%%%%%%%%%

\RequirePackage{fontspec}
\RequirePackage{unicode-math}

\newfontfamily\bodyfont[]{Ubuntu}
\newfontfamily\thinfont[]{Ubuntu Light}
\newfontfamily\headingfont[]{Ubuntu Condensed}
\newfontfamily\monofont[]{Ubuntu Mono}

\defaultfontfeatures{Mapping=tex-text}
\setmainfont[Mapping=tex-text, Color=textcolor]{Ubuntu Light}


%\setmathfont{XITS Math}
\setmathfont{xits-math.otf}

%%%%%%%%%%
% Header %
%%%%%%%%%%

\RequirePackage{tikz}
\RequirePackage{graphicx}

\newcommand{\rolefont}{%
  \fontsize{14pt}{24pt}\selectfont%
  \thinfont%
  \color{white}%
}

\newcommand{\header}[3]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=fillheader, anchor=north, minimum width=\paperwidth, minimum height=2.6cm] (box) at (current page.north){};
    \node [anchor=south,yshift=-0.4cm] (name) at (box) {%
      \fontsize{40pt}{72pt}\color{header}%
      {\thinfont #1}{\bodyfont  #2}
    };
    \node [anchor=north] at (name.south) {%
      \fontsize{14pt}{24pt}\color{header}%
      \thinfont #3%
    };
  \end{tikzpicture}
  \vspace{1.2cm}
}


%%%%%%%%%%%%%
% Structure %
%%%%%%%%%%%%%
\RequirePackage{parskip}

\newcounter{colorCounter}
\def\@sectioncolor#1#2#3{%
  {%
    \color{%
      \ifcase\value{colorCounter}%
        blue\or%
        green\or%
        orange\or%
        red\or%
        purple\else%
        headercolor\fi%
    } #1#2#3%
  }%
  \stepcounter{colorCounter}%
}

\renewcommand{\section}[1]{
  \par\vspace{\parskip}
  {%
    \LARGE\headingfont\color{headercolor}%
    \@sectioncolor #1%
  }
  \par\vspace{-0.2\parskip}
}

\renewcommand{\subsection}[1]{
  \par\vspace{.5\parskip}
  {%
    \Large\headingfont\color{headercolor} \@sectioncolor #1%
  }
  \vspace{-\parskip}
}

\pagestyle{empty}


%%%%%%%%%%%%%%%%%%%%
% List environment %
%%%%%%%%%%%%%%%%%%%%

\setlength{\tabcolsep}{0pt}
\newenvironment{entrylist}{%
  \begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{%
  \end{tabular*}
  %\vspace{-0.4cm}
}
\renewcommand{\bfseries}{\headingfont\color{headercolor}}
\newcommand{\entry}[4]{%
  \parbox[t]{2cm}{\small #1}&\parbox[t]{11.8cm}{%
    \small
    \textbf{#2}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #3}\\%
    #4\vspace{-0.5cm}%
  }\\}

\newcommand{\workentry}[5]{%
  \parbox[t]{\textwidth}{%
    \parbox[t]{\textwidth}{\small #1 – #2}\\%
    \parbox[t]{\textwidth}{%
    \textbf{#3}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #4}\\%
    #5\vspace{.7\parsep}%
  }\\}%
}

\newcommand{\shortworkentry}[5]{%
  & \parbox[t]{\textwidth}{%
    \footnotesize{\monofont\color{gray} #1 to #2} - \textbf{#3}%
    \hfill%
    {\footnotesize\addfontfeature{Color=lightgray} #4}\\%
    \vspace{-0.5cm}
  }\\}

%%%%%%%%%%%%%%
% Side block %
%%%%%%%%%%%%%%

\RequirePackage{fontawesome}
\RequirePackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1cm}
\setlength{\TPVertModule}{1cm}
\newenvironment{aside}{%
  \let\oldsection\section
  \renewcommand{\section}[1]{
    \par\vspace{\baselineskip}{\Large\headingfont\color{headercolor} ##1}
  }
  \begin{textblock}{3.6}(0.9, 2.90)
  \begin{flushright}
  \obeycr
}{%
  \restorecr
  \end{flushright}
  \end{textblock}
  \let\section\oldsection
}

%%%%%%%%%%%%%%%%
% Bibliography %
%%%%%%%%%%%%%%%%

\RequirePackage[style=verbose, maxnames=99, sorting=ydnt]{biblatex}

\DeclareFieldFormat[article]{title}{#1\par}
\DeclareFieldFormat[inproceedings]{title}{#1\par}
\DeclareFieldFormat[misc]{title}{#1\par}
\DeclareFieldFormat[report]{title}{#1\par}

\DeclareBibliographyDriver{article}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \usebibmacro{journal+issuetitle}%
    \setunit{\space}%
    \printfield{pages}%
    \newunit%
    \printlist{publisher}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{inproceedings}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}%
    \printfield{booktitle}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{misc}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{booktitle}%
    \setunit*{\addcomma\space}%
    \printfield{note}%
    \setunit*{\addcomma\space}%
    \printfield{year}%
    \setunit{\addcomma\space}%
    \printlist{location}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

\DeclareBibliographyDriver{report}{%
  \printfield{title}%
  \newblock%
  \printnames{author}%
  \par%
  \newblock%
  {%
    \footnotesize\addfontfeature{Color=lightgray}\itshape%
    \printfield{type}%
    \setunit{\space}%
    \printfield{number}%
    \setunit{\addcomma\space}%
    \printfield{year}%
    \newunit%
  }
  \par\vspace{0.3\baselineskip}
}

% New syntax for flexible backend (BibLaTeX > v3.3)
\DeclareNameFormat{author}{%
  \small\addfontfeature{Color=lightgray}%
  \renewcommand*{\multinamedelim}{\addcomma\addspace}%
  \nameparts{#1}%
  \ifthenelse{\value{listcount}=1}
    {\ifblank{\namepartgiven}{}{\namepartgiven\space}%
    \namepartfamily}%
    {\ifblank{\namepartgiven}{}{\namepartgiven\space}%
    \namepartfamily}%
  \ifthenelse{\value{listcount}<\value{liststop}}
  {\addcomma\space}
  {}
}

\ifdefined\@cv@academic
  \newcommand{\printbibsection}[2]{
    \begin{refsection}
      \nocite{*}
      \printbibliography[type={#1}, title={#2}, heading=subbibliography]
    \end{refsection}
  }
  \newcommand{\printbibsectionpar}[3]{
    \begin{refsection}
      \nocite{*}
      \printbibliography[type={#1}, title={#2}, heading=subbibliography, #3]
    \end{refsection}
  }
\else
  \newcommand{\printbibsection}[2]{}
  \newcommand{\printbibsectionpar}[3]{}
\fi



\DeclareSortingScheme{chronological}{
  \sort[direction=descending]{\field{year}}
  \sort[direction=descending]{\field{month}}
}



%%%%%%%%%%%%%%%%
% Other tweaks %
%%%%%%%%%%%%%%%%

\RequirePackage[left=5.7cm,top=1.4cm,right=1.5cm,bottom=0cm,nohead,nofoot]{geometry}
\RequirePackage[hidelinks]{hyperref}
