;;
;; U235SE Sample Bank
;;
;;
;;

			.dphrase

RAPTOR_samplebank:

sample0:	dc.l	select_sam		; start of sample
			dc.l	select_end		; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s0_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate	
				
sample1:	dc.l	johnnycage_sam	; start of sample
			dc.l	johnnycage_end	; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s1_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate

sample2:	dc.l	kano_sam		; start of sample
			dc.l	kano_end		; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s2_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate
			
sample3:	dc.l	raiden_sam		; start of sample
			dc.l	raiden_end		; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s3_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate

sample4:	dc.l	liukang_sam		; start of sample
			dc.l	liukang_end		; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s4_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate

sample5:	dc.l	scorpion_sam	; start of sample
			dc.l	scorpion_end	; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s5_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate
			
sample6:	dc.l	subzero_sam		; start of sample
			dc.l	subzero_end		; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s6_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate

sample7:	dc.l	sonya_sam		; start of sample
			dc.l	sonya_end		; end of sample
			dc.l	0				; repeat offset
			dc.l	0				; repeat length
			dc.w	0				; <NULL>
			dc.b	0				; fine tune
s7_vol:		dc.b	192				; volume
			dc.l	8000			; default play rate
; END OF FILE.
