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
			e2 
			e'16 
			gqf'4..  ~
		}
		{
			gqf'4  ~
			gqf'16 
			r8.
			e'2  ~
		}
		{
			e'1  ~
		}
		{
			e'4 
			fqf'4  ~
			fqf'16 
			gqf'16 
			f8 ~ f4  ~
		}
		{
			f8 
			fs16 
			r16
			bqf2. 
		}
		{
			r8
			fs2..  ~
		}
		{
			fs2.. 
			fs8  ~
		}
		{
			fs8. 
			bqf16 
			fqf'2 
			ef'16 
			btqf8.  ~
		}
		{
			btqf2  ~
			btqf16 
			r8.
			ef'4  ~
		}
		{
			ef'1 
		}
	}
	>>
}
