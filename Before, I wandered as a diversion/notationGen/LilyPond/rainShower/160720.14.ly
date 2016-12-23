% 2016-07-20 00:22

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
			fqs'8 
			cs''8 
			d'''8  ~
			d'''2 
			r8
		}
		{
			r16
			atqf''16  ~
			atqf''2..  ~ ~
		}
		{
			atqf''2.  ~
			atqf''16 
			b8.  ~
		}
		{
			b8 
			cs''8 
			d'''8 
			b''8 
			atqf'2  ~
		}
		{
			atqf'8 
			r8 r16
			btqf'8.  ~
			btqf'2  ~ ~
		}
		{
			btqf'1  ~
		}
		{
			btqf'16   
			atqf''8. ~ atqf''8 
			b''8 
			atqf'8 
			g8 
			cqs'4  ~
		}
		{
			cqs'4. 
			r8 r8
		        gqf''4.  ~
		} |
		{
			gqf''1  ~
		}
		{
			gqf''4  ~
			gqf''16 
			btqf'8. ~
			btqf'8  
			g8 
			cqs'8 
			gqf'8 
		} |
	}
	>>
}
