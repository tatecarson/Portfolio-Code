% 2016-07-20 00:10

\version "2.18.2"
\language "english"

#(set-default-paper-size "a4" 'landscape)
#(set-global-staff-size 16)

\header {
tagline = ##f
}

\layout {
	\context {
		\Score
}
}

\paper {
	left-margin = 20
	right-margin = 20
	score-system-spacing = #'( (basic-distance . 10) (minimum-distance . 10) (padding . 10) (stretchability . 0) )
	system-system-spacing = #'( (basic-distance . 0) (minimum-distance . 0) (padding . 10) (stretchability . 0) )
	top-margin = 20
	bottom-margin = 20
	indent = 0
}

\score {
	<<
	\set Score.tupletFullLength = ##t
	\override Score.TupletNumber.text = #tuplet-number::calc-fraction-text
	\override Score.TimeSignature.style = #'numbered
	\override Score.TupletBracket.full-length-to-extent = ##t
	\new Staff {
		\time 4/4
		{
			fs'1 
		}
		{
			r8
			dqf'''4   
			r8
			r2
		} |
		{
		        r2
			r4
			r8
			fqs''8  ~
		} |
		{
			fqs''8 
			dqf'''2..  ~
		}
		{
			dqf'''8 
			r8
			cqs''4 
			r2
		} |
		{
			r1
		}
		{
			fs'4 
			cqs''2.  ~
		}
		{
			cqs''4 
			r8
			bf'8 ~ bf'8 
			r4.
		}
		{
			r1
		}
		{
			r8
			dqf'''4 
			bf'8  ~
			bf'2 
		}
	}
	>>
}
