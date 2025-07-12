!------------------------------------------------------------------------------
! MIT License
!
! Copyright (c) 2025 Orkun Ozoglu
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
!
! The above copyright notice and this permission notice shall be included in
! all copies or substantial portions of the Software.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
! SOFTWARE.
!------------------------------------------------------------------------------

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
