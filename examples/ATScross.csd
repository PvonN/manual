<CsoundSynthesizer>
<CsOptions>
; Select audio/midi flags here according to platform
-odac  ;;;RT audio out
;-iadc    ;;;uncomment -iadc for RT audio input is needed too
; For Non-realtime ouput leave only the line below:
; -o ATScross.wav -W ;;; for file output any platform
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs  = 1

; by Menno Knevel - 2023

;ATSA wants a mono file!
;it takes a while to analyze these files...
ires1 system_i 1,{{ atsa finneganswake1.flac finneganswake.ats }} 
prints "\n***1st analyzed file is ready***\n\n"

ires2 system_i 1,{{ atsa drumsMlp.wav drumsMlp.ats }} 
prints "\n***2nd analyzed file is ready***\n\n"


instr 1
ires1 ATSinfo "finneganswake.ats", 3                  ; get number of partials
ires2 ATSinfo "drumsMlp.ats", 3                  ; get number of partials
prints "\n***number of partials of finneganswake.ats = %d***\n\n", ires1
prints "\n***number of partials of drumsMlp.ats = %d***\n\n", ires2
ktime1	line	0, p3, 12.67
ktime2	line	0, p3, 2
kline	line    p4, p3, p5                            
        ATSbufread ktime1, 1, "finneganswake.ats", ires1
aout	ATScross   ktime2, 1, "drumsMlp.ats", 1, kline, 1, 68 ; cross from p4 to p5
	outs aout*2.5, aout*2.5

endin

</CsInstruments>
<CsScore>
; sine wave.
f 1 0 16384 10 1
;          start    end
i 1 0 12.7   0       1 ; voice --> drums
i 1 15 12.7  1       0 ; drums --> voice
e
</CsScore>
</CsoundSynthesizer>
