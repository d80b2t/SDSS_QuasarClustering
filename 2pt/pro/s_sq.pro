;+
; NAME:
;      s_sq
;
; PURPOSE:
;       To perform cross-correlation calculations
;       between 2SLAQ LRGs and photometrically selected
;       SDSS QSOs from the NBC-KDE classification. 
;       (Non-parametric Bayesian Classification, 
;       based on kernel density estimation. 
;
; EXPLANATION:
;
; CALLING SEQUENCE:
;       result = s_sq(a_one, b_one, c_one, a_two, b_two, c_two)
;
; INPUTS:
;       None.
;
; OPTIONAL INPUTS:
;       None.
;
; KEYWORD PARAMETERS:
;       n/a
;
; OUTPUTS:
;       various
;
; OPTIONAL OUTPUTS:
;       also various
;
; COMMON BLOCKS:
;       None.
;
; RESTRICTIONS:
;
; PROCEDURES CALLED:
;
; EXAMPLES:
;
; COMMENTS:
;        Taken from J. Moustakas, webpage at
;        http://cerebus.as.arizona.edu/~ioannis/teaching/idl/
;        2003 November 17, U of A
;
; NOTES:
;
; MODIFICATION HISTORY:
;       Version 1.0  NPR    6th August.        
;-



function s_sq, a_one, b_one, c_one, a_two, b_two, c_two

  s_squared = ((a_two-a_one)^2 + (b_two-b_one)^2 + (c_two-c_one)^2)
  

return, s_squared

end 


