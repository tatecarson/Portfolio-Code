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
			cs''16 
			aqf16 
			af''8 ~ af''8 
			dqf''8
			r4
			aqf4  ~
		} |
		{
			aqf1  ~
		}
		{
			aqf1  ~
		}
		{
			aqf1  ~
		}
		{
			aqf16 
			aqf8. ~
			aqf8 
			dqf''16 
			cs''16 ~
			cs''16 
			aqf8. ~ aqf16 
			e'8. 
		} | 
		{
			cs''1  ~
		}
		{
			cs''1  ~
		}
		{
			cs''1  ~
		}
		{
			cs''2 
			cs''4  ~
			cs''16 
			e'16 
			dqf''16 
			cs''16 
		}
		{
			cs''4 
			fqf''8. 
			cs''16  ~
			cs''2 
		}
	}
	>>
}
