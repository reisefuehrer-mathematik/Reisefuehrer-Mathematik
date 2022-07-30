\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{buch}

\LoadClass[ngerman]{scrbook}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[main=ngerman]{babel}
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

\RequirePackage{enumitem}

\RequirePackage{imakeidx}

\RequirePackage{qrcode}


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
\RequirePackage{aliascnt} % must be loaded before cleveref
\RequirePackage[capitalise, nameinlink, ngerman]{cleveref}

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
\newcommand\ldadvsection[2][]{
    \clearpage
    \begingroup%
        % Redefine the colors of the environments while in an advanced section
        \colorlet{definition@bg}{red!5!white}%
        \colorlet{definition@frame}{red!75!black}%
        \colorlet{lemma@bg}{yellow!20}%
        \colorlet{lemma@frame}{yellow!50!orange}%
        \colorlet{theorem@bg}{green!20}%
        \colorlet{theorem@frame}{green!50!black}%
        \colorlet{corollary@bg}{green!20}%
        \colorlet{corollary@frame}{green!50!gray}%
        \colorlet{example@bg}{violet!30!white!95!black}%
        \colorlet{example@frame}{violet!70}%
        \colorlet{remark@bg}{blue!20}%
        \colorlet{remark@frame}{blue!40}%
        \colorlet{reminder@bg}{gray!20}%
        \colorlet{reminder@frame}{gray!40}%
        \colorlet{nutshell@bg}{brown!70!white}%
        \colorlet{nutshell@frame}{brown!70!black}%
        %
        \pagecolor{violet!30!white}
        \section{#2}
        \tosnakecase{\Chaptername}{\chapname}
        \tosnakecase{#2}{\filename}
        \subfile{chapters/\chapname/\two@digits{\arabic{section}}_\filename}
        \clearpage
    \endgroup
    \pagecolor{white}%\restorepagecolor
}
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
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mathematical environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{mathenv}[chapter]

\renewcommand{\themathenv}{\arabic{chapter}.\arabic{mathenv}}
\newaliascnt{def}{mathenv}
\newaliascnt{theo}{mathenv}
\newaliascnt{lem}{mathenv}
\newaliascnt{cor}{mathenv}
\newaliascnt{sample}{mathenv}
\newaliascnt{rem}{mathenv}


\Crefname{def}{Definition}{Definitionen}
\crefname{def}{Definition}{Definitionen}
\Crefname{theo}{Theorem}{Theoreme}
\crefname{theo}{Theorem}{Theoreme}
\Crefname{lem}{Lemma}{Lemmata}
\crefname{lem}{Lemma}{Lemmata}
\Crefname{cor}{Korollar}{Korollare}
\crefname{cor}{Korollar}{Korollare}
\Crefname{sample}{Beispiel}{Beispiele}
\crefname{sample}{Beispiel}{Beispiele}
\Crefname{rem}{Anmerkung}{Anmerkungen}
\crefname{rem}{Anmerkung}{Anmerkungen}

\renewcommand{\thedef}{\arabic{chapter}.\arabic{def}}
\renewcommand{\thetheo}{\arabic{chapter}.\arabic{theo}}
\renewcommand{\thelem}{\arabic{chapter}.\arabic{lem}}
\renewcommand{\thecor}{\arabic{chapter}.\arabic{cor}}
\renewcommand{\thesample}{\arabic{chapter}.\arabic{sample}}

%% Default Colors
\colorlet{definition@bg}{red!5!white}
\colorlet{definition@frame}{red!75!black}
\colorlet{lemma@bg}{yellow!20}
\colorlet{lemma@frame}{yellow!50!orange}
\colorlet{theorem@bg}{green!20}
\colorlet{theorem@frame}{green!50!black}
\colorlet{corollary@bg}{green!20}
\colorlet{corollary@frame}{green!50!gray}
\colorlet{example@bg}{black!5}
\colorlet{example@frame}{gray}
\colorlet{remark@bg}{blue!20}
\colorlet{remark@frame}{blue!40}
\colorlet{reminder@bg}{gray!20}
\colorlet{reminder@frame}{gray!40}
\colorlet{nutshell@bg}{brown!20}
\colorlet{nutshell@frame}{brown!40}


\tcbuselibrary{breakable}
\def\tcmathenvopt{breakable, enhanced jigsaw, pad at break=2mm, fonttitle=\bfseries, boxrule=2pt}
\DeclareTColorBox{definition}{ o m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    colback=definition@bg,colframe=definition@frame,
    title={Definition~\thedef\ifstrempty{#2}{}{~--~#2}},
    step=def,
    IfValueT={#1}{label=#1}
}
\DeclareTColorBox{lemma}{ o m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    colback=lemma@bg,colframe=lemma@frame,
    title={Satz~\thelem\ifstrempty{#2}{}{~--~#2}},
    step=lem,
    IfValueT={#1}{label=#1}
}
\DeclareTColorBox{theorem}{ o m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    colback=theorem@bg,colframe=theorem@frame,
    title={Satz~\thetheo\ifstrempty{#2}{}{~--~#2}},
    step=theo,
    IfValueT={#1}{label=#1}
}
\DeclareTColorBox{corollary}{ o m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    colback=corollary@bg,colframe=corollary@frame,
    title={Korollar~\thecor\ifstrempty{#2}{}{~--~#2}},
    step=cor,
    IfValueT={#1}{label=#1}
}
\DeclareTColorBox{example}{ o m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    sharp corners,
    boxrule=0pt, colframe=example@bg,
    coltitle=black, colback=example@bg,
    borderline west={3pt}{0pt}{example@frame},
    title={Beispiel~\thesample\ifstrempty{#2}{}{~--~#2}},
    attach title to upper=\vspace*{.5em}\par,
    step=sample,
    IfValueT={#1}{label=#1}
}
\DeclareTColorBox{remark}{ o m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    colback=remark@bg,colframe=remark@frame,
    title={\color{blue} Anmerkung: #2\hfill\tikz[overlay, scale=.5]{\squirrel}},
    attach title to upper=\vspace*{.5em}\par,
    step=rem,
    IfValueT={#1}{label=#1}
}
\newtcolorbox{reminder}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=reminder@bg,colframe=reminder@frame, title={\color{gray} Erinnerung}, attach title to upper=\vspace*{.5em}\par}
%\newtcolorbox{nutshell}[1]{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=brown!20,colframe=brown!40, title={\color{brown} Kurz und knapp: #1\hfill\tikz[overlay, scale=.5]{\sloth}}, attach title to upper=\vspace*{.5em}\par}
\newenvironment{nutshell}[1]{
    \begin{tcolorbox}[code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=nutshell@bg,colframe=nutshell@frame, title={\color{brown} Kurz und knapp: #1\hfill\tikz[overlay, scale=.5]{\sloth}}, attach title to upper=\vspace*{.5em}\par]
    \setlength\heavyrulewidth{2pt}
    \setlength{\lightrulewidth}{1.5pt}%
    \arrayrulecolor{brown!40}
}{
    \end{tcolorbox}
    \arrayrulecolor{black}
}
\DeclareTColorBox{goal}{ o m m }{
    code={\pgfkeysalsofrom{\tcmathenvopt}},
    sharp corners,
    boxrule=0pt, colframe=#3,
    coltitle=black, colback=black!5,
    borderline west={3pt}{0pt}{#3},
    title={#2},
    %attach title to upper=\vspace*{.5em}\par,
    step=sample
}

\newtcolorbox{advanced}[1]{
    %breakable,
    attach title to upper=\par,
    colback=violet!20,
    colframe=violet!20,
    left*=0pt,
    right*=0pt,
    outer arc=0pt,
    parbox=false,
    title={\bfseries\color{violet} #1},
    %extras pre={
    if odd page or oneside={
    grow to left by=\Gm@lmargin,
    grow to right by=\Gm@rmargin,
    }{
    grow to left by=\Gm@rmargin,
    grow to right by=\Gm@lmargin,
    }
    %},
}
\makeatother


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
        \node[anchor=south east, inner sep=0pt, transform shape, scale=8, text=chaptercolor!40!black!20!white] at ($(pic cs:A)-(0,.5cm)-(-.25cm, .25cm)$) {\bfseries\thechapter};
        \node[anchor=south east, inner sep=0pt, transform shape, scale=8] at ($(pic cs:A)-(0,.5cm)$) {#2};
    }}%
    \bfseries#3\tikzmark{A}
    \vspace*{-.5\baselineskip}%
    \rule{\textwidth}{.4pt}\par\nobreak
}
\renewcommand\chapterlineswithprefixformat[3]{\chapterlinesformat{#1}{#2}{#3}}

% Setting the default enumerate environment to circled numbers
\RequirePackage{circledsteps}
\RequirePackage{enumitem}
\def\@circlelblcolor@text{white}
\def\@circlelblcolor@border{blue!40!white}
\def\@circlelblcolor@fill{blue!40!white}
\newcommand{\circlelbl}[1]{%
    \Circled[%
        inner color=white,%\@circlelblcolor@text,
        outer color=blue!40,%\@circlelblcolor@border,
        fill color=blue!40,%\@circlelblcolor@fill,
        inner ysep=4pt,
        inner xsep=4pt]{\textsf{#1}}%
}
\newcommand{\mathmodecircle}[2]{%
    \Circled[%
        inner color=black,%\@circlelblcolor@text,
        outer color=orange!#2,%\@circlelblcolor@border,
        fill color=orange!#2,%\@circlelblcolor@fill,
        inner ysep=4pt,%
        inner xsep=4pt]{#1}%
}
\newcommand{\circlemath}[1]{%
    \mathmodecircle{#1}{30}
}
\newcommand{\circlemathresult}[1]{%
    \mathmodecircle{#1}{60}
}
\setlist[enumerate]{label=\circlelbl{\arabic*}}

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
