!
! This is a trademark Nic Ross(TM) Correlation function program, written with 
! the primary purpose of figuring our the correlation function, xi, of the SDSS
! DR5 quasars, and moreover, how it evolves with redshift. This will be very 
! much in the spirit of Croom et al. (2005), MNRAS, 356, 415. 
!
! Very much done so that I don't forget how to program in FORTRAN 90/5. 
!
! Nicholas P. Ross   
! Room 403, Davey Lab, University Park, Pennsylvania State University
! State College, PA 16802, U.S.A. 
!
! Started: 19th November 2007
!


program quasar_evolution

implicit none


integer:: i,j,k, m, n 

real*8, allocatable:: ra_J2K(:), dec_J2K(:), z_fin(:)
real*8, allocatable:: ra_random(:), dec_randoms(:), z_random(:)


m=  40000
n=1000000
allocate(ra_J2K(m), dec_J2K(m), z_fin(m))
allocate(ra_random(n), dec_randoms(n), z_random(n))




!I/P
open( 1, file='') 
open( 2, file='') 
open( 3, file='') 
open( 4, file='') 


!O/P
open( 9, file='')
open(18, file='')
open(27, file='')


i=0
istat=0
do while(istat .eq. 0) 
   i=i+1

end do
write(*,*) 'Read-in ' 


end program quasar_evolution


