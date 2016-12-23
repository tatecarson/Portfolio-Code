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
			e''8 
			eqf'16 
			btqf'16 ~ btqf'4 btqf'16 
			fqf'8. ~ fqf'8.
			a16  ~
		} |
		{
			a8. 
			r16
			r4
			dqf'8 
			bqf'8 
			ef'16 
			d'8.  ~
		} |
		{
			d'8 
			btqf'4. 
			fqf'8
			r4.
		} |
		{
			e''8
			eqf'8 
			r8 
			cqs''4.
			af'16  
			d'8.  ~
		} |
		{
			d'8. 
			r16
			btqf'4 
			r4
			ef'8 
			e'8 
		} |
		{
			d''4. 
			cs''4. 
			e''16 
			d'8.  ~
		} |
 		{
			d'16 
			r16
			r4
			af'8 
			dqf'8 
			bqf'16 
			b16  ~
			b4  
		} |
		{ 
			d''4. 
			cs''8 ~ cs''8
			b8
			r4
		} |
		{
			e''8 
			eqf'8 
			e''16 
			aqf8.  
			aqf8. 
			b16  ~
			b4  ~ ~
		} |
		{
			b16 
			d''8.
			r4
			bqf'8 
			ef'8 
			e'16 
			a16 
			r8
		} |
	}
	>>
}
