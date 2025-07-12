module if_api
  use if_types, only: dp, IsolationForest
  use if_forest, only: train_forest, predict_scores
  implicit none
  public :: fit, get_score

  type(IsolationForest), save :: forest 
contains

subroutine fit(X, n, m)
  real(dp), intent(in) :: X(n, m)
  integer, intent(in) :: n, m
  integer :: psi, n_trees

  psi = min(256, n)
  n_trees = 100

  call train_forest(forest, X, n, psi, n_trees)
end subroutine

subroutine get_score(x, m, score)
  real(dp), intent(in) :: x(m)
  integer, intent(in) :: m
  real(dp), intent(out) :: score
  real(dp) :: tmp(1, m)
  real(dp) :: out(1)

  tmp(1,:) = x(:)
  
  call predict_scores(forest, tmp, 1, out)
  score = out(1)
end subroutine

end module
