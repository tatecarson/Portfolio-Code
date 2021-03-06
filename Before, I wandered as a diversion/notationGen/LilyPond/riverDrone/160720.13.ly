% 2016-07-20 00:23

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
			f4 
			af16 
			f''8 
			r16 
			r4.
			af8  ~
		} |
		{
			af8. 
			aqf'16 ~ 
			aqf'4  
			aqf'4 
			cqs'16 
			af8. 
		} |
		{
			r4
			r8.
			af16  ~
			af4 
			aqf'4  ~
		}
		{
			aqf'8 
			f''8 ~ f''8 
			aqf'16 
			af16 ~ af16 
			r8.
			r4
		}
		{
			f4  ~
			f16  
			f''8. f''4 
			f''4 
		} |
		
	}
	>>
}
