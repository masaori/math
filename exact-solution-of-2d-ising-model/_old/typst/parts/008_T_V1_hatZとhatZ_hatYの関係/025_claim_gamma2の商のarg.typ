#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$(gamma_2(theta_mu)) / (gamma_2(-theta_mu))$の$arg$])[
  #note[
      $
    arg^([0, 2pi))(1/z)
    =
    arg^([0, 2pi))(z^(-1))
    =
    cases(
      0 & quad (arg^([0, 2pi))(z) = 0),
      2pi - arg^([0, 2pi))(z) & quad (0 < arg^([0, 2pi))(z) < 2pi),
    )
    // <range_of_args_of_reciprocal_of_complex_numbers>
  $
     $z_1, z_2 in CC$ について、

  $r_1, r_2 in RR_(>=0), theta_1, theta_2 in RR$ を用いて、

  $phi_("polar")(z_1) = [(r_1, theta_1)]_(~), phi_("polar")(z_2) = [(r_2, theta_2)]_(~)$ とする

  このとき、$0 <= theta_1 + theta_2 - 2n pi < 2pi$ を満たす $n in ZZ$ が存在して、
  $
    arg^([0, 2pi))(z_1 z_2) = theta_1 + theta_2 - 2n pi
  $
    
// <arg_of_product_of_complex_numbers>


  ]
  $mu in cal(M)$について、

  $
    arg^([0, 2pi))(
      (gamma_2(theta_mu)) / (gamma_2(-theta_mu))
    ) = ???
  $

  $
    
  $
]
