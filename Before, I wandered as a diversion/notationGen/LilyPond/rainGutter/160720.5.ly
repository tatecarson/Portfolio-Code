% 2016-07-20 00:19

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
			aqf''4 
			b''8.  
			af''16 ~
			af''4  ~
			af''16 
			c'''8.  ~
		} |
		{
			c'''8. 
			r2.
			aqf''16  ~
		}
		{
			aqf''4 
			b''16 
			af''8. ~ 
			af''16 
			dqf'''8. 
			c'''4  ~
		}
		{
			c'''8 
			a''4. 
			r2
		}
		{
			r4
			b''4  ~
			b''16 
			dqf'''16 
			cqs'''8 ~ 
			cqs'''8  
			cqf'''8  ~
		} |
		{
			cqf'''16 
			aqf''8. ~  
			aqf''16 
			aqf''8.   
			af''16 
			af''8. 
			r4 
		} |
		{
			r2
			r16
			dqf'''8. ~
			dqf'''8  
			cqf'''16 
			aqf''16  ~
		} |
		{
			aqf''8. 
			aqf''8. 
			dqf'''8 ~
			dqf'''4  
			c'''4  ~
		} |
		{
			c'''8 
			r2.
			cqf'''8  ~
		}
		{
			cqf'''8. 
			aqf''16 
			b''4 
			bqf''8. 
			cqs'''16  ~
			cqs'''4 
		}
	}
	>>
}
