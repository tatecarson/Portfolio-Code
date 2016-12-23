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
			atqf'2 
			f''4 
			atqf''4  ~
		}
		{
			atqf''1 
		}
		{
			atqf'4. 
			c''8 ~
			c''4. 
			bqf''8  ~
		}
		{
			bqf''1  ~
		}
		{
			bqf''8  
			d''4. ~ d''8
			d''4 
			bqf''8  ~
		} |
		{
			bqf''4. 
			c' 8 ~ 
			c' 8
			af4.  ~
		}
		{
			af2.. 
			bqf''8  ~
		}
		{
			bqf''4 
			bf''2 
			atqf''4  ~
		}
		{
			atqf''1 
		}
		{
			atqf'2. 
			atqf''4 
		}
	}
	>>
}
