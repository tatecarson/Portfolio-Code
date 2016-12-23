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
			e''4.. 
			cs''16 
			r4.
			fqf'8  ~
		}
		{
			fqf'4.. 
			cs''16  ~
			cs''2  
		}
		{
			cqs''8. 
			btqf'16  ~
			btqf'4 
			dqf'4. 
			fqf'8  ~
		}
		{
			fqf'4  ~
			fqf'16 
			aqf16 
			r8 r4
			ef'4  
		} |
		{
			ef'4  ~
			ef'16 
			aqf8.  ~
			aqf2  ~ ~
		} |
		{
			aqf16 
			dqf''8. ~ 
			dqf''8 
			af'8 ~ af'4 
			ef'4  ~
		} |
		{
			ef'8. 
			btqf'16 
			r4 r8
			bqf'4.  ~
		}
		{
			bqf'8. 
			btqf'16 ~ 
			btqf'2 ~ 
			btqf'8.
			a16  ~
		} |
		{
			a4 
			fqf''4. 
			bqf'4.  ~
		}
		{
			bqf'16 
			dqf''16 
			r8 r4
			dqf'2 
		}
	}
	>>
}
