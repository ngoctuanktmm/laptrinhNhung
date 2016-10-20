; Khai bao doan du lieu
    AREA    RESET,  DATA,   READONLY
        DCD     0x20001000
        DCD     START
        
; Khai bao vung nho cho Matrix
matrix
        DCD     1,  2,  3,  4
        DCD     5,  6,  7,  8
        DCD     9,  10, 11, 12
        DCD     13, 14, 15, 16
        
SO_PT    EQU    16        
        
; Khai bao doan code
    AREA    MYCODE, CODE,   READONLY
        ENTRY
      
;----------------------------------------------------      
;
;   DEM SO PHAN TU LA SO NGUYEN TO TRONG
;                MA TRAN
;
;----------------------------------------------------
        
START   
    
    
    LDR     R0, =matrix     ; R0 chua dia chi phan tu dau tien trong matrix
    LDR     R1, =SO_PT      ; R1 = 16    
    MOV     R2, #0          ; count = 0
    MOV     R5, #0          ; i = 0
    
LAP
    LDR     R3, [R0]        ; Lay gia tri cua phan tu hien tai
    MOV     R4, R3          ; R4 = R3
    
    CMP     R4, #1          ; So sanh R4 voi 1
    BEQ     tangCS          ; R4 == 1 => tang chi so -> den phan tu tiep theo
    
    CMP     R4, #2          ; So sanh R4 voi 2
    BEQ     COUNT           ; R4 == 2 => day la so Nguyen to -> dem ++
    ; Neu khong kiem tra Truong hop R4 = 2 thi sau khi thuc hien chia,
    ; so du cua phep chia la 0 (2-2 = 0) -> chuong trinh tu chuyen den phan tu tiep theo -> count == count
    ; Dieu nay la sai vi 2 la so Nguyen to
    
    
kiemTraNT
    MOV     R6, #2          ; R6 = 2

chia
    CMP     R4, R6          ; So sanh R4 voi R6
    BLT     ketThucChia     ; Neu R4 < R6 (du < so chia) thi dung chia
    SUB     R4, R6          ; R4 = R4 - R6
    B       chia
    
ketThucChia    
    CMP     R4, #0          ; So sanh R4 voi 0
    BEQ     tangCS          ; Neu R4 = 0 (du = 0) -> chia het -> Khong la So nguyen to
    
    MOV     R4, R3          ; R4 = R3. Hien tai R4 la so du -> muon chia tiep thi phai cho no nhan gia tri cua So bi chia (R3)
    ADD     R6, #1          ; R6 = R6 + 1
    CMP     R6, R4          ; So sanh R6 voi R4
    BLT     chia            ; R6 < R4 thi tiep tuc thuc hien chia
    
    
COUNT
    ADD     R2, #1          ; R2 = R2 + 1   count++
    
tangCS
    ADD     R0, #4          ; R0 = R0 + 4 byte -> dia chi cua phan tu tiep theo
    ADD     R5, #1          ; R5 = R5 + 1     <-> i++
    CMP     R5, R1          ; So sanh R5 voi R1
    BLT     LAP             ; R5 < R1 thi thuc hien lay phan tu tiep theo de kiem tra
    
    
    NOP
    
    END
    