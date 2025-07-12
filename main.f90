program if_main
  use if_types
  use if_sampling
  use if_tree
  use if_forest
  implicit none

  integer, parameter :: n_samples = 10, n_features = 2, psi = 5, n_trees = 3
  real(8) :: X(n_samples, n_features)
  type(IsolationForest) :: forest
  integer :: i
  real(8) :: scores(n_samples)

  ! Fill X with some values: X(i, j) = i + j*0.1
  do i = 1, n_samples
     X(i,1) = real(i,8)
     X(i,2) = real(i,8) * 0.1
  end do

  call train_forest(forest, X, n_samples, n_features, psi, n_trees)

  print *, 'Trained forest with', forest%n_trees, 'trees.'

  call predict_scores(forest, X, n_samples, n_features, scores)

  print *, 'Anomaly scores:'
  do i = 1, n_samples
     write(*,'(A,I2,A,2F10.4,A,F10.6)') 'X(', i, ',:) =', X(i,1), X(i,2), ' → score =', scores(i)

  end do
  
end program if_main
