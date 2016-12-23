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
			f'4 f'8 
			b16 
			f'16 ~ f'16 
			g16 ~ g4.  ~
		} |
		{
			g8 
			r4
			b8  ~
			b2  ~ ~
		}
		{
			b4  ~
			b16 
			cqs'8. ~ 
			cqs'8. 
			fs16  ~
			fs4  ~ ~
		}
		{
			fs16 
			f16 
			g8 
			fs2  ~
			fs16 
			r8.
		}
		{
			r16
			f16  ~
			f2.. 
		}
		{
			f'4. 
			b4. 
			cqs'16 
			b8 
			f16  ~
		}
		{
			f2 
			r4
			cqs'4  ~
		}
		{
			cqs'2  ~
			cqs'8. 
			fs16  ~
			fs4  ~ ~
		}
		{
			fs16 
			f8. ~ 
			f8. 
			f'16 
			f8 
			bf4.  ~
		} |
		{
			bf8. 
			f'16
			r4  
			f'2 
		}
	}
	>>
}
