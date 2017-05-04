program xis_chi
  
implicit none
  
integer:: i,j,k, l, count, n,m,o, istat, n_input, params, count2
integer:: choice, choice_two, choice_three, choice_four
integer:: j_min, k_min, j_min_COV, k_min_COV 
integer:: j_min_one, k_min_one, j_min_two, k_min_two
integer, allocatable:: i_bin(:), j_bin(:)
real:: gammln, x, gamma_fixed
real*8:: s0,gamma, r0,  chi_sq_min,  blah_one, blah_two,  chi_sq_min_COV
real*8:: mean_xi, stand_err, N_subsamples, gamma_1, gamma_2, gamma_3
real*8:: s_min, s_max, s_break, A, slope, chi_min,chi_sq_min_one,chi_sq_min_two
real*8:: temp1, temp2,  r_nought_aver, s_hi, s_lo, r_zero
real*8:: capital_C, r_nought_fixed, pi, A_min
real*8, allocatable:: wp_sigma_measured(:), wp_sigma(:), sigma(:), log_sigma(:)
real*8, allocatable:: s_0vec(:),gammavec(:),xi_s_test(:),wp_ratio_correction(:)
real*8, allocatable:: lg_s(:), s(:), xis(:),wp(:), wpsigma_LS(:)
real*8, allocatable:: delta_xis(:), jack_err(:), poisson_xis(:)
real*8, allocatable:: bin_DD(:), bin_DR(:), xis_LS(:), xi_HAM(:), r_nought(:)
real*8, allocatable:: bin_DD_sigma(:), bin_DR_sigma(:), jack_err_div_sigma(:)
real*8, allocatable:: theta_deg(:),theta_ams(:),errorwp(:),errorwz(:),wz(:)
real*8, allocatable:: chi2(:,:), chi2_one(:,:), chi2_two(:,:), wp_div_sigma(:)
real*8, allocatable:: chi2_COV(:,:), chi2_one_COV(:,:), chi2_two_COV(:,:)
real*8, allocatable:: Rchi2(:,:), Rchi2_one(:,:), Rchi2_two(:,:), bin_RR(:)
real*8, allocatable:: nRR(:,:), COV_I(:,:), COV_ii(:)
!real*8, allocatable:: r(:), xir(:)
!real*8, allocatable:: s_0vec(56), gammavec(141),s0,gamma
!real*8, allocatable:: xi_s_test(10),xi_s(10), s(10), error(10)
!real*8, allocatable:: chi2(356,141)
character*128 xi_s_file, output_file

pi = 3.141592654

m=200
allocate(s_0vec(3000), gammavec(3000))
allocate(i_bin(m), j_bin(m), COV_ii(m))
allocate(xi_s_test(m),lg_s(m), s(m), xis(m), delta_xis(m), bin_DD(m), bin_RR(m))
allocate(bin_DD_sigma(m), bin_DR_sigma(m), poisson_xis(m), jack_err_div_sigma(m))
allocate(bin_DR(m), xis_LS(m), xi_HAM(m), jack_err(m), wp_ratio_correction(m))
allocate(wp_sigma_measured(m), wp_sigma(m), sigma(m), log_sigma(m), wpsigma_LS(m))
allocate(theta_deg(m),theta_ams(m),wp(m),wz(m),errorwp(m),errorwz(m))
allocate(chi2(4000,4000), chi2_one(4000,4000), chi2_two(4000,4000))
allocate(chi2_COV(4000,4000), chi2_one_COV(4000,4000), chi2_two_COV(4000,4000))
allocate(Rchi2(4000,4000), Rchi2_one(4000,4000), Rchi2_two(4000,4000))
allocate(r_nought(400), wp_div_sigma(400), nRR(400,400), COV_I(400,400))



j_min = 1000
k_min = 1000
chi_sq_min = 100.0
do j = 1,400
   do k = 1,200
      chi2(j,k) = 0.
      chi2_one(j,k) = 0.
      chi2_two(j,k) = 0.
   end do
end do

write(*,*)
write(*,*) 'chi_sq on 1) xi(s)   2) xi(r)   3) wp(sigma)  4) wp(rp)/rp'
!read(*,*) choice
write(*,*) ' ***********************************'
if(choice .eq. 1) write(*,*) ' *********     xi(s)       *********'
if(choice .eq. 2) write(*,*) ' *********     xi(r)       *********'
if(choice .eq. 3) write(*,*) ' *********   wp(sigma)     *********'
if(choice .eq. 4) write(*,*) ' ********* wp(sigma)/sigma *********'
write(*,*) ' ***********************************'
write(*,*)
write(*,*)
choice = 4
if (choice .eq. 4) write(*,*) 'choice eq ', choice, ' wp(rp)/rp....'


choice_two = 0
write(*,*) ' 0) 0.30 < z < 2.20 '
write(*,*)
write(*,*) ' 1) 0.30 < z < 0.68 '
write(*,*) ' 2) 0.68 < z < 0.92 '
write(*,*) ' 3) 0.92 < z < 1.13 '
write(*,*) ' 4) 1.13 < z < 0.32 '
write(*,*) ' 5) 1.32 < z < 1.50 '
write(*,*) ' 6) 1.50 < z < 1.66 '
write(*,*) ' 7) 1.66 < z < 1.83 '
write(*,*) ' 8) 1.83 < z < 0.68 '
write(*,*) ' 9) 2.02 < z < 2.20 '
write(*,*) '10) 2.20 < z < 2.90 '
write(*,*) '11) 0.00 < z < 0.30 '
!write(*,*) '12) 0.70 < z < 1.40 (DEEP2 z-range) '
!write(*,*) '13) 0.00 < z < 2.20 RASS DR5Q (uni) Xrays' 
read(*,*) choice_two

if(choice_two .eq. 0) write(*,*) ' *****   0.30 < z < 2.20    ***** '



s_lo=1.
s_hi=130.

write(*,*) "r_p low ? (0.1, 0.40, 1.00)"
read(*,*) s_lo
write(*,*) "r_p high? (1.0, 5.0, 25.0, 70.0, 100.0)"
read(*,*) s_hi

write(*,*) "rp_low set at  ",  s_lo, " h^-1 Mpc" 
write(*,*) "rp_hi  set at  ",  s_hi, " h^-1 Mpc"



!! I/P
!! W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma
!! W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma
!! W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma
if(choice.eq.4) then
   write(*,*) 
   if (choice_two .eq. 0) then
      open(10,file='../../OP/OP_20080508/K_wp_output_UNI22.dat')
      write(*,*) '../../OP/OP_20080508/K_wp_output_UNI22.dat'
      open(12, file='../../jackknife/wp_sigma/K_wp_output_UNI22_jackknife_errors.dat')
      
   elseif(choice_two .eq.1) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt30z0pnt68.dat'
   elseif(choice_two .eq.2) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt68z0pnt92.dat'
   elseif(choice_two .eq.3) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt92z1pnt13.dat'
   elseif(choice_two .eq.4) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt13z1pnt32.dat'
   elseif(choice_two .eq.5) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt32z1pnt50.dat')
      write(*,*) 'OP/OP_20080215/K_wp_output_20080121_1pnt32z1pnt50.dat'
   elseif(choice_two .eq.6) then 
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt50z1pnt66.dat'
   elseif(choice_two .eq.7) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt66z1pnt83.dat'
   elseif(choice_two .eq.8) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_1pnt83z2pnt02.dat'
   elseif(choice_two .eq.9) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt02z2pnt20.dat'
   elseif(choice_two .eq. 10) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_2pnt20z2pnt90.dat'
   elseif(choice_two .eq. 11) then
      open(10,file='../../OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat')
      write(*,*) 'OP/UNI22_evol_wpsigma/K_wp_output_UNI22_0pnt00z0pnt30.dat'
   endif
endif   
!open(10, file='K_output_2SLAQ_Edin_cor_HAM_FtF_natural_areas.dat')




!! O/P
!read(*,'(A)') output_file
if(choice .eq. 1) open(20, file='k_output_DR5Q_chisq_1.dat', status='unknown')
if(choice .eq. 1) open(21, file='k_output_DR5Q_chisq_2.dat', status='unknown')
if(choice .eq. 2) open(20, file='xir_DR5Q_chisq.dat', status='unknown')  
if(choice .eq. 3) open(20, file='wp_sigma_DR5Q_chisq_1.dat', status='unknown')  
if(choice .eq. 3) open(21, file='wp_sigma_DR5Q_chisq_2.dat', status='unknown')  
if(choice .eq. 5) open(20, file='w_theta_DR5Q_chisq_1.dat', status='unknown')
!set xi_s_file = 
!"/cos/j/jaca/2dfQSO/outputfiles/xi_s/xi_s_all_o_hamil_large_2.dat"
!set outputfile = 
!"/cos/j/jaca/2dfQSO/outputfiles/xi_s/chi_s0_gamma_o_hamil_new_fit.dat"


i=0
n_input=0
istat = 0 
do while(istat .eq. 0)
   i=i+1
   
   if(choice .eq. 4) then 
      
      read(10,*,IOSTAT=istat) s(i), lg_s(i), xis(i),  delta_xis(i), &
           & bin_DD_sigma(i), bin_DR_sigma(i),  blah_one, xis_LS(i)

      !! sigma_0pnt30, lg_sigma, Xi_sigma, delta_Xi_sigma, 
      !! DD_0pnt30, DR,  Xi_sigma_HAM, Xi_sigma_LS_0pnt30
      !!
      !! This one's a bit subtle too: delta_xis here is the Poisson
      !! error using the ``standard'' estimator and the wp(rp) DDs (from quorrel_five_perl.f90
      !! but we plot/scale the Poisson erros using the LS estimator, thus:
      
      poisson_xis(i) = (1.+xis_LS(i)) * (sqrt(2./bin_DD_sigma(i)))
      
      if(s(i) .ne. 0.00) wp_div_sigma(i) = xis_LS(i)/s(i)
      if(s(i) .lt. 10.) jack_err(i) = poisson_xis(i) * 5.
      if(s(i) .gt. 10.) jack_err(i) = poisson_xis(i) * 45.

      if (choice_two .eq. 0) then
         read(12,*,IOSTAT=istat)  blah_one, blah_two,  temp1, jack_err(i) 
      endif
      write(*,*) i, lg_s(i), s(i), xis(i),  delta_xis(i), &
           & bin_DD_sigma(i), bin_DR_sigma(i),  blah_one, xis_LS(i), jack_err(i)
      !! These values for the Projected Correlation Function, 
      !! w_p(sigma) and again keeping the xis variable names for ease.

   endif
end do
n_input = i - 1 
write(*,*)
write(*,*) 'n_input read-in', n_input
write(*,*)
1000 format (f18.15,2x, f18.14,2x, f18.14)



gamma_fixed = 2.0 
!! fixed for wp(rp)/rp and r0 fitting....
x=0.5
gamma_1 = exp(gammln(x))
x = ((gamma_fixed -1.0) /2.)
gamma_2 = exp(gammln(x))
x= (gamma_fixed /2.)  
gamma_3 = exp(gammln(x))
A = (gamma_1 * gamma_2) / gamma_3

write(*,*)
write(*,*) 'gamma (fixed PL slope) ', gamma_fixed , '  => A(gamma) = ', A
write(*,*)

!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!
!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!
!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!! 
!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!

chi_sq_min = 10000.
chi_sq_min_COV = 1000

params=2 
!! s_0 and gamma
write(*,*)
write(*,*) 's(i), xis_LS(i), xi_s_test(i), jack_err(i), (diff**2.) /  (jack_err(i)**2,  chi2(j,k)'
j_min_COV = 1000
k_min_COV = 1000
!do j=1,2000
do j=1,300


   if(choice.eq.1 .or. choice.eq.2 .or. choice.eq.4) then
      !s_0vec(j) = 2.0+float(j-1)*0.05
      s_0vec(j) = 0.0+float(j-1)*0.05
   end if
   s0 = s_0vec(j)

   
   do k=1,300
!   do k=1,3
      if((choice.eq.1 .or. choice.eq.2 .or. choice.eq.4) .and. s_hi .lt. 5.0)then
         gammavec(k) = 0.00+float(k)*0.01 
         !gamma = 0.75+float(k-1)*0.005 
      elseif(choice.eq.1 .or. choice.eq.2 .or. choice.eq.4)then
        gammavec(k) = 0.00+float(k)*0.10
!         gammavec(k) = 0.75+float(k-1)*0.005 
      end if
      gamma=gammavec(k)
!!      gamma=2.0 
!! fixed from above


      do i=1,n_input
         xi_s_test(i) = 0.0
      end do
      
      chi2(j,k) = 0.0
      count = 0
      
      do i=1,n_input
        ! write(*,*) i,j, k, s0, gamma, s_lo, s_hi

         !if (jack_err(i) .gt. 0.0  .and.    s(i) .lt. 7.0) then 
         !if (jack_err(i) .gt. 0.0  .and.    s(i).lt. 100.0) then 
         if (  jack_err(i).gt.0.0  .and.  s(i).ge.s_lo  .and.  s(i).le.s_hi) then
            ! if(delta_xis(i) .gt. 0.0) then

!            if(choice .eq. 5)  xi_s_test(i) = s0*(s(i)**(1-gamma))    !w(theta)
            if(choice .eq. 4) xi_s_test(i) = (s0**gamma) * (s(i)**(1.-gamma)) * A
            !! s(i) = sigma for    choice .eq. 4    i.e. wp(rp)/rp

            !write(*,*) i, jack_err(i)
!            write(*,*) i,j, k, s0, gamma, s_lo, s_hi, xi_s_test(i), xis_LS(i), jack_err(i)

!            if (choice .ne. 4) then !For wp(sigma) / sigma
            if (choice .eq. 4) then !For wp(sigma) / sigma
               chi2(j,k) = chi2(j,k) + ((( xi_s_test(i)- xis_LS(i))**2.) /  &
                    & (jack_err(i)*jack_err(i)))
               chi2_COV(j,k) = chi2_COV(j,k) + ( &
                    & ((xi_s_test(i)-xis_LS(i))*(xi_s_test(i+1)-xis_LS(i+1)))* &
                    & (COV_I(i,i+1)))
            else 
               chi2(j,k) = chi2(j,k) + ((( xi_s_test(i) - &
                    & wp_div_sigma(i))**2.) / (jack_err(i)*jack_err(i)))
            end if
            
            if (j .eq. 120) then 
               if (k .eq. 116) then 
                  write(*,*) s(i), xis_LS(i), xi_s_test(i), &
                       & jack_err(i), ((( xi_s_test(i)- xis_LS(i))**2.) /  &
                       & (jack_err(i)*jack_err(i))), chi2(j,k)
               end if
            end if
            
            count = count+1

         end if
      end do
      
      if(chi2(j,k) .lt. chi_sq_min) then
         chi_sq_min = chi2(j,k) 
         j_min = j
         k_min =k
      end if
      
      if(chi2_COV(j,k) .lt. chi_sq_min_COV) then
         chi_sq_min_COV = chi2_COV(j,k) 
         j_min_COV = j
         k_min_COV = k
      end if
      
      write(20,20) chi2(j,k), (chi2(j,k)/(count-params)), &
           &       s_0vec(j), gammavec(k), j,k
      !write(*,*) chi2(j,k), r_0vec(j), gammavec(k)
      
   end do !k=1,150
end do !j=1,156



!end if !choice .eq. 2
write(*,*)
write(*,*) 'chi_sq_min,   j_min,   k_min'
write(*,*) chi_sq_min, j_min,   k_min
write(*,*)
20 format (2f18.4,2x, 2f8.3,1x,i4,1x,i3) 
21 format (2f18.4,2x, 2f8.3,1x,i3,1x,i3, 1x, f12.5) 
!20 format (2f12.5,2x, 2f8.3,1x,i3,1x,i3, 1x, f12.5, 1x, f12.5, 1x, f7.4)
23 format (i3,1x, i3,1x, f12.5,1x, f12.5,1x, f12.5)
24 format (i2,1x, f16.8,1x, f16.8,1x, f9.3,1x, f9.3,1x, i3,1x, i3,1x, &
        & f16.8,1x, f12.5,1x, f9.3)
25 format(f10.5,1x, f10.5,1x, f12.3,1x, f6.3,1x, f16.8,1x, f16.8,1x)


if(choice_two .eq. 1) then 
   write(*,*) 'n_input', n_input, 'Count', count, 'degs_of_free', (count-params)
   write(*,*) 'Reduced chi_sq_min', chi_sq_min/(count-params), 'with s_O=', s_0vec(j_min),  &
        & 'and gamma=', gammavec(k_min), j_min, k_min
   write(*,*) 'Taking the Inverse covariance matrix into account'
   write(*,*) chi_sq_min_COV, j_min_COV, k_min_COV
   write(*,*) 'The chi_sq_min is', chi_sq_min_COV, &
        & 'with s_O=', s_0vec(j_min_COV),  'and gamma=', gammavec(k_min_COV)
end if

!write(*,*) 'Output in k_output_2SLAQ_chisq.dat'
!write(*,*) ' sort -k 2 -n k_output_2SLAQ_chisq.dat > temp'
!if(choice .ne. 1) write(*,*) ' sort -k 2 -n xir_2SLAQ_chisq.dat > temp'
!if(choice .eq. 1) write(*,*) ' sort -k 2 -n k_output_2SLAQ_chisq_1.dat > temp'
!if(choice .eq. 1) write(*,*) ' sort -k 2 -n k_output_2SLAQ_chisq_2.dat > temp2'
write(*,*)

write(*,*) ' best fit   s0, gamma,  with chi_sq_min/DoF  (and count)  ' 
write(*,'(f9.4,f9.4,f11.7, i4)')  s_0vec(j_min), gammavec(k_min), chi_sq_min/(count-params), count
write(*,*) 's_lo, s_hi', s_lo, s_hi
write(*,*)




write(*,*) 
write(*,*)
write(*,*) ' ***************************************************************************'
write(*,*) ' ******       Using  wp(sigma)/sigma  to  work  out  r0/ gamma_r   *********'
write(*,*) ' ******                                                            *********'
write(*,*) ' ******      BEST-FIT SINGLE Power-laws:                           *********'
write(*,*) ' ****** r0 = ', s_0vec(j_min), '   with gamma ', gammavec(k_min), '  *********'
write(*,*) ' ****** Red chi^2 = ', chi_sq_min/(count-params),'  A(gamma) =', A_min,  '***'
write(*,*) ' ******                                                            *********'
write(*,*) ' ***************************************************************************'
write(*,*) 
write(*,*)







close(10)
close(12)


end program xis_chi





FUNCTION gammln(xx)
  REAL gammln,xx
  INTEGER j
  REAL*8 ser,stp,tmp,x,y,cof(6)
  SAVE cof,stp
  DATA cof,stp/76.18009172947146d0,-86.50532032941677d0, &
       & 24.01409824083091d0,-1.231739572450155d0,.1208650973866179d-2, &
       &-.5395239384953d-5,2.5066282746310005d0/
  x=xx
  y=x
  tmp=x+5.5d0
  tmp=(x+0.5d0)*log(tmp)-tmp
  ser=1.000000000190015d0
  do 11 j=1,6
     y=y+1.d0
     ser=ser+cof(j)/y
11   continue
     gammln=tmp+log(stp*ser/x)
     return
  END 

