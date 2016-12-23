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
			etqf'''4. 
			r16
			a''16  ~
			a''2  ~ ~
		} |
		{
			a''8 
			r4
			etqf'''8  ~
			etqf'''2  ~ ~
		} |
		{
			etqf'''8 
			bqf''8  ~
			bqf''2 
			c'''8 
			g''8  ~
		}
		{
			g''4 
			r16
			g''8.  ~
			g''2  
		} |
		{
			 
			r4
			dqf'2. 
		} |
		{
			etqf'''2  ~
			etqf'''8 
			d'''8 
			c'''4  ~
		}
		{
			c'''8 
			etqf'''2. 
			r8
		}
		{
			r8
			bqf''2. 
			g''8  ~
		}
		{
			g''2 
			ef'8 
			d'''4. 
		}
		{
			cs'''2. 
			r4
			
		} |
	}
	>>
}
