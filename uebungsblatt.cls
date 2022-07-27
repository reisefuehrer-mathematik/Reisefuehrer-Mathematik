\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uebungsblatt}

\LoadClass{scrarticle}

\RequirePackage[a4paper, bottom=2cm,left=2cm,right=2cm,top=2cm]{geometry}
\RequirePackage[utf8]{inputenc}
\RequirePackage{tabularx}
\RequirePackage{enumitem}
\RequirePackage{amssymb}
\RequirePackage{qrcode}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{csquotes}
\RequirePackage{picins}
\RequirePackage[gen]{eurosym}
\RequirePackage{xstring}
%\usepackage{soul}

\pagestyle{empty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\newif\if@solution \@solutionfalse
\DeclareOption{solution}{\global\@solutiontrue}
\DeclareOption*{%
  \PackageWarning{uebungsblatt}{Unknown option `\CurrentOption'}%
}
\ProcessOptions
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\def\@sheet{}
\def\@topic{}
\def\@chapternum{}

\newcommand{\sheet}[1]{\renewcommand{\@sheet}{#1}}
\newcommand{\topic}[1]{\renewcommand{\@topic}{#1}}
\newcommand{\chapternum}[1]{\renewcommand{\@chapternum}{#1}}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lengths
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength\parindent{0pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Structural commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\tosnakecase}[2]{
    \begingroup\edef\x{\lowercase{\endgroup\def\noexpand#2{#1}}}\x
    \StrSubstitute{#2}{ä}{ae}[#2]
    \StrSubstitute{#2}{ö}{oe}[#2]
    \StrSubstitute{#2}{ü}{ue}[#2]
    \StrSubstitute{#2}{ }{_}[#2]
}
\newcommand{\tosheetnum}[2]{
    \begingroup\edef\x{\lowercase{\endgroup\def\noexpand#2{#1}}}\x
    \StrSubstitute{#2}{blatt0}{}[#2]
    \StrSubstitute{#2}{blatt}{}[#2]
}
\makeatletter
\newcommand\ldtasks[1]{
    \tosheetnum{#1}{\sheetnum}
    \section*{Aufgaben zu Vorbereitungsblatt \@chapternum.\sheetnum}
    \tosnakecase{\@topic}{\chaptername}
    \subfile{\chaptername/#1}
}
\newcommand{\makesolutions}{
    \tosnakecase{\@topic}{\chaptername}    
    \begin{solutions}
        \subfile{\chaptername/solutions}
    \end{solutions}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Boxes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[many]{tcolorbox}

\def\tcmathenvopt{breakable, enhanced jigsaw, pad at break=2mm, fonttitle=\bfseries, boxrule=2pt}

\newtcolorbox{contents}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=blue!10,colframe=blue!30, coltitle=black, title={Inhalte des Vorbereitungsblattes}, attach title to upper=\vspace*{.5em}\par}
\newtcolorbox{definition}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=red!5!white,colframe=red!75!black, title={Definition}}
\newtcolorbox{theorem}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=green!20,colframe=green!50!black, title={Satz}}
\newtcolorbox{remark}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=yellow!10, coltitle=black, colframe=yellow!80!black}%, title=Bemerkung, attach title to upper=\vspace*{.5em}\par}
%\newmdenv[roundcorner=5pt,linewidth=1pt,backgroundcolor=black!10,linecolor=black!30]{literature}
\newtcolorbox{literature}{code={\pgfkeysalsofrom{\tcmathenvopt}}, colback=black!10,colframe=black!30, boxsep=0pt}
\newcommand{\video}[4]{
    \begin{literature}
        \begin{minipage}{.1\textwidth}
            \qrcode[height=1cm]{#4}
        \end{minipage}
        \begin{minipage}{.9\textwidth}
            \href{#4}{\textbf{Video:} \textit{#1}} (#2 Minuten)\\
            #3 im Buch
        \end{minipage}
    \end{literature}
}
\newcommand{\mandala}[1]{
    \vfill
    \begin{center}
        \input{#1}
    \end{center}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Document title
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\renewcommand{\maketitle}{
    \newcolumntype{L}{>{\raggedright\arraybackslash}X}
    \newcolumntype{R}{>{\raggedleft\arraybackslash}X}
    \noindent\begin{tabularx}{\linewidth}{@{}L@{}R@{}}
        Reiseführer Mathematik & Themenblock \textit{\@topic}\\
        Kapitel \@chapternum & Übungsmaterial\\
    \end{tabularx}
    
    \begin{center}
        \@sheet\\
        \LARGE \textbf{\@title}
    \end{center}
}
\makeatother

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tasks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcounter{exercisectr}
\setcounter{exercisectr}{0}
\def\exercisemargin{.5cm}
\newenvironment{exercise}{%
    \stepcounter{exercisectr}%
    \noindent\begin{tabular}{@{}p{\exercisemargin}@{}p{\dimexpr\linewidth-\exercisemargin}@{}}%
        \theexercisectr. & \begin{minipage}[t]{\linewidth}%
}{%
    \end{minipage}%
    \end{tabular}\bigskip%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General environments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{verbatim}
\makeatletter
\if@solution
    \newenvironment{insolution}{}{}
    \newcommand\ifsolutionthenelse[2]{#1}
\else
    \newenvironment{insolution}{\comment}{\endcomment}
    \newcommand\ifsolutionthenelse[2]{#2}
\fi
\makeatletter

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Environments and definitions needed for different tasks
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlist{multiplechoice}{itemize}{1}
\setlist[multiplechoice]{label=$\square$, topsep=0pt}

%the correct choice
\if@solution
    \newcommand{\citem}{\item[$\text{\rlap{$\checkmark$}}\square$]}
\else
    \newcommand{\citem}{\item}
\fi

\newtcolorbox{answerbox}[1][3em]{sharp corners, colback=white,colframe=black,boxsep=0pt, boxrule=1pt,height=#1,upperbox=\ifsolutionthenelse{visible}{invisible}}

% \answerfield{width}{solution}
\newcommand{\answerfield}[2]{\underline{\text{\parbox{#1}{\centering \ifsolutionthenelse{#2}{~}}}}}

\RequirePackage[normalem]{ulem}
\RequirePackage{etoolbox}
\makeatletter
\newcounter{entrynum}
%mark incorrect choices
\if@solution
    \newcommand{\@wrongtxtchoice}[1]{\sout{\color{gray} #1}}
\else
    \newcommand{\@wrongtxtchoice}[1]{#1}
\fi
\usepackage{expl3,xparse}
\ExplSyntaxOn
\makeatletter
\seq_new:N \l_choices_in_seq
\seq_new:N \l_choices_out_seq
\NewDocumentCommand\textchoice{ O{0} m }{%
    \begingroup
    \setcounter{entrynum}{0}%
    \newcommand\markcorrect[1]{%
        \unexpanded{\ifnum\theentrynum=#1%
            ##1%
        \else%
            \@wrongtxtchoice{##1}%
        \fi%
        \stepcounter{entrynum}}%
    }%
    \seq_set_from_clist:Nn \l_choices_in_seq { #2 }%
    \seq_set_map:NNn \l_choices_out_seq \l_choices_in_seq{%
        \markcorrect{ \exp_not:n { ##1 } }%
    }%
    \uline{\seq_use:Nn \l_choices_out_seq {\  |\ }}%
    \endgroup
}

\usepackage{environ}
\seq_new:N \l_wordlist
\newsavebox{\wordlistcontent}
\NewEnviron{blanktext}{
	\newcommand\phony[1]{\seq_gput_right:Nn\l_wordlist{##1}}%
	\newcommand{\blank}[2]{\phony{##2}\answerfield{##1}{##2}}%
	\sbox{\wordlistcontent}{\begin{minipage}{\linewidth}\BODY\end{minipage}}%
	\seq_shuffle:N\l_wordlist%
	\par\noindent\colorbox{gray!20!white}{%
		\begin{minipage}{\linewidth-6pt}%
			\seq_use:Nn\l_wordlist{\ |\ }%
		\end{minipage}%
	}\par%
	\usebox{\wordlistcontent}
}
\makeatother
\ExplSyntaxOff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Allow referencing main and pasting from it.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User must define \pathToMain previously
\RequirePackage{clipboard}
\RequirePackage{xr}
\IfFileExists{\pathToMain chapters.cpy}{
    \openclipboard{\pathToMain chapters}
}{
    \PackageWarning{uebungsblatt}{Chapters-clipboard not found}
}
%\openclipboard{\pathToMain chapters}
\externaldocument[ext:]{\pathToMain main}
\newcommand\getchapternum[1]{\ref*{ext:chap:#1}}
\newcommand\getchaptername[1]{\Paste{chap:lbl_#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\colorlet{maincolor}{orange}