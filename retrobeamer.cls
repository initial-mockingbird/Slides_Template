% =====================================================================
%  RETRO MAC OS BEAMER TEMPLATE
%  Style: classic System 7 / Platinum window chrome, rainbow apple logo,
%  checkbox-style bullets, and a "code editor" window panel.
%  Compile with pdflatex (or xelatex).
% =====================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{retrobeamer}[2026/08/27 Beamer with a Hint of class]

\LoadClass[aspectratio=169]{beamer}


\RequirePackage{tikz}

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{listings}
\RequirePackage{xcolor}

\RequirePackage{graphicx}
\RequirePackage{fontspec} 
\RequirePackage{currfile}

\usetikzlibrary{shadows,calc,shapes.callouts}

%\newfontfamily\Inconsolata{Inconsolata.ttf}[
%	Path=/home/danie/Slides/Slides_Template/fonts/Inconsolata/static/,
%  	UprightFont = Inconsolata-Regular.ttf,
%  	BoldFont = Inconsolata-Bold.ttf
%]
\newfontfamily\dosfont{PxPlus_IBM_VGA_9x16.ttf}[
	Path=/home/danie/Slides/Slides_Template/fonts/oldschool_pc_font_pack_v2.2_FULL/ttf_Px_pixel_outline/
]


\setmainfont{Inconsolata}[
	Path=/home/danie/Slides/Slides_Template/fonts/Inconsolata/static/,
	Extension = .ttf,
  	UprightFont = Inconsolata-Regular,
  	BoldFont = Inconsolata-Bold
]
\setsansfont{Inconsolata}[
	Path=/home/danie/Slides/Slides_Template/fonts/Inconsolata/static/,
	Extension = .ttf,
  	UprightFont = Inconsolata-Regular,
  	BoldFont = Inconsolata-Bold
]
\setbeamerfont{title}{family=\dosfont}
\setbeamerfont{frametitle}{family=\dosfont}


%\renewcommand{\familydefault}{\dosfont}

% ---------------------------------------------------------------------
% Strip all of beamer's default chrome -- we draw our own.
% ---------------------------------------------------------------------
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{headline}{}
\setbeamertemplate{footline}{}
\setbeamertemplate{frametitle}{}
\beamertemplatenavigationsymbolsempty

% ---------------------------------------------------------------------
% Palette
% ---------------------------------------------------------------------
\definecolor{macGrey}{RGB}{202,202,202}      % desktop / slide background
\definecolor{macBarBlack}{RGB}{20,20,20}     % menu bar
\definecolor{winTitle}{RGB}{225,225,214}     % window titlebar (platinum)
\definecolor{winStripe}{RGB}{188,188,178}
\definecolor{winBody}{RGB}{240,236,214}      % cream code background
\definecolor{winBorder}{RGB}{40,40,40}
\definecolor{codeKeyword}{RGB}{130,60,160}   % purple keywords (theorem, begin, end)
\definecolor{codeTactic}{RGB}{40,80,190}     % blue tactic names (rw, induction)
\definecolor{codeComment}{RGB}{40,140,60}    % green comments
\definecolor{codeText}{RGB}{35,35,35}
\definecolor{lineNum}{RGB}{150,150,140}
\definecolor{appleYellow}{RGB}{255,205,15}
\definecolor{appleOrange}{RGB}{255,140,20}
\definecolor{appleRed}{RGB}{230,45,45}
\definecolor{appleGreen}{RGB}{150,190,45}
\definecolor{appleBlue}{RGB}{30,150,210}
\definecolor{applePurple}{RGB}{120,60,160}
\definecolor{appleLeaf}{RGB}{80,170,60}
\definecolor{appleStem}{RGB}{90,60,30}
\definecolor{folderYellow}{RGB}{235,200,90}

% ---------------------------------------------------------------------
% Code listing style (tuned to look like the Lean example)
% ---------------------------------------------------------------------
\lstdefinelanguage{lean}{
  morekeywords={theorem,lemma,def,begin,end,with},
  morecomment=[l]{--},
  sensitive=true
}

\lstdefinestyle{macEditor}{
  language=lean,
  basicstyle=\ttfamily\small\color{codeText},
  keywordstyle=\color{codeKeyword}\bfseries,
  commentstyle=\color{codeComment},
  backgroundcolor=\color{winBody},
  numbers=left,
  numberstyle=\ttfamily\scriptsize\color{lineNum},
  numbersep=8pt,
  xleftmargin=18pt,
  frame=none,
  breaklines=false,
  showstringspaces=false,
  columns=fixed,
  basewidth=0.5em,
  aboveskip=0pt,
  belowskip=0pt,
  literate=
    {rw}{{\textcolor{codeTactic}{\bfseries rw}}}2
    {induction}{{\textcolor{codeTactic}{\bfseries induction}}}9
}

% ---------------------------------------------------------------------
% Rainbow "apple" logo (simplified silhouette, six-colour stripes)
%   usage: \macapple{radius}
% ---------------------------------------------------------------------
\newcommand{\macapple}[1]{%
  \begin{tikzpicture}
    \def\r{#1}
    % apple body: rainbow horizontal stripes clipped to a circle
    \begin{scope}
      \clip (0,0) circle (\r);
      \foreach \i/\c [count=\yi from 0] in
        {0/appleYellow,1/appleOrange,2/appleRed,
         3/appleGreen,4/appleBlue,5/applePurple}{
        \pgfmathsetmacro{\ytop}{\r-\yi*2*\r/6}
        \pgfmathsetmacro{\ybot}{\r-(\yi+1)*2*\r/6}
        \fill[\c] (-\r,\ytop) rectangle (\r,\ybot);
      }
    \end{scope}
    % leaf
    \fill[appleLeaf] (0.05*\r,1.02*\r) to[out=70,in=200] (0.55*\r,1.28*\r)
        to[out=20,in=110] (0.35*\r,0.95*\r) to[out=250,in=40] cycle;
    % stem
    \draw[line width=0.18*\r,appleStem,cap=round]
        (0.0,0.95*\r) -- (0.08*\r,1.28*\r);
  \end{tikzpicture}%
}


% ---------------------------------------------------------------------
% Rainbow "lambda" logo 
%   usage: \lambda_icon{includegraphics options}
% ---------------------------------------------------------------------
\newcommand{\lambdaicon}[1][]{
\includegraphics[#1]{./icons/lambda_icon.png}
}

% ---------------------------------------------------------------------
% Checkbox-style bullet used in the left-hand list
% ---------------------------------------------------------------------
\setbeamertemplate{itemize item}{%
  \tikz{\draw[line width=0.9pt] (0,0) rectangle (0.22,0.22);
        \draw[line width=0.5pt] (0.045,0.11) -- (0.045,0.22-0.045) -- (0.22-0.045,0.22-0.045);}
}
\setbeamerfont{itemize item}{size=\Large}
\setbeamertemplate{itemize subitem}{--}

% ---------------------------------------------------------------------
% Full-slide background: grey desktop + top menu bar with clock
% ---------------------------------------------------------------------
\newcommand{\slideclock}{Clase 1}   % change per-slide if you like

\setbeamertemplate{background canvas}{%
  \begin{tikzpicture}[remember picture, overlay]
    \fill[macGrey] (current page.south west) rectangle (current page.north east);
    % top menu bar
    \fill[macBarBlack]
      ($(current page.north west)+(0,-0.62)$) rectangle (current page.north east);
    % apple logo in the bar
    \begin{scope}[shift={($(current page.north west)+(0.55,-0.31)$)}]
      %\macapple{0.19}
       \node[anchor=west] at ($(current page.north west)+(0,-0.31)$) {\lambdaicon[scale=0.01]};
    \end{scope}
    % clock
    \node[anchor=east,white,font=\small\ttfamily]
      at ($(current page.north east)+(-0.35,-0.31)$) {\slideclock};
  \end{tikzpicture}%
}

% =====================================================================
%  \macslidetitle{...} -- draws the small apple icon + big black slide
%  title. Call this as the FIRST thing inside your own frame, i.e.:
%
%    \begin{frame}[fragile,t]
%      \macslidetitle{LEAN: Proof Assistant Demo Template}
%      ... your columns / content ...
%      \mactip{Press CMD+P to Verify.}
%    \end{frame}
%
%  NOTE: do NOT wrap \begin{frame}...\end{frame} itself inside a custom
%  LaTeX environment when the frame contains lstlisting/verbatim -- the
%  [fragile] mechanism needs to see the literal \end{frame} text in the
%  source to know where the verbatim scanning stops. A wrapper macro
%  like this one (used *inside* the frame) is safe; a wrapper
%  *environment* (used *around* \begin{frame}...\end{frame}) is not.
% =====================================================================
\newcommand{\macslidetitle}[1]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node[anchor=north west] at ($(current page.north west)+(1.3,-0.7)$)
      %{\lambdaicon[scale=0.025]};
      {};
  \end{tikzpicture}
  \begin{center}
    {\usebeamerfont{title}\LARGE\bfseries\color{black} #1}\\
  \end{center}
}

% ---------------------------------------------------------------------
% Little hand-drawn "bomb" glyph (classic Mac System-error icon)
% ---------------------------------------------------------------------
\newcommand{\macbomb}[1]{% radius
  \begin{tikzpicture}
    \def\r{#1}
    \fill[black] (0,0) circle (\r);
    \fill[white] (-0.32*\r,0.32*\r) circle (0.28*\r); % highlight
    \draw[line width=0.35*\r,black,cap=round] (0.55*\r,0.85*\r) to[out=70,in=250] (0.9*\r,1.35*\r);
    \foreach \a in {40,70,100}{
      \draw[line width=0.09*\r,black] ($(0.9*\r,1.35*\r)+(\a:0.05*\r)$) -- ($(0.9*\r,1.35*\r)+(\a:0.32*\r)$);
    }
  \end{tikzpicture}%
}

% ---------------------------------------------------------------------
% Little cartoon "TIP" callout bubble, bottom-right, bomb icon included
%   usage: \mactip{Press CMD+P to Verify.}
% ---------------------------------------------------------------------
\newcommand{\mactip}[1]{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[anchor=south east,
          fill=white, draw=black, line width=0.8pt, rounded corners=4pt,
          inner sep=6pt, font=\footnotesize]
      (tipnode)
      at ($(current page.south east)+(-0.5,0.5)$)
      {\raisebox{-0.15cm}{\macbomb{0.11cm}}\ \textbf{TIP:} #1};
    \node[anchor=south east, circle, draw=black, fill=white,
          minimum size=0.55cm, font=\small\bfseries, line width=0.8pt]
      at ($(current page.south east)+(-0.15,1.15)$) {?};
  \end{tikzpicture}%
}

% =====================================================================
%  \begin{macwindow}{title}{subtitle} ... code ... \end{macwindow}
%  A single component drawing the full Mac window: title bar with
%  traffic-light buttons, "Monaco" subtitle bar, and the code body --
%  all sharing exactly the same width (\linewidth of the column) so the
%  chrome and the code box are always perfectly aligned, with no gap.
% =====================================================================

\newsavebox{\mycodebox}



\lstnewenvironment{macwindow}[2]{% #1 = title, #2 = subtitle
  \noindent
  \pgfmathsetmacro{\w}{\linewidth/1cm}%
  \pgfmathsetmacro{\pad}{0.047em}%
  %\hspace*{1em}\scalebox{0.96}{
  \hspace*{1em}\scalebox{1}[1]{
  \begin{tikzpicture}
    % title bar
    \filldraw[fill=winTitle,draw=winBorder,line width=0.9pt] (\pad ,0) rectangle (\w,0.55);
    \foreach \y in {0.08,0.14,...,0.47}{
      \draw[winStripe,line width=0.5pt] (\pad+0.55,\y) -- (\w-0.55,\y);
    }
    \node[fill=winTitle,inner sep=2pt] at (\w/2,0.275) {\small\bfseries #1};
    \filldraw[winBorder,line width=0.8pt,fill=white] (\pad+0.16,0.14) rectangle (\pad+0.4,0.4);
    \draw[winBorder,line width=0.8pt] (\w-0.4,0.14) rectangle (\w-0.16,0.4);
    \draw[winBorder,line width=0.8pt] (\w-0.4,0.14) -- (\w-0.16,0.4);
    \draw[winBorder,line width=0.8pt] (\w-0.16,0.14) -- (\w-0.4,0.4);
    % subtitle bar
    \filldraw[fill=winStripe,draw=winBorder,line width=0.7pt] (\pad,-0.4) rectangle (\w,0);
    \node at (\w/2,-0.2) {\small\bfseries #2};
  \end{tikzpicture}}\\[-0.1em]
  \noindent
  \lstset{style=macEditor,breaklines=true,breakindent=0pt,
    basicstyle=\ttfamily\scriptsize\color{codeText},
    numbersep=5pt,xleftmargin=2.5em,   % total space reserved for the numbers column
    frame=single,rulecolor=\color{winBorder},framerule=0.9pt,tabsize=2}%
}{%
}

% =====================================================================
%  \begin{macbox}{title}{subtitle} ... plain content ... \end{macbox}
%  Same window chrome as macwindow, but for ordinary text/lists/images
%  instead of code -- no [fragile] needed. Use this for quotes, notes,
%  screenshots, tables, or any non-code content in a "window".
% =====================================================================
\newsavebox{\macboxcontent}
\newenvironment{macbox}[2]{% #1 = title, #2 = subtitle
  \noindent
  \pgfmathsetmacro{\w}{\linewidth/1cm}%
  \begin{tikzpicture}
    \fill[winTitle] (0,0) rectangle (\w,0.55);
    \draw[winBorder,line width=0.9pt] (0,0) rectangle (\w,0.55);
    \foreach \y in {0.08,0.14,...,0.47}{
      \draw[winStripe,line width=0.5pt] (0.55,\y) -- (\w-0.55,\y);
    }
    \node[fill=winTitle,inner sep=2pt] at (\w/2,0.275) {\small\bfseries #1};
    \draw[winBorder,line width=0.8pt,fill=white] (0.16,0.14) rectangle (0.4,0.4);
    \draw[winBorder,line width=0.8pt] (\w-0.4,0.14) rectangle (\w-0.16,0.4);
    \draw[winBorder,line width=0.8pt] (\w-0.4,0.14) -- (\w-0.16,0.4);
    \draw[winBorder,line width=0.8pt] (\w-0.16,0.14) -- (\w-0.4,0.4);
    \fill[winStripe] (0,-0.4) rectangle (\w,0);
    \draw[winBorder,line width=0.7pt] (0,-0.4) rectangle (\w,0);
    \node at (\w/2,-0.2) {\small\bfseries #2};
  \end{tikzpicture}\\[-0.1em]
  \setlength{\fboxsep}{10pt}%
  \begin{lrbox}{\macboxcontent}
  \begin{minipage}{\linewidth-2\fboxsep-2\fboxrule}
}{%
  \end{minipage}
  \end{lrbox}
  \noindent\fcolorbox{winBorder}{winBody}{\usebox{\macboxcontent}}%
}

% =====================================================================
%  \macdesktopicon{x}{y}{type}{label} -- a small decorative desktop
%  icon (folder or document) with a label underneath, used to dress up
%  \mactitledialog. type is "folder" or "doc". Coordinates are page-
%  relative offsets from the page center, in cm.
% =====================================================================
\newcommand{\macdesktopicon}[4]{%
\begin{tikzpicture}[remember picture,overlay]
    \node at ($(current page.center)+(#1,#2)$) {%
      \begin{tikzpicture}
        \ifthenelse{\equal{#3}{folder}}{%
          \fill[folderYellow] (0,0) rectangle (0.9,0.7);
          \fill[folderYellow] (0,0.7) -- (0.05,0.85) -- (0.4,0.85) -- (0.45,0.7) -- cycle;
          \draw[winBorder,line width=0.6pt] (0,0) rectangle (0.9,0.7);
          \draw[winBorder,line width=0.6pt] (0,0.7) -- (0.05,0.85) -- (0.4,0.85) -- (0.45,0.7);
        }{%
          \fill[white] (0,0) rectangle (0.7,0.9);
          \draw[winBorder,line width=0.6pt] (0,0) -- (0,0.9) -- (0.5,0.9) -- (0.7,0.7) -- (0.7,0) -- cycle;
          \draw[winBorder,line width=0.6pt] (0.5,0.9) -- (0.5,0.7) -- (0.7,0.7);
          \foreach \yy in {0.15,0.3,0.45}{\draw[winBorder,line width=0.4pt] (0.12,\yy) -- (0.58,\yy);}
        }
      \end{tikzpicture}%
    };
    \node[yshift=#2 cm-0.62cm,xshift=#1 cm,font=\scriptsize,color=black!70]
      at (current page.center) {#4};
  \end{tikzpicture}%
}

% =====================================================================
%  \mactitledialog{title}{subtitle}{meta} -- an alternative title slide:
%  a centered "About This Deck"-style Mac dialog box (with OK button)
%  floating over a desktop dressed with a couple of icons. Use inside
%  a plain frame:
%    \begin{frame}
%      \mactitledialog{Proof Assistant Demo}{A gentle introduction to Lean}
%        {J. Appleseed -- Fall 2026}
%    \end{frame}
% =====================================================================
\newcommand{\mactitledialog}[4]{%
  \macdesktopicon{-5.7}{2.1}{folder}{Lectures}
  \macdesktopicon{5.6}{2.1}{doc}{cats}
  \macdesktopicon{-5.7}{-2.3}{doc}{README}
  \macdesktopicon{5.6}{-2.3}{folder}{Exercises}
  \begin{tikzpicture}[remember picture,overlay]
    \node at (current page.center) {%
      \begin{tikzpicture}
        \def\dw{9.6} \def\dh{4.4}
        % drop shadow
        \fill[black!35] (0.12,-\dh-0.12) rectangle (\dw+0.12,0.12-0.55);
        % title bar
        \fill[winTitle] (0,-0.55) rectangle (\dw,0);
        \draw[winBorder,line width=1pt] (0,-0.55) rectangle (\dw,0);
        \foreach \y in {-0.08,-0.14,...,-0.47}{
          \draw[winStripe,line width=0.5pt] (0.55,\y) -- (\dw-0.55,\y);
        }
        \node[fill=winTitle,inner sep=2pt] at (\dw/2,-0.275) {\small\bfseries #4};
        \draw[winBorder,line width=0.8pt,fill=white] (0.16,-0.41) rectangle (0.4,-0.15);
        \draw[winBorder,line width=0.8pt] (\dw-0.4,-0.41) rectangle (\dw-0.16,-0.15);
        \draw[winBorder,line width=0.8pt] (\dw-0.4,-0.41) -- (\dw-0.16,-0.15);
        \draw[winBorder,line width=0.8pt] (\dw-0.16,-0.41) -- (\dw-0.4,-0.15);
        % body
        \fill[winBody] (0,-\dh) rectangle (\dw,-0.55);
        \draw[winBorder,line width=1pt] (0,-\dh) rectangle (\dw,-0.55);
        \node at (1.55,-2.3) {\lambdaicon[scale=0.06]};
        \node[align=left,anchor=north west,text width=6.3cm] at (3.15,-0.95) {%
          {\LARGE\bfseries #1}\\[6pt]
          {\Large\color{black!70} #2}\\[6pt]
          {\normalsize\ttfamily\color{black!55} #3}%
        };
        % OK button
        \draw[winBorder,line width=0.9pt,fill=winTitle,rounded corners=2pt]
          (\dw-2.0,-\dh+0.3) rectangle (\dw-0.4,-\dh+0.85);
        \node[font=\bfseries] at (\dw-1.2,-\dh+0.575) {OK};
      \end{tikzpicture}%
    };
  \end{tikzpicture}%
}

% =====================================================================
%  \macdivider{title}{subtitle} -- a big centered section-break slide.
%  Use inside a plain (non-fragile) frame:
%    \begin{frame}
%      \macdivider{Part Two}{Induction \& Recursion}
%    \end{frame}
% =====================================================================
\newcommand{\macdivider}[2]{%
  \begin{tikzpicture}[remember picture,overlay]
    \node at ($(current page.center) + (0,0.5)$) {\lambdaicon[scale=0.1]};
    \node[yshift=-2.1cm,font=\huge\bfseries] at (current page.center) {#1};
    \node[yshift=-2.9cm,font=\Large,color=black!65] at (current page.center) {#2};
  \end{tikzpicture}
}

% =====================================================================
%  \macstat{number}{label} -- one big statistic; combine several side
%  by side in a \begin{columns} row for a metrics/summary slide.
% =====================================================================
\newcommand{\macstat}[2]{%
  \begin{center}
    {\fontsize{40}{40}\selectfont\bfseries #1}\\[4pt]
    {\Large #2}
  \end{center}
}