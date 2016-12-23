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
			gqf'8. 
			cs''8 
			aqf'4. 
			r8.
			dqf'8  ~
		}
		{
			dqf'8 
			fqs'16  ~
			fqs'4 
			bqf'8 
			gqf''8. 
			dqf'8 
			dqf'8  ~
		}
		{
			dqf'4 
			r8.
			bqf'4 
			fqs'16  ~
			fqs'4 
		}
		{
			gqf'8 
			fqs'8. 
			aqf'8 
			bqf'4. 
			r8.
		}
		{
			gqf'4 
			d'16  ~
			d'4 
			gqf''8 
			fqs'8. 
			dqf'8 
		}
		{
			gqf'4. 
			r8.
			gqf''4 
			bf''8.  ~
		}
		{
			bf''8 
			fqs'8 
			d'8. 
			bqf'8 
			gqf''4. 
			r16
		}
		{
			r8
			fqs'4 
			f'16  ~
			f'4 
			fqs'8 
			bf''8. 
		}
		{
			gqf'8 
			fqs'4. 
			r8.
			fqs'4 
			cqs''16  ~
		}
		{
			cqs''4 
			d'8 
			f'8. 
			gqf''8 
			fqs'16  ~
			fqs'4 
		}
	}
	>>
}
