FUNCTION BETTER_BINARY, number

; This function returns the binary representation
; of byte, integer, and long integer numbers.

   ; What kind of number is this?

thisType = Size(number, /Type)
IF thisType LT 1 OR thisType GT 3 THEN $
   ok = Dialog_Message('Only BYTE, INTEGER, and LONG values allowed.')
RETURN, Reverse( (number AND 2L^Lindgen( 2^thisType*4) ) NE 0)
END
