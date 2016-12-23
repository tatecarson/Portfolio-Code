% 2016-07-19 23:41

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
			c'''4.. 
			c'''16 
			bqf''4 
			c'''4  ~
		} |
		{
			c'''4 ~
			c'''16   
			r16
			r8
			r2
		} |
		{
			r2
			r16
			dqf'''8. ~
			dqf'''4 ~
		} |
		{
			dqf'''8. 
			cs'''16 
			etqf'''4.. 
			cqf'''16 
			c'''4 
		} |
		{
			c'''2 
			r2
		} |
		{
			r2.
			r16
			ef'''8.  ~
		} |
		{
			ef'''4.. 
			c'''16 
			bqf''4.. 
			cqs'''16 
		} |
		{
			c'''4 
			etqf'''2 
			r4
		}
		{
			r1
		}
		{
			cqf'''2  ~
			cqf'''8 
			c'''8
			c'''8
			r8
		}
	}
	>>
}
