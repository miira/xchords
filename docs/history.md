# History of xchords project

0.1 - core version (svg + plain output) ("Hoourah version")

- SVG test, to see, how it is working
- XML example of one chord
- simple XSLT to create one SVG image from one chord
- XSLT for translating into pure txt html output (G:320033)
- better XML definition -> XChords DTD
- better output (nicer)
- optional fingers numbers
- XSLT for moving old chord database (previous .exe project) to new xchords format
- basic chords library
- mass transformation of chords -> HTML interface

0.2 - more outputs ("Xmas version on april" - was prepared on XMas, but smoothed and released on april)

- core rewrite - separate preprocessing phase and drawing to SVG phase (very important step)
- SVG to JPEG/PNG/TIFF conversion
- PDF of SVG's output
- HTML of JPEG/PNG/TIFF's output
- better parametrized scripts
- base attribute function in chord positions cleared, unified
- better docs about configuring and running xchords

0.3 - schema ("REAL-WORLD" version) (12.12.2005)

- added XSD definitions
- xml:lang, xml:id, chord:id linkage with XSong project
- online xchords testing application
- better documentation, rewritten tutorial
- rewritten startups - ant usage
- start work on swing gui for local usage - but removed short before release

0.4 - "reincarnation" (2013, 2014)

- moved repository to github
- src/java domain model for RoboTar project
- few changes to run it again, with robotar default set of chords, produces better PNG
- possibility to generate external stylesheet/internal styles definition or inline definition at elements. 
  (SVG Salamander library doesn't process styles at all)
- dynamic transformation of one chord to SVG
- few bugfixes
- java gui SVG previewer (abandoned, incorporated into RoboTar Chords page now)
  
  
possible future development:

- conversion modules from other formats to XChords?
- add chords to base database - positions, use also other sources to produce chords

- printable songbook from xml sources with index of chords in one line command
- the XSong project is now under development at sourceforge - with fop 0.90 alpha 1 - still not good. have to wait...
- well, the generation worked and it was able to create whole HTML site with pretty looking songs and chords, clickable. but due to some limitations with used tools, i abandoned it. It still waits on its reincarnation version... (05/2014)
