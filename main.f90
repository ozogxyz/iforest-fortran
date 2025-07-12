program if_main
  use if_types
  use if_sampling
  implicit none

  integer, parameter :: n_samples = 10, psi = 5
  integer :: i
  integer :: sample_idx(psi)

  call subsample(n_samples, psi, sample_idx)

  print *, 'Sampled indices:'
  do i = 1, psi
     print *, sample_idx(i)
  end do
  
end program if_main
