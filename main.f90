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

program if_main
  use if_types
  use if_api
  implicit none

  integer, parameter :: num_samples = 10, num_features = 2
  real(dp) :: M(num_samples, num_features), x(num_features), score
  integer :: i

  ! Fill X with some values
  do i = 1, num_samples
     M(i,1) = real(i,dp)
     M(i,2) = real(2*i,dp) + sin(real(i, dp))
  end do

  call fit(M, num_samples, num_features)
    
  ! Test a normal point
  x = [5.0_dp, 10.0_dp]
  call get_score(x, num_features, score)
  print *, "Normal score:", score

  ! Test an outlier
  x = [100.0_dp, -50.0_dp]
  call get_score(x, num_features, score)
  print *, "Outlier score:", score
  
end program if_main
