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
			e''4  ~
			e''16 
			aqf16 
			af'8  ~
			af'2  ~ ~
		} |
		{
			af'2 
			dqf'4. 
			e'8  ~
		} |
  		{
			e'8 
			eqf'16  ~
			eqf'4 
			cqs''4. 
			d'8.  ~
		} |
		{
			d'8 
			eqf'16 
			btqf'16  ~
			btqf'2.  ~ ~
		}
		{
			btqf'4  ~
			btqf'16 
			aqf8. ~ 
			aqf8.
			aqf16  
			b8. 
			a16  ~
		} |
		{
			a4 
			e''4 ~ e''8 
			bqf'8  ~
			bqf'8. 
			a16 
		} |
		{
			e''1  ~
		}
		{
			e''8 
			eqf'4. 
			dqf'4 
			ef'4  
		}
		{
			ef'16 
			d''8. ~
			d''8. 
			cqs''16  ~
			cqs''4 
			ef'16 
			d'8.  ~
		} |
		{
			d'2..  ~
			d'16 
			a16 
		}
	}
	>>
}
