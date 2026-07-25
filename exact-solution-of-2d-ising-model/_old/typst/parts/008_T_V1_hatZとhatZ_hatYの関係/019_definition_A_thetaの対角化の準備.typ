#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#definition([$A(theta)$の対角化の準備])[
  $mu in cal(M)$について、

  $
    gamma_1(theta_mu) :&= c_1 c_2^* - s_1 s_2^* cos theta_mu in RR
    \
    gamma_2(theta_mu) :&= sqrt(-1) e^(sqrt(-1) theta_mu) s_2^* (c_1 cos theta_mu - sqrt(-1) sin theta_mu - s_1 c_2) in CC
  $

  と定めると、

  $
    A(theta_mu)
    :&=
    mat(
      c_1 c_2^*
      -
      s_1 s_2^* cos theta_mu,
      sqrt(-1) e^(sqrt(-1) theta_mu) s_2^* (c_1 cos theta_mu - sqrt(-1) sin theta_mu - s_1 c_2);
      - sqrt(-1) e^(-sqrt(-1) theta_mu) s_2^* (c_1 cos theta_mu + sqrt(-1) sin theta_mu - s_1 c_2),
      c_1 c_2^*
      -
      s_1 s_2^* cos theta_mu;
    )
    \
    &=
    mat(
      gamma_1(theta_mu),
      gamma_2(theta_mu);
      - gamma_2(-theta_mu),
      gamma_1(theta_mu);
    )
  $

  とかける。
]
