% 2016-07-20 00:16

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
			d'''4 d'''8 
			r16
			b'16  ~
			b'2  ~ ~
		} |
		{
			b'4  ~
			b'16 
			aqf''8. ~ aqf''8 
			r8 r8.
			btqf'16  ~
		} |
		{
			btqf'4 
			bqf'16 
			aqf''8. ~ aqf''8
			r8
			fqs'4  ~
		} |
		{
			fqs'2  ~
			fqs'8 
			bqf'4. 
		}
		{
			r4
			bqf'4  ~
			bqf'16 
			f'16 
			bqf'8 ~ bqf'16 
			bqf'8. 
		} |
		{
			r16
			cqs'2.. 
			btqf'16  ~
		}
		{
			btqf'4  ~
			btqf'16 
			r8. r16
			f'8. ~
			f'8 
			c'16 
			btqf'16  ~
		} |
 		{
			btqf'4  ~
			btqf'16 
			r16
			eqf'8  ~
			eqf'2  ~ ~
		}
		{
			eqf'4 
			bqf'4
			r4.
			c'8  ~
		}
		{
			c'8. 
			bqf16 
			bqf'4
			r8.
			etqf'16  ~
			etqf'4 
		} |
	}
	>>
}
