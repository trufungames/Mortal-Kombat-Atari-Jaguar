;; EXAMPLE 19 - Mortal Kombat
;;
;; RAPTOR USER FILE
;;
;; Note: 	This file, and all other files, are tabulated for Notepad++
;;			Tabulation might be incorrect in other editors.
;;			use Notepad++ for maximum readability. 
;;
;; Created 2.20.2023 by Chris Bryant
;; trufungames@gmail.com

;; DO NOT MODIFY THE FOLLOWING LINES

			include				"../../JAGUAR.INC"										; Include JAGUAR system labels
			include				"../../RAPTOR/INCS/RAPTOR.INC"							; Include RAPTOR library labels
			include				"../../RAPTOR/INCS/RAPTOR235.INC"						; Include RAPTOR-235 wrapper library labels
			include				"../../U235SE/U235SE.INC"								; Include U235SE library labels

			.text							

;; YOUR APPLICATION GOES HERE
;; MODIFY AWAY!
						
;; VIDEO SETUP EQUATES
			
raptor_video_mode				equ				vidRGB16								; tell RAPTOR we want RGB 16 mode
raptor_video_enabled			equ				vidENABLE								; tell RAPTOR we want to Video ENABLED
raptor_video_VARMOD				equ				vidVARMOD_OFF							; tell RAPTOR we want VARMOD disabled
			
;; MAP MODULE SETUP EQUATES
			
raptor_first_map_object			equ				0										; Point RAPTOR to the first object of the map data
raptor_map_tiles_per_y			equ				0										; tell RAPTOR the height (in tiles) to display
raptor_map_tiles_per_x			equ				0										; tell RAPTOR the width (in tiles) to display
raptor_map_height				equ				0										; tell RAPTOR the map height (in tiles)
raptor_map_width				equ				0										; tell RAPTOR the map width (in tiles)
raptor_tilesize_x				equ				0										; tell RAPTOR the map tilesize (x) in pixels
raptor_tilesize_y				equ				0										; tell RAPTOR the map tilesize (y) in pixels
raptor_tilelinesz				equ				raptor_tilesize_x/2						; calculate the offset to next line of tile data
raptor_tilesize					equ				raptor_tilelinesz*raptor_tilesize_y		; calculate the byte size of a single tile

;; PARTICLE MODULE SETUP EQUATES

raptor_particle_buffer_width	equ				368										; tell RAPTOR the Particle / Text Buffer is 368 pixels wide
raptor_particle_buffer_height	equ				240										; tell RAPTOR the Particle / Text Buffer is 240 pixels high
raptor_particle_pixels			equ				50										; tell RAPTOR the maximum number of particles
raptor_particle_drift_x			equ				0										; tell RAPTOR the Particle Drift Factor (x)
raptor_particle_drift_y			equ				0										; tell RAPTOR the Particle Drift Factor (y)

;; some human friendly names

LIST_display					equ				0										; the first display list

ID_backdrop						equ				0										; RAPTOR Object number for the backdrop
ID_JohnnyCage					equ				8										; RAPTOR Object number for Johnny Cage
ID_Kano							equ				9										; RAPTOR Object number for Kano
ID_Raiden						equ				10										; RAPTOR Object number for Raiden
ID_LiuKang						equ				11										; RAPTOR Object number for Liu Kang
ID_Scorpion						equ				12										; RAPTOR Object number for Scorpion
ID_SubZero						equ				13										; RAPTOR Object number for Sub-Zero
ID_Sonya						equ				14										; RAPTOR Object number for Sonya
ID_Raiden_L1					equ				15										; RAPTOR Object number for Raidens lightning 1 (hat)
ID_Raiden_L2					equ				16										; RAPTOR Object number for Raidens lightning 2 (left leg)
ID_Raiden_L3					equ				17										; RAPTOR Object number for Raidens lightning 3 (right leg)

CLUT_player						equ				0										; 16 colour sub index into the 256 colour CLUT for the player sprite
CLUT_text						equ				15										; Text / Particle layer ALWAYS uses CLUT15
;;
;; The following lines **MUST** be at the start of EVERY RAPTOR APPLICATION
;; They configure the .OBJ file for use
;;	
			move.l	#raptor_video_mode,raptor_vidmode
			move.l	#raptor_video_enabled,raptor_videnable
			move.l	#raptor_video_VARMOD,raptor_varmod
			move.l	#raptor_first_map_object,raptor_maptop_obj
			move.l	#raptor_tilesize_x,raptor_tiles_x
			move.l	#raptor_tilesize_y,raptor_tiles_y
			move.l	#raptor_map_tiles_per_x+2,raptor_tilesperx
			move.l	#raptor_map_tiles_per_y+1,raptor_tilespery
			move.l	#raptor_map_width,raptor_mapwidth
			move.l	#raptor_map_height,raptor_mapheight
			move.l	#raptor_particle_pixels,raptor_maxparts
			move.l	#raptor_tilesize_x-1,raptor_tilerem_mask
			move.l	#raptor_particle_buffer_width,raptor_partbuf_x
			move.l	#raptor_particle_buffer_height,raptor_partbuf_y
			move.l	#raptor_particle_drift_x,raptor_pdriftx
			move.l	#raptor_particle_drift_y,raptor_pdrifty
			move.l	#top_of_bss,raptor_top_of_bss
			move.l	#_trashram,raptor_trashram
			move.l	#RAPTOR_MTtrash,raptor_MTwork
			move.l	#RAPTOR_user_vbi,raptor_uvbi_jmp
			move.l	#RAPTOR_POST_Object_List,raptor_poobjl
			move.l	#RAPTOR_PRE_Object_List,raptor_probjl
			move.l	#RAPTOR_font8x8,raptor_8x8_addr
			move.l	#RAPTOR_font8x16,raptor_8x16_addr
			move.l	#RAPTOR_font16x16,raptor_16x16_addr
			move.l	#RAPTOR_particle_palette,raptor_partipal
			move.l	#RAPTOR_particle_gfx,raptor_pgfx
			move.l	#RAPTOR_particle_gfxe,raptor_pgfxe
			move.l	#RAPTOR_sprite_table,raptor_spritetab
			move.l	#RAPTOR_particle_table,raptor_partitab
			move.l	#RAPTOR_MT_app_name,raptor_mtapp
			move.l	#RAPTOR_MT_file_name,raptor_mtfn
			move.l	#raptor_init_table,raptor_inittab
			move.l	#RAPTOR_samplebank,raptor_samplebank_ptr
			move.l	#0,raptor_mapbmptiles												; <<<<---- THIS WILL NEED TO BE CHANGED IF USING THE TILEMAP MODULE <<<<----
			jsr		RAPTOR_HWinit														; Setup Jaguar hardware / install RAPTOR library

;; convert some graphics

			lea		BMP_BACKDROP,a0														; point to our TGA file
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap 
			
			lea		BMP_SCORPION,a0														; point to our Windows BMP for Scorpion
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_JOHNNYCAGE,a0													; point to our Windows BMP for Johnny Cage
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_KANO,a0															; point to our Windows BMP for Kano
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_RAIDEN,a0														; point to our Windows BMP for Raiden
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_SONYA,a0														; point to our Windows BMP for Sonya
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_LIUKANG,a0														; point to our Windows BMP for Liu Kang
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_SUBZERO,a0														; point to our Windows BMP for Sub-Zero
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_PLAYER,a0														; point to our Windows BMP for the player
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_RAIDEN_L1,a0													; point to our Windows BMP for Raidens Lightning 1
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_RAIDEN_L2,a0													; point to our Windows BMP for Raidens Lightning 2
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap
			
			lea		BMP_RAIDEN_L3,a0													; point to our Windows BMP for Raidens Lightning 3
			lea		_trashram,a1														; some workram
			jsr		RAPTOR_GFXConvert													; Convert to Jaguar Bitmap

			;lea		$f00400+(32*CLUT_player),a1										; which CLUT palette needs to move into
			;jsr		RAPTOR_move_palette												; Copy the palette for the last converted bitmap to CLUT

;; we're using Joystick input, so we now need U235 Sound Engine running
			move.l	#U235SE_24KHZ,d0
			move.l	#U235SE_24KHZ_PERIOD,d1
			jsr		RAPTOR_U235init														; init the U235 Sound Engine

;; start some music
			lea		music,a0															; pointer to module file
			jsr		RAPTOR_U235setmodule												; U235 module Init
			jsr		RAPTOR_U235gomodule_stereo											; and start it playing	
			
;; get something on the screen
	
			jsr		RAPTOR_start_video													; start video processing
			move.l	#LIST_display,d0													; set RAPTOR to display initial RAPTOR list
			jsr		RAPTOR_setlist														; tell RAPTOR which list to process
			jsr		RAPTOR_UPDATE_ALL													; and update the object list with initial values
			
			clr.l	U235SE_pad1															; clear pad input flags

LOOP:		jsr		RAPTOR_wait_frame_UPDATE_ALL										; Sync to VBLANK and Update ALL RAPTOR objects	
			jsr		Handle_Input														; Handle the fire button	
			bra		LOOP																; Loop around!
;;
;; Sub-routines
;;
	
delay:		dc.w	10																	; input delay
cursor:		dc.w	8																	; the fighter cursor starts at Johnny Cage  (object #8)

Handle_Input:
			tst.w	delay																; can we check input?
			bmi		.check_input														; if -ve then we can check input
			sub.w	#1,delay															; decrement counter
			rts																			; and exit

.check_input:
			move.l	U235SE_pad1,d1														; get PAD1 status (from U235)
			btst	#U235SE_BBUT_RIGHT,d1												; was RIGHT pressed?
			bne		.move_right															; yes, move RIGHT
			btst	#U235SE_BBUT_LEFT,d1												; was LEFT pressed?
			bne		.move_left															; yes, move LEFT
			btst	#U235SE_BBUT_B,d1													; was B pressed?
			bne		.play_name															; yes, play fighter name sound
			rts																			; exit!

.play_name:
			move.w	#10,delay
			move.w	cursor,d0															; get the current cursor position
			cmp.w	#ID_JohnnyCage,d0													; is Johnny Cage selected?
			beq		.play_johnnycage													; if yes, show Johnny Cage
			cmp.w	#ID_Kano,d0															; is Kano selected?
			beq		.play_kano															; if yes, show Kano
			cmp.w	#ID_Raiden,d0														; is Raiden selected?
			beq		.play_raiden														; if yes, show Raiden
			cmp.w	#ID_LiuKang,d0														; is Liu Kang selected?
			beq		.play_liukang														; if yes, show Liu Kang
			cmp.w	#ID_Scorpion,d0														; is Scorpion selected?
			beq		.play_scorpion														; if yes, show Scorpion
			cmp.w	#ID_SubZero,d0														; is Sub-Zero selected?
			beq		.play_subzero														; if yes, show Sub-Zero
			cmp.w	#ID_Sonya,d0														; is Sonya selected?
			beq		.play_sonya															; if yes, show Sonya
			rts
			
.play_johnnycage:
			move.l	#(($1f40/2)<<16)+(1<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
.play_kano:
			move.l	#(($1f40/2)<<16)+(2<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
.play_raiden:
			move.l	#(($1f40/2)<<16)+(3<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
.play_liukang:
			move.l	#(($1f40/2)<<16)+(4<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
.play_scorpion:
			move.l	#(($1f40/2)<<16)+(5<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
.play_subzero:
			move.l	#(($1f40/2)<<16)+(6<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
.play_sonya:
			move.l	#(($1f40/2)<<16)+(7<<8)+(4<<4)+2,d1									; play sample on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			rts
			
.move_right:	
			move.w	#10,delay
			add.w 	#1,cursor	
			move.w	cursor,d0															; get the current cursor position
			cmp.w	#ID_Sonya,d0														; did we move RIGHT on Sonya?
			bgt		.wrap_to_johnnycage													; if yes, wrap to Johnny Cage	
			jmp		.hide_show			
			rts

.move_left:	
			move.w	#10,delay
			sub.w 	#1,cursor
			move.w	cursor,d0															; get the current cursor position
			cmp.w	#ID_JohnnyCage,d0													; did we move LEFT on Johnny Cage?
			blt		.wrap_to_sonya														; if yes, wrap to Sonya
			jmp		.hide_show
			rts

.wrap_to_johnnycage:
			move.w	#ID_JohnnyCage,cursor
			jmp		.hide_show
			rts
.wrap_to_sonya:
			move.w	#ID_Sonya,cursor
			jmp		.hide_show
			rts
.hide_show:		
			move.l	#(($1f40/2)<<16)+(0<<8)+(5<<4)+2,d1									; play sample 0 (player shot) on channel 4 (music is 0-3)
			jsr		RAPTOR_U235playsample												; send command to U235
			lea		RAPTOR_sprite_table+(ID_JohnnyCage*sprite_tabwidth),a0				; hide all fighters and selectors
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_JohnnyCage-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+(ID_Kano*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Kano-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+(ID_Raiden*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Raiden-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+(ID_LiuKang*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_LiuKang-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)	
			lea		RAPTOR_sprite_table+(ID_Scorpion*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Scorpion-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+(ID_SubZero*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_SubZero-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+(ID_Sonya*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Sonya-7)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Raiden_L1)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Raiden_L2)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
			lea		RAPTOR_sprite_table+((ID_Raiden_L3)*sprite_tabwidth),a0
			move.l	#is_inactive,sprite_active(a0)
				
			move.w	cursor,d0														; get the current cursor position
			cmp.w	#ID_JohnnyCage,d0												; is Johnny Cage selected?
			beq		show_johnnycage													; if yes, show Johnny Cage
			cmp.w	#ID_Kano,d0														; is Kano selected?
			beq		show_kano														; if yes, show Kano
			cmp.w	#ID_Raiden,d0													; is Raiden selected?
			beq		show_raiden														; if yes, show Raiden
			cmp.w	#ID_LiuKang,d0													; is Liu Kang selected?
			beq		show_liukang													; if yes, show Liu Kang
			cmp.w	#ID_Scorpion,d0													; is Scorpion selected?
			beq		show_scorpion													; if yes, show Scorpion
			cmp.w	#ID_SubZero,d0													; is Sub-Zero selected?
			beq		show_subzero													; if yes, show Sub-Zero
			cmp.w	#ID_Sonya,d0													; is Sonya selected?
			beq		show_sonya														; if yes, show Sonya
			rts

show_johnnycage:
			lea		RAPTOR_sprite_table+(ID_JohnnyCage*sprite_tabwidth),a0			; select Johnny Cage
			move.l	#is_active,sprite_active(a0)									; show Johnny Cage 
			lea		RAPTOR_sprite_table+((ID_JohnnyCage-7)*sprite_tabwidth),a0		; select Johnny Cage cursor
			move.l	#is_active,sprite_active(a0)									; show Johnny Cage cursor
			rts
show_kano:
			lea		RAPTOR_sprite_table+(ID_Kano*sprite_tabwidth),a0				; select Kano
			move.l	#is_active,sprite_active(a0)									; show Kano 
			lea		RAPTOR_sprite_table+((ID_Kano-7)*sprite_tabwidth),a0			; select Kano cursor
			move.l	#is_active,sprite_active(a0)									; show Kano cursor
			rts
show_raiden:
			lea		RAPTOR_sprite_table+(ID_Raiden*sprite_tabwidth),a0				; select Raiden
			move.l	#is_active,sprite_active(a0)									; show Raiden 
			lea		RAPTOR_sprite_table+((ID_Raiden-7)*sprite_tabwidth),a0			; select Raiden cursor
			move.l	#is_active,sprite_active(a0)									; show Raiden cursor
			lea		RAPTOR_sprite_table+(ID_Raiden_L1*sprite_tabwidth),a0			; select Raiden's Lightning 1
			move.l	#is_active,sprite_active(a0)									; show Raiden's Lightning 1
			lea		RAPTOR_sprite_table+(ID_Raiden_L2*sprite_tabwidth),a0			; select Raiden's Lightning 2
			move.l	#is_active,sprite_active(a0)									; show Raiden's Lightning 2
			lea		RAPTOR_sprite_table+(ID_Raiden_L3*sprite_tabwidth),a0			; select Raiden's Lightning 3
			move.l	#is_active,sprite_active(a0)									; show Raiden's Lightning 3
			rts
show_liukang:
			lea		RAPTOR_sprite_table+(ID_LiuKang*sprite_tabwidth),a0				; select Liu Kang
			move.l	#is_active,sprite_active(a0)									; show Liu Kang 
			lea		RAPTOR_sprite_table+((ID_LiuKang-7)*sprite_tabwidth),a0			; select Liu Kang cursor
			move.l	#is_active,sprite_active(a0)									; show Liu Kang cursor
			rts
show_scorpion:
			lea		RAPTOR_sprite_table+(ID_Scorpion*sprite_tabwidth),a0				; select Scorpion
			move.l	#is_active,sprite_active(a0)									; show Scorpion
			lea		RAPTOR_sprite_table+((ID_Scorpion-7)*sprite_tabwidth),a0			; select Scorpion cursor
			move.l	#is_active,sprite_active(a0)									; show Scorpion cursor
			rts
show_subzero:
			lea		RAPTOR_sprite_table+(ID_SubZero*sprite_tabwidth),a0				; select Sub-Zero
			move.l	#is_active,sprite_active(a0)									; show Sub-Zero
			lea		RAPTOR_sprite_table+((ID_SubZero-7)*sprite_tabwidth),a0			; select Sub-Zero cursor
			move.l	#is_active,sprite_active(a0)									; show Sub-Zero cursor
			rts
show_sonya:
			lea		RAPTOR_sprite_table+(ID_Sonya*sprite_tabwidth),a0				; select Sonya
			move.l	#is_active,sprite_active(a0)									; show Sonya
			lea		RAPTOR_sprite_table+((ID_Sonya-7)*sprite_tabwidth),a0			; select Sonya cursor
			move.l	#is_active,sprite_active(a0)									; show Sonya cursor
			rts
			
;;
;; RAPTOR user VBI vector
;;

RAPTOR_user_vbi:	
			rts																			; we're not using this, nothing tied to the vblank

;;
;; Creating Non-RAPTOR objects around the list
;;		

RAPTOR_PRE_Object_List:																	; No unmanaged objects before the list
			rts

RAPTOR_POST_Object_List:																; No unmanaged Objects after the list									
			rts
						
							include		"_RAPPIXL.S"									; RAPTOR particle module user data
							include 	"_RAPINIT.S"									; RAPTOR object user data
							include 	"_RAPU235.S"									; RAPTOR u235se user data
	
;;
;; Graphics
;;
							.dphrase
							dc.l	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				
RAPTOR_font8x8:				incbin	"../../RAPTOR/FONTS/F_8x8.BMP"						; User defined 8x8 fonts
							.dphrase
RAPTOR_font8x16:			incbin	"../../RAPTOR/FONTS/F_8x16.BMP"						; User defined 8x16 fonts
							.dphrase
RAPTOR_font16x16:			incbin	"../../RAPTOR/FONTS/F_16x16.BMP"					; User defined 16x16 fonts
							.dphrase
RAPTOR_particle_palette:	incbin	"../../RAPTOR/FONTS/PARTIPAL.BMP"					; User defined palette for fonts and particles
							.dphrase

BMP_BACKDROP:				incbin	"../DATAFILE/GFX/MK_Background.TGA"					; screen backdrop bitmap
							.dphrase
BMP_SCORPION:				incbin	"../DATAFILE/GFX/scorpion.tga"						; animated object for Scorpion			
							.dphrase
BMP_PLAYER:					incbin	"../DATAFILE/GFX/selectbig.tga"						; animated object for player
							.dphrase
BMP_JOHNNYCAGE:				incbin	"../DATAFILE/GFX/johnnycage.tga"					; animated object for Johnny Cage			
							.dphrase
BMP_KANO:					incbin	"../DATAFILE/GFX/kano.tga"							; animated object for Kano			
							.dphrase
BMP_RAIDEN:					incbin	"../DATAFILE/GFX/raiden.tga"						; animated object for Raiden			
							.dphrase
BMP_SONYA:					incbin	"../DATAFILE/GFX/sonya.tga"							; animated object for Sonya			
							.dphrase
BMP_LIUKANG:				incbin	"../DATAFILE/GFX/liukang.tga"						; animated object for Liu Kang			
							.dphrase
BMP_SUBZERO:				incbin	"../DATAFILE/GFX/subzero.tga"						; animated object for Sub-Zero			
							.dphrase
BMP_RAIDEN_L1:				incbin	"../DATAFILE/GFX/raiden_l1.tga"						; animated object for Raidens lightning 1			
							.dphrase
BMP_RAIDEN_L2:				incbin	"../DATAFILE/GFX/raiden_l2.tga"						; animated object for Raidens lightning 2
							.dphrase
BMP_RAIDEN_L3:				incbin	"../DATAFILE/GFX/raiden_l3.tga"						; animated object for Raidens lightning 3
							.dphrase
;;
;; Audio
;;

music:						incbin	"../DATAFILE/AUDIO/mortal_kombat_title.MOD"						; Music file from Mortal Kombat
							.dphrase
select_sam:					incbin	"../DATAFILE/AUDIO/select2.RAW"
select_end:					.dphrase
johnnycage_sam:				incbin	"../DATAFILE/AUDIO/johnnycage.RAW"
johnnycage_end:				.dphrase
kano_sam:					incbin	"../DATAFILE/AUDIO/kano.RAW"
kano_end:					.dphrase
raiden_sam:					incbin	"../DATAFILE/AUDIO/raiden.RAW"
raiden_end:					.dphrase
liukang_sam:				incbin	"../DATAFILE/AUDIO/liukang.RAW"
liukang_end:				.dphrase
scorpion_sam:				incbin	"../DATAFILE/AUDIO/scorpion.RAW"
scorpion_end:				.dphrase
subzero_sam:				incbin	"../DATAFILE/AUDIO/subzero.RAW"
subzero_end:				.dphrase
sonya_sam:					incbin	"../DATAFILE/AUDIO/sonya.RAW"
sonya_end:					.dphrase

;;
;; BSS SECTION
;;

							.bss
top_of_bss:

RAPTOR_MTtrash:				.ds.b	16384																		; Workspace for MemoryTrack routines

							.dphrase
RAPTOR_particle_gfx:		.ds.b	(raptor_particle_buffer_width/2)*raptor_particle_buffer_height				; particle FX buffer
RAPTOR_particle_gfxe:			
							.dphrase
RAPTOR_sprite_table:		.ds.b	sprite_max*sprite_tabwidth													; RAPTOR sprite database
							.dphrase
RAPTOR_particle_table:		.ds.b	raptor_particle_pixels*particle_tabwidth									; RAPTOR particle database
							.dphrase
							
_trashram:
								
;END OF FILE

				
