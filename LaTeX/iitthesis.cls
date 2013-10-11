
%%%   IITTHESIS DOCUMENT CLASS FiLE --  Version 2 (Updated on 11/11/2003 by Babak Hamidian)
%%%   for LaTeX version 2e - 05/30/2003
%%% =====================================================================
%%% =====================================================================
%%%  WHAT IS NEW IN VERSION 2 ?
%%%
%%% This version of style file contains List of Symbols page. You can easily add symobls/definitions using the
%%% command \SymbolDefinition{}{}. Also the subheadings' style is changed to bold and non-italic format.
%%% For the case when Table of Contents is more than one page, two macro commands \moretoc and \moretox are
%%% provided to add the titles "CHAPTER    PAGE" or "APPENDIX    PAGE" on the top of the 2nd page.
%%%
%%% =====================================================================
%%% =====================================================================
%%%  @LaTeX-class-file{
%%%     filename        = "iitthesis.cls",
%%%     date            = "May 2003",
%%%     writtenby       = "Ozlem KALINLI"
%%%     address         = "Illinois Institute of Technology
%%%                        3300 S. Federal Street
%%%                        Chicago, IL 60616 USA",
%%%     e-mail          = "kaliozl@iit.edu",
%%%     codetable       = "ISO/ASCII",
%%%     keywords        = "LaTeX,IIT,thesis",
%%%     notes           = "This file provides the LaTeX2e style iithesis.cls 
%%%                        for formating graduate thesis at the Illinois 
%%%                        Institute of Technology. It was written by 
%%%                        Ozlem Kalinli. For an example of its use, see the 
%%%                        file: iitsample.tex, and help files given in pdf format".
%%%  }
%%% =====================================================================

\typeout{Document Class `IIT_THESIS' <May 2003>.}

\NeedsTeXFormat{LaTeX2e} 
\ProvidesClass{iitthesis}[2003/05/30,Illinois Institute of Technology Thesis Class]

%   **********************************
%   * Interline Spacing Commands     *
%   **********************************
% \ssp : single-spacing
% \dsp : double-spacing
% \tsp : triple-spacing
\renewcommand{\normalsize}{\@normalsize}
\def\ssp{\def\baselinestretch{1.0}\large\normalsize}
\def\dsp{\def\baselinestretch{1.66}\large\normalsize}
\def\tsp{\def\baselinestretch{2.6}\large\normalsize}


%    ****************************************
%    * Declaration of Options              *
%    ****************************************
%
% Option values are declared first.  
% Defaults are set to: 12 point, onesided, final (i.e., not draft) mode

\newcommand\@ptsize{}
\newcommand{\draftmark}{\dsp}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}  % can be used later for 10pt font-size
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\renewcommand{\draftmark}{\ssp}}
\DeclareOption{final}{\renewcommand{\draftmark}{\dsp}}
\ExecuteOptions{oneside,final,12pt} 
\ProcessOptions

\def\ds@twoside{\@twosidetrue \@mparswitchtrue}
\def\ds@draft{\overfullrule 5pt}
\@options

% This command inputs the font file that is selected depending on size information. 
\input font1\@ptsize.clo\relax


%    ****************************************
%    *          Page Format                 *
%    ****************************************
%
% See pg. 24 of "A Guide to Latex" by Helmut Kopka and Patrick W Daly
% for details.

\setlength{\textheight}{9in} 
\setlength{\textwidth}{6in}
\setlength{\topmargin}{-0.5in}
\setlength{\oddsidemargin}{0.5in}
\setlength{\evensidemargin}{0.5in}
\setlength{\parskip}{10pt} 
\setlength{\parindent}{0.5in}



%    ****************************************
%    *        Title Page Commands           *
%    ****************************************
%
\renewcommand{\title}[1]{\gdef\@title{\uppercase{#1}}}
\renewcommand{\author}[1]{\gdef\@author{\uppercase{#1}}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
\newcommand{\dept}[1]{\gdef\@dept{#1}}
\renewcommand{\date}[1]{\gdef\@date{#1}}
\newif\ifcopyrightnotice
\newif\ifcoadvisor
\copyrightnoticefalse   % default is without copyright page
\coadvisorfalse         % default is without co-advisor


% -- Copyright Page Format ---
%
\def\copyrightpage{
\pagestyle{plain}
\pagenumbering{roman}
\setcounter{page}{2}
\dsp           % double space
\vspace*{3in}
\begin{center}
\copyright \ Copyright by \\ \@author \\ \@date
\end{center}
\clearpage
 }

 
% -- No Copyriht Page,  --
% -- It Creates Blank Page --
%
\def\nocopyrightpage{
\hbox{}               %   THEN Produce totally blank page
\thispagestyle{empty}%
\newpage
}


% -- Co-advisor  --
%
\def\coadvisortype{
  \vspace*{1.5em}
  \hfil{Approved \rule{2in}{0.01in}\\}
  \hfil
  \makebox[2in][c]{Co-Advisor} \\
  }


%    ****************************************
%    * Creating Title and Copyright Pages   *
%    ****************************************
%
\def\maketitle{
 \dsp
 \pagestyle{empty}
 \vspace*{0.3in}
 \begin{center}
  {\@title} \\
  \vspace{1.8in}
  {BY} \\
  {\@author} \\
 \end{center}
 \vspace{1.3in}
 \begin{center}
  \ssp{Submitted in partial fulfillment of the \\
   requirements for the degree of \\
   {\@degree} in {\@dept} \\
   in the Graduate College of the \\
   Illinois Institute of Technology\\}
 \end{center}
 \vspace{0.5in}
 \begin{flushright}
 \ssp
 \hfil{Approved \rule{2in}{0.01in}\\}
 \hfil
 \makebox[2in][c]{Advisor} \\
 \ifcoadvisor
 \coadvisortype
 \fi
 \end{flushright}
 \vfill
 \begin{center}
  \ssp
  Chicago, Illinois \\
  \@date
 \end{center}
 \clearpage
 \let\maketitle\relax
 \ifcopyrightnotice
 \copyrightpage
 \else
 \nocopyrightpage
 \fi
}


%    ****************************************
%    *          Acknowledgement             *
%    ****************************************
% 
\newenvironment{acknowledgement}{
 \pagestyle{plain}
 \pagenumbering{roman}
 \setcounter{page}{3}
 \begin{center}
 \tsp{ACKNOWLEDGMENT \\}    % Creates the title of Acknowledgement page
 \vspace{0pt}
 \end{center}
 \addcontentsline{toc}{chapter}{\protect\noindent ACKNOWLEDGEMENT}   % adds Acknowledgement title into Table of Contents
 \dsp }{\clearpage}



%    ****************************************
%    *            Abstract                  *
%    ****************************************
% 
\newenvironment{abstract}{
 \begin{center}
 \tsp{ABSTRACT \\}        % Creates the title of Abstract page
 \vspace{0pt}
 \end{center}
 \addcontentsline{toc}{chapter}{\protect\noindent ABSTRACT}         % adds Abstract title into Table of Contents
 \dsp}{\clearpage}



%    ****************************************
%    *    Preliminary Pages' Format         *
%    ****************************************
%
\def\prelimpages{            % sets page numbering for the preliminary pages
   \pagestyle{plain}         % will be {plain} at start of toc
   \pagenumbering{roman}
   \setcounter{page}{3}
   }



%    ****************************************
%    *        Text Pages' Format            *
%    ****************************************
%
 \def\textpages{
  \addtocontents{toc}{\protect\noindent CHAPTER \vspace{-10pt}}     % adds Chapter word into Table of Contents.
  \draftmark               % if it is draft, it will be single-spaced. if it is final, it will be double-spaced.
  \pagenumbering{arabic}
  \pagestyle{myheadings}
  \setcounter{page}{1}
 }
 
 
%    ****************************************
%    *           List Structures            *
%    ****************************************
%
% See pg. 56 of "The LaTeX Companion" by Goossens, Mittelbach and Samarin
% for details.


%  ENUMERATE
%  Enumeration is done with four counters: enumi, enumii, enumiii
%  and enumiv, where enumN controls the numbering of the Nth level
%  enumeration.  The label is generated by the commands \labelenumi
%  ... \labelenumiv.  The expansion of \p@enumN\theenumN defines the
%  output of a \ref command.
%
\def\labelenumi{\theenumi.}
\def\theenumi{\arabic{enumi}}

\def\labelenumii{(\theenumii)}
\def\theenumii{\alph{enumii}}
\def\p@enumii{\theenumi}

\def\labelenumiii{\theenumiii.}
\def\theenumiii{\roman{enumiii}}
\def\p@enumiii{\theenumi(\theenumii)}

\def\labelenumiv{\theenumiv.}
\def\theenumiv{\Alph{enumiv}}
\def\p@enumiv{\p@enumiii\theenumiii}


% ITEMIZE
% Itemization is controlled by four commands: \labelitemi, \labelitemii,
% \labelitemiii, and \labelitemiv, which define the labels of the
% various itemization levels.

\def\labelitemi{$\bullet$}
\def\labelitemii{\bf --}
\def\labelitemiii{$\ast$}
\def\labelitemiv{$\cdot$}


% DESCRIPTION
% Each item has a label on the left which appears in bold face. 
% It is created by \item[labelname] command.

\def\descriptionlabel#1{\hspace\labelsep \bf #1}
\def\description{\list{}{\labelwidth\z@ \itemindent-\leftmargin
 \let\makelabel\descriptionlabel}}
\let\enddescription\endlist


% VERSE
% For indenting rhymes, poetry, verses, etc.    
% The user types \\ to end of each line.
%
\def\verse{\let\\=\@centercr
 \list{}{\itemsep\z@ \itemindent -1.5em\listparindent \itemindent
 \rightmargin\leftmargin\advance\leftmargin 1.5em}\item[]}
\let\endverse\endlist


% QUOTATION
% Seperated from the text both above and belove it by a triple space 
% and by being single-spaced.
% It is indented in its entirety three spaces from the left margin.

\def\quotation{\list{}{\listparindent 0em \leftmargin 0.3in \rightmargin 0em
 \itemindent\listparindent
\ssp} \vspace{0cm}\item[]}
\let\endquotation=\endlist



%    ****************************************
%    *         OTHER ENVIRONMENTS           *
%    ****************************************


% ARRAY AND TABULAR
%
% These are default values (pg.110 of "The Latex Companieon" )

\arraycolsep 5pt     % Half the width between columns in an array
                     % environment.
\tabcolsep 6pt       % Half the width between columns in a tabular
                     % environment.
\arrayrulewidth .4pt % Width of vertical rules in array and tabular environment.
\doublerulesep 2pt   % Space between adjacent rules in array or tabular
                     % environment.

% We have to redefine array here in order to make it single-spaced.
\def\array{\let\@acol\@arrayacol \let\@classz\@arrayclassz
 \let\@classiv\@arrayclassiv \let\\\@arraycr\let\@halignto\@empty\@tabarray}

% We have to redefine tabular here in order to make it single-spaced.
\def\tabular{\par\ssp\let\@halignto\@empty\@tabular}
\expandafter \def\csname tabular*\endcsname #1%
{\par\ssp\def\@halignto{to#1}\@tabular}


% TABBING
%
\tabbingsep \labelsep   % Space used by the \' command.

% \smallssp is used to produce tabular environments in the small font.
% Font size change is mandatory here, because \baselinestretch requires 
% a change in font size to take effect.
% \scriptsizessp is a smaller version of the \smallssp.

\def\smallssp{\def\baselinestretch{1.0}\large\small}
\def\scriptsizessp{\def\baselinestretch{1.0}\large\scriptsize}
                  
% \smalltabular and \smalltabular* are alternative tabular styles
% in the \small font.  They are required because single-spacing implies a
% change of font to a particular size.

\def\smalltabular{\par\smallssp\let\@halignto\@empty\@tabular}
\def\endsmalltabular{\endtabular}
\expandafter \def\csname smalltabular*\endcsname #1%
{\par\smallssp\def\@halignto{to#1}\@tabular} \expandafter \let
\csname endsmalltabular*\endcsname = \endtabular

% \scriptsizetabular and \scriptsizetabular* use the
% \scriptsize font.

\def\scriptsizetabular{\par\scriptsizessp\let\@halignto\@empty\@tabular}
\def\endscriptsizetabular{\endtabular}
\expandafter \def\csname scriptsizetabular*\endcsname #1%
{\par\scriptsizessp\def\@halignto{to#1}\@tabular} \expandafter
\let \csname endscriptsizetabular*\endcsname = \endtabular


% FRAMEBOX
%
% These are default values (pg.453 of "The Latex Companion" )

\fboxsep = 3pt    % Space left between box and text by \fbox and
                  % \framebox.
\fboxrule = .4pt  % Width of lines comprising the box made by \fbox and \framebox.



%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************
%
% DEFINE COUNTERS:
%
% \newcounter{NEWCTR}[OLDCTR] : Defines NEWCTR to be a counter, which is
%                               reset to zero when counter OLDCTR is
%                               stepped.
%                               Counter OLDCTR must already be defined.
% See pg. 446 of "The Latex Companion"

\newcounter {chapter}
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {appendix}

% For any counter CTR, \theCTR is a macro that defines the printed
% version of counter CTR.  It is defined in terms of the following
% macros:
%
%  \arabic{COUNTER} : The value of COUNTER printed as an arabic numeral.
%  \roman{COUNTER}  : Its value printed as a lower-case roman numberal.
%  \Roman{COUNTER}  : Its value printed as an upper-case roman numberal.
%  \alph{COUNTER}   : Value of COUNTER printed as a lower-case letter:
%                     a, b, c, etc.
%  \Alph{COUNTER}   : Value of COUNTER printed as an upper-case letter:
%                     A, B, C, etc.
%

\def\thechapter       {\arabic{chapter}}
\def\thesection       {\thechapter.\arabic{section}}
\def\thesubsection    {\thesection.\arabic{subsection}}
\def\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\def\theappendix      {\Alph{appendix}}



%    ****************************************
%    *         TABLE OF CONTENTS, ETC.      *
%    ****************************************
%
%  A table of contents is a special list with the titles of the section 
%  units specifying the page numbers where each section starts. Similar lists 
%  for figures and tables, namely, list of figures and list of tables, exist. 
%  Starndard LaTeX can automatically create these three content lists. By default, 
%  LaTeX enters text generated by one of the arguments of the sectioning commands
%  into the .toc file. Similarly, LaTeX maintains two more files, one for the list
%  of figures (.lof) and one for the list of tables (.lot), which contins the text 
%  specified as the argument of the \caption command for figures and tables. 
%  It is always necessary to run LaTeX at leat twice, once to collect the relevant
%  information, and a second time to read back the information and typeset it in 
%  the correct place in the document. 
%
%
% A sectioning command, such as \subsection, writes a
%       \contentsline{subsection}{TITLE}{PAGE}
% command on the .toc file, where TITLE contains the contents of the
% entry and PAGE is the page number.  If subsections are being numbered,
% then TITLE will be of the form
%       \numberline{NUM}{HEADING}
% where NUM is the number produced by \thesubsection.  Other sectioning
% commands work similarly.
%
%
% A \caption command in a 'figure' environment writes
%    \contentsline{figure}{\numberline{NUM}{CAPTION}}{PAGE}
% on the .lof file, where NUM is the number produced by \thefigure and
% CAPTION is the figure caption.  It works similarly for a 'table'
% environment using .lot file. 
%
%
% The command \contentsline{NAME} expands to \l@NAME.  So, to specify
% the table of contents, we must define \l@chapter, \l@section,
% \l@subsection, ... ; to specify the list of figures, we must define
% \l@figure; and so on.  Most of these can be defined with the
% \@dottedtocline command, which works as follows.
%
% \@dottedtocline{LEVEL}{INDENT}{NUMWIDTH}{TITLE}{PAGE}
%    LEVEL    : The nesting level of entry. An entry with a LEVEL greater
%               than the value of counter 'tocdepth' will not appear in the 
%               table of contents. 
%    INDENT   : The indentation from the outer left margin of the start
%               of the contents line.
%    NUMWIDTH : The width of a box in which the section number is to go,
%               if TITLE includes a \numberline command. This is also the 
%               amount of extra indentation added to the second and later
%               lines of a multiple entry.

% Additionaly, the command \@dottedtocline uses the following three formatting 
% parameters, which specify the visual appearance of all entries. These parameters 
% are set with a \def command using em's to make them depend upon the font.
%
%   \@pnumwidth : The width of a box in which the page number is put.
%   \@tocrmarg  : The right margin for all but the last line of the multiple line 
%                 entries.  One wants \@tocrmarg > or = \@pnumwidth
%   \@dotsep    : Separation between dots, in mu units.  Should be
%                 \def'd to a number like 1.7 or 2.

\def\@pnumwidth{2.05em}
\def\@tocrmarg{3em}
\def\@dotsep{5.5}
\setcounter{tocdepth}{4}

\def\l@chapter{\@dottedtocline{1}{0em}{5.1em}}
\def\l@section{\@dottedtocline{2}{0.82in}{2.4em}}
\def\l@subsection{\@dottedtocline{3}{8em}{2.4em}} 
\def\l@subsubsection{\@dottedtocline{4}{7.8em}{5.2em}}

\def\l@figure{\@dottedtocline{1}{2em}{2.5em}}
\def\l@table{\@dottedtocline{1}{1.6em}{2.3em}}



% TABLE OF CONTENTS
% 
% The \tableofcontents command is defined to create table of contents page.
% Also a command called \moretoc is defined to create second, third, etc.,
% pages for table of contents, if it is necessary. 

\def\tableofcontents{
 \begin{center}
 \tsp{TABLE OF CONTENTS\\}
 \end{center}
 \ssp
 \hfill Page\@starttoc{toc}}  


% If "Table of Contents" is more than one page, the following macro commands put headings for the 2nd page
%i.e. \moretoc adds "CHAPTER    PAGE" at the top of the 2nd page and \moretox adds "APPENDIX   PAGE".

\def\moretoc{\addtocontents{toc}{\newpage\protect\noindent CHAPTER\hfill Page\par\protect\vspace*{5pt}}}
\def\moretox{\addtocontents{toc}{\newpage\protect\noindent APPENDIX\hfill Page\par\protect\vspace*{5pt}}}


% LIST OF FIGURES
%
% The \listoffigures command is defined to create list of figures page.
% Also a command called \morelof is defined to create second, third, etc.,
% pages for list of figures, if it is necessary. 
% Single-space list of figures is added to the table of contents.

\def\listoffigures{
 \begin{center}
  \tsp{LIST OF FIGURES\\}
 \end{center}
 \ssp
 \noindent Figure \hfill Page\@starttoc{lof}
 \addcontentsline{toc}{chapter}{\noindent LIST OF FIGURES}
 }

\def\morelof{\addtocontents{lof}{\newpage\protect\noindent Figure\hfill
Page\par}}



% LIST OF TABLES
%
% The \listoftables command is defined to create list of tables page.
% Also a command called \morelot is defined to create second, third, etc.,
% pages for list of tables, if it is necessary. 
% Single-space list of tables is added to the table of contents.

\def\listoftables{
 \begin{center}
  \tsp{LIST OF TABLES\\}
 \end{center}
 \ssp
 \noindent Table \hfill Page\@starttoc{lot}
 \addcontentsline{toc}{chapter}{\noindent LIST OF TABLES}
 }

\def\morelot{\addtocontents{lot}{\newpage\protect\noindent Table\hfill
Page\par}}



% LIST OF SYMBOLS
%
% The following section is optional. Only the list of symbols page can be 
% created using \listofsymbols command, and it is added to the table of contents.

\def\listofsymbols{
 \begin{center}
 \tsp{LIST OF SYMBOLS\\}
 \end{center}
 \ssp
 \hbox{\protect\makebox[1.5cm][c]{Symbol}\hspace{3cm}\makebox[10cm][l]{Definition}}
 \addcontentsline{toc}{chapter}{\noindent LIST OF SYMBOLS}  %OK
}


%    ****************************************
%    *         SYMBOL COMMNAD               *
%    ****************************************

%SymbolDefinition{symbol}{definition} COMMAND is used to add symbols and their relevant definitions. The first argument
%is used for "Symbol" and the second for definition.
% 
\newcommand{\SymbolDefinition}[2]{
  \noindent
% \hbox{\protect\makebox[1.5cm][c]{#1}\hspace{1cm}\makebox[10cm][l]{#2}}
  \protect\makebox[1.5cm][c]{#1}\hspace{1cm}\parbox[t]{11cm}{#2}
  \par\vspace{5pt}
 }

%    ****************************************
%    *         FIGURES AND TABLES           *
%    ****************************************
%
% LaTeX makes it posible to float figures and tables, together with
% their headlines and captions, to an appropriate location without
% interrupting the text. Float placement parameters are set below. 
% See LaTeX manual for their definition.
% Also, it can be found in 'A Quide to Latex' by Helmut Kopka.

\setcounter{topnumber}{2}    % maximum number of floats that may appear at the top of a page.
\def\topfraction{.7}         % decimal number that specifies what fraction of the page may be used for floats at the top.
\setcounter{bottomnumber}{1}
\def\bottomfraction{.3}
\setcounter{totalnumber}{3}  % the maximum number of floats that may appear on any page regardless of position.
\def\textfraction{.2}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2} % the sameas topnumber, but for two-column format. 
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}


% To define a float of type TYPE (e.g., TYPE = figure), the document
% style must define the following.
%
% \fps@TYPE   : The default placement specifier for floats of type
%               TYPE.
%
% \ftype@TYPE : The type number for floats of type TYPE.  Each TYPE
%               has associated a unique positive TYPE NUMBER, which
%               is a power of two.  E.g., figures might have type
%               number 1, tables type number 2, programs type number
%               4, etc.
%
% \ext@TYPE   : The file extension indicating the file on which the
%               contents list for float type TYPE is stored.  For
%               example, \ext@figure = 'lof'.
%
% \fnum@TYPE  : A macro to generate the figure number for a caption.
%               For example, \fnum@TYPE == Figure \thefigure.
%
%  The actual float-making environment commands--e.g., the commands
%  \figure and \endfigure--are defined in terms of the macros \@float
%  and \end@float, which are described below.
%
% \@float{TYPE}[PLACEMENT] : Macro to begin a float environment for a
%     single-column float of type TYPE with PLACEMENT as the placement
%     specifier.  The default value of PLACEMENT is defined by
%     \fps@TYPE.  The environment is ended by \end@float.  E.g.,
%     \figure == \@float{figure}, \endfigure == \end@float.


% FIGURE
%
\newcounter{figure}[chapter]
\def\thefigure{\thechapter.\@arabic\c@figure}  % numbering for figures, they are numbered for each chapters
\def\fps@figure{tbp}                           % default placement for figures
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{Figure \thefigure}
\def\figure{\@float{figure}}
\let\endfigure\end@float
\@namedef{figure*}{\@dblfloat{figure}}
\@namedef{endfigure*}{\end@dblfloat}


% TABLE
%
\newcounter{table}[chapter]
\def\thetable{\thechapter.\@arabic\c@table}  % numbering for tables, they are numbered for each chapters
\def\fps@table{tbp}                          % default placement for tables
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{Table \thetable}
\def\table{\@float{table}}
\renewcommand{\arraystretch}{1.3}  % determines the distance between the rows of table
                                   % it is a multiplying factor
\let\endtable\end@float
\@namedef{table*}{\@dblfloat{table}}
\@namedef{endtable*}{\end@dblfloat}



%    ****************************************
%    *               CAPTION                *
%    ****************************************
%
% A figure caption or table title is produced with the \caption command
% inside the figure or table environment. Internally, \caption invokes 
% the \@makecaption{NUMBER}{TEXT} command.
% \@makecaption{NUMBER}{TEXT} : Macro to make a figure or table caption.
%      NUMBER : Figure or table number--e.g., 'Figure 3.2'
%      TEXT   : The caption text.
%
% After an initial skip of 10 pt,the material is typeset in a temporary box
% and its width is compared to the line width. If the material is longer than one line,
% it will be typeset with indentation. If it fits on one line, then the text is centered.
% This is done with the defined \@makecaption command given below.

\newlength\captionindent \captionindent=.18in

\long\def\@makecaption#1#2{% Add space only if something is ...
   \vskip 10pt                     % 10pt vertical space above the caption
   \setbox\@tempboxa\hbox{#1. #2}%
   \ifdim \wd\@tempboxa >\hsize %#1. #2 \par         % IF longer than one line:
     \ssp \hangindent\captionindent\noindent #1. #2\par\vspace{5pt}
    \else                                             %   ELSE  center.
       \hbox to\hsize{\hfil\box\@tempboxa\hfil}\vspace{5pt}    %inserts ssp
    \fi}

% These two command can be activated to leave more spaces above and below captions. 
%\setlength{\abovecaptionskip}{10pt}
%\setlength{\belowcaptionskip}{10pt}



%    ****************************************
%    *             FOOTNOTES                *
%    ****************************************
%
% For IIT style, footnotes are single spaced below the last line of text
% or double-spaced above the top line of the footnote if the page is not full of text.
% Footnotes are numbered within entire thesis. 
% \footnoterule is a macro to draw the rule separating the footnotes
% from the text.  It should take zero vertical space, so it needs a
% negative skip to compensate for any positive space taken by the rule.

\def\footnoterule{\kern-3\p@
 \hrule width 1.5in          % 1.5in footnote rule 
 \kern 2.6\p@}

%   \@makefntext{NOTE} :
%        Must produce the actual footnote, using \@thefnmark as the mark
%        of the footnote and NOTE as the text.  It is called when
%        effectively inside a \parbox of width \columnwidth (i.e., with
%        \hsize = \columnwidth).
%
%        The following macro indents all lines of the footnote 0.5in,     
%        and indents the first line of a new paragraph by 1em.  To
%        change these dimensions, just substitute the desired value for
%        '0.5in' [in both places] or '1em'. A footnote is single-space typed.

\setlength{\footnotesep}{20pt}      % A double-space is inserted between two footnotes.
\long\def\@makefntext#1{\parindent 1em\noindent
           \hbox to 0.5in{\hss$^{\@thefnmark}$}\ssp{#1}}  %0.5in indentation for IIT style.



%    ****************************************
%    *             BIBLIOGRAPHY             *
%    ****************************************
%
% The \thebibliography environment executes the following commands:
%
%  \def\newblock{\hskip .11em plus .33em minus .07em} --
%      Defines the `closed' format, where the blocks (major units of
%      information) of an entry run together.
%
%  \sloppy  -- Used because it's rather hard to do line breaks in
%      bibliographies,
%
%  \sfcode`\.=1000\relax --
%      Causes a `.' (period) not toproduce an end-of-sentence space.

\def\thebibliography#1{
 \addtocontents{toc}{\protect\vspace*{0pt}}
 \addcontentsline{toc}{chapter}{\protect\noindent BIBLIOGRAPHY}
 \clearpage
 \center{BIBLIOGRAPHY\@mkboth{BIBLIOGRAPHY}{BIBLIOGRAPHY}}
 \vspace{10pt}
 \list {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}
 \leftmargin\labelwidth\advance\leftmargin\labelsep
 %\addtolength{\leftmargin}{0.5in}  % puts the second line indent.
 %\setlength{\itemindent}{-0.5in}   % puts the second line indent (used with previous line).
 \usecounter{enumi}
 \setlength{\baselineskip}{12pt}
 }
 \def\newblock{\hskip .11em plus .33em minus .07em}
 \sloppy\clubpenalty4000\widowpenalty4000
 \sfcode`\.=1000\relax}
\let\endthebibliography=\endlist



%    ****************************************
%    *              EQUATION                *
%    ****************************************
%
% EQUATION and EQNARRAY 
% Equations are in each chapter.
\@addtoreset{equation}{chapter}
\def\theequation{\thechapter.\arabic{equation}}



%    ****************************************
%    *        CHAPTERS AND SECTIONS         *
%    ****************************************

% CHAPTER
% 
\newcommand{\Chapter}[1]{%
  \clearpage
  \noindent
  \refstepcounter{chapter}
  \begin{center}
    \dsp{CHAPTER\space\thechapter\\}
    \vspace{10pt}
     \ssp\uppercase{#1}
     \vspace{-5pt}
     \end{center}
  \addtocontents{toc}{\protect\vspace*{3pt}}     
  \addcontentsline{toc}{chapter}{\protect
     \makebox[0.75in][r]{\thechapter.}\hspace*{3pt} \uppercase{#1}}
  \addtocontents{toc}{\protect\vspace*{10pt}} 
}


% SECTION
%
% Section names are bold face typed using \bf.
\newcommand{\Section}[1]{%
  \refstepcounter{section}
  \noindent
   \setbox\@tempboxa\hbox{\bf\thesection\space\space{#1}}%
   \ifdim \wd\@tempboxa >\hsize         % IF it is longer than one line, use indentation
    \vskip 1pt \noindent\ssp \hangindent 0.36in 
   {\bf\thesection\space\space{#1}\par} \dsp  
     \else                              % ELSE  center.
      {\bf\thesection\space\space{#1}}   
   \fi
  \addtocontents{toc}{\protect\vspace{-10pt}}
  \addcontentsline{toc}{section}{\protect
     \makebox[0.3in][r]{\thesection.} \hspace*{3pt}#1}      
}


% SUBSECTION
% 
% Subsection names are typed italic bold, and they are not included in tha table of contents.
\newcommand{\Subsection}[1]{%
  \refstepcounter{subsection}  
  \noindent
  {{\textbf{\thesubsection\space\space{#1.}}}}
  % \addtocontents{toc}{\protect\vspace{-10pt}}   % activate to put in toc
  % \addcontentsline{toc}{subsection}{\protect    % activate to put in toc
   %    \makebox[0.3in][r]{\thesubsection.} \hspace*{3pt}#1}    % activate to put in toc
    }


% SUBSUBSECTION
% Subsubsection names are typed italic,and they are not included in the table of contents.
\newcommand{\Subsubsection}[1]{%
  \refstepcounter{subsubsection}
  \noindent
   {\textbf{\thesubsubsection\space\space{#1.}}}
 }



%    ****************************************
%    *              APPENDIX                *
%    ****************************************
% \appendix command inserts APPENDIX word into table of contents, 
% and sets the appendix counter. 
% \Appendix{title} command creates individual  Appendices, and puts 
% into table of contents.  

\def\appendix{\par
    \setcounter{chapter}{0} %\refstepcounter{chapter}
    \addcontentsline{toc}{chapter}{\vspace{20pt}\protect\noindent APPENDIX\vspace*{-20pt}}
    \renewcommand{\thechapter}{\Alph{chapter}}
}

\newcommand{\Appendix}[1]{%
  \clearpage
  \vspace*{3in}
  \noindent
  \refstepcounter{chapter}
  \begin{center}
    APPENDIX\space\thechapter \\
    \uppercase{#1} \\
  \end{center}
 \addcontentsline{toc}{chapter}{\protect
 \makebox[0.75in][r]{\thechapter.} \hspace*{3pt}\uppercase{#1}}
  \clearpage
}



%    ****************************************
%    *            PAGE STYLES               *
%    ****************************************
%
% The \ps@... command defines the macros \@oddhead, \@oddfoot,
% \@evenhead, and \@evenfoot to define the running heads and
% feet---e.g., \@oddhead is the macro to produce the contents of the
% heading box for odd-numbered pages.  It is called inside an \hbox of
% width \textwidth.
%
% To make headings determined by the sectioning commands, the page style
% defines the commands \chaptermark, \sectionmark, ... , where
% \chaptermark{TEXT} is called by \chapter to set a mark, and so on.
% The \...mark commands and the \...head macros are defined with the
% help of the following macros.  (All the \...mark commands should be
% initialized to no-ops.)
%
% MARKING CONVENTIONS:
% LaTeX extends TeX's \mark facility by producing two kinds of marks
% a 'left' and a 'right' mark, using the following commands:
%     \markboth{LEFT}{RIGHT} : Adds both marks.
%     \markright{RIGHT}      : Adds a 'right' mark.
%     \leftmark  : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'left' mark.
%                  Works like TeX's \botmark command.
%     \rightmark : Used in the \@oddhead, \@oddfoot, \@evenhead or
%                  \@evenfoot macro, gets the current 'right' mark.
%                  Works like TeX's \firstmark command.
% The marking commands work reasonably well for right marks 'numbered
% within' left marks--e.g., the left mark is changed by a \chapter
% command and the right mark is changed by a \section command.  However,
% it does produce somewhat anomalous results if two \bothmark's occur on
% the same page.
%
%
% Commands like \tableofcontents that should set the marks in some
% page styles use a \@mkboth command, which is \let by the pagestyle
% command (\ps@...)  to \markboth for setting the heading or
% \@gobbletwo to do nothing.

\mark{{}{}}   % Initializes TeX's marks

\if@twoside \def\ps@headings{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}\def\@evenhead{\rm \thepage\hfil \sl
\leftmark}\def\@oddhead{\hbox{}\sl \rightmark \hfil
\rm\thepage}\def\chaptermark##1{\markboth {\uppercase{\ifnum
\c@secnumdepth
>\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}{}}\def\sectionmark##1{\markright
{\uppercase{\ifnum \c@secnumdepth >\z@
 \thesection. \ \fi ##1}}}}
\else \def\ps@headings{\let\@mkboth\markboth
\def\@oddfoot{}\def\@evenfoot{}\def\@oddhead{\hbox {}\sl \rightmark \hfil
\rm\thepage}\def\chaptermark##1{\markright {\uppercase{\ifnum
\c@secnumdepth
>\m@ne
 \@chapapp\ \thechapter. \ \fi ##1}}}}
\fi

% Definition of 'myheadings' page style.
%
\def\ps@myheadings{\let\@mkboth\@gobbletwo
\def\@oddhead{\hbox{}\sl\rightmark \hfil
\rm\thepage}
\def\@oddfoot{}
\def\@evenhead{\rm \thepage\hfil\sl\leftmark\hbox
{}}
\def\@evenfoot{}\def\chaptermark##1{}\def\sectionmark##1{}%
\def\subsectionmark##1{}}

% Definition of 'plain' page style.
%
\def\ps@plain{\let\@mkboth\markboth
\def\@oddfoot{\hfil\rmfamily\thepage\hfil}
\def\@evenfoot{\hfil\rmfamily\thepage\hfil}    
\def\@oddhead{}         % heading (right)
\def\@evenhead{}        % heading (left)
}



%    ****************************************
%    *           INITIALIZATION             *
%    ****************************************
%
% Default initializations

\ps@plain                   % 'plain' page style
\pagenumbering{arabic}      % Arabic page numbers
\onecolumn
\if@twoside\else\raggedbottom\fi % Ragged bottom unless twoside
                                 % option.
