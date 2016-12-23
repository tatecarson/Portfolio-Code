% 2016-07-20 00:16

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
			fqs'4 
			a'8. 
			aqf'16  ~
			aqf'2  ~ ~
		}
		{
			aqf'2  ~
			aqf'8. 
			f''8. 
			atqf''8  ~
		} |
		{
			atqf''2  ~
			atqf''8 
			a'4.  ~
		}
		{
			a'4 
			a'8 
			e''8 ~ e''8 
			a'8. 
			cqs'8.  ~
		}
		{
			cqs'1  ~
		}
		{
			cqs'16 
			g''8. 
			a'2. 
		}
		{
			fqs'2  ~
			fqs'8 
			a'8 
			d''4 
		}
		{
			fqs'8. 
			aqf''16  ~
			aqf''2.  
		}
		{
			a'4. 
			e''8  ~
			e''2 
		}
	}
	>>
}
