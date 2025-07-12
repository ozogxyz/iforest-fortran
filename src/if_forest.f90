module if_forest
  use if_types
  use if_sampling
  use if_tree
  implicit none
contains

  subroutine train_forest(forest, X, n_samples, n_features, psi, n_trees)
    type(IsolationForest), intent(out) :: forest
    real(8), intent(in) :: X(:,:)
    integer, intent(in) :: n_samples, n_features, psi, n_trees
    integer :: i
    integer, allocatable :: idx(:)

    allocate(forest%trees(n_trees))
    forest%n_trees = n_trees

    allocate(idx(psi))
    do i = 1, n_trees
       call subsample(n_samples, psi, idx)
       forest%trees(i)%root => build_tree(X, idx, 0, int(log(real(psi))/log(2.0d0)))
    end do

    deallocate(idx)
  end subroutine train_forest

  subroutine predict_scores(forest, X, n_samples, n_features, scores)
    use if_tree
    implicit none

    type(IsolationForest), intent(in) :: forest
    real(8), intent(in) :: X(:,:)
    integer, intent(in) :: n_samples, n_features
    real(8), intent(out) :: scores(:)

    integer :: i, j
    real(8) :: h, avg_h
    integer :: psi
    real(8) :: c_psi

    psi = 256
    c_psi = c(psi)

    do i = 1, n_samples
       avg_h = 0.0_8
       do j = 1, forest%n_trees
          h = path_length(forest%trees(j)%root, X(i,:), 0)
          avg_h = avg_h + h
       end do
       avg_h = avg_h / forest%n_trees
       scores(i) = 2.0_8 ** (-avg_h / c_psi)
    end do
  end subroutine predict_scores
end module if_forest
