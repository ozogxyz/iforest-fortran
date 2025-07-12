!------------------------------------------------------------------------------
! MIT License
!
! Copyright (c) 2025 Your Name
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

module if_types
  implicit none
  
  type :: TreeNode
     logical                 :: is_leaf
     integer                 :: split_feature
     real(8)                 :: split_value
     type(TreeNode), pointer :: left => null()
     type(TreeNode), pointer :: right => null()
     integer                 :: size
  end type TreeNode

  type :: Tree
     type(TreeNode), pointer :: root => null()
  end type Tree

  type IsolationForest
     type(Tree), allocatable :: trees(:)
     integer :: n_trees
  end type IsolationForest
end module if_types
