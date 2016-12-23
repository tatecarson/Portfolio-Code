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
			g'4  ~
			g'16
			r16
			f'8 
			r8.
			fqs'16  ~
			fqs'4  ~ ~
		} |
		{
			fqs'4.. 
			bqf'16  ~
			bqf'4 
			dqf'16 
			btqf''8.  ~
		} |
 		{
			btqf''8 
			r16
			cs''16 
			cs''4
			f2  ~
		} |
		{
			f4 
			d'4 
			gqf''16 
			af'8. 
			af'8 
			r16
			d'16  
		} |
		{
			g'8 
			r8 r16
			aqf'8. 
			aqf'2  ~ ~
		} |
		{
			aqf'16 
			etqf'''8. ~ etqf'''8 
			f'16 
			bqf'16  ~
			bqf'4 
			r16
			btqf''8 
			r16
		} |
		{
			r8
			f4. ~ f4. 
			dqf'8  ~
		}
		{
			dqf'8. 
			cs''16 
			d'4 ~
			d'16  
			r16
			af'8 
			r8.
			cs''16  ~
		}
		{
			cs''2  ~
			cs''8. 
			fqs'16  ~
			fqs'4 
		}
		{
			g'16 
			etqf'''8. ~ etqf'''8 
			r16
			bqf'16 ~ bqf'16 
			r8.
			dqf'4 
		}
	}
	>>
}
