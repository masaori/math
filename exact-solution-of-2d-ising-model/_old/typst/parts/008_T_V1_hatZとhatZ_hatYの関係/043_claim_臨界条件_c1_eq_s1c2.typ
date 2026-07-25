#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules

#claim([$c_1 = s_1 c_2$ は臨界条件 $s_1 s_2 = 1$ と同値])[
  #ref(<def_transfer_matrix_symbols>) の記号
  $c_1 = cosh(2 K_1)$, $s_1 = sinh(2 K_1)$, $c_2 = cosh(2 K_2)$, $s_2 = sinh(2 K_2)$
  について、$K_1, K_2 in RR_(> 0)$ とする。このとき

  $
    c_1 = s_1 c_2
    quad <=> quad
    s_1 s_2 = 1
  $

  すなわち $cosh(2 K_1) = sinh(2 K_1) cosh(2 K_2)$ であることと、Ising 模型の臨界条件
  $sinh(2 K_1) sinh(2 K_2) = 1$ であることは同値である。

  #note[
    #ref(<gamma_2_theta_is_0>) より、$mu in cal(M)$ について $gamma_2(theta_mu) = 0$ となるのは
    $mu = plus.minus M$（すなわち $theta_mu = plus.minus 2 pi$、$cos theta_mu = 1$）かつ $c_2 s_1 = c_1$ のときに限る。
    本 claim はこの条件 $c_1 = s_1 c_2$ が臨界条件 $s_1 s_2 = 1$ に他ならないことを示す。
    したがって、$gamma_2(theta_M) = 0$（フェルミオン $psi_M$ が #ref(<def_fermi>) で未定義になる特異点）は
    Ising 模型の臨界点 $sinh(2 K_1) sinh(2 K_2) = 1$ と同値である。
  ]

  #proof[TODO]
]<critical_condition_c1_eq_s1_c2>
