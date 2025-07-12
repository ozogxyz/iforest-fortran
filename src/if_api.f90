module if_api
  use if_types
  implicit none
  public :: iforest_fit, iforest_score

contains

subroutine iforest_fit(X, n, m)
  real(dp), intent(in) :: X(n, m)
  integer, intent(in) :: n, m
  ! build the forest here
end subroutine

subroutine iforest_score(x, m, score)
  real(dp), intent(in) :: x(m)
  integer, intent(in) :: m
  real(dp), intent(out) :: score
  ! walk the trees
end subroutine

end module
