module if_sampling
  implicit none
contains

  subroutine subsample(n_samples, psi, sample_idx)
    integer, intent(in) :: n_samples
    integer, intent(in) :: psi
    integer, intent(out) :: sample_idx(:)

    integer :: i, j
    real :: tmp
    integer, allocatable :: perm(:)

    if (size(sample_idx) /= psi) stop "sample_idx wrong size"

    allocate(perm(n_samples))
    perm = [(i, i = 1, n_samples)]

    call random_seed() ! optional: reseed RNG
    ! Fisher-Yates shuffle
    do i = n_samples, 2, -1
       call random_number(tmp)
       j = 1 + int(tmp * i)
       tmp = perm(i)
       perm(i) = perm(j)
       perm(j) = tmp
    end do

    sample_idx = perm(1:psi)

    deallocate(perm)
  end subroutine subsample

end module if_sampling
