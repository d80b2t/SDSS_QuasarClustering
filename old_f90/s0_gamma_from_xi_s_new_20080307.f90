program xis_chi

implicit none

integer:: i,j,k, l, count, n,m,o, istat, n_input, params, count2
integer:: choice, choice_two, choice_three, choice_four
integer:: j_min, k_min, j_min_COV, k_min_COV 
integer:: j_min_one, k_min_one, j_min_two, k_min_two
real:: gammln, x, gamma_fixed
real*8:: s0,gamma, r0,  chi_sq_min,  blah_one, blah_two,  chi_sq_min_COV
real*8:: mean_xi, stand_err, N_subsamples, gamma_1, gamma_2, gamma_3
real*8:: s_min, s_max, s_break, A, slope, chi_min,chi_sq_min_one,chi_sq_min_two
real*8:: temp1, temp2,  r_nought_aver, s_hi, s_lo, r_zero
real*8:: capital_C, r_nought_fixed, pi
real*8, allocatable:: w_sigma_measured(:), w_sigma(:)
real*8, allocatable:: s_0vec(:),gammavec(:),xi_s_test(:),wp_ratio_correction(:)
real*8, allocatable:: lg_s(:), s(:), xis(:), delta_xis(:), jack_err(:),wp(:)
real*8, allocatable:: bin_DD(:), bin_DR(:), xis_LS(:), xi_HAM(:), r_nought(:)
real*8, allocatable:: theta_deg(:),theta_ams(:),errorwp(:),errorwz(:),wz(:)
real*8, allocatable:: chi2(:,:), chi2_one(:,:), chi2_two(:,:), wp_div_sigma(:)
real*8, allocatable:: chi2_COV(:,:), chi2_one_COV(:,:), chi2_two_COV(:,:)
real*8, allocatable:: Rchi2(:,:), Rchi2_one(:,:), Rchi2_two(:,:), bin_RR(:)
real*8, allocatable:: nRR(:,:), COV_I(:,:)
!real*8, allocatable:: r(:), xir(:)
!real*8, allocatable:: s_0vec(56), gammavec(141),s0,gamma
!real*8, allocatable:: xi_s_test(10),xi_s(10), s(10), error(10)
!real*8, allocatable:: chi2(356,141)
character*128 xi_s_file, output_file

pi = 3.141592654

m=200
allocate(s_0vec(3000), gammavec(3000))
allocate(xi_s_test(m),lg_s(m), s(m), xis(m), delta_xis(m), bin_DD(m), bin_RR(m))
allocate(bin_DR(m), xis_LS(m), xi_HAM(m), jack_err(m), wp_ratio_correction(m))
allocate(w_sigma_measured(m), w_sigma(m))
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
write(*,*) 'chi_sq on 1) xi(s)   2) xi(r)   3) wp(sigma)  4) wp/sigma (colour cuts?)   5) w(theta)'
read(*,*) choice
write(*,*) ' ***********************************'
if(choice .eq. 1) write(*,*) ' *********     xi(s)       *********'
if(choice .eq. 2) write(*,*) ' *********     xi(r)       *********'
if(choice .eq. 3) write(*,*) ' *********   wp(sigma)     *********'
if(choice .eq. 4) write(*,*) ' ********* wp(sigma)/sigma *********'
if(choice .eq. 5) write(*,*) ' *********    w(theta)     *********'
write(*,*) ' ***********************************'
write(*,*)
write(*,*)


choice_two = 0
write(*,*) ' 0) 0.30 < z < 2.90 '
write(*,*)
write(*,*) ' 1) 0.30 < z < 0.68 '
write(*,*) ' 2) 0.68 < z < 0.68 '
write(*,*) ' 3) 0.92 < z < 0.68 '
write(*,*) ' 4) 1.13 < z < 0.68 '
write(*,*) ' 5) 1.32 < z < 0.68 '
write(*,*) ' 6) 1.50 < z < 0.68 '
write(*,*) ' 7) 1.66 < z < 0.68 '
write(*,*) ' 8) 1.83 < z < 0.68 '
write(*,*) ' 9) 2.02 < z < 2.25 '
write(*,*) '10) 2.25 < z < 2.90 '
write(*,*) '11) 0.70 < z < 1.40 (DEEP2 z-range) '
read(*,*) choice_two
!write(*,*) ' ***********************************'
!if(choice_two .eq. 1) write(*,*) ' ********* SINGLE Power Law ********'
!if(choice_two .eq. 2) write(*,*) ' ********* DOUBLE Power Law ********'
!write(*,*) ' ***********************************'
!write(*,*)
!write(*,*)



!write(*,*) '1) SPL  or   2) DPL?'
!!read(*,*) choice_two
!choice_two = 1
!write(*,*) ' ***********************************'
!if(choice_two .eq. 1) write(*,*) ' ********* SINGLE Power Law ********'
!if(choice_two .eq. 2) write(*,*) ' ********* DOUBLE Power Law ********'
!write(*,*) ' ***********************************'
!write(*,*)
!write(*,*)


!write(*,*) '1) Lambda 2) EdS'
!!read(*,*) choice_three 
!choice_three = 1
!write(*,*) ' ***********************************'
!if(choice_three .eq. 1) write(*,*) ' *********   Lambda  **************'
!if(choice_three .eq. 2) write(*,*) ' *********    EdS    **************'
!write(*,*) ' ***********************************'
!write(*,*)
!write(*,*)


!write(*,*) ' "Hybrid errors"?  1) yes  2) no'
!!read(*,*) choice_four
!choice_four =2
!write(*,*) ' ***********************************'
!if(choice_four .eq. 1) write(*,*) ' *********   Yes          *********'
!if(choice_four .eq. 2) write(*,*) ' *********    No (good)   *********'
!write(*,*) ' ***********************************'
!write(*,*)
!write(*,*)



write(*,*) "s_low set at 1 h^-1 Mpc"
s_lo=1
!write(*,*) "s_hi set at 100 h^-1 Mpc"
!s_hi=100
!write(*,*) "s low ? (0.1, 0.40, 1.00)"
!read(*,*) s_lo
write(*,*) "s high? (1.0, 20.0, 70.0)"
read(*,*) s_hi



!I/P
!REDSHIFT-SPACE !REDSHIFT-SPACE !REDSHIFT-SPACE !REDSHIFT-SPACE REDSHIFT-SPACE 
!REDSHIFT-SPACE !REDSHIFT-SPACE !REDSHIFT-SPACE !REDSHIFT-SPACE REDSHIFT-SPACE 
!REDSHIFT-SPACE !REDSHIFT-SPACE !REDSHIFT-SPACE !REDSHIFT-SPACE REDSHIFT-SPACE 
if(choice.eq.1) then      !xi(s) 
   write(*,*) 
   
   if (choice_two .eq. 0) then
      open(10,file='OP/OP_20080120/k_output_20080120_0pnt30z2pnt90.dat')
      write(*,*) 'OP/OP_20080120/k_output_20080120_0pnt30z2pnt90.dat'
   elseif(choice_two .eq.1) then
      open(10,file='OP/OP_20080121/k_output_20080121_0pnt30z0pnt68.dat')
      write(*,*) 'OP/OP_20080121/k_output_20080121_0pnt30z0pnt68.dat'
   elseif(choice_two .eq.2) then
      open(10,file='OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat')
      write(*,*) 'OP/OP_20080122b/k_output_20080122_0pnt68z0pnt92.dat'
   elseif(choice_two .eq.3) then
      open(10,file='OP/OP_20080123/k_output_20080123_0pnt92z1pnt13.dat')
      write(*,*) 'OP/OP_20080123/k_output_20080123_0pnt92z1pnt13.dat'
   elseif(choice_two .eq.4) then
      open(10,file='OP/OP_20080124/k_output_20080124_1pnt13z1pnt32.dat')
      write(*,*) 'OP/OP_20080124/k_output_20080124_1pnt13z1pnt32.dat'
   elseif(choice_two .eq.5) then
      open(10,file='OP/OP_20080215/k_output_20080215_1pnt32z1pnt50.dat')
      write(*,*) 'OP/OP_20080215/k_output_20080121_1pnt32z1pnt50.dat'
   elseif(choice_two .eq.6) then
      open(10,file='OP/OP_20080215b/k_output_20080215_1pnt50z1pnt66.dat')
      write(*,*) 'OP/OP_20080215b/k_output_20080215_1pnt50z1pnt66.dat'
   elseif(choice_two .eq.7) then
      open(10,file='OP/OP_20080215c/k_output_20080215_1pnt66z1pnt83.dat')
      write(*,*) 'OP/OP_20080215c/k_output_20080215_1pnt66z1pnt83.dat'
   elseif(choice_two .eq.8) then
      open(10,file='OP/OP_20080215d/k_output_20080215_1pnt83z2pnt02.dat')
      write(*,*) 'OP/OP_20080215d/k_output_20080215d_1pnt83z2pnt02.dat'
   elseif(choice_two .eq.9) then
      open(10,file='OP/OP_20080215e/k_output_20080215_2pnt02z2pnt25.dat')
      write(*,*) 'OP/OP_20080215e/k_output_20080215_2pnt02z2pnt25.dat'
   elseif(choice_two .eq. 10) then
      open(10,file='OP/OP_20080122/k_output_20080122_2pnt25z2pnt90.dat')
      write(*,*) 'OP/OP_20080122/k_output_20080122_2pnt25z2pnt90.dat'
   elseif(choice_two .eq. 11) then
      open(10,file='OP/OP_20080307/k_output_20080307_0pnt70z1pnt40.dat')
      write(*,*) 'OP/OP_20080307/k_output_20080307_0pnt70z1pnt40.dat'
   endif
   
   !open(12,file='jackknife_perl/xis_variances_errors_LS_hybrid_20061116.dat')
   !write(*,*) 'Using jackknife_perl/xis_variances_errors_LS_hybrid_20061116.dat'
   
   write(*,*)
end if       ! if(choice .eq. 1) then !xi(s) 


!I/P
!REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE
!REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE
!REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE !REAL-SPACE
if(choice .eq. 2) then

   write(*,*) 
end if


!I/P
!W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)
!W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)
!W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)  W_P(SIGMA)
if(choice .eq. 3) then 
   if(choice_three .eq. 1) then !LCDM
      !open(10,file='jackknife_perl/K_output_jack_perl_full_newcor.dat')
      open(10,file='jackknife_perl/K_output_jack_perl_full_newcor_v2.dat')
      open(12,file='jackknife_perl/wp_variances_errors_LS.dat')
      !
      !open(10,file='K_output_files/K_output_cc_bluesv4.dat')
      !open(10,file='wp_sigma_files/wgg_2slaq.dat')
   end if
   if(choice_three .eq. 2) then
      !open(10,file='jackknife_perl/EdS/K_output_jack_perl_EdS_full.dat')
      open(10,file='jackknife_perl/EdS/K_output_jack_perl_EdS_full_v2.dat')
      open(12,file='jackknife_perl/EdS/wp_variances_errors_LS_EdS.dat')
   end if
end if


! I/P
! W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma
! W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma
! W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma  W_P(sigma)/sigma
if(choice .eq. 4) open(10, file='K_output_2SLAQ_Edin_cor_HAM_FtF_natural_areas.dat')


! I/P
! w(theta)   w(theta)   w(theta)  ! w(theta)  ! w(theta)  ! w(theta)  ! w(theta) 
! w(theta)   w(theta)   w(theta)  ! w(theta)  ! w(theta)  ! w(theta)  ! w(theta) 
! w(theta)   w(theta)   w(theta)  ! w(theta)  ! w(theta)  ! w(theta)  ! w(theta) 
!
!if(choice .eq. 5) open(10, file='Zehavi_K_output.dat')
!if(choice .eq. 5) open(10, file='w_theta_2SLAQ_Sam8.dat')
if(choice .eq. 5) open(10, file='w_theta_FtF_errors_wp.dat')
if(choice .eq. 5) write(*,*) '   w_theta_FtF_errors_wp.dat'





!O/P
!read(*,'(A)') output_file
if(choice .eq. 1) open(20, file='k_output_2SLAQ_chisq_1.dat', status='unknown')
if(choice .eq. 1) open(21, file='k_output_2SLAQ_chisq_2.dat', status='unknown')
if(choice .eq. 2) open(20, file='xir_2SLAQ_chisq.dat', status='unknown')  
if(choice .eq. 3) open(20, file='wp_sigma_2SLAQ_chisq.dat', status='unknown')  
if(choice .eq. 5) open(20, file='w_theta_2SLAQ_chisq_1.dat', status='unknown')
!set xi_s_file = 
!"/cos/j/jaca/2dfQSO/outputfiles/xi_s/xi_s_all_o_hamil_large_2.dat"
!set outputfile = 
!"/cos/j/jaca/2dfQSO/outputfiles/xi_s/chi_s0_gamma_o_hamil_new_fit.dat"

i=0
n_input=0
istat = 0 
do while(istat .eq. 0)
   i=i+1

   if(choice .eq. 1) then ! xi(s)
      read(10,*, IOSTAT=istat) lg_s(i), s(i), xis(i), delta_xis(i), &
           & bin_DD(i), bin_DR(i), bin_RR(i), &
           & xis_LS(i), xi_HAM(i)
      write(*,*) i, lg_s(i), s(i), xis(i), delta_xis(i), &
           & bin_DD(i), bin_DR(i), bin_RR(i), &
           & xis_LS(i), xi_HAM(i)
      
      jack_err(i) = delta_xis(i)

   elseif(choice .eq. 2) then 
      read(10,*,IOSTAT=istat) s(i), xis_LS(i), jack_err(i)
      !read(12,*,IOSTAT=istat) s(i), xis_LS(i), blah_one
      read(12,*,IOSTAT=istat) s(i), blah_one, jack_err(i)

      write(*,*) s(i), xis_LS(i), jack_err(i)
      !Even though this is reading in xi(r), we're using 
      !s and xis_LS variable names for ease...


   elseif(choice .eq. 3) then 
      read(10,*,IOSTAT=istat) s(i), lg_s(i), xis(i),  delta_xis(i), &
           & jack_err(i), blah_one, xi_HAM(i), xis_LS(i)
      read(12,*,IOSTAT=istat) blah_one, delta_xis(i), jack_err(i)
      write(*,*) i, s(i), lg_s(i), xis(i),  delta_xis(i), &
                & jack_err(i), blah_one, xi_HAM(i),  xis_LS(i)

      !read(10,1000,IOSTAT=istat) s(i),  xis_LS(i), jack_err(i)
      !write(*,1000) s(i),  xis_LS(i), jack_err(i)
            
      !read(10,*,IOSTAT=istat) s(i), lg_s(i), xis_LS(i), jack_err(i)       
      !write(*,*) i, lg_s(i), s(i), xis_LS(i),  jack_err(i)  !for cc_bluesv4.dat
      !
      ! These values for the Projected Correlation Function, 
      ! w_p(sigma) and again keeping the xis variable names for ease.
      !wp_div_sigma(i) = xis_LS(i)/s(i)


   elseif(choice .eq. 4) then 
      read(10,*,IOSTAT=istat) s(i), lg_s(i), xis(i),  delta_xis(i), &
           & jack_err(i), blah_one, xis_LS(i)
      if(s(i) .ne. 0.00) wp_div_sigma(i) = xis_LS(i)/s(i)
      write(*,*) lg_s(i), s(i), xis(i),  delta_xis(i), &
           & jack_err(i), blah_one, xis_LS(i), wp_div_sigma(i)
      ! These values for the Projected Correlation Function, 
      ! w_p(sigma) and again keeping the xis variable names for ease.


   elseif(choice .eq. 5) then 
      !read(10,*,IOSTAT=istat)  s(i), lg_s(i),  xis_LS(i), jack_err(i)
      !write(*,*)  s(i), lg_s(i),  xis_LS(i), jack_err(i)
      !read(10,*,IOSTAT=istat) theta_deg(i), theta_ams(i), wp(i),  &
      !     &  wz(i), errorwp(i),  errorwz(i)
      !write(*,*)   theta_deg(i), theta_ams(i), wp(i),  &
      !     &  wz(i), errorwp(i),  errorwz(i)

      read(10,*,IOSTAT=istat) theta_ams(i), wp(i), errorwp(i)
      s(i) = theta_ams(i)
      xis_LS(i) = wp(i)
      jack_err(i) =  errorwp(i)
      write(*,*)    s(i),  xis_LS(i), jack_err(i)

   else
      read(10,*,IOSTAT=istat) s(i), xis_LS(i), blah_one, blah_two, jack_err(i)
      write(*,*) s(i), xis_LS(i), jack_err(i) 
      jack_err(i) = jack_err(i) * 2.2
      !Have added this factor of sqrt(10000/2000) to level up the errors
      !for the Colour_cuts xi(r) sample.

   end if
   
   !if(choice .eq. 1) xis_LS(i)= xis_LS(i) * wp_ratio_correction(i)
   !(float(k)-12+0.5)/5., 10**((float(k)-12+0.5)/5.), xi(k),  delta_xis(k), &
   !           & bin_DD(k), bin_DR(k), xis_LS(k), xi_HAM(k), &
   !           & bin_RR(k), bin_DR(k)/nRD_ratio
   !-0.5000000   0.3162278  66.5282174983667431  33.7641087491833716   
   !8.0000000000000000   3.0000000000000000    
   !44.6677999030591266   1.0033333333333333E+02   
   !1.1400000000000000E+02   0.1184689940941132
   
end do
n_input = i - 1 
write(*,*)
write(*,*) 'n_input read-in', n_input
write(*,*)
1000 format (f18.15,2x, f18.14,2x, f18.14)




i=0
j=0
istat = 0 
!do while(istat .eq. 0)
   if(choice .eq. 2) then
      do while(istat .eq. 0)
         i=i+1
         read(11,*, IOSTAT = istat) COV_I(i,1), COV_I(i,2), COV_I(i,3), &
              & COV_I(i,4),COV_I(i,5), COV_I(i,6), COV_I(i,7),COV_I(i,8), &
              & COV_I(i,9), COV_I(i,10), &
              & COV_I(i,11), COV_I(i,12), COV_I(i,13), COV_I(i,14), &
              & COV_I(i,15), COV_I(i,16)
         
         !write(*,'(15f11.4)') COV_I(i,1), COV_I(i,2), COV_I(i,3),&
         !     & COV_I(i,4),COV_I(i,5),&
         !     & COV_I(i,6), COV_I(i,7),COV_I(i,8),COV_I(i,9), COV_I(i,10), &
         !     & COV_I(i,11), COV_I(i,12), COV_I(i,13), COV_I(i,14), &
         !     & COV_I(i,15), COV_I(i,16)

         !These will be the sigma_i,j's from the Covariance matrix OR 
         ! the Inverse Covariance matrix
         
      end do
      !read(4,*) 
   end if
!end do




!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!
!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!
!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!! 
!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!!!!! SINGLE POWER LAW !!!

chi_sq_min = 10000.
chi_sq_min_COV = 1000

params=2 ! s_0 and gamma

j_min_COV = 1000
k_min_COV = 1000
do j=1,2000
   
   if(choice.eq. 1 .and. s_hi .lt. 5.0) then
      s_0vec(j) = 1.99 + float(j)*0.01
      !s0 = 5.0+float(j-1)*0.1
   else if(choice.eq.1 .or. choice.eq.2 .or. choice.eq.4)then
      s_0vec(j) = 2.0+float(j-1)*0.05
   else if(choice .eq. 3)  then
      s_0vec(j) = 2.0+float(j-1)*5.0 
      !           200+float(j-1)*2.0
   else if(choice .eq. 5) then
      s_0vec(j) = 0.01+(float(j-1)*0.01) 
   end if
   s0 = s_0vec(j)
   
   do k=1,300
      if((choice.eq.1 .or. choice.eq.2 .or. choice.eq.4) .and. s_hi .lt. 5.0)then
         gammavec(k) = 0.00+float(k)*0.01 
         !gamma = 0.75+float(k-1)*0.005 
      elseif(choice.eq.1 .or. choice.eq.2 .or. choice.eq.4)then
        gammavec(k) = 0.00+float(k)*0.01 
!         gammavec(k) = 0.75+float(k-1)*0.005 
      elseif(choice .eq. 3)  then
         gammavec(k) = 0.0+float(k-1)*0.01 
      elseif(choice .eq. 5)  then
         gammavec(k) = 0.0+float(k-1)*0.01 
      end if
      gamma=gammavec(k)

      do i=1,n_input
         xi_s_test(i) = 0.0
      end do
      
      chi2(j,k) = 0.0
      count = 0
      
      do i=1,n_input
         !write(*,*) i,j, s0, gamma, s_lo, s_hi....

         !if (jack_err(i) .gt. 0.0  .and.    s(i) .lt. 7.0) then 
         !if (jack_err(i) .gt. 0.0  .and.    s(i).lt. 100.0) then 
         if (jack_err(i).gt.0.0 .and. s(i).ge.s_lo .and. s(i).le.s_hi) then
            ! if(delta_xis(i) .gt. 0.0) then

            if(choice .ne. 5)  xi_s_test(i) = (s(i)/s0)**(-1.* gamma) !Not w(theta)
            if(choice .eq. 5)  xi_s_test(i) = s0*(s(i)**(1-gamma))    !w(theta)


            if (choice .ne. 4) then !For wp(sigma) / sigma
               chi2(j,k) = chi2(j,k) + ((( xi_s_test(i)- xis_LS(i))**2.) /  &
                    & (jack_err(i)*jack_err(i)))
               chi2_COV(j,k) = chi2_COV(j,k) + ( &
                    & ((xi_s_test(i)-xis_LS(i))*(xi_s_test(i+1)-xis_LS(i+1)))* &
                    & (COV_I(i,i+1)))
            else 
               chi2(j,k) = chi2(j,k) + ((( xi_s_test(i) - &
                    & wp_div_sigma(i))**2.) / (jack_err(i)*jack_err(i)))
            end if

!            write(*,*) s(i), xis_LS(i), xi_s_test(i), &
!                    & jack_err(i), ((( xi_s_test(i)- xis_LS(i))**2.) /  &
!                    & (jack_err(i)*jack_err(i))), chi2(j,k)

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
20 format (2f18.4,2x, 2f8.3,1x,i3,1x,i3) 
21 format (2f18.4,2x, 2f8.3,1x,i3,1x,i3, 1x, f12.5) 
!20 format (2f12.5,2x, 2f8.3,1x,i3,1x,i3, 1x, f12.5, 1x, f12.5, 1x, f7.4)
23 format (i3,1x, i3,1x, f12.5,1x, f12.5,1x, f12.5)
24 format (i2,1x, f16.8,1x, f16.8,1x, f9.3,1x, f9.3,1x, i3,1x, i3,1x, &
        & f16.8,1x, f12.5,1x, f9.3)
25 format(f10.5,1x, f10.5,1x, f12.3,1x, f6.3,1x, f16.8,1x, f16.8,1x)


if(choice_two .eq. 1) then 
   write(*,*) 'n_input', n_input, 'Count', count, &
        & 'degs_of_free', (count-params)
   write(*,*) 'Reduced chi_sq_min', chi_sq_min/(count-params), &
        & 'with s_O=', s_0vec(j_min),  'and gamma=', gammavec(k_min), j_min, k_min
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

write(*,*) ' best fit   s0, gamma,  with chi_sq_min/DoF ' 
write(*,'(f9.4,f9.4,f11.7)')  s_0vec(j_min), gammavec(k_min), chi_sq_min/(count-params)
write(*,*) 's_lo, s_hi', s_lo, s_hi
write(*,*)


!WORKING OUT r_noughts from w_p(\sigma) slopes
! Re-arranging Hawkins et al. 2003 eq. (6)
!if(choice .eq. 3 .or. choice .eq. 4 .or. choice .eq. 5) then 
if(choice .eq. 3 .or. choice .eq. 4) then 

   write(*,*) ' WORKING OUT r_noughts from w_p(\sigma) slopes'
   count2 = 0
   r_nought_aver=0
   slope = gammavec(k_min)+1.
  
   x=0.5
   gamma_1 = exp(gammln(x))
   write(*,*) 'gamma_1=', gamma_1
   
   x = ((slope -1.0) /2.)
   gamma_2 = exp(gammln(x))
   write(*,*) 'gamma_2=', gamma_2
   
   x= (slope /2.)  
   gamma_3 = exp(gammln(x))
   write(*,*) 'gamma_3=', gamma_3
   
   A = (gamma_1 * gamma_2) / gamma_3
   
   write(*,*) '(gamma_1*gamma_2)/gamma_3 = ', A 
   write(*,*) 
   write(*,*) '   s(i),            xis_LS(i),            r_nought(i)'

   do i=1,n_input
      if(xis_LS(i) .gt. 0) then
         !write(*,*) i,xis_LS(i),s(i), slope, A
         !r_nought(i) = ( xis_LS(i)  / (   (s(i)**(-0.88)) *A)  ) ** (1./1.88)
         !r_nought(i) = ( xis_LS(i)  / (   (s(i)**(-0.77)) *A)  ) ** (1./1.77)
         r_nought(i) = (xis_LS(i) / ( (s(i)**(1.0-slope)) *A) ) ** (1./(slope))
         write(*,*) s(i),  xis_LS(i),  r_nought(i), slope, A
         if(s(i) .ge. s_lo  .and.   s(i) .le. s_hi ) then
            
            r_nought_aver = r_nought_aver + r_nought(i)
            count2 = count2 + 1
            
         end if
      end if
   end do
   
   r_zero =  (s_0vec(j_min)**(1-(1/slope))) * (A**(-1.0*(1/slope)))
   !write(*,*)  r_nought_aver
   !write(*,*)  count2
   if(count2 .ne. 0) write(*,*)  r_nought_aver/count2
   if(count2 .ne. 0) write(*,*)  '****** r_0 =', r_zero, ' ********' 
   !write(*,*)  ( xis_LS(i)  / (   (s(i)**(-0.88)) *A)  ) ** (1./1.88)
end if !if(choice .eq. 3 .or. choice .eq. 4) then 


write(*,*)
capital_C = 0.
if(choice .eq. 3 .or. choice .eq. 4) then 
   gamma_fixed = 1.73
   r_nought_fixed = 7.45     ! if LAMBDA

   gamma_1 = exp(gammln((gamma_fixed-1)/2))
   gamma_2 = exp(gammln(gamma_fixed/2))
   
   capital_C = sqrt(pi) * (gamma_1 / gamma_2  ) 
   write(*,*) 'gamma_1=', gamma_1, 'gamma_2=', gamma_2
   write(*,*) 'capital_C', capital_C
   write(*,*)

   write(*,*)' i, s(i), xis_LS(i), w_sigma_measured(i), IC ' 
   
   do i=1,n_input
      if(xis_LS(i) .gt. 0) then
         if(s(i) .ge. s_lo  .and.   s(i) .le. s_hi ) then
            
            w_sigma(i) = capital_C * (r_nought_fixed**gamma_fixed) * &
                 & (s(i)**(1- gamma_fixed))  
            !
            !where s(i) in this case is sigma (equivalent to r_p)
            !
            !
            write(*,*) i, s(i), xis_LS(i), w_sigma(i), xis_LS(i), &
                 & (w_sigma(i) - xis_LS(i))         
         end if
      end if

   end do
end if




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

