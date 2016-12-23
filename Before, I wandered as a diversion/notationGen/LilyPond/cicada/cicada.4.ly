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
			cs'''16 
			dqf'''16
			r16
			bqf''16  ~
			bqf''16  
			bqf''8
			bqf''4
			r8
			bqf''8.  ~
		} |
		{
			bqf''1  ~
		}
		{
			bqf''2  ~
			bqf''16 
			r16
			r4
			b''16 
			cs'''16 
		} |
		{
			cs'''16 
			r8
			c'''16  ~
			c'''2 
			cs'''4  ~
		}
		{
			cs'''1  ~
		}
		{
			cs'''2 
			r4
			r16
			bqf''16 
			b''16 
			cs'''16 
		}
		{
			r8
			bqf''4. ~
			bqf''8
			bqf''16 
			dqf'''16  ~
			dqf'''4  ~ ~
		} |
		{
			dqf'''1  ~
		}
		{
			dqf'''4. 
			r8
			r4
			cs'''16 
			bqf''16 
			b''16 
			r16
		} |
		{
			r16
			dqf'''8.  ~
			dqf'''8
			dqf'''8
			dqf'''8
			cqs'''4. 
		} |
	}
	>>
}
