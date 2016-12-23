% 2016-07-20 00:22

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
			aqf''2. 
			aqf''8 
			fqf'8  ~
		}
		{
			fqf'1  ~
		}
		{
			fqf'4. 
			aqf''4. 
			r4
		}
		{
			r1
		}
		{
			r1
		}
		{
			r1
		}
		{
			r4
			aqf''2.  ~
		}
		{
			aqf''2 
			aqf''8 
			aqf''4.  ~
		}
		{
			aqf''4. 
			aqf''8 
			aqf''2  ~
		}
		{
			aqf''1 
		}
	}
	>>
}
