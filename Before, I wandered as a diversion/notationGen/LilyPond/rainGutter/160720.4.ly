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
			a''8 
			bqf''8 
			bqf''8 
			bf''8 ~ bf''16 
			af''8. ~
			af''16  
			a''8.  ~
		} |
		{
			a''2. 
			bqf''16 
			a''8 
			b''16  ~
		}
		{
			b''16 
			bf''8 
			c'''16 ~ c'''8 
			bf''8 ~ bf''8 
			aqf''4.  ~
		}
		{
			aqf''2  ~
			aqf''16 
			af''16 
			aqf''8 
			bqf''8 
			af''8 
		}
		{
			a''8. r16
			c'''4 
			
			cs'''2  
		} |
		{
			a''8 
			bqf''8 
			bqf''8 
			bf''8 ~ bf''16 
			af''8. ~
			af''16  
			a''8.  ~
		}
		{
			a''4 
			bqf''2.  ~
		}
		{
			bqf''8. 
			c'''16 
			bqf''8 
			bf''8 
			dqf'''8 
			aqf''8. 
			a''8.  ~
		}
		{
			a''16 
			bf''16  ~
			bf''2.. 
		}
		{
			bf''8 
			c'''8 
			d'''8 
			cs'''8 r16 
			a''16
			aqf''8 r8 
			af''8 
		} |
	}
	>>
}
