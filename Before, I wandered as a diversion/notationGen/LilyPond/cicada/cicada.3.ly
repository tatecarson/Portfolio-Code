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
			cqf'''4  ~
			cqf'''16 
			r16
			r8
			r2
		} |
		{
			cqf'''4. 
			ef'''8  ~
			ef'''2  ~ ~
		} |
		{
			ef'''8 
			  
			bqf''8 
			cqs'''8 
			cqs'''16  
			bqf''16
			cqs'''4
			r4
		} |
		{
			r2
			cqs'''8
			cqs'''8
			r8
			r16
			d'16  ~
		} |
		{
			d'2 ~
			d'8.  
			c'''16  ~
			c'''4 
		}
		{
			cqf'''8
			r16
			bqf''16  
			bqf''8
			bqf''8
			r2
		} |
		{
			r8
			bqf''4. 
			cqf'''2  ~
		} |
		{
			cqf'''4 
			cqf'''4  ~
			cqf'''16 
			cqs'''8 
			c'''16  ~
			c'''4 
		} |
		{
			r2
			r4
			c'''4  
		} |
		{ 
			cqs'''2. 
			c'''16
			cqf'''8. 
		} |
	}
	>>
}
