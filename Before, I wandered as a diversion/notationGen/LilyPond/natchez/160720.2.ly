% 2016-07-20 00:18

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
			c'''2 
			b'8 
			r4.
		}
		{
			r1
		}
		{
			r4.
			cs''4. 
			eqf''4  ~
		}
		{
			eqf''1  ~
		}
		{
			eqf''4 
			r2
			r8
			aqf8  ~
		}
		{
			aqf2  ~
			aqf8 
			e'4.  ~
		}
		{
			e'8 
			dqf'''8 
			r2.
		}
		{
			r1
		}
		{
			c'''4. 
			cs''8  ~
			cs''2  ~ ~
		}
		{
			cs''2. 
			r4
		}
	}
	>>
}
