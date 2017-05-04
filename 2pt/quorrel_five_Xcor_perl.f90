!
! Room 403, Astronomy and Astrophysics Department
! Davey Lab, University Park, PA 16802
! Pennsylvania State University
!
! Okay, so this is the ``new'' and `improved' program that (primarily) should
! take SDSS Quasar data (mainly from DR5) and compute the redshift-space
! correlation function, xi(s), the ``2-D'' correlation function, xi(sigma,pi)
! and the projected correlation function, wp(sigma). wp(sigma) can, of course,
! be used and inverted/interpolated to workout, the real-space correlation, 
! xi(r), via a program such as correl_six.f90
!
! Nicholas P. Ross, Postdoctoral Research Scholar, 18th January 2008   

program correlfive
  
implicit none
  
integer:: number, ra1_rnd, ra2_rnd, dec1_rnd, dec2_rnd, bad_pi_para
integer:: counter, cumulate, counter_two, repeat_counter, fld_s01
integer:: count_lt, count_mid, count_gt, q, istat, flag, x_int, y_int
integer:: pair_count, jack, z_max_int

integer, allocatable:: ra1(:), ra2(:), dec1(:), dec2(:), template(:), qa(:)
integer, allocatable:: lrgsam(:), run(:), rerun(:), camCol(:), field(:), id(:)
integer, allocatable:: bin(:), z_bin(:), z_rnd_bin(:), z_Xray_bin(:)
integer, allocatable:: fib(:),qop(:),repeat(:),z_flag(:), f(:)

real*8, allocatable:: ra_J2K(:), dec_J2K(:), objc_rowc(:), objc_colc(:)
real*8, allocatable:: ra3(:), dec3(:), z_abs(:), r_mag(:), sky2(:), xcor(:)
real*8, allocatable:: x_coord(:),      y_coord(:),      z_coord(:), z_fin(:) 
real*8, allocatable:: x_coord_rnd(:),  y_coord_rnd(:),  z_coord_rnd(:)
real*8, allocatable:: x_coord_Xray(:), y_coord_Xray(:), z_coord_Xray(:)
real*8, allocatable:: r_fib(:), z_LRG(:)
real*8, allocatable:: bin_RR(:), bin_RR_sigma(:), xi_LS(:), xi_HAM(:)
real*8, allocatable:: xi_lin(:), delta_xi_lin(:), xi_LS_lin(:), xi_HAM_lin(:)
real*8, allocatable:: ra_theta(:), dec_theta(:), one_plus_ws(:), Mpc_sep(:)
real*8, allocatable:: theta_deg(:), theta_ams(:), w_theta_p(:)
real*8, allocatable:: w_theta_z(:), delta_w_theta_p(:), delta_w_theta_z(:) 
real*8, allocatable:: ra_DR5Q(:), dec_DR5Q(:), z_DR5Q(:), rc_DR5Q(:)
real*8, allocatable:: ra_Xray(:), dec_Xray(:), z_Xray(:), rc_Xray(:)
real*8, allocatable:: ra_rnd_npr(:), dec_rnd_npr(:), z_rnd_npr(:), rc_rnd(:)
real*8, allocatable:: ra_rnd(:), dec_rnd(:), z_rnd(:)
real*8:: ra3_rnd, dec3_rnd 
real*8:: ra_rad, dec_rad, ra_rad_rnd, dec_rad_rnd, ra_rad_Xray, dec_rad_Xray
real*8:: x_one,y_one,z_one,  x_two,y_two,z_two,  zero 
real*8:: s,sa,sb,s_sq,s_squared,s_max,s_min,pi_max,pi_min, sigma_max,sigma_min
real*8:: my_sigma, delta_sigma, sigma_rad, sigma_deg, cos_theta, theta
real*8:: pi_para_one, sigma, pi_para_two, pi_para, pi_para_rnd, sigma_rnd
real*8:: z_min, z_max, hundred_z, zbin_width, z_offset, z_LRG_mean, para_one
real*8:: Landy, Szalay, k_max_RR, z_off
real*8:: ra_temp, dec_temp, z_fin_temp
real*8:: ra_min,  ra_max,  ra_min_rad,  ra_max_rad
real*8:: dec_min, dec_max, dec_min_rad, dec_max_rad
real*8:: Landy2d,  Szalay2d
integer:: k, k_max_DD, k_max_DR, k_sigma, k_pi_para
integer:: k_lin 
integer:: i,j, i_max, j_max, i_min, j_min, ten_i, ip_counter, l, m, n, o
integer:: N_lns, N_data, N_star, d, x, dummy_i, choice, choice_2
integer:: N_LRGs, N_LRG_sample, N_rnd, N_rnd_total, N_Xray


character:: dec_3char*3, choice_three*1
character, allocatable:: dec_sign(:)*1, dec_sign_rnd(:)*1, dec3char(:)*3
character, allocatable:: flags22(:)*8, flags23(:)*8, flags3(:)*8, flags2(:)*8
character, allocatable:: comments(:)*30,  SDSS_id(:)*18, date(:)*6
character, allocatable:: fld(:)*3, object_id(:)*20, object_sam_id(:)*20

real*8,  allocatable:: bin_DD(:), bin_DR(:), bin_DD_sigma(:), bin_DR_sigma(:)
real*8,  allocatable:: bin_DD_lin(:), bin_DR_lin(:), bin_RR_lin(:)
real*8,  allocatable:: Xi_sigma(:), delta_Xi_sigma(:), bin_sigma_pi(:,:)
real*8,  allocatable:: bin_DD_2d(:,:), bin_DR_2d(:,:), bin_RR_2d(:,:)
real*8,  allocatable:: ra_deg(:), dec_deg(:), xi(:), delta_xi(:) 
real*8,  allocatable:: xi_sigma_pi(:,:),delta_xi_sigma_pi(:,:), Xi_sigma_HAM(:)
real*8,  allocatable:: xi_sigma_pi_HAM(:,:), bin_sigma_pi_HAM(:,:)
real*8,  allocatable:: xi_sigma_pi_LS(:,:), Xi_sigma_LS(:),bin_sigma_pi_LS(:,:)
real*8:: lambda0, omega0, beta, pi, nRD_ratio, ra_off, dec_off, theta_cor
real*8:: rp,wp_norm,wperror,wp_div,wp, rp_lg, wp_lg, wp_div_siglg, wperror_lg
real*8:: z_LRGs_rminusi0pnt8
real*8:: matcher_lo, matcher_hi, matcher2_lo, matcher2_hi

pi = 3.141592654

write(*,*)
lambda0 = 0.7
omega0 = 0.3
beta = 0.0
call tabulate_dist(omega0, lambda0, beta) 
write(*,*)
!write(*,1010) 'omega,lambda,beta,EPS ', omega0, lambda0, beta
1010 format (a23, 2f6.3,2x, f4.2)



m = 80000   ! Size of data arrays, this could well need to be increased...
n = 1000000 ! Size of random arrays
o = 101     ! Size of xi(s) etc. arrays....
N_lns=0
N_data = 0
N_rnd = 0
N_star=0
N_LRGs = 0 


allocate(object_id(m),object_sam_id(m), SDSS_id(m), ra_J2K(m), dec_J2K(m))
allocate(ra_DR5Q(m), dec_DR5Q(m), z_DR5Q(m), rc_DR5Q(m))
allocate(ra_Xray(m), dec_Xray(m), z_Xray(m), rc_Xray(m))
allocate(x_coord(m), y_coord(m), z_coord(m))
allocate(ra_theta(m), dec_theta(m))
allocate(lrgsam(m), run(m), rerun(m), camCol(m), field(m), repeat(m))
allocate(fib(m), ra1(m), ra2(m), ra3(m), dec1(m), z_LRG(m))
allocate(dec2(m), dec3(m), r_mag(m), template(m), xcor(m))
allocate(dec_sign(m), dec_sign_rnd(m), dec3char(m))
allocate(z_abs(m), qa(m), z_fin(m),  qop(m),  f(m))
allocate(z_flag(m), fld(m),  date(m))
allocate(ra_deg(m), dec_deg(m), comments(m), r_fib(m))

allocate(theta_deg(41), theta_ams(41), w_theta_p(41), w_theta_z(41))
allocate(delta_w_theta_p(41),delta_w_theta_z(41),Mpc_sep(41),one_plus_ws(41))
allocate(ra_rnd_npr(n), dec_rnd_npr(n), z_rnd_npr(n), rc_rnd(n))
allocate(ra_rnd(n), dec_rnd(n), z_rnd(n))
allocate(x_coord_rnd(n), y_coord_rnd(n), z_coord_rnd(n))
allocate(x_coord_Xray(n), y_coord_Xray(n), z_coord_Xray(n))

allocate(z_rnd_bin(251), z_Xray_bin(251))
allocate(bin_DD(101), bin_RR(101), z_bin(251), bin_DR(101), bin(101))
allocate(bin_DD_lin(101), bin_DR_lin(101), bin_RR_lin(101))
allocate(bin_DD_sigma(101),bin_DR_sigma(101),Xi_sigma(101),delta_Xi_sigma(99))
allocate(bin_DD_2d(101,101), bin_DR_2d(101,101), bin_RR_2d(101,101))
allocate(xi(101), delta_xi(101), bin_sigma_pi(101,101))
allocate(xi_LS(101), bin_RR_sigma(101), xi_HAM(101))
allocate(xi_lin(101), delta_xi_lin(101), xi_LS_lin(101), xi_HAM_lin(101))
allocate(xi_sigma_pi(101,101), delta_xi_sigma_pi(101,101))
allocate(xi_sigma_pi_HAM(101,101),bin_sigma_pi_HAM(101,101),Xi_sigma_HAM(101))
allocate(xi_sigma_pi_LS(101,101), Xi_sigma_LS(101), bin_sigma_pi_LS(101,101))

write(*,*)
write(*,*)
open(33, file='w_theta_2SLAQ_Sam8_v3.dat')
i=0
istat=0
do while(istat .eq. 0) 
   i=i+1
   read(33,*, IOSTAT=istat) theta_deg(i), theta_ams(i), w_theta_p(i), &
        & w_theta_z(i), delta_w_theta_p(i), delta_w_theta_z(i), &
        & one_plus_ws(i), Mpc_sep(i) !NB THe Mpc_sep is for LCDM!!
end do
close(33)
write(*,*) 'Read-in w_theta_2SLAQ.dat', i
write(*,*) '******* CURRENTLY NO FIBRE COLLISION IS APPLIED!!!! ***********'

write(*,*) choice_three
write(*,*) 'Do you want to use the Landy-Szalay estimator? y/n'
choice_three = 'n'
write(*,*) choice, '  (choice)  ', choice_three, ' (choice_three)'


! I/P FILES

open(1,file='../data/DR5QSO_uni_data.dat')
open(2,file='../randoms/randoms_dat/randoms_npr_UNIFORM.dat')
open(3,file='../data/DR5QSO_uni_Xray_data.dat')


! O/P FILES
open( 9,file='k_output_UNI22_RASS_Xray_temp.dat')
open(10,file='k_output_lin_UNI22_RASS_Xray_temp.dat')
open(18,file='k2d_output_UNI22_RASS_Xray_temp.dat')
open(27,file='K_wp_output_UNI22_RASS_Xray_temp.dat')
!
open(44,file='z_values_UNI22_RASS_Xray.dat')
open(55,file='ra_dec_z_DR5Q_used_UNI22_RASS_Xray.dat')
open(56,file='ra_dec_z_randoms_used_UNI22_RASS_Xray.dat')
open(57,file='ra_dec_z_Xray_used_UNI22_RASS_Xray.dat')
!
!!open(2,file='sanity_check.dat')
!!open(2, file='2df_LRG_formatted6970.dat')
!!open(14, file='2df_LRG_formatted.dat')
!!open(89, file='sanity_check.dat')
!!open(91, file='capital_xi.dat')
!!open(77,file='wp_sig_2dfgrs.dat')

count_lt  = 0
count_mid = 0
count_gt = 0
repeat_counter = 0
z_fin = 0.000
z_max = 0.000
z_min = 1.000
z_bin = 0
z_rnd_bin=0
z_LRG_mean = 0
xi = 0.0
bin_DD = 0.0
bin_DR = 0.0
bin_RR = 0.0
bin_DD_lin = 0.0
bin_DR_lin = 0.0
bin_RR_lin = 0.0
bin_DD_2d = 0.0
bin_DR_2d = 0.0
bin_RR_2d = 0.0
bad_pi_para =0

zbin_width = 0.05
z_offset = (zbin_width / 2.0)
zbin_width = (1.0/zbin_width)

ra_min = 0.0000
ra_max = 360.0000
!0.0 !36.47 !151.333 !160.01 !185.386 !201.410! 210.096! 222.335! 324.035 !360
!120.0 !145.0 !175.0 !195.0 !215.0 !240.0 !300.0 !330.0 !360.0 !0.0 !30.0!60.0

dec_min = -20.000
dec_max = 90.000


z_min = 0.300
z_max = 2.200
!! 0.300, 0.680, 0.920, 1.130, 1.320, 1.500, 1.660, 1.83, 2.02 
!!



ra_min_rad = (ra_min/180.0) * pi
ra_max_rad = (ra_max/180.0) * pi
write(*,*)
write(*,*)         'ra_min, ra_max, ra_min_rad, ra_max_rad'
write(*,'(4f11.3)') ra_min, ra_max, ra_min_rad, ra_max_rad

dec_min_rad = (dec_min/180.0) * pi
dec_max_rad = (dec_max/180.0) * pi
write(*,*)         'dec_min, dec_max, dec_min_rad, dec_max_rad'
write(*,'(4f11.3)') dec_min, dec_max, dec_min_rad, dec_max_rad

write(*,*)        'z_min,   z_max'
write(*,'(2f6.3)') z_min, z_max
write(*,*)
write(*,*)
write(*,*)

i=0
istat=0
N_LRG_sample = 0
do while (istat .eq. 0) 
   i=i+1
   read(1, *, IOSTAT=istat) ra_DR5Q(i), dec_DR5Q(i), z_DR5Q(i), rc_DR5Q(i)

!! Not for jackknifes:
   if(  ((ra_DR5Q(i) .ge. ra_min) .and. (ra_DR5Q(i) .le. ra_max)) .and. & 
        ((dec_DR5Q(i) .ge. dec_min) .and. (dec_DR5Q(i) .le. dec_max))) then
   
!! For jackknifes:
!   if(  ((ra_DR5Q(i) .le. ra_min) .or. (ra_DR5Q(i) .ge. ra_max)) .or. & 
!        ((dec_DR5Q(i) .le. dec_min) .or. (dec_DR5Q(i) .ge. dec_max))) then
      
      if((z_DR5Q(i) .ge. z_min) .and. (z_DR5Q(i) .le. z_max)) then
         
         N_LRG_sample = N_LRG_sample + 1
         ra_J2K(N_LRG_sample)  =  ra_DR5Q(i)
         dec_J2K(N_LRG_sample) = dec_DR5Q(i)
         z_fin(N_LRG_sample)   =   z_DR5Q(i)
         
         d = int(z_fin(N_LRG_sample) * zbin_width) + 1
         if(d .ge. 1 .and. d .le. 170) z_bin(d) = z_bin(d) + 1
         
         ra_rad  = ( ra_J2K(N_LRG_sample)/180.) * pi
         dec_rad = (dec_J2K(N_LRG_sample)/180.) * pi
         x_coord(N_LRG_sample) = rc_DR5Q(i) * cos(dec_rad) * cos(ra_rad)  
         y_coord(N_LRG_sample) = rc_DR5Q(i) * cos(dec_rad) * sin(ra_rad)  
         z_coord(N_LRG_sample) = rc_DR5Q(i) * sin(dec_rad)
         
         write(55,*) ra_J2K(N_LRG_sample), dec_J2K(N_LRG_sample), z_fin(N_LRG_sample)          
         !         end if
      end if
   end if
end do
write(*,*) 'Read-in data  points', i, ' of which', N_LRG_sample, 'are in the sample' 
write(*,*) 'i.e.', (N_LRG_sample/38208.)*100., '% of the FULL UNIFORM sample'
close(55)
write(*,*)


i=0
istat=0
N_rnd=0
N_rnd_total = N_LRG_Sample * 20.
do while (istat .eq. 0) 
   i=i+1
   
   read(2,*,IOSTAT=istat) ra_rnd_npr(i), dec_rnd_npr(i), z_rnd_npr(i), rc_rnd(i)

   if( ((ra_rnd_npr (i)  .ge. ra_min)  .and. (ra_rnd_npr(i) .le. ra_max)) .and. &
        ((dec_rnd_npr(i) .ge. dec_min) .and. (dec_rnd_npr(i) .le. dec_max))) then
!   if( ((ra_rnd_npr (i) .le. ra_min) .or. (ra_rnd_npr(i) .ge. ra_max)) .or. &
!        ((dec_rnd_npr(i) .le. dec_min) .or. (dec_rnd_npr(i) .ge. dec_max))) then

      if((z_rnd_npr(i) .ge. z_min) .and. (z_rnd_npr(i) .le. z_max)) then
         
         N_rnd = N_rnd + 1
         ra_rnd(N_rnd)  =  ra_rnd_npr(i)
         dec_rnd(N_rnd) = dec_rnd_npr(i)
         z_rnd(N_rnd)   =   z_rnd_npr(i)
         
         d = int(z_rnd(N_rnd) * zbin_width) + 1
         if(d .ge. 1 .and. d .le. 170) z_rnd_bin(d) = z_rnd_bin(d) + 1
         
         ra_rad_rnd  = ( ra_rnd(N_rnd)/180.) * pi
         dec_rad_rnd = (dec_rnd(N_rnd)/180.) * pi
         x_coord_rnd(N_rnd) = rc_rnd(i) * cos(dec_rad_rnd) * cos(ra_rad_rnd)  
         y_coord_rnd(N_rnd) = rc_rnd(i) * cos(dec_rad_rnd) * sin(ra_rad_rnd)  
         z_coord_rnd(N_rnd) = rc_rnd(i) * sin(dec_rad_rnd)
         
         write(56,*)  ra_rnd(N_rnd), dec_rnd(N_rnd), z_rnd(N_rnd) 
         
         ! end if
      end if
   end if
   
!   if (N_rnd .ge. N_rnd_total) istat =1
end do
!write(*,*) 'Read-in random points', N_rnd, 'equals', (N_rnd/173120.)*100.,'%'
write(*,*) 'Read-in random points',  i,  'equals', (N_rnd/1000000.)*100.,'%'
write(*,*) 'N_rnd', N_rnd,   'and cf. N_LRG_sample*20=', N_rnd_total
close(56) 
write(*,*)



i=0
istat=0
N_Xray=0
do while (istat .eq. 0) 
   i=i+1
   
   read(3,*,IOSTAT=istat) ra_Xray(i), dec_Xray(i), z_Xray(i), rc_Xray(i)

   if( ((ra_Xray (i)  .ge. ra_min)  .and. (ra_Xray(i) .le. ra_max)) .and. &
        ((dec_Xray(i) .ge. dec_min) .and. (dec_Xray(i) .le. dec_max))) then
!   if( ((ra_Xray (i) .le. ra_min) .or. (ra_Xray(i) .ge. ra_max)) .or. &
!        ((dec_Xray(i) .le. dec_min) .or. (dec_Xray(i) .ge. dec_max))) then

      if((z_Xray(i) .ge. z_min) .and. (z_Xray(i) .le. z_max)) then
         
         N_Xray           =  N_Xray + 1
         ra_Xray(N_Xray)  =  ra_Xray(i)
         dec_Xray(N_Xray) =  dec_Xray(i)
         z_Xray(N_Xray)   =  z_Xray(i)
         
         d = int(z_Xray(N_Xray) * zbin_width) + 1
         if(d .ge. 1 .and. d .le. 170) z_Xray_bin(d) = z_Xray_bin(d) + 1
         
         ra_rad_Xray  = ( ra_Xray(N_Xray)/180.) * pi
         dec_rad_Xray = (dec_Xray(N_Xray)/180.) * pi
         x_coord_Xray(N_Xray) = rc_Xray(i) * cos(dec_rad_Xray) * cos(ra_rad_Xray)  
         y_coord_Xray(N_Xray) = rc_Xray(i) * cos(dec_rad_Xray) * sin(ra_rad_Xray)  
         z_coord_Xray(N_Xray) = rc_Xray(i) * sin(dec_rad_Xray)
         
         write(57,*)  ra_Xray(N_Xray), dec_Xray(N_Xray), z_Xray(N_Xray) 
         
         ! end if
      end if
   end if
   
!   if (N_Xray .ge. N_Xray_total) istat =1
end do
write(*,*) 'Read-in X-ray points', N_Xray, 'equals', (N_Xray/2712.)*100.,'%'
write(*,*) 'N_Xray', N_Xray, 'N_Xraye sample*20=', N_Xray*20
close(57) 
write(*,*)
write(*,*)
write(*,*)




bin = 0
s_max = 0.0
pi_max = 0.0
sigma_max = 0.0
s_min = 10.0
pi_min = 10.0
sigma_min = 10.0
k_max_DD = 0
k_max_DR = 0
pair_count = 0
theta_cor =  1.00

write(*,*)  'matcher_lo  matcher_hi  matcher2_lo matcher2_hi'
matcher_lo = 0.0
matcher_hi = 0.5
matcher2_lo = 0.0
matcher2_hi = 0.5
!read(*,*)  matcher_lo !, matcher_hi, matcher2_lo, matcher2_hi
write(*,*) matcher_lo, matcher_hi, matcher2_lo, matcher2_hi
write(*,*)
write(*,*)


!!!  A  LOOP  A  LOOP  A  LOOP !  A  LOOP  A  LOOP  A  LOOP 
!!!  A  LOOP  A  LOOP  A  LOOP !  A  LOOP  A  LOOP  A  LOOP 
!!! Now we're gonna try and work out the separation between the
!!! Quasars and the X-ray sources, i.e. the XRAY-DATA point, XD. 
!!!
!!! (Though currently everything is still reffered to as DD's)
do i=1, N_LRG_sample
   if(i .eq. (int(N_LRG_sample/4))) write(*,*) '1/4 done on XDs'
   if(i .eq. (int((3*N_LRG_sample)/4))) write(*,*) '3/4 done on XDs'

   x_one = x_coord(i)
   y_one = y_coord(i)
   z_one = z_coord(i)
   zero = 0.0
   pi_para_one = (sqrt(s_squared(x_one,y_one,z_one,zero, zero,zero)))

   do j=1,N_Xray
      x_two = x_coord_Xray(j)
      y_two = y_coord_Xray(j)
      z_two = z_coord_Xray(j)
      pi_para_two = (sqrt(s_squared(x_two,y_two,z_two,zero,zero,zero)))
      pi_para = abs(pi_para_one - pi_para_two)
      if(pi_para .eq. 0.0) pi_para = 0.000001

      s_sq =  (s_squared(x_one,y_one,z_one,x_two,y_two,z_two))
      s = (sqrt(s_sq))  

      my_sigma = (sqrt(s_sq - (pi_para**2)))
      sigma=my_sigma
      
      if( (sigma .gt. matcher_lo .and. sigma .lt. matcher_hi) .and. &
           & (pi_para .gt. matcher2_lo .and. pi_para .lt. matcher2_hi))then
         pair_count = pair_count+1
      end if

      if (s .ne. 0 .and. sigma .ne. 0 .and. pi_para .ne. 0) then
         !if (s .ne. 0) then
         if(s.gt.s_max)  s_max = s
         if(s.lt.s_min)  s_min = s
         if(sigma.gt.sigma_max)  sigma_max = sigma
         if(sigma.lt.sigma_min)  sigma_min = sigma
         if(pi_para.gt.pi_max)  pi_max = pi_para
         if(pi_para.lt.pi_min)  pi_min =pi_para
         
         !k         = int((log10(s)*5) + 12)   ! Which "bucket" it goes into
         k         = int((log10(s)*10.) + 12)
         k_lin     = int(s/50.) + 1

         k_sigma   = int((log10(sigma)*5) + 12) ! THIS HAS ALWAYS WORKED!!!!
         k_pi_para = int((log10(pi_para)*5) + 12) ! THIS HAS ALWAYS WORKED!!!!
         
         if (k .gt. k_max_DD)  k_max_DD = k

         !if (k .le. 24 .and.k .gt. 0) then !when k = int((log10(s)*5) + 12
         if (k .le. 56 .and.k .gt. 0) then
            bin_DD(k) = bin_DD(k) + 2 !WITHOUT w_theta correction!!
            
            !if (k_sigma .le. 56 .and. k_pi_para .le. 56 .and. &
            !if (k_sigma .le. 40 .and. k_pi_para .le. 40 .and. & !For Petals
            if (k_sigma .le. 22 .and. k_pi_para .le. 22 .and. &
                 & k_sigma .gt. 0 .and. k_pi_para .gt. 0) then                 
               
               bin_DD_2d(k_sigma,k_pi_para) = &
                    &     bin_DD_2d(k_sigma,k_pi_para) + 2
               
            end if
         end if !(k .le. 24/56 .and.k .gt. 0)
         
         if (k_lin.le.56 .and. k_lin.gt.0) bin_DD_lin(k_lin)=bin_DD_lin(k_lin)+2 
            !WITHOUT w_theta correction!! !k_lin 56 => cut-off at s=275
         
         counter_two = counter_two +1 
      end if !(s .ne. 0 .and. sigma .ne. 0 .and. pi_para .ne. 0) then

      !! Looing at small separations...
      if (s.lt. 3.0) then 
         write(72,*) x_one, y_one, z_one,  pi_para_one
         write(72,*) x_two, y_two, z_two,  pi_para_two
         write(72,*) s,10**((float(k)-12+0.5)/10.), &
              & 10**((float(k)-11+0.5)/10.), k, bin_DD(k),  theta_cor
         write(72,*)
      end if
      
   end do !do j= 1, N_Xray 
end do    !do i= 1, N_LRG_sample-1
close(72)


write(*,*)
write(*,*) 'Finished working out XDs, k_max_DD', k_max_DD
write(*,*)
write(*,*) 'counter',counter,'counter_two', counter_two
write(*,*) 's_min_XD', s_min, 's_max_XD', s_max
write(*,*) 's_max, pi_max, sigma_max'
write(*,*)  s_max, pi_max, sigma_max
write(*,*) 's_min, pi_min, sigma_min'
write(*,*)  s_min, pi_min, sigma_min
write(*,*) 
write(*,*) '************* pair_count **************'
write(*,*) '*************', pair_count, '**************'
write(*,*)
write(*,*) 'N_LRGs', N_LRG_sample, 'N_rnd', N_rnd !, 'int_s', int_s
write(*,*)
write(*,*) 'k, (float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.),  bin_DD(k)'
do k=1,56
   if(bin_DD(k) .gt. 0) then
      write(*,*) k, (float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.),  bin_DD(k)
   end if
end do
write(*,*)




write(*,*) 'Now working out DRs, no of randoms', N_rnd  
!!  B  LOOP  B  LOOP  B  LOOP   B  LOOP  B  LOOP  B  LOOP
!!  B  LOOP  B  LOOP  B  LOOP   B  LOOP  B  LOOP  B  LOOP
!!  B  LOOP  B  LOOP  B  LOOP   B  LOOP  B  LOOP  B  LOOP
!!
!! We are now going to compare the separations between the real data
!! and a collection of random points, so this is the DR loop.
!! Well, actually, we're going to compare the X-ray to Random separations
!! so this becomes the XR loop....
do i=1,N_Xray
!do i=1,100
   if(i .eq. (int(N_Xray/4))) write(*,*) '1/4 done on DRs'
   if(i .eq. (int((3*N_Xray)/4))) write(*,*) '3/4 done on DRs'
   x_one = x_coord_Xray(i)
   y_one = y_coord_Xray(i)
   z_one = z_coord_Xray(i)
   pi_para_one = (sqrt(s_squared(x_one,y_one,z_one,zero,zero,zero)))
   
   do j=1,N_rnd 
      x_two = x_coord_rnd(j)
      y_two = y_coord_rnd(j)
      z_two = z_coord_rnd(j)
      pi_para_two = (sqrt(s_squared(x_two,y_two,z_two,zero,zero,zero)))
      s_sq =  s_squared(x_one,y_one,z_one,x_two,y_two,z_two)
      s = (sqrt(s_sq))  
      pi_para = abs(pi_para_one - pi_para_two)
      sigma=sqrt(s_sq-(pi_para**2)) 
      
      if(s.gt.s_max) s_max = s
      if(s.lt.s_min) s_min = s 
      
      if (s .ne. 0 .and. sigma .ne. 0 .and. pi_para .ne. 0) then
         k     = int((log10(s)*10) + 12)
         !k     = int((log10(s)*5) + 12)
         k_lin     = int(s/50.) + 1
         !else
         !   k = (int(s/10.) + 21) 
         !end if
         
         k_sigma = int((log10(sigma)*5) + 12)
         k_pi_para = int((log10(pi_para)*5) + 12)
         !k_sigma = int((log10(sigma)*10) + 12)
         !k_pi_para = int((log10(pi_para)*10) + 12)
         !k_sigma   = int(sigma)   +1 !USE FOR xi(sigma,pi) "Petal plots" 
         !k_pi_para = int(pi_para) +1 !USE FOR xi(sigma,pi) "Petal plots" 
         
         !if(k.le. 22) write(*,*) 's_sq', s_sq, 's', s,'DR k values', k
         if (k .gt. k_max_DR)  k_max_DR = k
         !if (k .le. 24 .and. k .gt. 0)   bin_DR(k) = bin_DR(k) + 1 
         if (k .le. 56 .and. k .gt. 0)   bin_DR(k) = bin_DR(k) + 1
         if (k_lin .le. 56 .and. k_lin .gt. 0) bin_DR_lin(k_lin)=bin_DR_lin(k_lin)+1 
         !if (k_sigma .le. 56 .and. k_pi_para .le. 56 .and. &
         !if (k_sigma .le. 40 .and. k_pi_para .le. 40 .and. &
         if (k_sigma .le. 22 .and. k_pi_para .le. 22 .and. &
              & k_sigma .gt. 0 .and. k_pi_para .gt. 0) then
            bin_DR_2d(k_sigma,k_pi_para) =bin_DR_2d(k_sigma,k_pi_para) + 1
         end if
      end if !(s .ne. 0) 
   end do !j=1,N_rnd
end do !i=1,N_LRG_sample 
write(*,*) 'DRs done'
write(*,*) 'i', i, 'j',j, 's_max,',s_max,'s_min', s_min
write(*,*)
write(*,*) 'log_s,   s,   xi(s),    delta_xi,   bin_DD,    bin_DR' 

nRD_ratio = ( real(N_rnd) / real(N_LRG_sample))

do k=1,56
   !if(bin_DR(k) .gt. 0) then
   if (bin_DR(k) .ne. 0 .and. bin_DD(k) .ne. 0) then
      
      xi(k) = (nRD_ratio *(bin_DD(k) / bin_DR(k))) - 1.0
      delta_xi(k) = (1 + xi(k)) * (sqrt(2.0 / bin_DD(k)))
      write(*,*) (float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.), & 
!      write(*,*) (float(k)-12+0.5)/5., 10**((float(k)-12+0.5)/5.), & 
           & xi(k),  delta_xi(k), &
           & bin_DD(k), bin_DR(k)
!      write(*,*) (float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.),  bin_DR(k), ((N_rnd/N_LRG_sample)*(bin_DD(k)/ bin_DR(k))-1.)
   end if
end do
write(*,*)





nRD_ratio = ( real(N_rnd) / real(N_LRG_sample))
write(*,*) 'nRD_ratio', nRD_ratio, 'N_rnd', N_rnd, & 
     & 'N_data', N_data, 'N_LRGs', N_LRGs, 'N_LRG_sample', N_LRG_sample
!open(9,file='k_output.dat')
!write(9,*) '# float(k)-0.5)/5, xi, delta_xi, bin_DD, bin_DR'
!write(*,*) '(float(k)-12+0.5)/5., 10**((float(k)-12+0.5)/5.), & 
write(*,*) '(float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.), & 
     & xi(k), delta_xi(k), &
     & bin_DD(k), bin_DR(k), bin_RR(k), bin_DR(k)/nRD_ratio'

do k=1,56
   if (bin_DR(k) .ne. 0 .and. bin_DD(k) .ne. 0) then
      
      xi(k) = (nRD_ratio *(bin_DD(k) / bin_DR(k))) - 1.0
      delta_xi(k) = (1 + xi(k)) * (sqrt(2.0 / bin_DD(k)))

      !write(9,*) (float(k)-12+0.5)/5., 10**((float(k)-12+0.5)/5.), & 
      !    & xi(k),delta_xi(k), bin_DD(k), bin_DR(k), bin_DR(k)/nRD_ratio
      
      if (choice_three .eq. 'y' .and. bin_RR(k) .ne.  0) then 
         Landy = (nRD_ratio**2) * ( bin_DD(k)/bin_RR(k) )  
         Szalay = 2.0 * nRD_ratio * ( bin_DR(k) / bin_RR(k)) 
         xi_LS(k)  = 1 + Landy - Szalay
         xi_HAM(k) = ((bin_DD(k) * bin_RR(k)) / (bin_DR(k)**2)) - 1.0
         
      end if

      write(9,1499) (float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.), & 
           & xi(k),  delta_xi(k), &
           & bin_DD(k), bin_DR(k), bin_DR(k)/nRD_ratio
!      write(9,1500) (float(k)-12+0.5)/10., 10**((float(k)-12+0.5)/10.), & 
!           & xi(k),  delta_xi(k), &
!           & bin_DD(k), bin_DR(k), bin_RR(k), &
!           & xi_LS(k), xi_HAM(k), bin_DR(k)/nRD_ratio


   end if ! if (bin_DR(k) .ne. 0 .and. bin_DD(k) .ne. 0) th
end do !k=1,56
close(9)
write(*,*) 'xi(s) HAS BEEN CALCULATED!'
1499 format (f5.2,1x,   f15.6,1x, &
          &  f15.8,1x, f18.13,1x,   &
          &  f18.0,1x,    f18.0,1x, f21.5)
1500 format (f5.2,1x,   f15.6,1x, &
          &  f15.8,1x, f18.13,1x,   &
          &  f18.0,1x,    f18.0,1x, f18.0,1x, &
          &  f18.10,1x, f18.10,1x, f21.5)




do k_lin=1,56
   if (bin_DR_lin(k_lin) .ne. 0 .and. bin_DD_lin(k_lin) .ne. 0) then
      
      xi_lin(k_lin) = (nRD_ratio *(bin_DD_lin(k_lin) / bin_DR_lin(k_lin))) - 1.0
      delta_xi_lin(k_lin) = (1 + xi_lin(k_lin)) * (sqrt(2.0 / bin_DD_lin(k_lin)))

      if (choice_three .eq. 'y' .and. bin_RR_lin(k_lin) .ne.  0) then 
         Landy = (nRD_ratio**2) * ( bin_DD_lin(k_lin)/bin_RR_lin(k_lin) )  
         Szalay = 2.0 * nRD_ratio * ( bin_DR_lin(k_lin) / bin_RR_lin(k_lin)) 
         xi_LS_lin(k_lin)  = 1 + Landy - Szalay
         xi_HAM_lin(k_lin) = ((bin_DD_lin(k_lin) * bin_RR_lin(k_lin)) / (bin_DR_lin(k_lin)**2)) - 1.0
      end if
      
      write(10,1510) k_lin, (k_lin-.5)*5., & 
           & xi_lin(k_lin),  delta_xi_lin(k_lin), &
           & bin_DD_lin(k_lin), bin_DR_lin(k_lin), bin_RR_lin(k_lin), &
           & xi_LS_lin(k_lin), xi_HAM_lin(k_lin), bin_DR_lin(k_lin)/nRD_ratio

   end if ! if (bin_DR_lin(k_lin) .ne. 0 .and. bin_DD_lin(k_lin) .ne. 0) th
end do !k_lin=1,56
write(*,*) 'xi(s) (linear) HAS BEEN CALCULATED!'
1510 format (i4,1x,   f8.4,1x, &
          &  f15.8,1x, f18.13,1x,   &
          &  f18.0,1x,    f18.0,1x, f18.0,1x, &
          &  f18.10,1x, f18.10,1x, f21.5)
close(10)











!open(18,file='k2d_output.dat')
!open(27,file='K_output.dat')
xi_sigma_pi=0.0
xi_sigma_pi_HAM=0.0
xi_sigma_pi_LS=0.0
bin_sigma_pi=0.0
bin_sigma_pi_HAM=0.0
bin_sigma_pi_LS=0.0
Xi_sigma=0.0
Xi_sigma_HAM=0.0
Xi_sigma_LS=0.0

do k_sigma=1,22
!do k_sigma=1,56 
!do k_sigma=1,41
   do k_pi_para=1,22
   !do k_pi_para =1,56 
   !do k_pi_para =1,41
      
      if(bin_DR_2d(k_sigma,k_pi_para) .ne. 0 .and. &
           & bin_DD_2d(k_sigma,k_pi_para) .ne. 0) then
         
         xi_sigma_pi(k_sigma,k_pi_para) = (-1.0) + (nRD_ratio * &
              & (bin_DD_2d(k_sigma,k_pi_para) / bin_DR_2d(k_sigma,k_pi_para)))

         
         if (choice_three.eq.'y' .and. bin_RR_2d(k_sigma,k_pi_para).ne.0) then
            xi_sigma_pi_HAM(k_sigma,k_pi_para) = ((bin_DD_2d(k_sigma,k_pi_para)* &
                 & bin_RR_2d(k_sigma,k_pi_para)) / (bin_DR_2d(k_sigma,k_pi_para)**2)) - 1.0
            
            Landy2d = (nRD_ratio**2) * &
                 & (bin_DD_2d(k_sigma,k_pi_para)/bin_RR_2d(k_sigma,k_pi_para))
            Szalay2d =  (2.0 * nRD_ratio) * &
                 & (bin_DR_2d(k_sigma,k_pi_para)/bin_RR_2d(k_sigma,k_pi_para))
            xi_sigma_pi_LS(k_sigma,k_pi_para) =  1 + Landy2d - Szalay2d
            
         end if
         
         delta_xi_sigma_pi(k_sigma,k_pi_para) = (1.0 + &
              & xi_sigma_pi(k_sigma,k_pi_para)) &
              & * (sqrt(2.0 / bin_DD_2d(k_sigma,k_pi_para))) 
         
         if(k_pi_para .le. 20) then 
            !le 19 => Putting a pi_para cut in at 31 h^-1 Mpc,  5 bins per decade
            !le 20 => Putting a pi_para cut in at 63 h^-1 Mpc,  5 bins per decade
            !if(k_pi_para .le. 39) then !for 5 bins/decade=>21; 10/dec => pi=39
            !if(k_pi_para .le. 40) then !Putting a pi_para cut in at 40Mpc 
            
            !if(k_pi_para .eq. 1) then 
            ! bin_sigma_pi(k_sigma,k_pi_para)=xi_sigma_pi(k_sigma,k_pi_para) &
            !      & * (10**((float(k_pi_para)-11)/10.))
            !& * (10**((float(k_pi_para)-12)/10.))
            !else
            bin_sigma_pi(k_sigma,k_pi_para)=xi_sigma_pi(k_sigma,k_pi_para) &
                 & *(10**((float(k_pi_para)-11)/5.) &
                 &  - 10**((float(k_pi_para)-12)/5.)) 
            
            if (choice_three.eq.'y' .and. bin_RR_2d(k_sigma,k_pi_para).ne.0) then
               bin_sigma_pi_HAM(k_sigma,k_pi_para) = &
                    & xi_sigma_pi_HAM(k_sigma,k_pi_para) &
                    & *(10**((float(k_pi_para)-11)/5.) &
                    &  - 10**((float(k_pi_para)-12)/5.)) 
               bin_sigma_pi_LS(k_sigma,k_pi_para) = &
                    & xi_sigma_pi_LS(k_sigma,k_pi_para) &
                    & *(10**((float(k_pi_para)-11)/5.) &
                    &  - 10**((float(k_pi_para)-12)/5.)) 
            end if
            !bin_sigma_pi(k_sigma,k_pi_para)=xi_sigma_pi(k_sigma,k_pi_para) &
            !     & *(10**((float(k_pi_para)-11)/10.) &
            !     &  - 10**((float(k_pi_para)-12)/10.)) 
            !end if
         end if
         
         Xi_sigma(k_sigma)=Xi_sigma(k_sigma) + &
              & (2*bin_sigma_pi(k_sigma,k_pi_para))

!         Xi_sigma_HAM(k_sigma)=Xi_sigma_HAM(k_sigma)+ &
!              & (2*bin_sigma_pi_HAM(k_sigma,k_pi_para))
!         Xi_sigma_LS(k_sigma)= Xi_sigma_LS(k_sigma) + &
!              & (2*bin_sigma_pi_LS(k_sigma,k_pi_para)) 

         bin_DD_sigma(k_sigma)=bin_DD_sigma(k_sigma) + &
              & (bin_DD_2d(k_sigma,k_pi_para))
         bin_DR_sigma(k_sigma)=bin_DR_sigma(k_sigma) + &
              & (bin_DR_2d(k_sigma,k_pi_para))
         
         write(98,*) (10**((float(k_sigma)-12+0.5)/5.)), &
              & k_sigma, k_pi_para,  xi_sigma_pi(k_sigma,k_pi_para), &
              & (10**((float(k_pi_para)-11)/5.)), &
              & (10**((float(k_pi_para)-12)/5.)), &
              & bin_sigma_pi(k_sigma,k_pi_para),  Xi_sigma(k_sigma)
         
         ! write(*,*) 10**((float(k_sigma)-12+0.5)/5.), &
         !     & 10**((float(k_sigma)-12+0.5)/5.), &
         !    & xi_sigma_pi(k_sigma,k_pi_para), &
         !    & bin_DD_2d(k_sigma,k_pi_para),  bin_DR_2d(k_sigma,k_pi_para)
         
      end if !(bin_DR_2d(k_sigma,k_pi_para).ne.0 .and. bin_DD_2d(k_sigma)...
      
      if (k_sigma .ge. 6 .and. k_pi_para .ge. 6) then    
         write(18,*) 10**((float(k_sigma)-12+0.5)/5.), & !-12+0.5/5.)
              & 10**((float(k_pi_para)-12+0.5)/5.), k_sigma, k_pi_para, &
              !write(18,*) 10**((float(k_sigma)-12+0.5)/10.), & !-12+0.5/5.)
              !    & 10**((float(k_pi_para)-12+0.5)/10.), k_sigma, k_pi_para, &
              !if (k_sigma .ge. 0 .and. k_pi_para .ge. 0) then    
              !  write(18,*) real(k_sigma),real(k_pi_para),k_sigma,k_pi_para, &
              & xi_sigma_pi(k_sigma,k_pi_para), &
              & delta_xi_sigma_pi(k_sigma,k_pi_para), & 
              & bin_DD_2d(k_sigma,k_pi_para), bin_DR_2d(k_sigma,k_pi_para) !, &   
!              & bin_RR_2d(k_sigma,k_pi_para), &
!              & xi_sigma_pi_HAM(k_sigma,k_pi_para), &
!              & xi_sigma_pi_LS(k_sigma,k_pi_para)
      end if
   end do !k_pi_para=1,22      
   
   
   if(bin_DD_sigma(k_sigma) .ne. 0 .and. bin_DR_sigma(k_sigma) .ne. 0) then
      delta_Xi_sigma(k_sigma) = (1 + Xi_sigma(k_sigma)) &
           & * (sqrt(2.0 / bin_DD_sigma(k_sigma)))
   else
      delta_Xi_sigma(k_sigma) = 0.
   end if
   !   27,file= K_output_2SLAQ.dat
   if(Xi_sigma(k_sigma) .ne. 0.0) then
      write(27,*) 10**((float(k_sigma)-12+0.5)/5.), &
           & (float(k_sigma)-12+0.5)/5., &
           !write(27,*) 10**((float(k_sigma)-12+0.5)/10.), &
           !     & (float(k_sigma)-12+0.5)/10., &
           & Xi_sigma(k_sigma), delta_Xi_sigma(k_sigma), &
           & bin_DD_sigma(k_sigma),bin_DR_sigma(k_sigma) !, &
!           & Xi_sigma_HAM(k_sigma), Xi_sigma_LS(k_sigma)
   end if
   
end do !k_sigma =1,22

close(18)
close(27)
close(98)

close(1)
close(2)


write(*,*)
write(*,*)
write(*,*) 'almost there..'
write(*,*) 'z_max', z_max, 'zbin_wdith', zbin_width
N_data = N_LRG_sample
N_star = 1
z_max_int = int(z_max * zbin_width) + 2
write(*,*) 'z_max_int', z_max_int
do i = z_max_int,1,-1
!do i = 175,1,-1
   hundred_z = real( i / zbin_width)  
   cumulate = cumulate + int(z_bin(i))
   write(*,1600) hundred_z, int(z_bin(i)), int(z_rnd_bin(i))
   write(44,1600) hundred_z, int(z_bin(i)),  int(z_rnd_bin(i))
end do
!write(44,1600) 0.000, N_star,1.000
!write(44,1600) -0.020, 0 ,1.000
write(*,*) ' Closing time.'
1600 format (f6.3,1x, i6,2x, i6,2x)


close(44)
!close(89)


!end do !jack =1,32

write(*,*) 'DONE AND DUSTED'

end program correlfive






function s_squared (a_one,b_one,c_one,a_two,b_two,c_two)
  implicit none
  
  real*8:: s_squared
  real*8:: a_one,b_one,c_one,a_two,b_two,c_two

  !write(*,*) 'in the function', a_one,b_one,c_one,a_two,b_two,c_two
  s_squared = ((a_two-a_one)**2 + (b_two-b_one)**2 + (c_two-c_one)**2) 
  
  return
end function  s_squared








