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
