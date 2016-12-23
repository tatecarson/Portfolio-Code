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
			bf''4. 
			cqs'''8 
			c'4. 
			fqf''8  ~
		}
		{
			fqf''4.. 
			fs'16  ~
			fs'2  ~ ~
		}
		{
			fs'2..  ~
			fs'16 
			cs'''16  ~
		}
		{
			cs'''4 
			bf8 
			cqs'''8 ~ 
			cqs'''4
			a''8 
			fqf''8  ~
		} |
		{
			fqf''4 
			bf2  ~
			bf16 
			aqf'8.  ~
		}
		{
			aqf'1  ~
		}
		{
			aqf'4  ~
			aqf'16 
			btqf8. ~
			btqf8   
			e''8 
			a''4  ~
		} |
		{
			a''8 
			r8 
			bf4. 
			e''4.  ~
		}
		{
			e''8. 
			d'''16  ~
			d'''2.  ~ ~
		}
		{
			d'''2  ~
			d'''8. 
			cqf'16  ~
			cqf'4 
		}
	}
	>>
}
