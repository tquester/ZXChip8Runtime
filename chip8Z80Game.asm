
chip8Game:    call initChip8
zlabel0012:               jp        zgmain                  ;0200 17 8c	jump gmain
zenemyReverseX:           ld        b, $00                  ;0202 6f 00	vf := 0x0
                          ld        a, b                    ;0204 82 f7	v2 =- vf
                          sub       (ix+reg_v2)
                          ld        (ix+reg_v2), a
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          ret                               ;0206 00 ee	return
zenemyReverseY:           ld        b, $00                  ;0208 6f 00	vf := 0x0
                          ld        a, b                    ;020a 83 f7	v3 =- vf
                          sub       (ix+reg_v3)
                          ld        (ix+reg_v3), a
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          ret                               ;020c 00 ee	return
zenemyReverseFrame:       ld        b, $00                  ;020e 6f 00	vf := 0x0
                          ld        a, b                    ;0210 8a f7	va =- vf
                          sub       (ix+reg_va)
                          ld        (ix+reg_va), a
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          ret                               ;0212 00 ee	return
zcalcEnemyCoords:         ld        (ix+reg_vb), c          ;0214 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;0216 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;0218 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          ld        a, (ix+reg_v2)          ;021a 42 00	if v2 == 0x0 then
                          or        a
                          jp        z, zskip0019            ;021c 12 30	jump skip0019
zskip0017:                ld        a, c                    ;021e 80 24	v0 += v2
                          add       (ix+reg_v2)
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v4)          ;0220 8f 40	vf := v4
                          ld        b, a
                          sub       c                       ;0222 8f 05	vf -= v0
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;0224 3f 00	if vf != 0x0 then
                          call      nz, zenemyReverseX      ;0226 22 02	:call enemyReverse0
zskip0018:                ld        a, (ix+reg_v5)          ;0228 8f 50	vf := v5
                          ld        b, a
                          ld        a, c                    ;022a 8f 07	vf =- v0
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;022c 3f 00	if vf != 0x0 then
                          call      nz, zenemyReverseX      ;022e 22 02	:call enemyReverse0
zskip0019:                ld        a, (ix+reg_v3)          ;0230 43 00	if v3 == 0x0 then
                          or        a
                          jp        z, zskip0022            ;0232 12 46	jump skip0022
zskip0020:                ld        a, (ix+reg_v1)          ;0234 81 34	v1 += v3
                          add       (ix+reg_v3)
                          ld        (ix+reg_v1), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v6)          ;0236 8f 60	vf := v6
                          ld        b, a
                          sub       (ix+reg_v1)             ;0238 8f 15	vf -= v1
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;023a 3f 00	if vf != 0x0 then
                          call      nz, zenemyReverseY      ;023c 22 08	:call enemyReverse0
zskip0021:                ld        a, (ix+reg_v7)          ;023e 8f 70	vf := v7
                          ld        b, a
                          ld        a, (ix+reg_v1)          ;0240 8f 17	vf =- v1
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;0242 3f 00	if vf != 0x0 then
                          call      nz, zenemyReverseY      ;0244 22 08	:call enemyReverse0
zskip0022:                ld        a, (ix+reg_v8)          ;0246 88 a4	v8 += va
                          add       (ix+reg_va)
                          ld        (ix+reg_v8), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        b, $00                  ;0248 6f 00	vf := 0x0
                          ld        a, (ix+reg_v8)          ;024a 8f 87	vf =- v8
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;024c 3f 00	if vf != 0x0 then
                          jp        nz, zlabel0024          ;024e 12 54	jump label0024
zskip0023:                call      zenemyReverseFrame      ;0250 22 0e	:call enemyReverseFrame
                          ld        a, (ix+reg_v8)          ;0252 88 a4	v8 += va
                          add       (ix+reg_va)
                          ld        (ix+reg_v8), a
                          ld        a, 0
                          adc       a
                          ld        b, a
zlabel0024:               ld        a, (ix+reg_v9)          ;0254 8f 90	vf := v9
                          ld        b, a
                          ld        a, (ix+reg_v8)          ;0256 8f 87	vf =- v8
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;0258 4f 00	if vf == 0x0 then
                          jp        z, zlabel0026           ;025a 12 60	jump label0026
zskip0025:                call      zenemyReverseFrame      ;025c 22 0e	:call enemyReverseFrame
                          ld        a, (ix+reg_v8)          ;025e 88 a4	v8 += va
                          add       (ix+reg_va)
                          ld        (ix+reg_v8), a
                          ld        a, 0
                          adc       a
                          ld        b, a
zlabel0026:               ret                               ;0260 00 ee	return
zcopyEnemyCoords:         ld        (ix+reg_vb), c          ;0262 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;0264 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;0266 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          ret                               ;0268 00 ee	return
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zdecompressLevelStart:    ld        (ix+reg_v1), $00        ;026c 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $00        ;026e 62 00	v2 := 0x0
                          ld        (ix+reg_v3), $00        ;0270 63 00	v3 := 0x0
                          ld        (ix+reg_v4), $00        ;0272 64 00	v4 := 0x0
                          ld        (ix+reg_v6), $00        ;0274 66 00	v6 := 0x0
                          ld        (ix+reg_v7), $00        ;0276 67 00	v7 := 0x0
                          ld        (ix+reg_vb), $ff        ;0278 6b ff	vb := 0xff
                          ret                               ;027a 00 ee	return
zdecompressByteCheckNewLine: ld        a, (ix+reg_v2)       ;027c 32 10	if v2 != 0x10 then
                          cp        $10
                          jp        nz, zlabel0031          ;027e 12 84	jump label0031
zskip0030:                ld        (ix+reg_v2), $00        ;0280 62 00	v2 := 0x0
                          inc       (ix+reg_v1)             ;0282 71 01	v1 += 0x1
zlabel0031:               ret                               ;0284 00 ee	return
zdecompressByteWrite:     ld        iy, zlevelData          ;0286 a3 30	i := levelData
                          ld        d, 0                    ;0288 f4 1e	i += v4
                          ld        e, (ix+reg_v4)
                          add       iy, de
                          ld        (iy), c                 ;028a f0 55	save v0
                          inc       iy
                          inc       (ix+reg_v4)             ;028c 74 01	v4 += 0x1
                          inc       (ix+reg_v2)             ;028e 72 01	v2 += 0x1
                          ret                               ;0290 00 ee	return
zdecompressCopyBytes:     ld        a, (ix+reg_v5)          ;0292 45 00	if v5 == 0x0 then
                          or        a
                          jr        nz, zskip0034
                          ret                               ;0294 00 ee	return
zskip0034:                call      zdecompressByteWrite    ;0296 22 86	:call decompressByteWrite
                          call      zdecompressByteCheckNewLine;0298 22 7c	:call decompressByteCheck0x27cewLine
                          dec       (ix+reg_v5)             ;029a 75 ff	v5 += 0xff
                          jp        zdecompressCopyBytes    ;029c 12 92	jump decompressCopyBytes
zdecompressByte:          ld        d, 0                    ;029e f3 1e	i += v3
                          ld        e, (ix+reg_v3)
                          add       iy, de
                          ld        c, (iy)                 ;02a0 f0 65	load v0
                          inc       iy
                          inc       (ix+reg_v3)             ;02a2 73 01	v3 += 0x1
                          ld        a, c                    ;02a4 30 ff	if v0 != 0xff then
                          cp        $ff
                          jp        nz, zlabel0040          ;02a6 12 bc	jump label0040
zskip0036:                ld        c, $00                  ;02a8 60 00	v0 := 0x0
zlabel0037:               ld        b, $10                  ;02aa 6f 10	vf := 0x10
                          ld        a, (ix+reg_v2)          ;02ac 8f 27	vf =- v2
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;02ae 3f 00	if vf != 0x0 then
                          jp        nz, zlabel0039          ;02b0 12 b6	jump label0039
zskip0038:                call      zdecompressByteWrite    ;02b2 22 86	:call decompressByteWrite
                          jp        zlabel0037              ;02b4 12 aa	jump label0037
zlabel0039:               inc       (ix+reg_v1)             ;02b6 71 01	v1 += 0x1
                          ld        (ix+reg_v2), $00        ;02b8 62 00	v2 := 0x0
                          ret                               ;02ba 00 ee	return
zlabel0040:               ld        a, c                    ;02bc 30 fe	if v0 != 0xfe then
                          cp        $fe
                          jp        nz, zlabel0042          ;02be 12 ca	jump label0042
zskip0041:                ld        c, (iy)                 ;02c0 f0 65	load v0
                          inc       iy
                          ld        (ix+reg_v5), c          ;02c2 85 00	v5 := v0
                          inc       (ix+reg_v3)             ;02c4 73 01	v3 += 0x1
                          ld        c, $00                  ;02c6 60 00	v0 := 0x0
                          jp        zdecompressCopyBytes    ;02c8 12 92	jump decompressCopyBytes
zlabel0042:               ld        a, c                    ;02ca 30 fd	if v0 != 0xfd then
                          cp        $fd
                          jp        nz, zlabel0044          ;02cc 12 d8	jump label0044
zskip0043:                ld        c, (iy)                 ;02ce f0 65	load v0
                          inc       iy
                          ld        (ix+reg_v5), c          ;02d0 85 00	v5 := v0
                          ld        c, (iy)                 ;02d2 f0 65	load v0
                          inc       iy
                          ld        a, $02                  ;02d4 73 02	v3 += 0x2
                          add       (ix+reg_v3)
                          ld        (ix+reg_v3), a
                          jp        zdecompressCopyBytes    ;02d6 12 92	jump decompressCopyBytes
zlabel0044:               call      zdecompressByteWrite    ;02d8 22 86	:call decompressByteWrite
                          call      zdecompressByteCheckNewLine;02da 22 7c	:call decompressByteCheck0x27cewLine
                          ret                               ;02dc 00 ee	return
zv0x16:                   ld        a, c                    ;02de 80 04	v0 += v0
                          add       c
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
zv0x8:                    ld        a, c                    ;02e0 80 04	v0 += v0
                          add       c
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
zv0x4:                    ld        a, c                    ;02e2 80 04	v0 += v0
                          add       c
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, c                    ;02e4 80 04	v0 += v0
                          add       c
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ret                               ;02e6 00 ee	return
zdisplayTileSub:          dec       c                       ;02e8 70 ff	v0 += 0xff
                          call      zv0x8                   ;02ea 22 e0	:call v0x8
                          ld        iy, zscenesprites       ;02ec ad 05	i := scenesprites
                          ld        d, 0                    ;02ee f0 1e	i += v0
                          ld        e, c
                          add       iy, de
                          push      bc                      ;02f0 d1 28	sprite v1 v2 0x8
                          ld        a, 8
                          ld        b, (ix+reg_v1)
                          ld        c, (ix+reg_v2)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ret                               ;02f2 00 ee	return
ztileAtV0V1:              call      zv0x16                  ;02f4 22 de	:call v0x16
                          ld        a, c                    ;02f6 80 14	v0 += v1
                          add       (ix+reg_v1)
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        iy, zlevelData          ;02f8 a3 30	i := levelData
                          ld        d, 0                    ;02fa f0 1e	i += v0
                          ld        e, c
                          add       iy, de
                          ld        c, (iy)                 ;02fc f0 65	load v0
                          inc       iy
                          ret                               ;02fe 00 ee	return
zdrawTileLevel:           ld        iy, zlevelData          ;0300 a3 30	i := levelData
                          ld        (ix+reg_v9), $00        ;0302 69 00	v9 := 0x0
                          ld        (ix+reg_va), $00        ;0304 6a 00	va := 0x0
                          ld        (ix+reg_v3), $00        ;0306 63 00	v3 := 0x0
                          ld        (ix+reg_v3), $00        ;0308 63 00	v3 := 0x0
zlabel0051:               ld        iy, zlevelData          ;030a a3 30	i := levelData
                          ld        d, 0                    ;030c f3 1e	i += v3
                          ld        e, (ix+reg_v3)
                          add       iy, de
                          ld        c, (iy)                 ;030e f0 65	load v0
                          inc       iy
                          ld        a, c                    ;0310 40 00	if v0 == 0x0 then
                          or        a
                          jp        z, zlabel0053           ;0312 13 1e	jump label0053
zskip0052:                dec       c                       ;0314 70 ff	v0 += 0xff
                          call      zv0x8                   ;0316 22 e0	:call v0x8
                          ld        iy, zscenesprites       ;0318 ad 05	i := scenesprites
                          ld        d, 0                    ;031a f0 1e	i += v0
                          ld        e, c
                          add       iy, de
                          push      bc                      ;031c d9 a8	sprite v9 va 0x8
                          ld        a, 8
                          ld        b, (ix+reg_v9)
                          ld        c, (ix+reg_va)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
zlabel0053:               ld        a, $08                  ;031e 79 08	v9 += 0x8
                          add       (ix+reg_v9)
                          ld        (ix+reg_v9), a
                          cp        $80                     ;0320 39 80	if v9 != 0x80 then
                          jp        nz, zlabel0055          ;0322 13 28	jump label0055
zskip0054:                ld        (ix+reg_v9), $00        ;0324 69 00	v9 := 0x0
                          ld        a, $08                  ;0326 7a 08	va += 0x8
                          add       (ix+reg_va)
                          ld        (ix+reg_va), a
zlabel0055:               inc       (ix+reg_v3)             ;0328 73 01	v3 += 0x1
                          ld        a, (ix+reg_v3)          ;032a 33 80	if v3 != 0x80 then
                          cp        $80
                          jp        nz, zlabel0051          ;032c 13 0a	jump label0051
zskip0056:                ret                               ;032e 00 ee	return
zlevelData:               db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zdrawTinyLetter2:         ld        a, c                    ;03b2 30 01	if v0 != 0x1 then
                          dec       a
                          jp        nz, zlabel0060          ;03b4 13 bc	jump label0060
zskip0059:                ld        (ix+reg_v1), $00        ;03b6 61 00	v1 := 0x0
                          ld        a, $06                  ;03b8 72 06	v2 += 0x6
                          add       (ix+reg_v2)
                          ld        (ix+reg_v2), a
                          ret                               ;03ba 00 ee	return
zlabel0060:               ld        a, $fe                  ;03bc 70 fe	v0 += 0xfe
                          add       c
                          ld        c, a
                          ld        iy, ztinyA              ;03be a3 ee	i := tinyA
                          ld        b, $1e                  ;03c0 6f 1e	vf := 0x1e
                          ld        a, b                    ;03c2 8f 05	vf -= v0
                          sub       c
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;03c4 3f 00	if vf != 0x0 then
                          jp        nz, zlabel0062          ;03c6 13 ce	jump label0062
zskip0061:                ld        (ix+reg_v4), $96        ;03c8 64 96	v4 := 0x96
                          ld        d, 0                    ;03ca f4 1e	i += v4
                          ld        e, (ix+reg_v4)
                          add       iy, de
                          ld        a, $e2                  ;03cc 70 e2	v0 += 0xe2
                          add       c
                          ld        c, a
zlabel0062:               ld        (ix+reg_v4), c          ;03ce 84 00	v4 := v0
                          ld        a, c                    ;03d0 80 04	v0 += v0
                          add       c
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, c                    ;03d2 80 04	v0 += v0
                          add       c
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, c                    ;03d4 80 44	v0 += v4
                          add       (ix+reg_v4)
                          ld        c, a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        d, 0                    ;03d6 f0 1e	i += v0
                          ld        e, c
                          add       iy, de
                          push      bc                      ;03d8 d1 25	sprite v1 v2 0x5
                          ld        a, 5
                          ld        b, (ix+reg_v1)
                          ld        c, (ix+reg_v2)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ld        a, $05                  ;03da 71 05	v1 += 0x5
                          add       (ix+reg_v1)
                          ld        (ix+reg_v1), a
                          ret                               ;03dc 00 ee	return
zdrawTinyString:          ld        iy, ztxtAmoebetronsRevance;03de a6 90	i := txtAmoebetronsRevance
                          ld        d, 0                    ;03e0 f3 1e	i += v3
                          ld        e, (ix+reg_v3)
                          add       iy, de
                          ld        c, (iy)                 ;03e2 f0 65	load v0
                          inc       iy
                          ld        a, c                    ;03e4 40 00	if v0 == 0x0 then
                          or        a
                          jr        nz, zskip0064
                          ret                               ;03e6 00 ee	return
zskip0064:                call      zdrawTinyLetter2        ;03e8 23 b2	:call drawTinyLetter2
                          inc       (ix+reg_v3)             ;03ea 73 01	v3 += 0x1
                          jp        zdrawTinyString         ;03ec 13 de	jump drawTinyString
ztinyA:                   db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x60                           ;;_██      `
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x60                           ;;_██      `
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0xc0                           ;;██        
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0xc0                           ;;██        
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x60                           ;;_██      `
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x60                           ;;_██      `
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0x60                           ;;_██      `
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x60                           ;;_██      `
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0xc0                           ;;██        
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x60                           ;;_██      `
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0x40                           ;;_█       @
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
ztinySmallA:              db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0xc0                           ;;██        
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0xc0                           ;;██        
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0xc0                           ;;██        
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0xc0                           ;;██        
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0x60                           ;;_██      `
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0x00                           ;;_______   
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0x60                           ;;_██      `
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0x60                           ;;_██      `
                          db 0x80                           ;;█         
                          db 0x20                           ;;__█       
                          db 0xc0                           ;;██        
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x60                           ;;_██      `
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0x40                           ;;_█       @
                          db 0x60                           ;;_██      `
                          db 0xa0                           ;;█ █       
                          db 0x20                           ;;__█       
                          db 0x20                           ;;__█       
                          db 0x60                           ;;_██      `
                          db 0x60                           ;;_██      `
                          db 0xa0                           ;;█ █       
                          db 0x20                           ;;__█       
                          db 0x40                           ;;_█       @
                          db 0xe0                           ;;███       
                          db 0xc0                           ;;██        
                          db 0x20                           ;;__█       
                          db 0x40                           ;;_█       @
                          db 0x20                           ;;__█       
                          db 0xc0                           ;;██        
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0x20                           ;;__█       
                          db 0xe0                           ;;███       
                          db 0x80                           ;;█         
                          db 0xc0                           ;;██        
                          db 0x20                           ;;__█       
                          db 0xc0                           ;;██        
                          db 0x40                           ;;_█       @
                          db 0x80                           ;;█         
                          db 0xe0                           ;;███       
                          db 0xa0                           ;;█ █       
                          db 0x40                           ;;_█       @
                          db 0xe0                           ;;███       
                          db 0x20                           ;;__█       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0x80                           ;;█         
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0x40                           ;;_█       @
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0x60                           ;;_██      `
                          db 0x20                           ;;__█       
                          db 0xc0                           ;;██        
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x60                           ;;_██      `
                          db 0x60                           ;;_██      `
                          db 0x60                           ;;_██      `
                          db 0x60                           ;;_██      `
                          db 0x60                           ;;_██      `
                          db 0x00                           ;;_______   
                          db 0x60                           ;;_██      `
                          db 0x40                           ;;_█       @
                          db 0xa0                           ;;█ █       
                          db 0x20                           ;;__█       
                          db 0x00                           ;;_______   
                          db 0x40                           ;;_█       @
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x20                           ;;__█       
                          db 0x40                           ;;_█       @
                          db 0x20                           ;;__█       
                          db 0x20                           ;;__█       
                          db 0x40                           ;;_█       @
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xa0                           ;;█ █       
                          db 0xa0                           ;;█ █       
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zplayerData:              db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zplayerSaveData:          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zplayerTilePos:           db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zplayerInitData:          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x14                           ;;___█ █    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zloadPlayerData:          ld        iy, zplayerData         ;0578 a5 4e	i := playerData
                          push      bc                      ;057a fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ret                               ;057c 00 ee	return
zsavePlayerData:          ld        iy, zplayerData         ;057e a5 4e	i := playerData
                          ld        (ix+reg_v0), c          ;0580 fb 55	save vb
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ret                               ;0582 00 ee	return
zplayerTileAddress:       ld        a, (ix+reg_v1)          ;0584 83 10	v3 := v1
                          ld        (ix+reg_v3), a
                          ld        a, (ix+reg_v2)          ;0586 84 20	v4 := v2
                          ld        (ix+reg_v4), a
                          ld        a, $0f                  ;0588 74 0f	v4 += 0xf
                          add       (ix+reg_v4)
                          ld        (ix+reg_v4), a
                          ld        a, $04                  ;058a 73 04	v3 += 0x4
                          add       (ix+reg_v3)
                          ld        (ix+reg_v3), a
                          sra       a                       ;058c 83 36	v3 >>= v3
                          ld        (ix+reg_v3), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v3)          ;058e 83 36	v3 >>= v3
                          sra       a
                          ld        (ix+reg_v3), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v3)          ;0590 83 36	v3 >>= v3
                          sra       a
                          ld        (ix+reg_v3), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v4)          ;0592 84 46	v4 >>= v4
                          sra       a
                          ld        (ix+reg_v4), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v4)          ;0594 84 46	v4 >>= v4
                          sra       a
                          ld        (ix+reg_v4), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        a, (ix+reg_v4)          ;0596 84 46	v4 >>= v4
                          sra       a
                          ld        (ix+reg_v4), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ret                               ;0598 00 ee	return
zmovePlayer:              ld        iy, zplayerSprite       ;059a ad ad	i := playerSprite
                          ld        a, (ix+reg_v6)          ;059c 46 ff	if v6 == 0xff then
                          cp        $ff
                          jr        nz, zskip0075
                          ld        iy, zplayerReverseSprite;059e ad f8	i := playerReverseSprite
zskip0075:                ld        d, 0                    ;05a0 f8 1e	i += v8
                          ld        e, (ix+reg_v8)
                          add       iy, de
                          ld        a, (ix+reg_v1)          ;05a2 83 10	v3 := v1
                          ld        (ix+reg_v3), a
                          ld        a, (ix+reg_v2)          ;05a4 84 20	v4 := v2
                          ld        (ix+reg_v4), a
                          ld        a, (ix+reg_v8)          ;05a6 8a 80	va := v8
                          ld        (ix+reg_va), a
                          ld        a, $0f                  ;05a8 78 0f	v8 += 0xf
                          add       (ix+reg_v8)
                          ld        (ix+reg_v8), a
                          cp        $4b                     ;05aa 48 4b	if v8 == 0x4b then
                          jr        nz, zskip0076
                          ld        (ix+reg_v8), $00        ;05ac 68 00	v8 := 0x0
zskip0076:                ld        a, (ix+reg_v1)          ;05ae 81 64	v1 += v6
                          add       (ix+reg_v6)
                          ld        (ix+reg_v1), a
                          ld        a, 0
                          adc       a
                          ld        b, a
                          ld        b, $00                  ;05b0 6f 00	vf := 0x0
                          ld        a, b                    ;05b2 8f 15	vf -= v1
                          sub       (ix+reg_v1)
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;05b4 3f 00	if vf != 0x0 then
                          jr        z, zskip0077
                          ld        (ix+reg_v1), $00        ;05b6 61 00	v1 := 0x0
zskip0077:                ld        b, $74                  ;05b8 6f 74	vf := 0x74
                          ld        a, b                    ;05ba 8f 15	vf -= v1
                          sub       (ix+reg_v1)
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;05bc 4f 00	if vf == 0x0 then
                          jr        nz, zskip0078
                          ld        (ix+reg_v1), $74        ;05be 61 74	v1 := 0x74
zskip0078:                ld        a, (ix+reg_v7)          ;05c0 37 fe	if v7 != 0xfe then
                          cp        $fe
                          jp        nz, zlabel0080          ;05c2 15 cc	jump label0080
zskip0079:                inc       (ix+reg_v2)             ;05c4 72 01	v2 += 0x1
                          ld        a, (ix+reg_v1)          ;05c6 81 65	v1 -= v6
                          sub       (ix+reg_v6)
                          ld        (ix+reg_v1), a
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          ld        (ix+reg_v8), $00        ;05c8 68 00	v8 := 0x0
                          jp        zlabel0086              ;05ca 15 ee	jump label0086
zlabel0080:               ld        b, $00                  ;05cc 6f 00	vf := 0x0
                          ld        a, b                    ;05ce 8f 75	vf -= v7
                          sub       (ix+reg_v7)
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;05d0 3f 00	if vf != 0x0 then
                          jp        nz, zlabel0086          ;05d2 15 ee	jump label0086
zskip0081:                ld        b, $0e                  ;05d4 6f 0e	vf := 0xe
                          ld        a, b                    ;05d6 8f 75	vf -= v7
                          sub       (ix+reg_v7)
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;05d8 4f 00	if vf == 0x0 then
                          jp        z, zlabel0083           ;05da 15 e0	jump label0083
zskip0082:                dec       (ix+reg_v2)             ;05dc 72 ff	v2 += 0xff
                          jp        zlabel0084              ;05de 15 e2	jump label0084
zlabel0083:               inc       (ix+reg_v2)             ;05e0 72 01	v2 += 0x1
zlabel0084:               inc       (ix+reg_v7)             ;05e2 77 01	v7 += 0x1
                          ld        b, $1d                  ;05e4 6f 1d	vf := 0x1d
                          ld        a, (ix+reg_v7)          ;05e6 8f 77	vf =- v7
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;05e8 4f 00	if vf == 0x0 then
                          jp        z, zlabel0086           ;05ea 15 ee	jump label0086
zskip0085:                ld        (ix+reg_v7), $00        ;05ec 67 00	v7 := 0x0
zlabel0086:               call      zdrawPlayer             ;05ee 26 84	:call drawPlayer
                          ld        a, (ix+reg_v1)          ;05f0 83 10	v3 := v1
                          ld        (ix+reg_v3), a
                          ld        a, (ix+reg_v2)          ;05f2 84 20	v4 := v2
                          ld        (ix+reg_v4), a
                          ld        a, (ix+reg_v8)          ;05f4 8a 80	va := v8
                          ld        (ix+reg_va), a
                          ld        a, (ix+reg_v6)          ;05f6 85 60	v5 := v6
                          ld        (ix+reg_v5), a
                          call      zdrawPlayer             ;05f8 26 84	:call drawPlayer
                          ld        (ix+reg_v5), b          ;05fa 85 f0	v5 := vf
                          call      zplayerTileAddress      ;05fc 25 84	:call playerTileAddress
                          ld        a, (ix+reg_v7)          ;05fe 47 fe	if v7 == 0xfe then
                          cp        $fe
                          jr        nz, zskip0087
                          ld        (ix+reg_v5), $00        ;0600 65 00	v5 := 0x0
zskip0087:                ld        a, (ix+reg_v5)          ;0602 8f 50	vf := v5
                          ld        b, a
                          ret                               ;0604 00 ee	return
zplayerProcessKeys:       ld        iy, zplayerData         ;0606 a5 4e	i := playerData
                          push      bc                      ;0608 fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        c, $00                  ;060a 60 00	v0 := 0x0
                          ld        a, (ix+reg_v6)          ;060c 85 60	v5 := v6
                          ld        (ix+reg_v5), a
                          ld        (ix+reg_v3), $09        ;060e 63 09	v3 := 0x9
                          ld        b, $09                  ;0610 6f 09	vf := 0x9
                          ld        a, b                    ;0612 ef 9e	if vf -key then
                          call      checkKey
                          jp        nz, zlabel0090          ;0614 16 1a	jump label0090
zskip0089:                ld        (ix+reg_v6), $01        ;0616 66 01	v6 := 0x1
                          ld        c, $01                  ;0618 60 01	v0 := 0x1
zlabel0090:               ld        b, $07                  ;061a 6f 07	vf := 0x7
                          ld        a, b                    ;061c ef 9e	if vf -key then
                          call      checkKey
                          jp        nz, zlabel0095          ;061e 16 30	jump label0095
zskip0091:                ld        b, $01                  ;0620 6f 01	vf := 0x1
                          ld        a, b                    ;0622 8f 15	vf -= v1
                          sub       (ix+reg_v1)
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;0624 3f 00	if vf != 0x0 then
                          jp        nz, zlabel0093          ;0626 16 2c	jump label0093
zskip0092:                ld        (ix+reg_v6), $ff        ;0628 66 ff	v6 := 0xff
                          jp        zlabel0094              ;062a 16 2e	jump label0094
zlabel0093:               ld        (ix+reg_v6), $00        ;062c 66 00	v6 := 0x0
zlabel0094:               ld        c, $01                  ;062e 60 01	v0 := 0x1
zlabel0095:               ld        a, (ix+reg_v7)          ;0630 37 00	if v7 != 0x0 then
                          or        a
                          jp        nz, zlabel0098          ;0632 16 3c	jump label0098
zskip0096:                ld        b, $05                  ;0634 6f 05	vf := 0x5
                          ld        a, b                    ;0636 ef a1	if vf key then
                          call      checkKey
                          jr        nz, zskip0097
                          ld        (ix+reg_v7), $01        ;0638 67 01	v7 := 0x1
zskip0097:                jp        zlabel0099              ;063a 16 3e	jump label0099
zlabel0098:               ld        c, $01                  ;063c 60 01	v0 := 0x1
zlabel0099:               ld        b, $00                  ;063e 6f 00	vf := 0x0
                          ld        a, c                    ;0640 30 01	if v0 != 0x1 then
                          dec       a
                          jp        nz, zlabel0101          ;0642 16 46	jump label0101
zskip0100:                call      zmovePlayer             ;0644 25 9a	:call movePlayer
zlabel0101:               ld        iy, zplayerData         ;0646 a5 4e	i := playerData
                          ld        (ix+reg_v0), c          ;0648 fb 55	save vb
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ret                               ;064a 00 ee	return
zplayerInitDraw:          ld        (ix+reg_v6), $01        ;064c 66 01	v6 := 0x1
                          ld        (ix+reg_v7), $00        ;064e 67 00	v7 := 0x0
                          ld        (ix+reg_v8), $00        ;0650 68 00	v8 := 0x0
                          ld        a, (ix+reg_v1)          ;0652 83 10	v3 := v1
                          ld        (ix+reg_v3), a
                          ld        a, (ix+reg_v2)          ;0654 84 20	v4 := v2
                          ld        (ix+reg_v4), a
                          ld        a, (ix+reg_v8)          ;0656 8a 80	va := v8
                          ld        (ix+reg_va), a
                          call      zdrawPlayer             ;0658 26 84	:call drawPlayer
                          ld        iy, zplayerData         ;065a a5 4e	i := playerData
                          ld        (ix+reg_v0), c          ;065c fb 55	save vb
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ret                               ;065e 00 ee	return
zplayerCheckJump:         db 0xa5                           ;;█ █  █ █  
                          db 0x5a                           ;;_█ ██ █  Z
                          db 0xfb                           ;;█████ ██  
                          db 0x55                           ;;_█ █ █ █ U
                          db 0xa5                           ;;█ █  █ █  
                          db 0x4e                           ;;_█  ███  N
                          db 0xfb                           ;;█████ ██  
                          db 0x65                           ;;_██  █ █ e
                          db 0x37                           ;;__██ ███ 7
                          db 0x00                           ;;_______   
                          db 0x25                           ;;__█  █ █ %
                          db 0x9a                           ;;█  ██ █   
                          db 0xa5                           ;;█ █  █ █  
                          db 0x5a                           ;;_█ ██ █  Z
                          db 0xf4                           ;;████ █    
                          db 0x65                           ;;_██  █ █ e
                          db 0x00                           ;;_______   
                          db 0xee                           ;;███ ███   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zinitfast:                ret                               ;0674 00 ee	return
zfast:                    call      f0fast                  ;0676 f0 e0	fast
                          ret                               ;0678 00 ee	return
zslow:                    db 0xf1                           ;;████   █  
                          db 0xe0                           ;;███       
                          db 0x00                           ;;_______   
                          db 0xee                           ;;███ ███   
zredraw:                  call      f0redraw                ;067e f2 e0	redraw
                          ret                               ;0680 00 ee	return
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zdrawPlayer:              ld        iy, zplayerSprite       ;0684 ad ad	i := playerSprite
                          ld        a, (ix+reg_v5)          ;0686 45 ff	if v5 == 0xff then
                          cp        $ff
                          jr        nz, zskip0109
                          ld        iy, zplayerReverseSprite;0688 ad f8	i := playerReverseSprite
zskip0109:                ld        d, 0                    ;068a fa 1e	i += va
                          ld        e, (ix+reg_va)
                          add       iy, de
                          push      bc                      ;068c d3 4f	sprite v3 v4 0xf
                          ld        a, 15
                          ld        b, (ix+reg_v3)
                          ld        c, (ix+reg_v4)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ret                               ;068e 00 ee	return
ztxtAmoebetronsRevance:   db 0x02                           ;;______█   
                          db 0x28                           ;;__█ █    (
                          db 0x2a                           ;;__█ █ █  *
                          db 0x20                           ;;__█       
                          db 0x1d                           ;;___███ █  
                          db 0x20                           ;;__█       
                          db 0x2f                           ;;__█ ████ /
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x2a                           ;;__█ █ █  *
                          db 0x29                           ;;__█ █  █ )
                          db 0x2e                           ;;__█ ███  .
                          db 0x46                           ;;_█   ██  F
                          db 0x38                           ;;__███    8
                          db 0x29                           ;;__█ █  █ )
                          db 0x1f                           ;;___█████  
                          db 0x46                           ;;_█   ██  F
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x20                           ;;__█       
                          db 0x31                           ;;__██   █ 1
                          db 0x1c                           ;;___███    
                          db 0x29                           ;;__█ █  █ )
                          db 0x1e                           ;;___████   
                          db 0x23                           ;;__█   ██ #
                          db 0x20                           ;;__█       
                          db 0x41                           ;;_█     █ A
                          db 0x00                           ;;_______   
ztxtCellPhones1:          db 0x02                           ;;______█   
                          db 0x2f                           ;;__█ ████ /
                          db 0x2f                           ;;__█ ████ /
                          db 0x1c                           ;;___███    
                          db 0x1e                           ;;___████   
                          db 0x26                           ;;__█  ██  &
                          db 0x46                           ;;_█   ██  F
                          db 0x2a                           ;;__█ █ █  *
                          db 0x21                           ;;__█    █ !
                          db 0x46                           ;;_█   ██  F
                          db 0x28                           ;;__█ █    (
                          db 0x30                           ;;__██     0
                          db 0x2f                           ;;__█ ████ /
                          db 0x1c                           ;;___███    
                          db 0x29                           ;;__█ █  █ )
                          db 0x2f                           ;;__█ ████ /
                          db 0x46                           ;;_█   ██  F
                          db 0x00                           ;;_______   
ztxtCellPhones2:          db 0x1e                           ;;___████   
                          db 0x20                           ;;__█       
                          db 0x27                           ;;__█  ███ '
                          db 0x27                           ;;__█  ███ '
                          db 0x46                           ;;_█   ██  F
                          db 0x2b                           ;;__█ █ ██ +
                          db 0x23                           ;;__█   ██ #
                          db 0x2a                           ;;__█ █ █  *
                          db 0x29                           ;;__█ █  █ )
                          db 0x20                           ;;__█       
                          db 0x2e                           ;;__█ ███  .
                          db 0x41                           ;;_█     █ A
                          db 0x00                           ;;_______   
zmariowashere1:           db 0x0e                           ;;____███   
                          db 0x1c                           ;;___███    
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x24                           ;;__█  █   $
                          db 0x2a                           ;;__█ █ █  *
                          db 0x46                           ;;_█   ██  F
                          db 0x2f                           ;;__█ ████ /
                          db 0x2a                           ;;__█ █ █  *
                          db 0x2a                           ;;__█ █ █  *
                          db 0x26                           ;;__█  ██  &
                          db 0x00                           ;;_______   
zmariowashere2:           db 0x2f                           ;;__█ ████ /
                          db 0x23                           ;;__█   ██ #
                          db 0x20                           ;;__█       
                          db 0x46                           ;;_█   ██  F
                          db 0x1e                           ;;___████   
                          db 0x2a                           ;;__█ █ █  *
                          db 0x24                           ;;__█  █   $
                          db 0x29                           ;;__█ █  █ )
                          db 0x41                           ;;_█     █ A
                          db 0x00                           ;;_______   
zwhereiseugene:           db 0x18                           ;;___██     
                          db 0x23                           ;;__█   ██ #
                          db 0x20                           ;;__█       
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x20                           ;;__█       
                          db 0x46                           ;;_█   ██  F
                          db 0x24                           ;;__█  █   $
                          db 0x2e                           ;;__█ ███  .
                          db 0x46                           ;;_█   ██  F
                          db 0x06                           ;;_____██   
                          db 0x30                           ;;__██     0
                          db 0x22                           ;;__█   █  "
                          db 0x20                           ;;__█       
                          db 0x29                           ;;__█ █  █ )
                          db 0x20                           ;;__█       
                          db 0x42                           ;;_█    █  B
                          db 0x00                           ;;_______   
ztxtpackman:              db 0x05                           ;;_____█ █  
                          db 0x2a                           ;;__█ █ █  *
                          db 0x29                           ;;__█ █  █ )
                          db 0x2f                           ;;__█ ████ /
                          db 0x46                           ;;_█   ██  F
                          db 0x2b                           ;;__█ █ ██ +
                          db 0x27                           ;;__█  ███ '
                          db 0x1c                           ;;___███    
                          db 0x34                           ;;__██ █   4
                          db 0x46                           ;;_█   ██  F
                          db 0x32                           ;;__██  █  2
                          db 0x24                           ;;__█  █   $
                          db 0x2f                           ;;__█ ████ /
                          db 0x23                           ;;__█   ██ #
                          db 0x46                           ;;_█   ██  F
                          db 0x2b                           ;;__█ █ ██ +
                          db 0x1c                           ;;___███    
                          db 0x1e                           ;;___████   
                          db 0x26                           ;;__█  ██  &
                          db 0x28                           ;;__█ █    (
                          db 0x1c                           ;;___███    
                          db 0x29                           ;;__█ █  █ )
                          db 0x41                           ;;_█     █ A
                          db 0x00                           ;;_______   
zwelldone:                db 0x18                           ;;___██     
                          db 0x20                           ;;__█       
                          db 0x27                           ;;__█  ███ '
                          db 0x27                           ;;__█  ███ '
                          db 0x46                           ;;_█   ██  F
                          db 0x1f                           ;;___█████  
                          db 0x2a                           ;;__█ █ █  *
                          db 0x29                           ;;__█ █  █ )
                          db 0x20                           ;;__█       
                          db 0x41                           ;;_█     █ A
                          db 0x00                           ;;_______   
zwelldone2:               db 0x1a                           ;;___██ █   
                          db 0x2a                           ;;__█ █ █  *
                          db 0x30                           ;;__██     0
                          db 0x46                           ;;_█   ██  F
                          db 0x2c                           ;;__█ ██   ,
                          db 0x30                           ;;__██     0
                          db 0x1c                           ;;___███    
                          db 0x27                           ;;__█  ███ '
                          db 0x24                           ;;__█  █   $
                          db 0x21                           ;;__█    █ !
                          db 0x34                           ;;__██ █   4
                          db 0x00                           ;;_______   
zwelldone3:               db 0x1c                           ;;___███    
                          db 0x2e                           ;;__█ ███  .
                          db 0x46                           ;;_█   ██  F
                          db 0x1c                           ;;___███    
                          db 0x46                           ;;_█   ██  F
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x20                           ;;__█       
                          db 0x2f                           ;;__█ ████ /
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x2a                           ;;__█ █ █  *
                          db 0x45                           ;;_█   █ █ E
                          db 0x00                           ;;_______   
zwelldone4:               db 0x22                           ;;__█   █  "
                          db 0x1c                           ;;___███    
                          db 0x28                           ;;__█ █    (
                          db 0x20                           ;;__█       
                          db 0x2d                           ;;__█ ██ █ -
                          db 0x00                           ;;_______   
zbcdbuf1:                 db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zbcdbuf2:                 db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zbcdbuf3:                 db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zbcdfirst:                db 0x01                           ;;_______█  
zprintsave:               db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zprintCoords:             ld        iy, zamoebetron0        ;074a ac 09	i := amoebetron0
                          jp        zdrawSprite12           ;074c 17 50	jump drawSprite12
zdrawToilette:            ld        iy, ztoilette           ;074e ac 2d	i := toilette
zdrawSprite12:            ld        d, 0                    ;0750 fd 1e	i += vd
                          ld        e, (ix+reg_vd)
                          add       iy, de
                          push      bc                      ;0752 db cc	sprite vb vc 0xc
                          ld        a, 12
                          ld        b, (ix+reg_vb)
                          ld        c, (ix+reg_vc)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ret                               ;0754 00 ee	return
zdrawStomper:             ld        iy, zstomper            ;0756 ac 81	i := stomper
                          jp        zdrawSprite12           ;0758 17 50	jump drawSprite12
zdrawRobo:                ld        iy, zrobo               ;075a ac a5	i := robo
                          jp        zdrawSprite12           ;075c 17 50	jump drawSprite12
zdrawCellphone:           ld        iy, zcellphone          ;075e ac c9	i := cellphone
                          jp        zdrawSprite12           ;0760 17 50	jump drawSprite12
zcheckFalling:            ld        a, (ix+reg_v4)          ;0762 80 40	v0 := v4
                          ld        c, a
                          ld        a, (ix+reg_v3)          ;0764 81 30	v1 := v3
                          ld        (ix+reg_v1), a
                          call      ztileAtV0V1             ;0766 22 f4	:call tileAtV0V1
                          ld        a, c                    ;0768 30 00	if v0 != 0x0 then
                          or        a
                          jp        nz, zlabel0136          ;076a 17 78	jump label0136
zskip0133:                ld        a, (ix+reg_v7)          ;076c 37 00	if v7 != 0x0 then
                          or        a
                          jp        nz, zlabel0135          ;076e 17 76	jump label0135
zskip0134:                call      zloadPlayerData         ;0770 25 78	:call loadPlayerData
                          ld        (ix+reg_v7), $fe        ;0772 67 fe	v7 := 0xfe
                          call      zsavePlayerData         ;0774 25 7e	:call savePlayerData
zlabel0135:               jp        zlabel0139              ;0776 17 8a	jump label0139
zlabel0136:               ld        b, $06                  ;0778 6f 06	vf := 0x6
                          ld        a, c                    ;077a 8f 07	vf =- v0
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;077c 3f 00	if vf != 0x0 then
                          jp        nz, zlabel0139          ;077e 17 8a	jump label0139
zskip0137:                ld        a, (ix+reg_v7)          ;0780 47 00	if v7 == 0x0 then
                          or        a
                          jp        z, zlabel0139           ;0782 17 8a	jump label0139
zskip0138:                call      zloadPlayerData         ;0784 25 78	:call loadPlayerData
                          ld        (ix+reg_v7), $00        ;0786 67 00	v7 := 0x0
                          call      zsavePlayerData         ;0788 25 7e	:call savePlayerData
zlabel0139:               ret                               ;078a 00 ee	return
zgmain:                   ld        a, 1                    ;078c 00 ff	hires
                          call      setRes
                          call      zinitfast               ;078e 26 74	:call initfast
                          call      zfast                   ;0790 26 76	:call fast
zscene1:                  call      clearScreenChip8        ;0792 00 e0	clear
                          call      updateGameScreen
                          ld        (ix+reg_v1), $00        ;0794 61 00	v1 := 0x0
zlabel0142:               ld        iy, zscene1SpriteData   ;0796 ab 63	i := scene1SpriteData
                          ld        d, 0                    ;0798 f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        c, (iy)                 ;079a f0 65	load v0
                          inc       iy
                          ld        iy, zenemydata1         ;079c ab db	i := enemydata1
                          ld        d, 0                    ;079e f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        (iy), c                 ;07a0 f0 55	save v0
                          inc       iy
                          inc       (ix+reg_v1)             ;07a2 71 01	v1 += 0x1
                          ld        a, (ix+reg_v1)          ;07a4 31 1e	if v1 != 0x1e then
                          cp        $1e
                          jp        nz, zlabel0142          ;07a6 17 96	jump label0142
zskip0143:                ld        (ix+reg_v9), $ff        ;07a8 69 ff	v9 := 0xff
                          call      zdecompressLevelStart   ;07aa 22 6c	:call decompressLevelStart
zlabel0144:               ld        a, (ix+reg_v1)          ;07ac 41 08	if v1 == 0x8 then
                          cp        $08
                          jp        z, zlabel0146           ;07ae 17 b6	jump label0146
zskip0145:                ld        iy, zlevel1             ;07b0 ae 43	i := level1
                          call      zdecompressByte         ;07b2 22 9e	:call decompressByte
                          jp        zlabel0144              ;07b4 17 ac	jump label0144
zlabel0146:               call      zdrawTileLevel          ;07b6 23 00	:call drawTileLevel
                          ld        (ix+reg_v1), $05        ;07b8 61 05	v1 := 0x5
                          ld        (ix+reg_v2), $3a        ;07ba 62 3a	v2 := 0x3a
                          ld        (ix+reg_v3), $00        ;07bc 63 00	v3 := 0x0
                          call      zdrawTinyString         ;07be 23 de	:call drawTinyString
                          ld        iy, zplayerInitData     ;07c0 a5 6c	i := playerInitData
                          push      bc                      ;07c2 fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_v2), $19        ;07c4 62 19	v2 := 0x19
                          call      zplayerInitDraw         ;07c6 26 4c	:call playerInitDraw
                          ld        iy, zenemydata1         ;07c8 ab db	i := enemydata1
                          push      bc                      ;07ca fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;07cc 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;07ce 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;07d0 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zprintCoords            ;07d2 27 4a	:call printCoords
                          ld        iy, zenemydata2         ;07d4 ab ea	i := enemydata2
                          push      bc                      ;07d6 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;07d8 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;07da 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;07dc 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zprintCoords            ;07de 27 4a	:call printCoords
zlabel0147:               ld        c, $01                  ;07e0 60 01	v0 := 0x1
                          ld        a, c                    ;07e2 e0 a1	if v0 key then
                          call      checkKey
                          jp        z, zscene2              ;07e4 18 57	jump scene2
zskip0148:                ld        c, $02                  ;07e6 60 02	v0 := 0x2
                          ld        a, c                    ;07e8 e0 a1	if v0 key then
                          call      checkKey
                          jp        z, zscene3              ;07ea 19 6d	jump scene3
zskip0149:                ld        c, $03                  ;07ec 60 03	v0 := 0x3
                          ld        a, c                    ;07ee e0 a1	if v0 key then
                          call      checkKey
                          jp        z, zscene4              ;07f0 1a 8b	jump scene4
zskip0150:                call      zplayerProcessKeys      ;07f2 26 06	:call playerProcessKeys
                          ld        (ix+reg_v5), b          ;07f4 85 f0	v5 := vf
                          ld        a, c                    ;07f6 30 01	if v0 != 0x1 then
                          dec       a
                          jp        nz, zscene1cont         ;07f8 18 24	jump scene1cont
zskip0151:                call      zcheckFalling           ;07fa 27 62	:call checkFalling
                          ld        a, (ix+reg_v4)          ;07fc 44 08	if v4 == 0x8 then
                          cp        $08
                          jp        z, zscene1              ;07fe 17 92	jump scene1
zskip0152:                ld        a, (ix+reg_v5)          ;0800 35 01	if v5 != 0x1 then
                          dec       a
                          jp        nz, zscene1cont         ;0802 18 24	jump scene1cont
zskip0153:                ld        iy, zlevel1Objects      ;0804 ae 6d	i := level1Objects
                          call      zcheckCollision         ;0806 2b 29	:call checkCollision
                          ld        a, c                    ;0808 30 02	if v0 != 0x2 then
                          cp        $02
                          jp        nz, zlabel0155          ;080a 18 1e	jump label0155
zskip0154:                ld        (ix+reg_v1), $00        ;080c 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $05        ;080e 62 05	v2 := 0x5
                          ld        (ix+reg_v3), $39        ;0810 63 39	v3 := 0x39
                          call      zdrawTinyString         ;0812 23 de	:call drawTinyString
                          ld        (ix+reg_v1), $00        ;0814 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $0d        ;0816 62 0d	v2 := 0xd
                          ld        (ix+reg_v3), $44        ;0818 63 44	v3 := 0x44
                          call      zdrawTinyString         ;081a 23 de	:call drawTinyString
                          jp        zscene1cont             ;081c 18 24	jump scene1cont
zlabel0155:               ld        a, c                    ;081e 40 01	if v0 == 0x1 then
                          dec       a
                          jp        z, zscene2              ;0820 18 57	jump scene2
zskip0156:                jp        zscene1                 ;0822 17 92	jump scene1
zscene1cont:              ld        iy, zenemydata1         ;0824 ab db	i := enemydata1
                          push      bc                      ;0826 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;0828 22 14	:call calcEnemyCoords
                          call      zprintCoords            ;082a 27 4a	:call printCoords
                          call      zcopyEnemyCoords        ;082c 22 62	:call copyEnemyCoords
                          call      zprintCoords            ;082e 27 4a	:call printCoords
                          ld        iy, zenemydata1         ;0830 ab db	i := enemydata1
                          ld        (ix+reg_v0), c          ;0832 fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0834 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene1              ;0836 17 92	jump scene1
zskip0158:                ld        iy, zenemydata2         ;0838 ab ea	i := enemydata2
                          push      bc                      ;083a fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;083c 22 14	:call calcEnemyCoords
                          call      zprintCoords            ;083e 27 4a	:call printCoords
                          call      zcopyEnemyCoords        ;0840 22 62	:call copyEnemyCoords
                          call      zprintCoords            ;0842 27 4a	:call printCoords
                          ld        iy, zenemydata2         ;0844 ab ea	i := enemydata2
                          ld        (ix+reg_v0), c          ;0846 fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0848 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene1              ;084a 17 92	jump scene1
zskip0159:                call      zredraw                 ;084c 26 7e	:call redraw
                          jp        zlabel0147              ;084e 17 e0	jump label0147
zfuelflag:                db 0x01                           ;;_______█  
zkey1flag:                db 0x01                           ;;_______█  
zkey2flag:                db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zscene2:                  call      clearScreenChip8        ;0857 00 e0	clear
                          call      updateGameScreen
                          ld        c, $01                  ;0859 60 01	v0 := 0x1
                          ld        (ix+reg_v1), $01        ;085b 61 01	v1 := 0x1
                          ld        (ix+reg_v2), $01        ;085d 62 01	v2 := 0x1
                          ld        iy, zfuelflag           ;085f a8 50	i := fuelflag
                          ld        (ix+reg_v0), c          ;0861 f3 55	save v3
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 4
                          add       iy, bc
                          ldir     
                          pop       bc
                          call      clearScreenChip8        ;0863 00 e0	clear
                          call      updateGameScreen
                          ld        (ix+reg_ve), $01        ;0865 6e 01	ve := 0x1
                          ld        (ix+reg_v1), $00        ;0867 61 00	v1 := 0x0
zlabel0164:               ld        iy, zscene2SpriteData   ;0869 ab 81	i := scene2SpriteData
                          ld        d, 0                    ;086b f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        c, (iy)                 ;086d f0 65	load v0
                          inc       iy
                          ld        iy, zenemydata1         ;086f ab db	i := enemydata1
                          ld        d, 0                    ;0871 f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        (iy), c                 ;0873 f0 55	save v0
                          inc       iy
                          inc       (ix+reg_v1)             ;0875 71 01	v1 += 0x1
                          ld        a, (ix+reg_v1)          ;0877 31 1e	if v1 != 0x1e then
                          cp        $1e
                          jp        nz, zlabel0164          ;0879 18 69	jump label0164
zskip0165:                ld        (ix+reg_v9), $ff        ;087b 69 ff	v9 := 0xff
                          call      zdecompressLevelStart   ;087d 22 6c	:call decompressLevelStart
zlabel0166:               ld        a, (ix+reg_v1)          ;087f 41 08	if v1 == 0x8 then
                          cp        $08
                          jp        z, zlabel0168           ;0881 18 89	jump label0168
zskip0167:                ld        iy, zlevel2             ;0883 ae c1	i := level2
                          call      zdecompressByte         ;0885 22 9e	:call decompressByte
                          jp        zlabel0166              ;0887 18 7f	jump label0166
zlabel0168:               call      zdrawTileLevel          ;0889 23 00	:call drawTileLevel
                          ld        (ix+reg_v1), $00        ;088b 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $3a        ;088d 62 3a	v2 := 0x3a
                          ld        (ix+reg_v3), $4e        ;088f 63 4e	v3 := 0x4e
                          call      zdrawTinyString         ;0891 23 de	:call drawTinyString
                          ld        iy, zplayerInitData     ;0893 a5 6c	i := playerInitData
                          push      bc                      ;0895 fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_v2), $11        ;0897 62 11	v2 := 0x11
                          call      zplayerInitDraw         ;0899 26 4c	:call playerInitDraw
                          ld        iy, zenemydata1         ;089b ab db	i := enemydata1
                          push      bc                      ;089d fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;089f 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;08a1 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;08a3 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zdrawToilette           ;08a5 27 4e	:call drawToilette
                          ld        iy, zenemydata2         ;08a7 ab ea	i := enemydata2
                          push      bc                      ;08a9 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;08ab 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;08ad 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;08af 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zdrawToilette           ;08b1 27 4e	:call drawToilette
zlabel0169:               call      zplayerProcessKeys      ;08b3 26 06	:call playerProcessKeys
                          ld        (ix+reg_v5), b          ;08b5 85 f0	v5 := vf
                          ld        a, c                    ;08b7 30 01	if v0 != 0x1 then
                          dec       a
                          jp        nz, zscene2cont         ;08b9 19 41	jump scene2cont
zskip0170:                call      zcheckFalling           ;08bb 27 62	:call checkFalling
                          ld        a, (ix+reg_v4)          ;08bd 44 08	if v4 == 0x8 then
                          cp        $08
                          jp        z, zscene1              ;08bf 17 92	jump scene1
zskip0171:                ld        a, (ix+reg_v5)          ;08c1 35 01	if v5 != 0x1 then
                          dec       a
                          jp        nz, zscene2cont         ;08c3 19 41	jump scene2cont
zskip0172:                ld        iy, zlevel2Objects      ;08c5 ae 88	i := level2Objects
                          call      zcheckCollision         ;08c7 2b 29	:call checkCollision
                          ld        a, c                    ;08c9 30 05	if v0 != 0x5 then
                          cp        $05
                          jp        nz, zlabel0176          ;08cb 18 ff	jump label0176
zskip0173:                ld        iy, zfuelflag           ;08cd a8 50	i := fuelflag
                          ld        c, (iy)                 ;08cf f0 65	load v0
                          inc       iy
                          ld        b, c                    ;08d1 8f 00	vf := v0
                          ld        iy, zfuelflag           ;08d3 a8 50	i := fuelflag
                          ld        c, $00                  ;08d5 60 00	v0 := 0x0
                          ld        (iy), c                 ;08d7 f0 55	save v0
                          inc       iy
                          ld        a, b                    ;08d9 3f 01	if vf != 0x1 then
                          dec       a
                          jp        nz, zlabel0175          ;08db 18 fd	jump label0175
zskip0174:                ld        (ix+reg_v1), $00        ;08dd 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $00        ;08df 62 00	v2 := 0x0
                          ld        c, $07                  ;08e1 60 07	v0 := 0x7
                          call      zdisplayTileSub         ;08e3 22 e8	:call displayTileSub
                          ld        (ix+reg_v1), $08        ;08e5 61 08	v1 := 0x8
                          ld        (ix+reg_v2), $00        ;08e7 62 00	v2 := 0x0
                          ld        c, $08                  ;08e9 60 08	v0 := 0x8
                          call      zdisplayTileSub         ;08eb 22 e8	:call displayTileSub
                          ld        (ix+reg_v1), $00        ;08ed 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $08        ;08ef 62 08	v2 := 0x8
                          ld        c, $09                  ;08f1 60 09	v0 := 0x9
                          call      zdisplayTileSub         ;08f3 22 e8	:call displayTileSub
                          ld        (ix+reg_v1), $08        ;08f5 61 08	v1 := 0x8
                          ld        (ix+reg_v2), $08        ;08f7 62 08	v2 := 0x8
                          ld        c, $0a                  ;08f9 60 0a	v0 := 0xa
                          call      zdisplayTileSub         ;08fb 22 e8	:call displayTileSub
zlabel0175:               jp        zscene2cont             ;08fd 19 41	jump scene2cont
zlabel0176:               ld        a, c                    ;08ff 30 03	if v0 != 0x3 then
                          cp        $03
                          jp        nz, zlabel0180          ;0901 19 1d	jump label0180
zskip0177:                ld        iy, zkey1flag           ;0903 a8 51	i := key1flag
                          ld        c, (iy)                 ;0905 f0 65	load v0
                          inc       iy
                          ld        b, c                    ;0907 8f 00	vf := v0
                          ld        iy, zkey1flag           ;0909 a8 51	i := key1flag
                          ld        c, $00                  ;090b 60 00	v0 := 0x0
                          ld        (iy), c                 ;090d f0 55	save v0
                          inc       iy
                          ld        a, b                    ;090f 3f 01	if vf != 0x1 then
                          dec       a
                          jp        nz, zlabel0179          ;0911 19 1b	jump label0179
zskip0178:                ld        (ix+reg_v1), $48        ;0913 61 48	v1 := 0x48
                          ld        (ix+reg_v2), $00        ;0915 62 00	v2 := 0x0
                          ld        c, $0c                  ;0917 60 0c	v0 := 0xc
                          call      zdisplayTileSub         ;0919 22 e8	:call displayTileSub
zlabel0179:               jp        zscene2cont             ;091b 19 41	jump scene2cont
zlabel0180:               ld        a, c                    ;091d 30 04	if v0 != 0x4 then
                          cp        $04
                          jp        nz, zlabel0184          ;091f 19 3b	jump label0184
zskip0181:                ld        iy, zkey2flag           ;0921 a8 52	i := key2flag
                          ld        c, (iy)                 ;0923 f0 65	load v0
                          inc       iy
                          ld        b, c                    ;0925 8f 00	vf := v0
                          ld        iy, zkey2flag           ;0927 a8 52	i := key2flag
                          ld        c, $00                  ;0929 60 00	v0 := 0x0
                          ld        (iy), c                 ;092b f0 55	save v0
                          inc       iy
                          ld        a, b                    ;092d 3f 01	if vf != 0x1 then
                          dec       a
                          jp        nz, zlabel0183          ;092f 19 39	jump label0183
zskip0182:                ld        (ix+reg_v1), $78        ;0931 61 78	v1 := 0x78
                          ld        (ix+reg_v2), $18        ;0933 62 18	v2 := 0x18
                          ld        c, $0c                  ;0935 60 0c	v0 := 0xc
                          call      zdisplayTileSub         ;0937 22 e8	:call displayTileSub
zlabel0183:               jp        zscene2cont             ;0939 19 41	jump scene2cont
zlabel0184:               ld        a, c                    ;093b 40 01	if v0 == 0x1 then
                          dec       a
                          jp        z, zscene3              ;093d 19 6d	jump scene3
zskip0185:                jp        zscene2                 ;093f 18 57	jump scene2
zscene2cont:              ld        iy, zenemydata1         ;0941 ab db	i := enemydata1
                          push      bc                      ;0943 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;0945 22 14	:call calcEnemyCoords
                          call      zdrawToilette           ;0947 27 4e	:call drawToilette
                          call      zcopyEnemyCoords        ;0949 22 62	:call copyEnemyCoords
                          call      zdrawToilette           ;094b 27 4e	:call drawToilette
                          ld        iy, zenemydata1         ;094d ab db	i := enemydata1
                          ld        (ix+reg_v0), c          ;094f fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0951 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene2              ;0953 18 57	jump scene2
zskip0187:                ld        iy, zenemydata2         ;0955 ab ea	i := enemydata2
                          push      bc                      ;0957 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;0959 22 14	:call calcEnemyCoords
                          call      zdrawToilette           ;095b 27 4e	:call drawToilette
                          call      zcopyEnemyCoords        ;095d 22 62	:call copyEnemyCoords
                          call      zdrawToilette           ;095f 27 4e	:call drawToilette
                          ld        iy, zenemydata2         ;0961 ab ea	i := enemydata2
                          ld        (ix+reg_v0), c          ;0963 fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0965 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene2              ;0967 18 57	jump scene2
zskip0188:                call      zredraw                 ;0969 26 7e	:call redraw
                          jp        zlabel0169              ;096b 18 b3	jump label0169
zscene3:                  call      clearScreenChip8        ;096d 00 e0	clear
                          call      updateGameScreen
                          ld        (ix+reg_v1), $00        ;096f 61 00	v1 := 0x0
zlabel0190:               ld        iy, zscene3SpriteData   ;0971 ab 9f	i := scene3SpriteData
                          ld        d, 0                    ;0973 f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        c, (iy)                 ;0975 f0 65	load v0
                          inc       iy
                          ld        iy, zenemydata1         ;0977 ab db	i := enemydata1
                          ld        d, 0                    ;0979 f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        (iy), c                 ;097b f0 55	save v0
                          inc       iy
                          inc       (ix+reg_v1)             ;097d 71 01	v1 += 0x1
                          ld        a, (ix+reg_v1)          ;097f 31 1e	if v1 != 0x1e then
                          cp        $1e
                          jp        nz, zlabel0190          ;0981 19 71	jump label0190
zskip0191:                ld        (ix+reg_v9), $ff        ;0983 69 ff	v9 := 0xff
                          call      zdecompressLevelStart   ;0985 22 6c	:call decompressLevelStart
zlabel0192:               ld        a, (ix+reg_v1)          ;0987 41 08	if v1 == 0x8 then
                          cp        $08
                          jp        z, zlabel0194           ;0989 19 91	jump label0194
zskip0193:                ld        iy, zlevel3             ;098b ae fe	i := level3
                          call      zdecompressByte         ;098d 22 9e	:call decompressByte
                          jp        zlabel0192              ;098f 19 87	jump label0192
zlabel0194:               call      zdrawTileLevel          ;0991 23 00	:call drawTileLevel
                          ld        (ix+reg_v1), $00        ;0993 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $3a        ;0995 62 3a	v2 := 0x3a
                          ld        (ix+reg_v3), $5f        ;0997 63 5f	v3 := 0x5f
                          call      zdrawTinyString         ;0999 23 de	:call drawTinyString
                          ld        iy, zplayerInitData     ;099b a5 6c	i := playerInitData
                          push      bc                      ;099d fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_v2), $09        ;099f 62 09	v2 := 0x9
                          call      zplayerInitDraw         ;09a1 26 4c	:call playerInitDraw
                          ld        iy, zenemydata1         ;09a3 ab db	i := enemydata1
                          push      bc                      ;09a5 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;09a7 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;09a9 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;09ab 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zdrawStomper            ;09ad 27 56	:call drawStomper
                          ld        iy, zenemydata2         ;09af ab ea	i := enemydata2
                          push      bc                      ;09b1 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;09b3 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;09b5 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;09b7 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zdrawRobo               ;09b9 27 5a	:call drawRobo
zlabel0195:               call      zplayerProcessKeys      ;09bb 26 06	:call playerProcessKeys
                          ld        (ix+reg_v5), b          ;09bd 85 f0	v5 := vf
                          ld        a, (ix+reg_v4)          ;09bf 44 08	if v4 == 0x8 then
                          cp        $08
                          jp        z, zscene3              ;09c1 19 6d	jump scene3
zskip0196:                ld        a, c                    ;09c3 30 01	if v0 != 0x1 then
                          dec       a
                          jp        nz, zscene3cont         ;09c5 19 e7	jump scene3cont
zskip0197:                call      zcheckFalling           ;09c7 27 62	:call checkFalling
                          ld        a, (ix+reg_v4)          ;09c9 44 08	if v4 == 0x8 then
                          cp        $08
                          jp        z, zscene2              ;09cb 18 57	jump scene2
zskip0198:                ld        b, $06                  ;09cd 6f 06	vf := 0x6
                          ld        a, (ix+reg_v3)          ;09cf 8f 37	vf =- v3
                          sub       b
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          or        a                       ;09d1 4f 00	if vf == 0x0 then
                          jp        z, zscene3cont          ;09d3 19 e7	jump scene3cont
zskip0199:                ld        a, (ix+reg_v5)          ;09d5 35 01	if v5 != 0x1 then
                          dec       a
                          jp        nz, zscene3cont         ;09d7 19 e7	jump scene3cont
zskip0200:                ld        iy, zlevel3Objects      ;09d9 ae a9	i := level3Objects
                          call      zcheckCollision         ;09db 2b 29	:call checkCollision
                          ld        a, c                    ;09dd 40 07	if v0 == 0x7 then
                          cp        $07
                          jp        z, zrocketHit           ;09df 1a 13	jump rocketHit
zskip0201:                ld        a, c                    ;09e1 40 01	if v0 == 0x1 then
                          dec       a
                          jp        z, zscene4              ;09e3 1a 8b	jump scene4
zskip0202:                jp        zscene3                 ;09e5 19 6d	jump scene3
zscene3cont:              ld        iy, zenemydata1         ;09e7 ab db	i := enemydata1
                          push      bc                      ;09e9 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;09eb 22 14	:call calcEnemyCoords
                          call      zdrawStomper            ;09ed 27 56	:call drawStomper
                          call      zcopyEnemyCoords        ;09ef 22 62	:call copyEnemyCoords
                          call      zdrawStomper            ;09f1 27 56	:call drawStomper
                          ld        iy, zenemydata1         ;09f3 ab db	i := enemydata1
                          ld        (ix+reg_v0), c          ;09f5 fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;09f7 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene3              ;09f9 19 6d	jump scene3
zskip0204:                ld        iy, zenemydata2         ;09fb ab ea	i := enemydata2
                          push      bc                      ;09fd fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;09ff 22 14	:call calcEnemyCoords
                          call      zdrawRobo               ;0a01 27 5a	:call drawRobo
                          call      zcopyEnemyCoords        ;0a03 22 62	:call copyEnemyCoords
                          call      zdrawRobo               ;0a05 27 5a	:call drawRobo
                          ld        iy, zenemydata2         ;0a07 ab ea	i := enemydata2
                          ld        (ix+reg_v0), c          ;0a09 fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0a0b 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene3              ;0a0d 19 6d	jump scene3
zskip0205:                call      zredraw                 ;0a0f 26 7e	:call redraw
                          jp        zlabel0195              ;0a11 19 bb	jump label0195
zrocketHit:               ld        iy, zplayerData         ;0a13 a5 4e	i := playerData
                          push      bc                      ;0a15 fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        a, (ix+reg_v1)          ;0a17 83 10	v3 := v1
                          ld        (ix+reg_v3), a
                          ld        a, (ix+reg_v2)          ;0a19 84 20	v4 := v2
                          ld        (ix+reg_v4), a
                          ld        a, (ix+reg_v8)          ;0a1b 8a 80	va := v8
                          ld        (ix+reg_va), a
                          call      zdrawPlayer             ;0a1d 26 84	:call drawPlayer
                          ld        (ix+reg_v1), $70        ;0a1f 61 70	v1 := 0x70
                          ld        (ix+reg_v2), $20        ;0a21 62 20	v2 := 0x20
                          ld        c, $12                  ;0a23 60 12	v0 := 0x12
                          call      zdisplayTileSub         ;0a25 22 e8	:call displayTileSub
                          ld        (ix+reg_v1), $78        ;0a27 61 78	v1 := 0x78
                          ld        (ix+reg_v2), $20        ;0a29 62 20	v2 := 0x20
                          ld        c, $13                  ;0a2b 60 13	v0 := 0x13
                          call      zdisplayTileSub         ;0a2d 22 e8	:call displayTileSub
                          ld        (ix+reg_v1), $70        ;0a2f 61 70	v1 := 0x70
                          ld        (ix+reg_v2), $28        ;0a31 62 28	v2 := 0x28
                          ld        c, $14                  ;0a33 60 14	v0 := 0x14
                          call      zdisplayTileSub         ;0a35 22 e8	:call displayTileSub
                          ld        (ix+reg_v1), $78        ;0a37 61 78	v1 := 0x78
                          ld        (ix+reg_v2), $28        ;0a39 62 28	v2 := 0x28
                          ld        c, $15                  ;0a3b 60 15	v0 := 0x15
                          call      zdisplayTileSub         ;0a3d 22 e8	:call displayTileSub
                          ld        (ix+reg_v4), $08        ;0a3f 64 08	v4 := 0x8
                          ld        (ix+reg_v3), $00        ;0a41 63 00	v3 := 0x0
zlabel0207:               call      zdrawRocket             ;0a43 2a 69	:call drawRocket
                          call      zredraw                 ;0a45 26 7e	:call redraw
                          ld        (ix+reg_v5), $00        ;0a47 65 00	v5 := 0x0
zlabel0208:               ld        a, $00                  ;0a49 75 00	v5 += 0x0
                          add       (ix+reg_v5)
                          ld        (ix+reg_v5), a
                          inc       (ix+reg_v5)             ;0a4b 75 01	v5 += 0x1
                          ld        a, (ix+reg_v5)          ;0a4d 35 1e	if v5 != 0x1e then
                          cp        $1e
                          jp        nz, zlabel0208          ;0a4f 1a 49	jump label0208
zskip0209:                call      zdrawRocket             ;0a51 2a 69	:call drawRocket
                          inc       (ix+reg_v3)             ;0a53 73 01	v3 += 0x1
                          ld        a, (ix+reg_v3)          ;0a55 33 1e	if v3 != 0x1e then
                          cp        $1e
                          jp        nz, zlabel0207          ;0a57 1a 43	jump label0207
zskip0210:                ld        iy, zplayerData         ;0a59 a5 4e	i := playerData
                          push      bc                      ;0a5b fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_v1), $68        ;0a5d 61 68	v1 := 0x68
                          ld        (ix+reg_v2), $01        ;0a5f 62 01	v2 := 0x1
                          ld        iy, zplayerData         ;0a61 a5 4e	i := playerData
                          call      zsavePlayerData         ;0a63 25 7e	:call savePlayerData
                          call      zplayerInitDraw         ;0a65 26 4c	:call playerInitDraw
                          jp        zscene3cont             ;0a67 19 e7	jump scene3cont
zdrawRocket:              ld        (ix+reg_v4), $08        ;0a69 64 08	v4 := 0x8
                          ld        iy, zdata0248           ;0a6b ad 8d	i := data0248
                          ld        (ix+reg_v1), $70        ;0a6d 61 70	v1 := 0x70
                          ld        (ix+reg_v2), $20        ;0a6f 62 20	v2 := 0x20
                          ld        a, (ix+reg_v2)          ;0a71 82 35	v2 -= v3
                          sub       (ix+reg_v3)
                          ld        (ix+reg_v2), a
                          ld        a, 0
                          adc       a
                          xor       1
                          ld        b, a
                          push      bc                      ;0a73 d1 28	sprite v1 v2 0x8
                          ld        a, 8
                          ld        b, (ix+reg_v1)
                          ld        c, (ix+reg_v2)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ld        a, $08                  ;0a75 71 08	v1 += 0x8
                          add       (ix+reg_v1)
                          ld        (ix+reg_v1), a
                          ld        d, 0                    ;0a77 f4 1e	i += v4
                          ld        e, (ix+reg_v4)
                          add       iy, de
                          push      bc                      ;0a79 d1 28	sprite v1 v2 0x8
                          ld        a, 8
                          ld        b, (ix+reg_v1)
                          ld        c, (ix+reg_v2)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ld        a, $f8                  ;0a7b 71 f8	v1 += 0xf8
                          add       (ix+reg_v1)
                          ld        (ix+reg_v1), a
                          ld        a, $08                  ;0a7d 72 08	v2 += 0x8
                          add       (ix+reg_v2)
                          ld        (ix+reg_v2), a
                          ld        d, 0                    ;0a7f f4 1e	i += v4
                          ld        e, (ix+reg_v4)
                          add       iy, de
                          push      bc                      ;0a81 d1 28	sprite v1 v2 0x8
                          ld        a, 8
                          ld        b, (ix+reg_v1)
                          ld        c, (ix+reg_v2)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ld        a, $08                  ;0a83 71 08	v1 += 0x8
                          add       (ix+reg_v1)
                          ld        (ix+reg_v1), a
                          ld        d, 0                    ;0a85 f4 1e	i += v4
                          ld        e, (ix+reg_v4)
                          add       iy, de
                          push      bc                      ;0a87 d1 28	sprite v1 v2 0x8
                          ld        a, 8
                          ld        b, (ix+reg_v1)
                          ld        c, (ix+reg_v2)
                          ld        hl, iy
                          call      chip8sprite
                          pop       bc
                          ld        b, (ix+reg_vf)
                          ret                               ;0a89 00 ee	return
zscene4:                  call      clearScreenChip8        ;0a8b 00 e0	clear
                          call      updateGameScreen
                          call      clearScreenChip8        ;0a8d 00 e0	clear
                          call      updateGameScreen
                          ld        (ix+reg_v1), $00        ;0a8f 61 00	v1 := 0x0
zlabel0213:               ld        iy, zscene4SpriteData   ;0a91 ab bd	i := scene4SpriteData
                          ld        d, 0                    ;0a93 f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        c, (iy)                 ;0a95 f0 65	load v0
                          inc       iy
                          ld        iy, zenemydata1         ;0a97 ab db	i := enemydata1
                          ld        d, 0                    ;0a99 f1 1e	i += v1
                          ld        e, (ix+reg_v1)
                          add       iy, de
                          ld        (iy), c                 ;0a9b f0 55	save v0
                          inc       iy
                          inc       (ix+reg_v1)             ;0a9d 71 01	v1 += 0x1
                          ld        a, (ix+reg_v1)          ;0a9f 31 1e	if v1 != 0x1e then
                          cp        $1e
                          jp        nz, zlabel0213          ;0aa1 1a 91	jump label0213
zskip0214:                ld        (ix+reg_v9), $ff        ;0aa3 69 ff	v9 := 0xff
                          call      zdecompressLevelStart   ;0aa5 22 6c	:call decompressLevelStart
zlabel0215:               ld        a, (ix+reg_v1)          ;0aa7 41 08	if v1 == 0x8 then
                          cp        $08
                          jp        z, zlabel0217           ;0aa9 1a b1	jump label0217
zskip0216:                ld        iy, zlevel4             ;0aab af 28	i := level4
                          call      zdecompressByte         ;0aad 22 9e	:call decompressByte
                          jp        zlabel0215              ;0aaf 1a a7	jump label0215
zlabel0217:               call      zdrawTileLevel          ;0ab1 23 00	:call drawTileLevel
                          ld        (ix+reg_v1), $00        ;0ab3 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $34        ;0ab5 62 34	v2 := 0x34
                          ld        (ix+reg_v3), $1a        ;0ab7 63 1a	v3 := 0x1a
                          call      zdrawTinyString         ;0ab9 23 de	:call drawTinyString
                          ld        (ix+reg_v1), $00        ;0abb 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $3a        ;0abd 62 3a	v2 := 0x3a
                          ld        (ix+reg_v3), $2c        ;0abf 63 2c	v3 := 0x2c
                          call      zdrawTinyString         ;0ac1 23 de	:call drawTinyString
                          ld        iy, zplayerInitData     ;0ac3 a5 6c	i := playerInitData
                          push      bc                      ;0ac5 fb 65	load vb
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 12
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_v2), $19        ;0ac7 62 19	v2 := 0x19
                          call      zplayerInitDraw         ;0ac9 26 4c	:call playerInitDraw
                          ld        iy, zenemydata1         ;0acb ab db	i := enemydata1
                          push      bc                      ;0acd fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;0acf 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;0ad1 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;0ad3 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zdrawCellphone          ;0ad5 27 5e	:call drawCellphone
                          ld        iy, zenemydata2         ;0ad7 ab ea	i := enemydata2
                          push      bc                      ;0ad9 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        (ix+reg_vb), c          ;0adb 8b 00	vb := v0
                          ld        a, (ix+reg_v1)          ;0add 8c 10	vc := v1
                          ld        (ix+reg_vc), a
                          ld        a, (ix+reg_v8)          ;0adf 8d 80	vd := v8
                          ld        (ix+reg_vd), a
                          call      zdrawCellphone          ;0ae1 27 5e	:call drawCellphone
zlabel0218:               call      zplayerProcessKeys      ;0ae3 26 06	:call playerProcessKeys
                          ld        (ix+reg_v5), b          ;0ae5 85 f0	v5 := vf
                          call      zloadPlayerData         ;0ae7 25 78	:call loadPlayerData
                          ld        a, c                    ;0ae9 30 01	if v0 != 0x1 then
                          dec       a
                          jp        nz, zlabel0222          ;0aeb 1a fd	jump label0222
zskip0219:                call      zcheckFalling           ;0aed 27 62	:call checkFalling
                          ld        a, (ix+reg_v5)          ;0aef 35 01	if v5 != 0x1 then
                          dec       a
                          jp        nz, zlabel0222          ;0af1 1a fd	jump label0222
zskip0220:                ld        iy, zlevel4Objects      ;0af3 ae b8	i := level4Objects
                          call      zcheckCollision         ;0af5 2b 29	:call checkCollision
                          ld        a, c                    ;0af7 40 01	if v0 == 0x1 then
                          dec       a
                          jp        z, zendofgame           ;0af9 1b 3d	jump endofgame
zskip0221:                jp        zscene4                 ;0afb 1a 8b	jump scene4
zlabel0222:               ld        iy, zenemydata1         ;0afd ab db	i := enemydata1
                          push      bc                      ;0aff fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;0b01 22 14	:call calcEnemyCoords
                          call      zdrawCellphone          ;0b03 27 5e	:call drawCellphone
                          call      zcopyEnemyCoords        ;0b05 22 62	:call copyEnemyCoords
                          call      zdrawCellphone          ;0b07 27 5e	:call drawCellphone
                          ld        iy, zenemydata1         ;0b09 ab db	i := enemydata1
                          ld        (ix+reg_v0), c          ;0b0b fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0b0d 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene4              ;0b0f 1a 8b	jump scene4
zskip0223:                ld        iy, zenemydata2         ;0b11 ab ea	i := enemydata2
                          push      bc                      ;0b13 fe 65	load ve
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          call      zcalcEnemyCoords        ;0b15 22 14	:call calcEnemyCoords
                          call      zdrawCellphone          ;0b17 27 5e	:call drawCellphone
                          call      zcopyEnemyCoords        ;0b19 22 62	:call copyEnemyCoords
                          call      zdrawCellphone          ;0b1b 27 5e	:call drawCellphone
                          ld        iy, zenemydata2         ;0b1d ab ea	i := enemydata2
                          ld        (ix+reg_v0), c          ;0b1f fe 55	save ve
                          push      bc
                          ld        hl, ix
                          ld        de, iy
                          ld        bc, 15
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        a, b                    ;0b21 4f 01	if vf == 0x1 then
                          dec       a
                          jp        z, zscene4              ;0b23 1a 8b	jump scene4
zskip0224:                call      zredraw                 ;0b25 26 7e	:call redraw
                          jp        zlabel0218              ;0b27 1a e3	jump label0218
zcheckCollision:          push      bc                      ;0b29 f2 65	load v2
                          ld        de, ix
                          ld        hl, iy
                          ld        bc, 3
                          add       iy, bc
                          ldir     
                          pop       bc
                          ld        c, (ix+reg_v0)
                          ld        a, c                    ;0b2b 40 ff	if v0 == 0xff then
                          cp        $ff
                          jr        nz, zskip0226
                          ret                               ;0b2d 00 ee	return
zskip0226:                ld        a, c                    ;0b2f 50 30	if v0 != v3 then
                          cp        (ix+reg_v3)
                          jp        nz, zlabel0229          ;0b31 1b 3b	jump label0229
zskip0227:                ld        a, (ix+reg_v1)          ;0b33 51 40	if v1 != v4 then
                          cp        (ix+reg_v4)
                          jp        nz, zlabel0229          ;0b35 1b 3b	jump label0229
zskip0228:                ld        a, (ix+reg_v2)          ;0b37 80 20	v0 := v2
                          ld        c, a
                          ret                               ;0b39 00 ee	return
zlabel0229:               jp        zcheckCollision         ;0b3b 1b 29	jump checkCollision
zendofgame:               call      clearScreenChip8        ;0b3d 00 e0	clear
                          call      updateGameScreen
                          ld        (ix+reg_v1), $00        ;0b3f 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $0a        ;0b41 62 0a	v2 := 0xa
                          ld        (ix+reg_v3), $77        ;0b43 63 77	v3 := 0x77
                          call      zdrawTinyString         ;0b45 23 de	:call drawTinyString
                          ld        (ix+reg_v1), $00        ;0b47 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $12        ;0b49 62 12	v2 := 0x12
                          ld        (ix+reg_v3), $82        ;0b4b 63 82	v3 := 0x82
                          call      zdrawTinyString         ;0b4d 23 de	:call drawTinyString
                          ld        (ix+reg_v1), $00        ;0b4f 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $1a        ;0b51 62 1a	v2 := 0x1a
                          ld        (ix+reg_v3), $8e        ;0b53 63 8e	v3 := 0x8e
                          call      zdrawTinyString         ;0b55 23 de	:call drawTinyString
                          ld        (ix+reg_v1), $00        ;0b57 61 00	v1 := 0x0
                          ld        (ix+reg_v2), $22        ;0b59 62 22	v2 := 0x22
                          ld        (ix+reg_v3), $9a        ;0b5b 63 9a	v3 := 0x9a
                          call      zdrawTinyString         ;0b5d 23 de	:call drawTinyString
                          call      GetKey                  ;0b5f f0 0a	v0 := key
                          ld        c, a
                          jp        zscene1                 ;0b61 17 92	jump scene1
zscene1SpriteData:        db 0x30                           ;;__██     0
                          db 0x0f                           ;;____████  
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x28                           ;;__█ █    (
                          db 0x04                           ;;_____█    
                          db 0x00                           ;;_______   
                          db 0x24                           ;;__█  █   $
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zinitEnemyData1:          db 0x60                           ;;_██      `
                          db 0x08                           ;;____█     
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x28                           ;;__█ █    (
                          db 0x00                           ;;_______   
                          db 0x24                           ;;__█  █   $
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zscene2SpriteData:        db 0x2d                           ;;__█ ██ █ -
                          db 0x15                           ;;___█ █ █  
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x23                           ;;__█   ██ #
                          db 0x46                           ;;_█   ██  F
                          db 0x09                           ;;____█  █  
                          db 0x1e                           ;;___████   
                          db 0x00                           ;;_______   
                          db 0x48                           ;;_█  █    H
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x60                           ;;_██      `
                          db 0x08                           ;;____█     
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x7f                           ;;_███████ 
                          db 0x08                           ;;____█     
                          db 0x28                           ;;__█ █    (
                          db 0x00                           ;;_______   
                          db 0x48                           ;;_█  █    H
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zscene3SpriteData:        db 0x45                           ;;_█   █ █ E
                          db 0x24                           ;;__█  █   $
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x40                           ;;_█       @
                          db 0x60                           ;;_██      `
                          db 0x09                           ;;____█  █  
                          db 0x26                           ;;__█  ██  &
                          db 0x00                           ;;_______   
                          db 0x24                           ;;__█  █   $
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x30                           ;;__██     0
                          db 0x0a                           ;;____█ █   
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x80                           ;;█         
                          db 0x08                           ;;____█     
                          db 0x28                           ;;__█ █    (
                          db 0x00                           ;;_______   
                          db 0x24                           ;;__█  █   $
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zscene4SpriteData:        db 0x5a                           ;;_█ ██ █  Z
                          db 0x0a                           ;;____█ █   
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x44                           ;;_█   █   D
                          db 0x6e                           ;;_██ ███  n
                          db 0x01                           ;;_______█  
                          db 0x19                           ;;___██  █  
                          db 0x00                           ;;_______   
                          db 0x24                           ;;__█  █   $
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x1e                           ;;___████   
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x06                           ;;_____██   
                          db 0x32                           ;;__██  █  2
                          db 0x00                           ;;_______   
                          db 0x15                           ;;___█ █ █  
                          db 0x00                           ;;_______   
                          db 0x24                           ;;__█  █   $
                          db 0x0c                           ;;____██    
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zenemydata1:              db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zenemydata2:              db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zsavedata:                db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
ztemp:                    db 0x00                           ;;_______   
zamoebetron0:             db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x12                           ;;___█  █   
                          db 0x6d                           ;;_██ ██ █ m
                          db 0xc9                           ;;██  █  █  
                          db 0xf2                           ;;████  █   
                          db 0xbc                           ;;█ ████    
                          db 0xb8                           ;;█ ███     
                          db 0x58                           ;;_█ ██    X
                          db 0x14                           ;;___█ █    
                          db 0x14                           ;;___█ █    
                          db 0x24                           ;;__█  █   $
zamoebetron1:             db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x6c                           ;;_██ ██   l
                          db 0x49                           ;;_█  █  █ I
                          db 0x72                           ;;_███  █  r
                          db 0xbc                           ;;█ ████    
                          db 0xb8                           ;;█ ███     
                          db 0x58                           ;;_█ ██    X
                          db 0x14                           ;;___█ █    
                          db 0x14                           ;;___█ █    
                          db 0x24                           ;;__█  █   $
zamoebetron2:             db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xc8                           ;;██  █     
                          db 0x48                           ;;_█  █    H
                          db 0x48                           ;;_█  █    H
                          db 0x70                           ;;_███     p
                          db 0x3c                           ;;__████   <
                          db 0x3a                           ;;__███ █  :
                          db 0x58                           ;;_█ ██    X
                          db 0x54                           ;;_█ █ █   T
                          db 0x92                           ;;█  █  █   
                          db 0x10                           ;;___█      
ztoilette:                db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
                          db 0x04                           ;;_____█    
                          db 0x04                           ;;_____█    
                          db 0x02                           ;;______█   
                          db 0x02                           ;;______█   
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
                          db 0x10                           ;;___█      
                          db 0x08                           ;;____█     
                          db 0x04                           ;;_____█    
                          db 0x02                           ;;______█   
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
                          db 0xc0                           ;;██        
                          db 0x30                           ;;__██     0
                          db 0x0c                           ;;____██    
                          db 0x02                           ;;______█   
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x1c                           ;;___███    
                          db 0x02                           ;;______█   
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xe0                           ;;███       
                          db 0x1e                           ;;___████   
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xfe                           ;;███████   
                          db 0xfd                           ;;██████ █  
                          db 0xff                           ;;████████  
                          db 0xfc                           ;;██████    
                          db 0x76                           ;;_███ ██  v
                          db 0x79                           ;;_████  █ y
                          db 0x39                           ;;__███  █ 9
                          db 0x39                           ;;__███  █ 9
                          db 0x00                           ;;_______   
zstomper:                 db 0x00                           ;;_______   
                          db 0x38                           ;;__███    8
                          db 0x74                           ;;_███ █   t
                          db 0xfe                           ;;███████   
                          db 0xe0                           ;;███       
                          db 0xe0                           ;;███       
                          db 0xfe                           ;;███████   
                          db 0x7e                           ;;_██████  ~
                          db 0x28                           ;;__█ █    (
                          db 0x28                           ;;__█ █    (
                          db 0x28                           ;;__█ █    (
                          db 0x7e                           ;;_██████  ~
                          db 0x00                           ;;_______   
                          db 0x38                           ;;__███    8
                          db 0x74                           ;;_███ █   t
                          db 0xfe                           ;;███████   
                          db 0xe0                           ;;███       
                          db 0xfc                           ;;██████    
                          db 0xfe                           ;;███████   
                          db 0x7e                           ;;_██████  ~
                          db 0x28                           ;;__█ █    (
                          db 0x28                           ;;__█ █    (
                          db 0x7e                           ;;_██████  ~
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x38                           ;;__███    8
                          db 0x74                           ;;_███ █   t
                          db 0xfe                           ;;███████   
                          db 0xf8                           ;;█████     
                          db 0xfc                           ;;██████    
                          db 0xfe                           ;;███████   
                          db 0x7e                           ;;_██████  ~
                          db 0x28                           ;;__█ █    (
                          db 0x7e                           ;;_██████  ~
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zrobo:                    db 0x38                           ;;__███    8
                          db 0x6a                           ;;_██ █ █  j
                          db 0x7e                           ;;_██████  ~
                          db 0x3e                           ;;__█████  >
                          db 0x12                           ;;___█  █   
                          db 0xb8                           ;;█ ███     
                          db 0xb8                           ;;█ ███     
                          db 0xfc                           ;;██████    
                          db 0xa0                           ;;█ █       
                          db 0xbc                           ;;█ ████    
                          db 0x38                           ;;__███    8
                          db 0x18                           ;;___██     
                          db 0x38                           ;;__███    8
                          db 0x6a                           ;;_██ █ █  j
                          db 0x7e                           ;;_██████  ~
                          db 0x3e                           ;;__█████  >
                          db 0x12                           ;;___█  █   
                          db 0x38                           ;;__███    8
                          db 0xb8                           ;;█ ███     
                          db 0xfc                           ;;██████    
                          db 0xa0                           ;;█ █       
                          db 0x3c                           ;;__████   <
                          db 0x38                           ;;__███    8
                          db 0x18                           ;;___██     
                          db 0x38                           ;;__███    8
                          db 0x6a                           ;;_██ █ █  j
                          db 0x7e                           ;;_██████  ~
                          db 0x3e                           ;;__█████  >
                          db 0x12                           ;;___█  █   
                          db 0x38                           ;;__███    8
                          db 0x38                           ;;__███    8
                          db 0xfc                           ;;██████    
                          db 0x30                           ;;__██     0
                          db 0x3c                           ;;__████   <
                          db 0x38                           ;;__███    8
                          db 0x18                           ;;___██     
zcellphone:               db 0x04                           ;;_____█    
                          db 0x3e                           ;;__█████  >
                          db 0x41                           ;;_█     █ A
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x3e                           ;;__█████  >
                          db 0x04                           ;;_____█    
                          db 0x3e                           ;;__█████  >
                          db 0x41                           ;;_█     █ A
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x49                           ;;_█  █  █ I
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x3e                           ;;__█████  >
                          db 0x04                           ;;_____█    
                          db 0x3e                           ;;__█████  >
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x49                           ;;_█  █  █ I
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x3e                           ;;__█████  >
                          db 0x04                           ;;_____█    
                          db 0x3e                           ;;__█████  >
                          db 0x4b                           ;;_█  █ ██ K
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x3e                           ;;__█████  >
                          db 0x04                           ;;_____█    
                          db 0x3e                           ;;__█████  >
                          db 0x4b                           ;;_█  █ ██ K
                          db 0x55                           ;;_█ █ █ █ U
                          db 0x41                           ;;_█     █ A
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x5d                           ;;_█ ███ █ ]
                          db 0x41                           ;;_█     █ A
                          db 0x41                           ;;_█     █ A
                          db 0x3e                           ;;__█████  >
zscenesprites:            db 0xaa                           ;;█ █ █ █   
                          db 0x55                           ;;_█ █ █ █ U
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x55                           ;;_█ █ █ █ U
                          db 0xaa                           ;;█ █ █ █   
                          db 0x55                           ;;_█ █ █ █ U
                          db 0xaa                           ;;█ █ █ █   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x1f                           ;;___█████  
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x1c                           ;;___███    
                          db 0x14                           ;;___█ █    
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x10                           ;;___█      
                          db 0x1f                           ;;___█████  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x92                           ;;█  █  █   
                          db 0x54                           ;;_█ █ █   T
                          db 0x28                           ;;__█ █    (
                          db 0x10                           ;;___█      
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xff                           ;;████████  
                          db 0x80                           ;;█         
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xff                           ;;████████  
                          db 0x01                           ;;_______█  
                          db 0xb5                           ;;█ ██ █ █  
                          db 0xa5                           ;;█ █  █ █  
                          db 0xb5                           ;;█ ██ █ █  
                          db 0xa5                           ;;█ █  █ █  
                          db 0xa7                           ;;█ █  ███  
                          db 0x80                           ;;█         
                          db 0xff                           ;;████████  
                          db 0x00                           ;;_______   
                          db 0x69                           ;;_██ █  █ i
                          db 0x49                           ;;_█  █  █ I
                          db 0x69                           ;;_██ █  █ i
                          db 0x49                           ;;_█  █  █ I
                          db 0x6d                           ;;_██ ██ █ m
                          db 0x01                           ;;_______█  
                          db 0xff                           ;;████████  
                          db 0x00                           ;;_______   
                          db 0x81                           ;;█      █  
                          db 0x42                           ;;_█    █  B
                          db 0x24                           ;;__█  █   $
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0x24                           ;;__█  █   $
                          db 0x42                           ;;_█    █  B
                          db 0x81                           ;;█      █  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xa2                           ;;█ █   █   
                          db 0xe5                           ;;███  █ █  
                          db 0xfd                           ;;██████ █  
                          db 0x05                           ;;_____█ █  
                          db 0x02                           ;;______█   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x22                           ;;__█   █  "
                          db 0x22                           ;;__█   █  "
                          db 0x2a                           ;;__█ █ █  *
                          db 0x2a                           ;;__█ █ █  *
                          db 0x2a                           ;;__█ █ █  *
                          db 0x1f                           ;;___█████  
                          db 0x20                           ;;__█       
                          db 0x7f                           ;;_███████ 
                          db 0x79                           ;;_████  █ y
                          db 0x76                           ;;_███ ██  v
                          db 0x7f                           ;;_███████ 
                          db 0x7e                           ;;_██████  ~
                          db 0x7d                           ;;_█████ █ }
                          db 0xfe                           ;;███████   
                          db 0x06                           ;;_____██   
                          db 0xfa                           ;;█████ █   
                          db 0xfa                           ;;█████ █   
                          db 0xfa                           ;;█████ █   
                          db 0x7a                           ;;_████ █  z
                          db 0xfa                           ;;█████ █   
                          db 0xfa                           ;;█████ █   
                          db 0x7d                           ;;_█████ █ }
                          db 0x7f                           ;;_███████ 
                          db 0x7d                           ;;_█████ █ }
                          db 0x7f                           ;;_███████ 
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xfa                           ;;█████ █   
                          db 0xfa                           ;;█████ █   
                          db 0xfc                           ;;██████    
                          db 0xf8                           ;;█████     
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
zdata0248:                db 0x01                           ;;_______█  
                          db 0x03                           ;;______██  
                          db 0x03                           ;;______██  
                          db 0x07                           ;;_____███  
                          db 0x07                           ;;_____███  
                          db 0x07                           ;;_____███  
                          db 0x07                           ;;_____███  
                          db 0x07                           ;;_____███  
                          db 0x00                           ;;_______   
                          db 0x80                           ;;█         
                          db 0x80                           ;;█         
                          db 0xc0                           ;;██        
                          db 0xc0                           ;;██        
                          db 0xc0                           ;;██        
                          db 0xc0                           ;;██        
                          db 0xc0                           ;;██        
                          db 0x07                           ;;_____███  
                          db 0x07                           ;;_____███  
                          db 0x06                           ;;_____██   
                          db 0x0c                           ;;____██    
                          db 0x0c                           ;;____██    
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0xc0                           ;;██        
                          db 0xc0                           ;;██        
                          db 0xc0                           ;;██        
                          db 0x60                           ;;_██      `
                          db 0x70                           ;;_███     p
                          db 0x30                           ;;__██     0
                          db 0x30                           ;;__██     0
                          db 0x30                           ;;__██     0
zplayerSprite:            db 0x06                           ;;_____██   
                          db 0x3e                           ;;__█████  >
                          db 0x7c                           ;;_█████   |
                          db 0x34                           ;;__██ █   4
                          db 0x3e                           ;;__█████  >
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x6e                           ;;_██ ███  n
                          db 0x6e                           ;;_██ ███  n
                          db 0x6e                           ;;_██ ███  n
                          db 0x76                           ;;_███ ██  v
                          db 0x3c                           ;;__████   <
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0x1c                           ;;___███    
                          db 0x06                           ;;_____██   
                          db 0x3e                           ;;__█████  >
                          db 0x7c                           ;;_█████   |
                          db 0x34                           ;;__██ █   4
                          db 0x3e                           ;;__█████  >
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x7e                           ;;_██████  ~
                          db 0x7e                           ;;_██████  ~
                          db 0xf7                           ;;████ ███  
                          db 0xfb                           ;;█████ ██  
                          db 0x3c                           ;;__████   <
                          db 0x76                           ;;_███ ██  v
                          db 0x6e                           ;;_██ ███  n
                          db 0x77                           ;;_███ ███ w
                          db 0x06                           ;;_____██   
                          db 0x3e                           ;;__█████  >
                          db 0x7c                           ;;_█████   |
                          db 0x34                           ;;__██ █   4
                          db 0x3e                           ;;__█████  >
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x7e                           ;;_██████  ~
                          db 0x7e                           ;;_██████  ~
                          db 0xf7                           ;;████ ███  
                          db 0xbb                           ;;█ ███ ██  
                          db 0x3e                           ;;__█████  >
                          db 0x66                           ;;_██  ██  f
                          db 0xc7                           ;;██   ███  
                          db 0xe3                           ;;███   ██  
                          db 0x06                           ;;_____██   
                          db 0x3e                           ;;__█████  >
                          db 0x7c                           ;;_█████   |
                          db 0x34                           ;;__██ █   4
                          db 0x3e                           ;;__█████  >
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x7e                           ;;_██████  ~
                          db 0x7e                           ;;_██████  ~
                          db 0xf7                           ;;████ ███  
                          db 0xfb                           ;;█████ ██  
                          db 0x3c                           ;;__████   <
                          db 0x76                           ;;_███ ██  v
                          db 0x6e                           ;;_██ ███  n
                          db 0x77                           ;;_███ ███ w
                          db 0x06                           ;;_____██   
                          db 0x3e                           ;;__█████  >
                          db 0x7c                           ;;_█████   |
                          db 0x34                           ;;__██ █   4
                          db 0x3e                           ;;__█████  >
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x6e                           ;;_██ ███  n
                          db 0x6e                           ;;_██ ███  n
                          db 0x6e                           ;;_██ ███  n
                          db 0x76                           ;;_███ ██  v
                          db 0x3c                           ;;__████   <
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0x1c                           ;;___███    
zplayerReverseSprite:     db 0x60                           ;;_██      `
                          db 0x7c                           ;;_█████   |
                          db 0x3e                           ;;__█████  >
                          db 0x2c                           ;;__█ ██   ,
                          db 0x7c                           ;;_█████   |
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x76                           ;;_███ ██  v
                          db 0x76                           ;;_███ ██  v
                          db 0x76                           ;;_███ ██  v
                          db 0x6e                           ;;_██ ███  n
                          db 0x3c                           ;;__████   <
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0x38                           ;;__███    8
                          db 0x60                           ;;_██      `
                          db 0x7c                           ;;_█████   |
                          db 0x3e                           ;;__█████  >
                          db 0x2c                           ;;__█ ██   ,
                          db 0x7c                           ;;_█████   |
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x7e                           ;;_██████  ~
                          db 0x7e                           ;;_██████  ~
                          db 0xef                           ;;███ ████  
                          db 0xdf                           ;;██ █████  
                          db 0x3c                           ;;__████   <
                          db 0x6e                           ;;_██ ███  n
                          db 0x76                           ;;_███ ██  v
                          db 0xee                           ;;███ ███   
                          db 0x60                           ;;_██      `
                          db 0x7c                           ;;_█████   |
                          db 0x3e                           ;;__█████  >
                          db 0x2c                           ;;__█ ██   ,
                          db 0x7c                           ;;_█████   |
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x7e                           ;;_██████  ~
                          db 0x7e                           ;;_██████  ~
                          db 0xef                           ;;███ ████  
                          db 0xdd                           ;;██ ███ █  
                          db 0x7c                           ;;_█████   |
                          db 0x66                           ;;_██  ██  f
                          db 0xe3                           ;;███   ██  
                          db 0xc7                           ;;██   ███  
                          db 0x60                           ;;_██      `
                          db 0x7c                           ;;_█████   |
                          db 0x3e                           ;;__█████  >
                          db 0x2c                           ;;__█ ██   ,
                          db 0x7c                           ;;_█████   |
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x7e                           ;;_██████  ~
                          db 0x7e                           ;;_██████  ~
                          db 0xef                           ;;███ ████  
                          db 0xdf                           ;;██ █████  
                          db 0x3c                           ;;__████   <
                          db 0x6e                           ;;_██ ███  n
                          db 0x76                           ;;_███ ██  v
                          db 0xee                           ;;███ ███   
                          db 0x60                           ;;_██      `
                          db 0x7c                           ;;_█████   |
                          db 0x3e                           ;;__█████  >
                          db 0x2c                           ;;__█ ██   ,
                          db 0x7c                           ;;_█████   |
                          db 0x18                           ;;___██     
                          db 0x3c                           ;;__████   <
                          db 0x76                           ;;_███ ██  v
                          db 0x76                           ;;_███ ██  v
                          db 0x76                           ;;_███ ██  v
                          db 0x6e                           ;;_██ ███  n
                          db 0x3c                           ;;__████   <
                          db 0x18                           ;;___██     
                          db 0x18                           ;;___██     
                          db 0x38                           ;;__███    8
zlevel1:                  db 0xfe                           ;;███████   
                          db 0x09                           ;;____█  █  
                          db 0x0e                           ;;____███   
                          db 0x0f                           ;;____████  
                          db 0xff                           ;;████████  
                          db 0xfe                           ;;███████   
                          db 0x09                           ;;____█  █  
                          db 0x10                           ;;___█      
                          db 0x11                           ;;___█   █  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xfe                           ;;███████   
                          db 0x0f                           ;;____████  
                          db 0x04                           ;;_____█    
                          db 0xfe                           ;;███████   
                          db 0x03                           ;;______██  
                          db 0x06                           ;;_____██   
                          db 0xfe                           ;;███████   
                          db 0x05                           ;;_____█ █  
                          db 0x06                           ;;_____██   
                          db 0xfe                           ;;███████   
                          db 0x05                           ;;_____█ █  
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
zlevel1Objects:           db 0x05                           ;;_____█ █  
                          db 0x05                           ;;_____█ █  
                          db 0x00                           ;;_______   
                          db 0x06                           ;;_____██   
                          db 0x05                           ;;_____█ █  
                          db 0x00                           ;;_______   
                          db 0x0f                           ;;____████  
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0x09                           ;;____█  █  
                          db 0x03                           ;;______██  
                          db 0x02                           ;;______█   
                          db 0x09                           ;;____█  █  
                          db 0x05                           ;;_____█ █  
                          db 0x02                           ;;______█   
                          db 0x0a                           ;;____█ █   
                          db 0x03                           ;;______██  
                          db 0x02                           ;;______█   
                          db 0x0a                           ;;____█ █   
                          db 0x05                           ;;_____█ █  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x05                           ;;_____█ █  
                          db 0x00                           ;;_______   
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
zlevel2Objects:           db 0x00                           ;;_______   
                          db 0x03                           ;;______██  
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0x03                           ;;______██  
                          db 0x05                           ;;_____█ █  
                          db 0x0e                           ;;____███   
                          db 0x04                           ;;_____█    
                          db 0x04                           ;;_____█    
                          db 0x0f                           ;;____████  
                          db 0x04                           ;;_____█    
                          db 0x04                           ;;_____█    
                          db 0x09                           ;;____█  █  
                          db 0x02                           ;;______█   
                          db 0x03                           ;;______██  
                          db 0x09                           ;;____█  █  
                          db 0x03                           ;;______██  
                          db 0x03                           ;;______██  
                          db 0x0a                           ;;____█ █   
                          db 0x02                           ;;______█   
                          db 0x03                           ;;______██  
                          db 0x0a                           ;;____█ █   
                          db 0x03                           ;;______██  
                          db 0x03                           ;;______██  
                          db 0x0f                           ;;____████  
                          db 0x07                           ;;_____███  
                          db 0x01                           ;;_______█  
                          db 0x0f                           ;;____████  
                          db 0x06                           ;;_____██   
                          db 0x01                           ;;_______█  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
zlevel3Objects:           db 0x0e                           ;;____███   
                          db 0x06                           ;;_____██   
                          db 0x07                           ;;_____███  
                          db 0x0e                           ;;____███   
                          db 0x05                           ;;_____█ █  
                          db 0x07                           ;;_____███  
                          db 0x0e                           ;;____███   
                          db 0x02                           ;;______█   
                          db 0x01                           ;;_______█  
                          db 0x0f                           ;;____████  
                          db 0x02                           ;;______█   
                          db 0x01                           ;;_______█  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
zlevel4Objects:           db 0x0f                           ;;____████  
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0x0f                           ;;____████  
                          db 0x04                           ;;_____█    
                          db 0x01                           ;;_______█  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
zlevel2:                  db 0x07                           ;;_____███  
                          db 0x08                           ;;____█     
                          db 0xfe                           ;;███████   
                          db 0x07                           ;;_____███  
                          db 0x0c                           ;;____██    
                          db 0xff                           ;;████████  
                          db 0x09                           ;;____█  █  
                          db 0x0a                           ;;____█ █   
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x06                           ;;_____██   
                          db 0xfe                           ;;███████   
                          db 0x0c                           ;;____██    
                          db 0x0c                           ;;____██    
                          db 0xfd                           ;;██████ █  
                          db 0x04                           ;;_____█    
                          db 0x01                           ;;_______█  
                          db 0x03                           ;;______██  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xfd                           ;;██████ █  
                          db 0x05                           ;;_____█ █  
                          db 0x02                           ;;______█   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x02                           ;;______█   
                          db 0x02                           ;;______█   
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0xfe                           ;;███████   
                          db 0x03                           ;;______██  
                          db 0x0b                           ;;____█ ██  
                          db 0xfe                           ;;███████   
                          db 0x03                           ;;______██  
                          db 0x0b                           ;;____█ ██  
                          db 0xfe                           ;;███████   
                          db 0x05                           ;;_____█ █  
                          db 0x04                           ;;_____█    
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x06                           ;;_____██   
                          db 0xfe                           ;;███████   
                          db 0x03                           ;;______██  
                          db 0x05                           ;;_____█ █  
                          db 0xfe                           ;;███████   
                          db 0x0b                           ;;____█ ██  
                          db 0xfd                           ;;██████ █  
                          db 0x04                           ;;_____█    
                          db 0x01                           ;;_______█  
                          db 0x03                           ;;______██  
zlevel3:                  db 0xfe                           ;;███████   
                          db 0x0f                           ;;____████  
                          db 0x04                           ;;_____█    
                          db 0xfe                           ;;███████   
                          db 0x0f                           ;;____████  
                          db 0x05                           ;;_____█ █  
                          db 0xfe                           ;;███████   
                          db 0x0d                           ;;____██ █  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x02                           ;;______█   
                          db 0x03                           ;;______██  
                          db 0xff                           ;;████████  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0x01                           ;;_______█  
                          db 0x02                           ;;______█   
                          db 0x03                           ;;______██  
                          db 0xfe                           ;;███████   
                          db 0x09                           ;;____█  █  
                          db 0x12                           ;;___█  █   
                          db 0x13                           ;;___█  ██  
                          db 0xfe                           ;;███████   
                          db 0x04                           ;;_____█    
                          db 0x02                           ;;______█   
                          db 0x02                           ;;______█   
                          db 0xfe                           ;;███████   
                          db 0x08                           ;;____█     
                          db 0x14                           ;;___█ █    
                          db 0x15                           ;;___█ █ █  
                          db 0xfe                           ;;███████   
                          db 0x07                           ;;_____███  
                          db 0x02                           ;;______█   
                          db 0x02                           ;;______█   
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xfd                           ;;██████ █  
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0xff                           ;;████████  
zlevel4:                  db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xff                           ;;████████  
                          db 0xfe                           ;;███████   
                          db 0x0f                           ;;____████  
                          db 0x04                           ;;_____█    
                          db 0xfe                           ;;███████   
                          db 0x07                           ;;_____███  
                          db 0x06                           ;;_____██   
                          db 0x06                           ;;_____██   
                          db 0xfe                           ;;███████   
                          db 0x06                           ;;_____██   
                          db 0x05                           ;;_____█ █  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xfd                           ;;██████ █  
                          db 0x06                           ;;_____██   
                          db 0x01                           ;;_______█  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0x01                           ;;_______█  
                          db 0xfe                           ;;███████   
                          db 0x0b                           ;;____█ ██  
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x00                           ;;_______   
                          db 0xfe                           ;;███████   
                          db 0x0a                           ;;____█ █   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
                          db 0x0b                           ;;____█ ██  
                          db 0x00                           ;;_______   
