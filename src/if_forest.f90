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

module if_forest
  use if_types
  use if_sampling
  use if_tree
  implicit none
contains

  subroutine train_forest(forest, X, n_samples, psi, n_trees)
    type(IsolationForest), intent(out) :: forest
    real(dp), intent(in) :: X(:,:)
    integer, intent(in) :: n_samples, psi, n_trees
    integer :: i
    integer, allocatable :: idx(:)

    allocate(forest%trees(n_trees))
    forest%n_trees = n_trees

    allocate(idx(psi))
    do i = 1, n_trees
       call subsample(n_samples, psi, idx)
       forest%trees(i)%root => build_tree(X, idx, 0, int(log(real(psi, dp))/log(2.0_dp)))
    end do

    deallocate(idx)
  end subroutine train_forest

  subroutine predict_scores(forest, X, n_samples, scores)
    implicit none

    type(IsolationForest), intent(in) :: forest
    real(dp), intent(in) :: X(:,:)
    integer, intent(in) :: n_samples
    real(dp), intent(out) :: scores(:)

    integer :: i, j
    real(dp) :: h, avg_h
    integer :: psi
    real(dp) :: c_psi

    psi = 256
    c_psi = c(psi)

    do i = 1, n_samples
       avg_h = 0.0_dp
       do j = 1, forest%n_trees
          h = path_length(forest%trees(j)%root, X(i,:), 0)
          avg_h = avg_h + h
       end do
       avg_h = avg_h / forest%n_trees
       scores(i) = 2.0_dp ** (-avg_h / c_psi)
    end do
  end subroutine predict_scores
end module if_forest
