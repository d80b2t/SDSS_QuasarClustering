! Small bit of F90 FORTRAN code to match the SDSS Spec-z DR5 quasars, with
! local, i.e. ~<55'' counterparts, in order to investigate the small-scales
! of the quasar xi(s).


program photoz_match

implicit none


integer:: i, j, m, n, istat
integer:: N_DR5Q, N_poa, N_close_objs
integer:: test_hex
integer*8, allocatable:: objID(:), primTarget(:), status(:), flags(:)
integer*8, allocatable:: run(:),  rerun(:), camcol(:), field(:), obj(:)
integer*8, allocatable:: mode(:), type(:), probPSF(:), insideMask(:)

real*8:: z_fin_max, ra_poa_min, dec_poa_min, ra_poa_max, dec_poa_max
real*8:: delta_ra_ams, delta_dec_ams, diff
real*8, allocatable:: ra_J2K(:), dec_J2K(:)
real*8, allocatable:: ra_poa(:), dec_poa(:)
real*8, allocatable:: u(:), g(:), r(:), i_mag(:), z(:)
real*8, allocatable:: u_err(:), g_err(:), r_err(:), i_magerr(:), z_err(:)
real*8, allocatable:: z_fin(:)
real*8, allocatable:: psfMag_u(:),psfMag_g(:),psfMag_r(:),psfMag_i(:),psfMag_z(:)
real*8, allocatable:: psfMagErr_u(:), psfMagErr_g(:), psfMagErr_r(:)
real*8, allocatable:: psfMagErr_i(:), psfMagErr_z(:)
   
character, allocatable:: obj_DR5Q(:)*18

test_hex = Z'100'
write(*,*) Z'100', test_hex
write(*,*) Z'00', Z'FF'
write(*,1003) Z'10'+Z'1F'
write(*,*) IAND(Z'10', Z'1F')
!write(*,*) 'B01010101010101010101010101010101, O01234567, ZABCDEF'
!write(*,*) B'01010101010101010101010101010101', O'01234567', Z'ABCDEF'


m=80000
n=250000
allocate(objID(n), obj_DR5Q(m), primTarget(n), status(n), flags(n))
allocate(run(n),  rerun(n), camcol(n), field(n), obj(n))
allocate(mode(n), type(n), probPSF(n), insideMask(n))
allocate(ra_poa(n), dec_poa(n), ra_J2K(m), dec_J2K(m))
allocate(u(m), g(m), r(m), i_mag(m), z(m))
allocate(u_err(m), g_err(m), r_err(m), i_magerr(m), z_err(m))
allocate(psfMag_u(n), psfMag_g(n), psfMag_r(n), psfMag_i(n), psfMag_z(n))
allocate(psfMagErr_u(n), psfMagErr_g(n), psfMagErr_r(n))
allocate(psfMagErr_i(n), psfMagErr_z(n))
allocate(z_fin(m))

! I/P
! The one of the mini DR5Q cats or do we want the colour info as well?
open(1, file="../../../data/Quasars/DR5/DR5.cat") 
!open(1, file="../../../data/Quasars/DR5/DR5_mini.cat") 
! The photobjall table, 202958 strong with primflag & 0x...1f. 
! Also colour info here too??
open(2, file="../../../data/Quasars/CAS/PhotoObjAll_PrimQSOs_npr.dat") 


ra_poa_min=360.0
dec_poa_min=90.0
ra_poa_max=0.0
dec_poa_max=0.0
z_fin_max=0.0

i=0
istat=0
write(*,*)
do while(istat .eq. 0) 
   i=i+1 
   read(1, 1001, IOSTAT=istat) obj_DR5Q(i), ra_J2K(i), dec_J2K(i), z_fin(i), &
        & u(i), u_err(i), g(i), g_err(i), r(i), r_err(i), &
        & i_mag(i), i_magerr(i), z(i), z_err(i)
   
!   write(*,1001) obj_DR5Q(i), ra_J2K(i), dec_J2K(i), z_fin(i),  &
!        & u(i), u_err(i), g(i), g_err(i), r(i), r_err(i), &
!        & i_mag(i), i_magerr(i), z(i), z_err(i)
   
   
   if(z_fin(i) .gt. z_fin_max) z_fin_max=z_fin(i)
end do
close(1) 
N_DR5Q = i - 1
write(*,*) 'Read-in DR5_mini.cat', N_DR5Q, 'z_max ', z_fin_max
write(*,*)


i=0
istat=0
do while(istat.eq.0) 
   i=i+1
   read(2,*, IOSTAT=istat) objID(i), ra_poa(i), dec_poa(i)  , &
        & primTarget(i), status(i), flags(i),  &
        & run(i), rerun(i), camcol(i), field(i), obj(i),  &
        & mode(i), type(i), probPSF(i), insideMask(i),  &
        & psfMag_u(i), psfMag_g(i), psfMag_r(i), psfMag_i (i), psfMag_z(i),  &
        & psfMagErr_u(i), psfMagErr_g(i), psfMagErr_r(i), psfMagErr_i(i), &
        & psfMagErr_z(i)
   
!   write(*,*) objID(i), ra_poa(i), dec_poa(i), &
!        & primTarget(i), status(i), flags(i),  &
!        & run(i), rerun(i), camcol(i), field(i), obj(i),  &
!        & mode(i), type(i), probPSF(i), insideMask(i),  &
!        & psfMag_u(i), psfMag_g(i), psfMag_r(i), psfMag_i (i), psfMag_z(i),  &
!        & psfMagErr_u(i), psfMagErr_g(i), psfMagErr_r(i), psfMagErr_i(i), &
!        & psfMagErr_z(i)

   if(istat .eq. 0) then
      if( ra_poa(i) .lt.  ra_poa_min)  ra_poa_min = ra_poa(i)
      if(dec_poa(i) .lt. dec_poa_min) dec_poa_min = dec_poa(i)
      if( ra_poa(i) .gt.  ra_poa_max)  ra_poa_max = ra_poa(i)
      if(dec_poa(i) .gt. dec_poa_max) dec_poa_max = dec_poa(i)
   end if

end do
close(2) 
N_poa = i - 1
write(*,*) 'Read-in PhotoObjAll_PrimQSOs_npr.dat', N_poa
write(*,*) ' ra_poa_min',  ra_poa_min,  'ra_poa_max',  ra_poa_max
write(*,*) 'dec_poa_min', dec_poa_min, 'dec_poa_max', dec_poa_max
write(*,*)

!1001 format(a18,1x, f10.6,1x, f10.6, f6.4, &
!          & f6.3, f6.3, f6.3, f6.3, f6.3) 
1001 format(a18,1x, f10.6,1x, f10.6,1x, f6.4,1x, & 
          f6.3,1x,f5.3,1x,  f6.3,1x,f5.3,1x,  f6.3,1x,f5.3,1x, &
          f6.3,1x,f5.3,1x, f6.3,1x,f5.3)
1003 format(z5.1)


!O/P
open(72, file='Primary_Objects.dat')
open(73, file='POA_targets_within55_1.dat')
open(74, file='POA_targets_within55_234.dat')

do i=1,N_DR5Q
   N_close_objs=0
   
   do j=1,N_poa
      ! Work out spec-z quasar separation from photo-z target.
      delta_ra_ams  = abs( ra_J2K(i) -  ra_poa(j)) * 60.
      delta_dec_ams = abs(dec_J2K(i) - dec_poa(j)) * 60.
      diff = sqrt((delta_ra_ams**2) +  (delta_dec_ams**2))
      
      if(diff .le. 0.016667) then
         
         write(72,*) obj_DR5Q(i), ra_J2K(i), dec_J2K(i), z_fin(i), &
              & primTarget(j), u(i), g(i), r(i), i_mag(i), z(i)

      elseif ( diff .le. 0.91667 .and. diff .gt. 0.0001) then
         N_close_objs=N_close_objs+1
         ! write(*,*) 'ra_J2K', ra_J2K(i), 'dec_J2K', dec_J2K(i)
         ! write(*,*) 'ra_poa', ra_poa(j), 'dec_poa', dec_poa(j), 'diff', diff
         ! write(*,*)
         write(73,*) i,j, ra_J2K(i), dec_J2K(i), ra_poa(j), dec_poa(j)
         if(N_close_objs .gt. 1) then 
            write(74,*) i,j, ra_J2K(i), dec_J2K(i), ra_poa(j), dec_poa(j), N_close_objs
         end if !N_close_objs
         
      end if !diff le 1 and gt 0.0001
   end do !j=1,N_[oa

   ! do j=i+1,N_DR5Q
   ! end do
end do ! i=1,N_DR5Q
close(72)
close(73)
close(74)


!
! theta = delta(ras) delta(decs)
!
















end program photoz_match

