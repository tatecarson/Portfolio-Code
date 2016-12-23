% 2016-07-19 23:43

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
			ef'8. 
			af'16 
			cs''2.  ~
		}
		{
			cs''1 
		}
		{
			ef'4. 
			r8
			r2 ~
		}
		{
			r2
			r8
			bf'8 bf'8.
			cqf'16  ~
		} |
		{
			cqf'16 
			gqf'8. 
			cs''16 
			eqf'8.  ~
			eqf'2  ~ ~
		}
		{
			eqf'1  
		}
		{
			b''1 
		}
	}
	>>
}
