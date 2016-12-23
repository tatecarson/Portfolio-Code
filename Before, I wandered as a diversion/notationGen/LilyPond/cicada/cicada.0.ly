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
			dqf'''8-. 
			d'''2..  ~
		} |
		{
			d'''4. 
			cs'''8 
			r2
		} |
		{
			r1
		}
		{
			r8
			d'''8 
			cqf'''8-.
			cs'''8  ~
			cs'''2  ~ ~
		} |
		{
			cs'''2  ~
			cs'''8 
			d'''8-.
			r4
		} |
		{
			r1
		}
		{
			r4
			r8
			cs'''8 
			d'''8-. 
			d'''4.  ~
		}
		{
			d'''2.. 
			d'''8  ~
		}
		{
			d'''8
			r8
			r2. 
		} |
		{
			r2
			r8
			d'''8 
			d'''8 
			d'''8 
		}
	}
	>>
}
