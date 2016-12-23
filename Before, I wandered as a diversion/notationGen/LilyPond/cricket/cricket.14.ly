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
			etqf'16 
			r16
			bqf'2..  ~
		}
		{
			bqf'1 
		}
		{
			etqf'8. 
			af'16  ~
			af'2.  ~ ~
		}
		{
			af'4.. 
			fqf''16  ~
			fqf''2  ~ ~
		}
		{
			fqf''4. 
			b''8 
			cqf'8-. 
			bf'4.  ~
		}
		{
			bf'1  ~
		}
		{
			bf'2 
			cqf'8. 
			gqf''16  ~
			gqf''4  ~ ~
		}
		{
			gqf''2..  ~
			gqf''16 
			cqf'16  ~
		}
		{
			cqf'2.. 
			dqf'8 
		}
		{
			etqf'8-.
			bqf'2.. 
		} |
	}
	>>
}
