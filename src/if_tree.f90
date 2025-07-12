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


module if_tree
  use if_types
  implicit none
contains

  recursive function build_tree(X, idx, height, height_limit) result(node)
    real(dp), intent(in) :: X(:,:)
    integer, intent(in) :: idx(:)
    integer, intent(in) :: height, height_limit
    type(TreeNode), pointer :: node
    integer :: n_features, split_feature
    real(dp) :: r
    integer :: i
    real(dp) :: fmin, fmax
    real(dp) :: split_value
    integer :: left_count, right_count
    integer, allocatable :: left_idx(:), right_idx(:)
    
    allocate(node)

    if (height >= height_limit .or. size(idx) <= 1) then
       node%is_leaf = .true.
       node%size = size(idx)
       return
    end if

    ! Split feature selection
    n_features = size(X, 2)
    call random_number(r)
    split_feature = 1 + int(r * n_features)

    ! Compute range on selected feature
    fmin = minval(X(idx, split_feature))
    fmax = maxval(X(idx, split_feature))

    ! Check if split is possible
    if (fmax == fmin) then
       node%is_leaf = .true.
       node%size = size(idx)
       return
    end if

    ! Pick random split in (fmin, fmax) interval
    call random_number(r)
    split_value = fmin + r * (fmax - fmin)

    ! First pass: count
    left_count = 0
    right_count = 0

    do i = 1, size(idx)
       if (X(idx(i), split_feature) < split_value) then
          left_count = left_count + 1
       else
          right_count = right_count + 1
       end if
    end do

    ! Allocate based on count
    allocate(left_idx(left_count), right_idx(right_count))

    ! Second pass: assign
    left_count = 0
    right_count = 0

    do i = 1, size(idx)
       if (X(idx(i), split_feature) < split_value) then
          left_count = left_count + 1
          left_idx(left_count) = idx(i)
       else
          right_count = right_count + 1
          right_idx(right_count) = idx(i)
       end if
    end do

    node%is_leaf = .false.
    node%split_feature = split_feature
    node%split_value = split_value
    node%size = size(idx)

    node%left  => build_tree(X, left_idx, height + 1, height_limit)
    node%right => build_tree(X, right_idx, height + 1, height_limit)

    deallocate(left_idx, right_idx)
  end function build_tree

  recursive function path_length(node, x, depth) result(h)
    use if_types
    implicit none

    type(TreeNode), pointer :: node
    real(dp), intent(in) :: x(:)
    integer, intent(in) :: depth
    real(dp) :: h

    if (node%is_leaf) then
       if (node%size <= 1) then
          h = depth * 1.0_dp
       else
          h = depth + c(node%size)
       end if
       return
    end if

    if (x(node%split_feature) < node%split_value) then
       h = path_length(node%left, x, depth + 1)
    else
       h = path_length(node%right, x, depth + 1)
    end if
  end function path_length

  pure function c(n) result(res)
    integer, intent(in) :: n
    real(dp) :: res

    if (n <= 1) then
       res = 0.0_dp
    else
       res = 2.0_dp * log(real(n)) + 0.5772156649_dp - 2.0_dp * (real(n - 1) / real(n))
    end if
  end function c
end module if_tree
