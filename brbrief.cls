\NeedsTeXFormat{LaTeX2e}

% Calls name and version
\newcommand{\classname}{brbrief}
\newcommand{\version}{0.1}

\ProvidesClass{\classname}[Briefvorlage by Bertram Richter]

% Ignored options
\DeclareOption{twocolumn}{\OptionNotUsed\ClassWarning{brbrief}{Option "twocolumn" is not supported, will be ignored.}{}}
\DeclareOption{landscape}{\OptionNotUsed\ClassWarning{brbrief}{Option "landscape" is not supported, , will be ignored.}{}}

% Option to show foldmarks, default is true
\newif\if@foldmark
\DeclareOption{foldmark}{\@foldmarktrue}	
\DeclareOption{nofoldmark}{\@foldmarkfalse}	

% Option to show punchmark, default is true
\newif\if@punchmark
\DeclareOption{punchmark}{\@punchmarktrue}		
\DeclareOption{nopunchmark}{\@punchmarkfalse}	

% Default options
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ExecuteOptions{punchmark,foldmark}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage[utf8]{inputenc}
\RequirePackage[OT1]{fontenc}		% character encoding, using open type (enables open type ligatures)
\RequirePackage{CormorantGaramond}	% Nice font
\RequirePackage{pifont}				% Used for symbols
\RequirePackage{pdfpages}			% Include von PDFs nach dem Brief, siehe \includepdf unten
\RequirePackage{microtype}			% for even nicer typography, load after the class file
\RequirePackage[%					% als letztes Paket
	hidelinks, 						% show no red box around links
	breaklinks=true,				% enables hyphernation in links
	pdfusetitle,					% sets metadata in the outputted pdf file
	]{hyperref}						% use hyperref to enable "\autoref" with hyperlinks instead of "\ref"

%%% Dimensionen %%%
\newlength{\toprand}
\newlength{\botrand}
\newlength{\leftrand}
\newlength{\rightrand}
\setlength{\toprand}{20mm}
\setlength{\botrand}{20mm}
\setlength{\leftrand}{25mm}
\setlength{\rightrand}{20mm}
\newlength{\anschriftpos}
\setlength{\anschriftpos}{45mm}
\addtolength{\anschriftpos}{-\toprand}
% Vertical
\setlength{\paperheight}{297mm}
\setlength{\paperwidth}{210mm}
\setlength{\voffset}{0pt}
\setlength{\topmargin}{\toprand}
\addtolength{\topmargin}{-1in}
\setlength{\headheight}{0mm}
\setlength{\headsep}{0mm}
\setlength{\topskip}{0mm}
\setlength{\footskip}{2\baselineskip}
% Horizontal
\setlength{\hoffset}{0pt}
\setlength{\oddsidemargin}{\leftrand}
\setlength{\evensidemargin}{\rightrand}
\addtolength{\oddsidemargin}{-1in}
\addtolength{\evensidemargin}{-1in}
% Text block
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-\leftrand}
\addtolength{\textwidth}{-\rightrand}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\toprand}
\addtolength{\textheight}{-\botrand}
\addtolength{\textheight}{-\footskip}
% Paragraph length
\setlength{\parindent}{0pt}%
\setlength{\parskip}{1\baselineskip plus 0.2ex minus 0.2ex}%

%%% Page style %%%
% Faltmarken
\newcommand{\@faltmarken}{{%
		\def\unitlength{}%
		\begin{picture}(0mm,0mm)(0mm,-\toprand)%
		\put(-\leftrand,-105mm){\line(1,0){4mm}}%
		\put(-\leftrand,-210mm){\line(1,0){4mm}}%
		\end{picture}%
}}%
% Lochmarke
\newcommand{\@lochmarke}{{%
		\def\unitlength{}%
		\begin{picture}(0mm,0mm)(0mm,-\toprand)%
		\put(-\leftrand,-.5\paperheight){\line(1,0){4mm}}%
		\end{picture}%
}}%

% Custom page style
\newcommand{\ps@brief}{%
	\renewcommand{\@oddhead}{\if@foldmark\@faltmarken\fi\if@punchmark\@lochmarke\fi}
	\renewcommand{\@evenhead}{\@empty}
	\renewcommand*{\@oddfoot}{\hfill{}Seite\:\thepage{}}%
	\renewcommand*{\@evenfoot}{Seite\:\thepage\hfill{}}%
}
\newcommand{\ps@briefersteseite}{%
	\renewcommand{\@oddhead}{\if@foldmark\@faltmarken\fi\if@punchmark\@lochmarke\fi}
	\renewcommand{\@evenhead}{\@empty}
	\renewcommand*{\@oddfoot}{\@empty}%
	\renewcommand*{\@evenfoot}{\@empty}%
}

%%% Internal Commands %%%
\newcommand{\test}{\textcolor{red}{\textbf{Test}}}

%%% Symbols %%%
\newcommand{\phonesymbol}{\ding{37}}
\newcommand{\mobilesymbol}{\ding{38}}
\newcommand{\mailsymbol}{\ding{41}}


% Removes all whitespaces
\def\foreverunspace{%
	\ifnum\lastnodetype=11
		\unskip\foreverunspace
	\else
		\ifnum\lastnodetype=12
			\unkern\foreverunspace
		\else
			\ifnum\lastnodetype=13
				\unpenalty\foreverunspace
			\fi
		\fi
	\fi
}

% Usage: \PrintIfDefined{a}{b}{c}: If a is defined and contains non-whitespace elements, b is printed. Else c is printed.
\newcommand{\PrintIfDefined}[3]{%
	\setbox0=\hbox{\foreverunspace#1\foreverunspace}\ifdim\wd0=0pt#3\else{#2}\fi%
}%
% Usage \PrintOptionalField{a}: If a is defined and contains non-whitespace elements,it is printed and a new paragraph is started.
\newcommand{\PrintOptionalField}[1]{%
	\PrintIfDefined{#1}{#1\par}{}%
}%

%%% Variablen %%%
% Adressfeld
\newcommand*{\@ZVZiii}{}										% Speichervariable für elektronische Freimachungsvermerke.
\newcommand*{\ZViii}[1]{\renewcommand*{\@ZVZiii}{#1}}			% Legt elektronische Freimachungsvermerke fest.
\newcommand*{\@ZVZii}{}											% Speichervariable für Vorausfügung z.B. "Nicht Nachsenden".
\newcommand*{\ZVii}[1]{\renewcommand*{\@ZVZii}{#1}}				% Legt Vorausfügung fest.
\newcommand*{\@ZVZi}{}											% Speichervariable für z.B. Einschreiben.
\newcommand*{\ZVi}[1]{\renewcommand*{\@ZVZi}{#1}}				% Legt z.B. Einschreiben fest.
\newcommand*{\@AZFirma}{}										% Speichervariable für Firma des Adressaten.
\newcommand*{\AZFirma}[1]{\renewcommand*{\@AZFirma}{#1}}		% Legt Firma des Adressaten fest.
\newcommand*{\@AZAnrede}{}										% Speichevariable für z.B. Berufs- oder Amtsbezeichnungen des Adressaten
\newcommand*{\AZAnrede}[1]{\renewcommand*{\@AZAnrede}{#1}}		% Legt Anrede des Adressaten fest.
\newcommand*{\@AZName}{}										% Speichervariable für akademische Grade und Namen des Adressaten.
\newcommand*{\AZName}[1]{\renewcommand*{\@AZName}{#1}}			% Legt akademische Grade und Namen des Adressaten fest.
\newcommand*{\@AZStrasse}{}										% Speichervariable für Straße und Hausnummer des Adressaten.
\newcommand*{\AZStrasse}[1]{\renewcommand*{\@AZStrasse}{#1}}	% Legt Straße und Hausnummer des Adressaten fest.
\newcommand*{\@AZPLZOrt}{}										% Speichervariable für Postleitzahl und Ort des Adressaten.
\newcommand*{\AZPLZOrt}[1]{\renewcommand*{\@AZPLZOrt}{#1}}		% Legt Postleitzahl und Ort des Adressaten fest.
\newcommand*{\@AZLand}{}										% Speichervariable für das Land des Adressaten.
\newcommand*{\AZLand}[1]{\renewcommand*{\@AZLand}{#1}}			% Legt das Land des Adressaten fest.
% Absender
\newcommand*{\@ABSName}{}										% Speichervariable für den Namen des Schreibenden.
\newcommand*{\ABSName}[1]{\renewcommand*{\@ABSName}{#1}}		% Legt den den Namen des Schreibenden fest.
\newcommand*{\@ABSStrasse}{}									% Speichervariable für Straße und Hausnummer des Schreibenden.
\newcommand*{\ABSStrasse}[1]{\renewcommand*{\@ABSStrasse}{#1}}	% Legt Straße und Hausnummer des Schreibenden fest.
\newcommand*{\@ABSPLZ}{}										% Speichervariable für die Postleitzahldes Schreibenden.
\newcommand*{\ABSPLZ}[1]{\renewcommand*{\@ABSPLZ}{#1}}			% Legt die Postleitzahl des Schreibenden fest.
\newcommand*{\@ABSOrt}{}										% Speichervariable für den Stadtnamen des Schreibenden.
\newcommand*{\ABSOrt}[1]{\renewcommand*{\@ABSOrt}{#1}}			% Legt den Stadtnamen des Schreibenden fest.
\newcommand*{\@ABSPhone}{}										% Speichervariable für die Festnetznummer des Schreibenden.
\newcommand*{\ABSPhone}[1]{\renewcommand*{\@ABSPhone}{#1}}		% Legt die Festnetznummer des Schreibenden fest.
\newcommand*{\@ABSMobile}{}										% Speichervariable für die Handynummer des Schreibenden.
\newcommand*{\ABSMobile}[1]{\renewcommand*{\@ABSMobile}{#1}}	% Legt die Handynummer des Schreibenden fest.
\newcommand*{\@ABSMail}{}										% Speichervariable für die E-Mail-Adresse des Schreibenden.
\newcommand*{\ABSMail}[1]{\renewcommand*{\@ABSMail}{#1}}		% Legt die E-Mail-Adresse des Schreibenden fest.
\newcommand*{\@ABSInfo}{}										% Speichervariable für die E-Mail-Adresse des Schreibenden.
\newcommand*{\ABSInfo}[1]{\renewcommand*{\@ABSInfo}{#1}}		% Legt die E-Mail-Adresse des Schreibenden fest.
% Bezugszeichenzeile
\newcommand*{\@IhrSchreiben}{}										% Speichervariable
\newcommand*{\IhrSchreiben}[1]{\renewcommand*{\@IhrSchreiben}{#1}}	% Setzt den Wert, welcher unter "Ihr Schreiben vom" kommt
\newcommand*{\@IhrZeichen}{}										% Speichervariable
\newcommand*{\IhrZeichen}[1]{\renewcommand*{\@IhrZeichen}{#1}}		% Setzt den Wert, welcher unter "Ihr Zeichen" kommt
\newcommand*{\@KundenNummer}{}										% Speichervariable
\newcommand*{\KundenNummer}[1]{\renewcommand*{\@KundenNummer}{#1}}	% Setzt den Wert, welcher unter "Kundennummer" kommt
%Brief
\newcommand*{\@Betreff}{}											% Speichervariable für den Betreff.
\newcommand*{\Betreff}[1]{\renewcommand*{\@Betreff}{#1}}			% Legt den Betreff des Briefs fest.
\newcommand*{\@Briefkopf}{}											% Speichervariable für den Briefkopf.
\newcommand*{\Briefkopf}[1]{\renewcommand*{\@Briefkopf}{#1}}		% Legt den Inhalt, des Briefkopfs fest.
\newcommand*{\@Briefpapier}{}										% Speichervariable für den Pfad zum Briefpapier.
\newcommand*{\Briefpapier}[1]{\renewcommand*{\@Briefpapier}{#1}}	%  Legt den Pfad der Briefpapier fest.
\newcommand*{\@Signature}{}											% Speichervariable für den Pfad zur Unterschriftsdatei.
\newcommand*{\Signature}[1]{\renewcommand*{\@Signature}{#1}}		% Legt den Pfad der Unterschriftsdatei fest.

%%% Brieffelder %%%
% Kopfbereich
\newcommand{\kopfbereich}{%
	\begin{minipage}[t][\anschriftpos][t]{\textwidth} % [minipage outside alignment][height][aling in minipage]{width}
	\mbox{}\@Briefkopf
	\end{minipage}
}

% Set an image or the first page of a pdf as background.
\newcommand{\PrintBriefPapier}{%
	\def\@brempty{}% temporary empty string
	\ifx\@Briefpapier\@brempty% check if empty
	% do nothing, -> no background
	\else%
	% Print background to every page
	\IfFileExists{\@Briefpapier}{%
		\AddToHook{shipout/background}{\put (0in,-\paperheight){\includegraphics[width=\paperwidth,height=\paperheight]{\@Briefpapier}}}%
	}%
	{\ClassError{\classname}{File "\@Briefpapier" was not found. Did you specify the correct path and filename in \string\Briefpapier{}?}{}}%
	\fi%
}

% Adressfeld
\newcommand{\anschriftzone}{%
	\begin{minipage}[b][45mm][c]{80mm}% [minipage outside alignment][height][aling in minipage]{width}
		\setlength{\parindent}{0pt}%
		\setlength{\parskip}{0pt}%
		\begin{scriptsize}%
			\PrintIfDefined{\@ABSName{}}{\@ABSName{}, }{}%
			\PrintIfDefined{\@ABSStrasse{}}{\@ABSStrasse{}, }{}%
			\PrintIfDefined{\@ABSPLZ\@ABSOrt{}}{\@ABSPLZ{}~\@ABSOrt{}}{}%
		\end{scriptsize}% 5mm hoch
		\\[-.8em]\rule{80mm}{0.5pt}\\%
		\PrintOptionalField{\@ZVZiii{}}%	zusammen 12,7 mm hoch
		\PrintOptionalField{\@ZVZii{}}%		zusammen 12,7 mm hoch
		\PrintOptionalField{\@ZVZi{}}%		zusammen 12,7 mm hoch
		\PrintOptionalField{\@AZFirma{}}%	zusammen 27,3 mm hoch
		\PrintOptionalField{\@AZAnrede{}}%	zusammen 27,3 mm hoch
		\PrintOptionalField{\@AZName{}}%	zusammen 27,3 mm hoch
		\PrintOptionalField{\@AZStrasse{}}%	zusammen 27,3 mm hoch
		\PrintOptionalField{\@AZPLZOrt{}}%	zusammen 27,3 mm hoch
		\PrintOptionalField{\@AZLand{}}%	zusammen 27,3 mm hoch
\end{minipage}
}
% Feld für Absenderinfos
\newcommand{\absenderzone}{%
	\begin{minipage}[b][45mm][b]{75mm}%	% [minipage outside alignment][height][aling in minipage]{width}
		\setlength{\parindent}{0pt}%
		\setlength{\parskip}{0pt}%
		\begin{flushright}%
			\PrintOptionalField{\@ABSName{}}%
			\PrintOptionalField{\@ABSStrasse{}}%
			\PrintIfDefined{\@ABSPLZ{}\@ABSOrt{}}{\@ABSPLZ{}~\@ABSOrt{}\par}{}
			%\PrintOptionalField{\@ABSPLZ{}~\@ABSOrt{}}%
			\PrintIfDefined{\@ABSPhone{}}{\phonesymbol{} \@ABSPhone{}\par}{}%
			\PrintIfDefined{\@ABSMobile{}}{\mobilesymbol{} \@ABSMobile{}\par}{}%
			\PrintIfDefined{\@ABSMail{}}{\mailsymbol{} \href{mailto:\@ABSMail}{\@ABSMail}\par}{}%
			\PrintOptionalField{\@ABSInfo{}}%
		\end{flushright}
	\end{minipage}
}
% Bezugszeichenzeile
\newcommand{\bezugszeichenzeile}{%
	\begin{minipage}[t][8.46mm][b]{\textwidth} % [minipage outside alignment][height][aling in minipage]{width}
		\PrintIfDefined{\@IhrZeichen\@IhrSchreiben\@KundenNummer}{%		% If none of those is set, print only date
			\PrintIfDefined{\@IhrZeichen}{%
				\begin{minipage}{.25\textwidth}Ihr Zeichen\newline\@IhrZeichen\end{minipage}\hfill%
			}{}%
			\PrintIfDefined{\@IhrSchreiben}{%
				\begin{minipage}{.25\textwidth}Ihr Schreiben vom\newline\@IhrSchreiben\end{minipage}\hfill%
			}{}%
			\PrintIfDefined{\@KundenNummer}{%
				\begin{minipage}{.25\textwidth}Kundennummer\newline\@KundenNummer\end{minipage}\hfill%
			}{}%
			\begin{minipage}{.25\textwidth}\flushright Datum\\ \@date\end{minipage}\hfill%
		}{%
		{\hfill\@date}%
		}%
	\end{minipage}
}

%%% Typesetting commands %%%
% Anrede
\newcommand{\Anrede}[1]{%
	{\flushleft#1,\par}%
}
% Signatur
\newcommand{\signatur}[1][3.5cm]{%
	{% Make prevent page braking in-between
		\def\@brempty{}% temporary empty string
		\ifx\@Signature\@brempty% check if empty
			\par
		\else%
			\IfFileExists{\@Signature}{%
				\begin{minipage}{#1}%
					\centering%
					\includegraphics[width=#1]{\@Signature}%
				\end{minipage}\\[-8pt]%
				}%
				{\ClassError{\classname}{File "\@Signature" was not found. Did you specify the correct path and filename in \string\Singature{}?}{}%
			}%
		\fi
		\rule{#1}{0.5pt}\\
		\@ABSName
	}%
}
% Grußformel
\newcommand{\Gruss}[2][3.5cm]{
	\par
	#2\newline
	\signatur[#1]{}
}

%%% Erste Seite %%%
\renewcommand{\maketitle}{%
	\pagestyle{brief}%
	\thispagestyle{briefersteseite}%
	\kopfbereich{}%
	\begin{minipage}[t]{\textwidth}\anschriftzone\hfill\absenderzone\end{minipage}\\%
	\bezugszeichenzeile{}%
	{\flushleft\textbf{\@Betreff}\setlength{\parskip}{2\baselineskip}\par}%	Betreffzeile
	% Set PDF metadata
	\hypersetup{%
		pdfsubject = {\@Betreff},%
		pdfauthor = {\@ABSName}%
	}%
	% Add Briefpapier to the background
	\PrintBriefPapier{}%
}
