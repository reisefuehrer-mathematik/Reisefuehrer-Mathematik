\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{buch}

\LoadClass[ngerman]{scrbook}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[ngerman]{babel}
\RequirePackage[table]{xcolor}

\RequirePackage[utf8]{inputenc}
\RequirePackage[bottom=4cm]{geometry}
\RequirePackage{csquotes}

\RequirePackage{subfiles}

\RequirePackage[gen]{eurosym}
\RequirePackage{amsmath, amssymb}

\RequirePackage{tikz}
\RequirePackage{tikzlings}
\usepackage{pgfplots}

\RequirePackage{longtable, tabu}

\RequirePackage{tabularx}

\RequirePackage{imakeidx}


%indexing
\begin{filecontents}{idxstyle.ist}
headings_flag 1
heading_prefix "\n\\large\\sffamily\\bfseries%
\\noindent\\textbf{"heading_suffix "}\\par\\nopagebreak\n"
item_0 "\n \\item \\small "
delim_0 " \\hfill "
delim_1 " \\hfill "
delim_2 " \\hfill "
suffix_2p "\\,f."
suffix_3p "\\,ff."
\end{filecontents}

\indexsetup{othercode=\small}
\makeindex[program=makeindex,columns=2,intoc=true,options={-s idxstyle.ist}]
%

\RequirePackage{bookmark}
\RequirePackage{hyperref}
\RequirePackage[capitalise]{cleveref}

\RequirePackage[most]{tcolorbox}
%\RequirePackage[framemethod=TikZ]{mdframed}
\usepgfplotslibrary{groupplots}

\usetikzlibrary{calc}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lengths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength\parindent{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\def\@bookseries{}
\def\@volume{}

\newcommand{\bookseries}[1]{\renewcommand{\@bookseries}{#1}}
\newcommand{\volume}[1]{\renewcommand{\@volume}{#1}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Structural commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{xstring}
\let\Chaptermark\chaptermark
\def\chaptermark#1{\def\Chaptername{#1}\Chaptermark{#1}}
%\newcommand{\ldsection}[2]{\section{#1}\subfile{#2}}
\newcommand{\tosnakecase}[2]{
    \begingroup\edef\x{\lowercase{\endgroup\def\noexpand#2{#1}}}\x
    \StrSubstitute{#2}{ä}{ae}[#2]
    \StrSubstitute{#2}{ö}{oe}[#2]
    \StrSubstitute{#2}{ü}{ue}[#2]
    \StrSubstitute{#2}{ }{_}[#2]
}
\makeatletter
\newcommand\ldsection[2][]{
    \section{#2}
    \tosnakecase{\Chaptername}{\chapname}
    \tosnakecase{#2}{\filename}
    \subfile{chapters/\chapname/\two@digits{\arabic{section}}_\filename}
}
\makeatother
\newcommand\ldadvsection[2][]{
    \clearpage
    \pagecolor{violet!30!white}
    \section{#2}
    \begin{remark}{Für Fortgeschrittene}
        Dieser Abschnitt baut stark auf dem Verständnis vorangegangener Kapitel auf. Die behandelte Thematik ist wesentlich schwieriger zu verstehen und geht über den Schulstoff hinaus. Sinn dieses Kapitels ist es, dem interessierten Schüler einen Einblick darein zu geben, was die Kombinatorik über den Schulstoff hinaus zu bieten hat.
        
        Die wichtigste Lektion, die man aus diesem Kapitel ziehen kann, ist, dass der in der Schule behandelte Stoff nur einen sehr kleinen Teil dessen ausmacht, was es zu wissen gibt. \textbf{Der Kaninchenbau geht wesentlich tiefer als es von oben scheint.}
    \end{remark}
    \tosnakecase{\Chaptername}{\chapname}
    \tosnakecase{#2}{\filename}
    \subfile{chapters/\chapname/0\arabic{section}_\filename}
    \clearpage
    \pagecolor{white}%\restorepagecolor
}
\makeatletter
\newenvironment{wip}{%
    \begingroup%
    \newpage%
    \appto{\ESO@HookIBG}{%
        \tikz[overlay,remember picture]{
            \fill[yellow] (current page.south east) -- ++(0,1) -| (current page.south west) -- cycle;
            \foreach\i in {0,...,20}{
                \fill[black] (\i,0) -- ++(.5,0) -- ++(.5,1) -- ++(-.5, 0) -- cycle;
            }
            \node[black, anchor=center, font=\Large\fontseries{b}\selectfont\sffamily, fill=yellow] at ($(current page.south) + (0,.5)$) {Work in Progress};
        }%
    }%
}{%
    \newpage%
    \endgroup%
}
\newenvironment{train}{%
    \begingroup%
    \newpage%
    \appto{\ESO@HookIBG}{%
        \tikz[overlay,remember picture]{
            \fill[violet] ($(current page.north east) + (0,-1.85)$) -- ++(0,-0.3) -| ($(current page.north west) + (0,-1.85)$) -- cycle;
            \fill[orange] ($(current page.north east) + (0,-1.45)$) -- ++ (0,-0.3) -- ++ (-5.5, 0) -- ++ (135:1) -- ++ (-5,0) -- ++ (225:1) coordinate (a) -- ($(current page.north west) + (0,-1.75)$) -- ++ (0,0.3) -- ($(a) + (-0.1212,0.3)$) -- ++ (45:1) -- ++ (5.2424,0) -- ++ (-45:1) -- cycle;
            \draw[rounded corners=1mm, line width=.75mm, fill=white] ($(current page.north west) + (17.75,-1.3)$) -- ++ (0,-1) -- ++ (0.8,0) -- ++ (0,1) -- cycle;
            %\draw[line width=.55mm, fill=white] ($(current page.north west) + (17.75,-2.35)$) -- ++ (0,-4) -- ++ (0.8,0) -- ++ (0,4) -- cycle;
            \node at ($(current page.north west) + (18.15,-1.8)$) {\Large \textbf{17}};
            \foreach\x in {2,3.3,...,8.5}{%,17,18.25,19.5}{
                \draw[fill=white, thick, rounded corners=.8mm] ($(current page.north west) + (\x,-1.35)$) -- ++ (0,-0.9) -- ++ (0.3,0) -- ++ (0,0.9) -- cycle;
            }
        }%
    }%
}{%
    \newpage%
    \endgroup%
}
\makeatother
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mathematical environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{def}[chapter]
\newcounter{theo}[chapter]
\newcounter{lem}[chapter]
\newcounter{cor}[chapter]
\newcounter{sample}[chapter]
\newcounter{envcount}[chapter]

\renewcommand{\thectr}{\arabic{chapter}.\arabic{envcount}}
\renewcommand{\thedef}{\arabic{chapter}.\arabic{def}}
\renewcommand{\thetheo}{\arabic{chapter}.\arabic{theo}}
\renewcommand{\thelem}{\arabic{chapter}.\arabic{lem}}
\renewcommand{\thecor}{\arabic{chapter}.\arabic{cor}}
\renewcommand{\thesample}{\arabic{chapter}.\arabic{sample}}

\def\tcmathenvopt{breakable, enhanced jigsaw, pad at break=2mm, fonttitle=\bfseries, boxrule=2pt}
\newtcolorbox{definition}[1][]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=red!5!white,colframe=red!75!black, title={\refstepcounter{envcount} Definition~\thectr\ifstrempty{#1}{}{~--~#1}}}
\newtcolorbox{lemma}[1][]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=yellow!20,colframe=yellow!50!orange, title={\refstepcounter{envcount} Satz~\thectr\ifstrempty{#1}{}{~--~#1}}}

\newtcolorbox{theorem}[1][]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=green!20,colframe=green!50!black, title={\refstepcounter{envcount} Satz~\thectr\ifstrempty{#1}{}{~--~#1}}}
\newtcolorbox{corollary}[1][]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=green!20,colframe=green!50!gray, title={\refstepcounter{envcount} Korollar~\thectr\ifstrempty{#1}{}{~--~#1}}}
\newtcolorbox{example}[1][]{code={\pgfkeysalsofrom{\tcmathenvopt}},
    sharp corners,
    boxrule=0pt, colframe=black!5,
    coltitle=black, colback=black!5,
    borderline west={3pt}{0pt}{gray},
    title={\refstepcounter{envcount}Beispiel~\thectr\ifstrempty{#1}{}{~--~#1}},
    attach title to upper=\vspace*{.5em}\par
}
\newtcolorbox{advexample}[1][]{code={\pgfkeysalsofrom{\tcmathenvopt}},
    sharp corners,
    boxrule=0pt, colframe=violet!30,
    coltitle=black, colback=violet!30,
    borderline west={3pt}{0pt}{violet!70},
    title={\refstepcounter{envcount}Beispiel~\thectr\ifstrempty{#1}{}{~--~#1}},
    attach title to upper=\vspace*{.5em}\par
}

\newtcolorbox{remark}[1]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=blue!20,colframe=blue!40, title={\color{blue} Anmerkung: #1\hfill\tikz[overlay, scale=.5]{\squirrel}}, attach title to upper=\vspace*{.5em}\par}
\newtcolorbox{reminder}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=gray!20,colframe=gray!40, title={\color{gray} Erinnerung}, attach title to upper=\vspace*{.5em}\par}
%\newtcolorbox{nutshell}[1]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=brown!20,colframe=brown!40, title={\color{brown} Kurz und knapp: #1\hfill\tikz[overlay, scale=.5]{\sloth}}, attach title to upper=\vspace*{.5em}\par}
\newenvironment{nutshell}[1]{
    \begin{tcolorbox}[code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=brown!20,colframe=brown!40, title={\color{brown} Kurz und knapp: #1\hfill\tikz[overlay, scale=.5]{\sloth}}, attach title to upper=\vspace*{.5em}\par]
    \setlength\heavyrulewidth{2pt}
    \setlength{\lightrulewidth}{1.5pt}%
    \arrayrulecolor{brown!40}
}{
    \end{tcolorbox}
    \arrayrulecolor{black}
}

\newtcolorbox{advanced}[1]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=violet!20,colframe=violet!40, title={\color{violet} Tiefer in den Hasenbau: #1\hfill\tikz[overlay, scale=.5]{\moles}}, attach title to upper=\vspace*{.5em}\par}

\newcolumntype{L}{>{\raggedright\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}
\newcolumntype{Y}{>{\centering\arraybackslash}X}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Styles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{ifthen}

\usetikzlibrary{tikzmark}

\colorlet{maincolor}{orange}
\colorlet{chaptercolor}{maincolor!40}
\RedeclareSectionCommand[
    beforeskip=\dimexpr3.3\baselineskip+1\parskip\relax,
    innerskip=0pt,
    afterskip=1.725\baselineskip plus .115\baselineskip minus .192\baselineskip
]{chapter}
\renewcommand\raggedchapter{\raggedleft}
\renewcommand\chapterformat{{\textcolor{chaptercolor}{\bfseries\thechapter}}}
\renewcommand{\chapterlinesformat}[3]{%
    \ifthenelse{\equal{#2}{\empty}}{}{
    \tikz[remember picture, overlay]{
        \node[anchor=south east, inner sep=0pt, transform shape, scale=8, text=chaptercolor!40!black!20!white] at ($(A.south east)-(0,.5cm)-(-.25cm, .25cm)$) {\bfseries\thechapter};
        \node[anchor=south east, inner sep=0pt, transform shape, scale=8] at ($(A.south east)-(0,.5cm)$) {#2};
    }}%
    \tikzmarknode{A}{\bfseries#3}
    \vspace*{-.5\baselineskip}%
    \rule{\textwidth}{.4pt}\par\nobreak
}
\renewcommand\chapterlineswithprefixformat[3]{\chapterlinesformat{#1}{#2}{#3}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Todos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{todocomment}
\newcommand{\todocomment}[2][]{\refstepcounter{todocomment}{%\setstretch{0.7}%
    \todo[color={red!100!green!33},size=\small]{%
    \textbf{Comment [\uppercase{#1}\thetodocomment]:}~#2}%
}}
\newcommand{\mayberef}{\colorbox{red}{\bfseries\color{white} [VERWEIS?]}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\renewcommand{\maketitle}{
\begin{titlepage}
\begin{tikzpicture}[overlay,remember picture]
    % Background color
    \fill[black!2] (current page.south west) rectangle (current page.north east);
    % Rectangles
    \shade[transform canvas={rotate around={45:($(current page.north west)+(0,-6)$)}}]
        ($(current page.north west)+(0,-6)$) rectangle ++(9,1.5);
    \shade[left color=lightgray, right color=lightgray!50, rounded corners=0.75cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(.5,-10)$)}}]
        ($(current page.north west)+(0.5,-10)$) rectangle ++(15,1.5);
    \shade[left color=lightgray, rounded corners=0.3cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(.5,-10)$)}}] ($(current page.north west)+(1.5,-9.55)$) rectangle ++(7,.6);
    \shade[left color=orange!80, right color=orange!60, rounded corners=0.4cm,
        transform canvas ={rotate around ={45:($(current page.north)+(-1.5,-3)$)}}]
        ($(current page.north)+(-1.5,-3)$) rectangle ++(9,0.8);
    \shade[left color=red!80, right color=red!80, rounded corners=0.9cm,
        transform canvas ={rotate around ={45:($(current page.north)+(-3,-8)$)}}] ($(current page.north)+(-3,-8)$) rectangle ++(15,1.8);
    \shade[left color=orange, rounded corners=0.9cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(4,-15.5)$)}}]
        ($(current page.north west)+(4,-15.5)$) rectangle ++(30,1.8);
    \shade[rounded corners=0.75cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(13,-10)$)}}]
        ($(current page.north west)+(13,-10)$) rectangle ++(15,1.5);
    \shade[left color=lightgray, rounded corners=0.3cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(18,-8)$)}}]
        ($(current page.north west)+(18,-8)$) rectangle ++(15,0.6);
    \shade[left color=lightgray, rounded corners=0.4cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(19,-5.65)$)}}]
        ($(current page.north west)+(19,-5.65)$) rectangle ++(15,0.8);
    \shade[left color=orange!50!red, right color=red!80, rounded corners=0.6cm,
        transform canvas ={rotate around ={45:($(current page.north west)+(20,-9)$)}}] 
        ($(current page.north west)+(20,-9)$) rectangle ++(14,1.2);
    % Volume and title
    \draw[ultra thick,gray] ($(current page.center)+(5,2)$) -- ++(0,-3cm) 
        node[midway, left=0.25cm, text width=20cm, align=right, black!75, font={\fontsize{32}{37} \selectfont\bfseries}] {\MakeUppercase \@bookseries} 
        node[midway, right=0.25cm, text width=6cm, align=left, orange, font={\fontsize{72}{86.4} \selectfont}] {\@volume};
    % Authors
    \node[align=center] at ($(current page.center)+(0,-5)$) {
        {\fontsize{30}{42} \selectfont {{\@title}}} \\[1cm]
        {\fontsize{16}{19.2} \selectfont \textcolor{orange}{ \textbf{Band 1: Unterstufenmathematik}}}\\[3pt]
        Schulstoff ab Klasse 5\\[43pt]
        %Ergänzungen für Unterforderte
        Ein einfacher aber herausfordernder Leitfaden\\durch die Schulmathematik};
\end{tikzpicture}
\end{titlepage}
\makeatother
}
