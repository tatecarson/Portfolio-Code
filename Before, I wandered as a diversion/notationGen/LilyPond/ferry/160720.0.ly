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
			d'''8 
			af''8 
			bqf'2.  ~
		}
		{
			bqf'2 
			etqf'4. 
			cqf'8  ~
		}
		{
			cqf'1  ~
		}
		{
			cqf'4
			r4
			r8
			r16
			etqf'16 ~ etqf'16 
			g''8 
			btqf'16  ~
		} |
		{
			btqf'16 
			cqs'16  ~
			cqs'2..  ~ ~
		}
		{
			cqs'4  ~
			cqs'16 
			aqf''8. ~ 
			aqf''8. 
			etqf'16  ~
			etqf'4  ~ ~
		} |
		{
			etqf'1  ~
		}
		{
			etqf'8. 
			r16
			r4
			etqf'8 
			bqf'8 
			fqs'8 
			cqf'8  ~
		}
		{
			cqf'1  ~
		}
		{
			cqf'8 
			af''4. 
			etqf'2 
		}
	}
	>>
}
