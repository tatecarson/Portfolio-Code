% 2016-07-19 23:41

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
			etqf'''4.
			r8
			fqf'8
			fqf'4
			fqf'8
		} |
		{
			fqf'4 
			r8.
			fqf'16  ~
			fqf'2  ~ ~
		}
		{
			fqf'1  ~
		}
		{
			fqf'1  ~
		}
		{
			fqf'1  
		}
		{
			r4
			etqf'''4. 
			fqf'4.  ~
		}
		{
			fqf'16 
			etqf'''8. 
			etqf'''2  ~
			etqf'''8 
			r8
		}
		{
			r16
			etqf'''16  ~
			etqf'''2..  ~ ~
		}
		{
			etqf'''1  ~
		}
		{
			etqf'''1 
		}
	}
	>>
}
