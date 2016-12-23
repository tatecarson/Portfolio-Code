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
      bf''8 bf''8 fs8 r8 fs2 |
      r2. r8 ef''8  ~ |
      \tuplet 3/2 { ef''8 bf''8 fs8 af'8 aqf1  ~ } |
      aqf8 r8 r4 r2 |
      \tuplet 3/2 { r16 a'16  ~ a'4 af'8 aqf8 aqf''8 eqf''2.  ~ } |
      eqf''4. r8 r2 |  
      \tuplet 3/2 { r4 r16 cs''16  ~ cs''8 cs''8 aqf''8 eqf''8 aqf''8 etqf'''2   } |
      etqf'''2 ~ etqf'''8 r8 r4 |
    }
  >>
}
