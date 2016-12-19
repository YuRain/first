!#define debug
!#define redundant
subroutine buffer_x
use variables
implicit none
save
!integer ntemp
integer nshift,nlen,nlast,ifrom,mlast

if (head) print*, 'buffer_x'
print*, 'cumsum of all particles =', cum(nt+ncb,nt+ncb,nt+ncb,nnt,nnt,nnt)


! buffer x direction

! sync x- buffer with node on the left
do itz=1,nnt
do ity=1,nnt
do itx=1,1 ! do only tile_x=1
	do iz=1,nt
	do iy=1,nt
		nlast=cum(0,iy,iz,itx,ity,itz)
		nlen=nlast-cum(1-ncb,iy,iz,itx,ity,itz)+rhoc(1-ncb,iy,iz,itx,ity,itz)
		mlast=cum(nt,iy,iz,nnt,ity,itz)[image1d(inx,icy,icz)]
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)[image1d(inx,icy,icz)]
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)[image1d(inx,icy,icz)]
	enddo
	enddo
enddo
enddo
enddo

! redistribute local x- buffer
do itz=1,nnt
do ity=1,nnt
do itx=2,nnt ! skip tile_x=1
	do iz=1,nt
	do iy=1,nt
		nlast=cum(0,iy,iz,itx,ity,itz)
		nlen=nlast-cum(1-ncb,iy,iz,itx,ity,itz)+rhoc(1-ncb,iy,iz,itx,ity,itz)
		mlast=cum(nt,iy,iz,itx-1,ity,itz)
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)
	enddo
	enddo
enddo
enddo
enddo

! sync x+ buffer with node on the right
do itz=1,nnt
do ity=1,nnt
do itx=nnt,nnt ! do only tile_x=nnt
	do iz=1,nt
	do iy=1,nt
		nlast=cum(nt+ncb,iy,iz,itx,ity,itz)
		nlen=nlast-cum(nt,iy,iz,itx,ity,itz)
		mlast=cum(ncb,iy,iz,1,ity,itz)[image1d(ipx,icy,icz)]
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)[image1d(ipx,icy,icz)]
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)[image1d(ipx,icy,icz)]
	enddo
	enddo
enddo
enddo
enddo

! redistribute local x+ buffer
do itz=1,nnt
do ity=1,nnt
do itx=1,nnt-1 ! skip tile_x=nnt
	do iz=1,nt
	do iy=1,nt
		nlast=cum(nt+ncb,iy,iz,itx,ity,itz)
		nlen=nlast-cum(nt,iy,iz,itx,ity,itz)
		mlast=cum(ncb,iy,iz,itx+1,ity,itz)
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)
	enddo
	enddo
enddo
enddo
enddo
sync all
!print*, 'buffered x', sum(x*unit8)


! buffer y direction

! sync y- 
do itz=1,nnt
do ity=1,1 ! do only ity=1
do itx=1,nnt
	do iz=1,nt
		nlast=cum(nt+ncb,0,iz,itx,ity,itz)
		nlen=nlast-cum(1-ncb,1-ncb,iz,itx,ity,itz)+rhoc(1-ncb,1-ncb,iz,itx,ity,itz)
		mlast=cum(nt+ncb,nt,iz,itx,nnt,itz)[image1d(icx,iny,icz)]
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)[image1d(icx,iny,icz)]
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)[image1d(icx,iny,icz)]
	enddo
enddo
enddo
enddo

! redistribute y-
do itz=1,nnt
do ity=2,nnt ! skip ity=1
do itx=1,nnt
	do iz=1,nt
		nlast=cum(nt+ncb,0,iz,itx,ity,itz)
		nlen=nlast-cum(1-ncb,1-ncb,iz,itx,ity,itz)+rhoc(1-ncb,1-ncb,iz,itx,ity,itz)
		mlast=cum(nt+ncb,nt,iz,itx,ity-1,itz)
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)
	enddo
enddo
enddo
enddo

! sync y+
do itz=1,nnt
do ity=nnt,nnt ! do only ity=nnt
do itx=1,nnt
	do iz=1,nt
		nlast=cum(nt+ncb,nt+ncb,iz,itx,ity,itz)
		nlen=nlast-cum(nt+ncb,nt,iz,itx,ity,itz)
		mlast=cum(nt+ncb,ncb,iz,itx,1,itz)[image1d(icx,ipy,icz)]
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)[image1d(icx,ipy,icz)]
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)[image1d(icx,ipy,icz)]
	enddo
enddo
enddo
enddo


! redistribute y+
do itz=1,nnt
do ity=1,nnt-1 ! skip ity=nnt
do itx=1,nnt
	do iz=1,nt
		nlast=cum(nt+ncb,nt+ncb,iz,itx,ity,itz)
		nlen=nlast-cum(nt+ncb,nt,iz,itx,ity,itz)
		mlast=cum(nt+ncb,ncb,iz,itx,ity+1,itz)
		x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)
		v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)
	enddo
enddo
enddo
enddo
sync all
!print*, 'buffered y', sum(x*unit8)


! buffer z direction

! sync z-
do itz=1,1 ! do only itz=1
do ity=1,nnt
do itx=1,nnt
	nlast=cum(nt+ncb,nt+ncb,0,itx,ity,itz)
	nlen=nlast-cum(1-ncb,1-ncb,1-ncb,itx,ity,itz)+rhoc(1-ncb,1-ncb,1-ncb,itx,ity,itz)
	mlast=cum(nt+ncb,nt+ncb,nt,itx,ity,nnt)[image1d(icx,icy,inz)]
	x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)[image1d(icx,icy,inz)]
	v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)[image1d(icx,icy,inz)]
enddo
enddo
enddo

! redistribute z-
do itz=2,nnt ! skip itz=1
do ity=1,nnt
do itx=1,nnt
	nlast=cum(nt+ncb,nt+ncb,0,itx,ity,itz)
	nlen=nlast-cum(1-ncb,1-ncb,1-ncb,itx,ity,itz)+rhoc(1-ncb,1-ncb,1-ncb,itx,ity,itz)
	mlast=cum(nt+ncb,nt+ncb,nt,itx,ity,itz-1)
	x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)
	v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)
enddo
enddo
enddo

! sync z+
do itz=nnt,nnt ! do only itz=nnt
do ity=1,nnt
do itx=1,nnt
	nlast=cum(nt+ncb,nt+ncb,nt+ncb,itx,ity,itz)
	nlen=nlast-cum(nt+ncb,nt+ncb,nt,itx,ity,itz)
	mlast=cum(nt+ncb,nt+ncb,ncb,itx,ity,1)[image1d(icx,icy,ipz)]
	x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)[image1d(icx,icy,ipz)]
	v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)[image1d(icx,icy,ipz)]
enddo
enddo
enddo

! redistribute z+
do itz=1,nnt-1 ! skip itz=nnt
do ity=1,nnt
do itx=1,nnt
	nlast=cum(nt+ncb,nt+ncb,nt+ncb,itx,ity,itz)
	nlen=nlast-cum(nt+ncb,nt+ncb,nt,itx,ity,itz)
	mlast=cum(nt+ncb,nt+ncb,ncb,itx,ity,itz+1)
	x(:,nlast-nlen+1:nlast)=x(:,mlast-nlen+1:mlast)
	v(:,nlast-nlen+1:nlast)=v(:,mlast-nlen+1:mlast)
enddo
enddo
enddo
sync all

!print*, 'buffered z', sum(x*unit8)
!print*, 'first (8*nplocal) x =', sum(x(:,:nplocal*8)*unit8)
!print*, 'the rest =', sum(abs(x(:,nplocal*8+1:)*unit8))
#ifdef debug
  print*, sum(abs(x(1,:884736)*unit8-1))
#endif

endsubroutine buffer_x
