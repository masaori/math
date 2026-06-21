#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$gamma_2(theta_mu) = 0$ のとき $T_((V'))$ は $hat(Z)_mu^((minus)), hat(Y)_mu$ を固定する])[
  $cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$ とする。

  $mu in cal(M)$ が $gamma_2(theta_mu) = 0$ を満たすとき、

  $
    T_((V'))(hat(Z)_mu^((minus))) = hat(Z)_mu^((minus)),
    quad
    T_((V'))(hat(Y)_mu) = hat(Y)_mu
  $

  #note[
    $#ref(<def_Vprime>)$ の $X := sum_(nu=1)^M gamma(theta_nu) (psi_nu^dagger psi_(-nu) - 1/2)$ において、$gamma_2(theta_nu) = 0$ となる $nu in {1, dots, M}$ では $psi_nu$ は $#ref(<def_fermi>)$ で定義されないが、そのような $nu$ では後述（Step 1）のとおり $gamma(theta_nu) = 0$ であり当該項の係数が $0$ である。よって $X$ は $gamma_2(theta_nu) eq.not 0$ となる $nu in {1, dots, M}$ にわたる和としてwell-definedであるとみなす。以下この規約のもとで議論する。
  ]

  #proof[
    $gamma_2(theta_mu) = 0$ を満たす $mu in cal(M)$ を固定する。

    $#ref(<def_Vprime>)$ より $V' = exp(X)$、ただし

    $
      X
      :=
      sum_(nu = 1)^M
      gamma(theta_nu)
      (
        psi_nu^dagger psi_(-nu) - 1/2
      )
    $

    である。$#ref(<action_of_T_Vprime_on_psi>)$ の証明冒頭と同様に $V'^(-1) = exp(-X)$ であり、$#ref(<def_T_g>)$ より $T_((V'))(W) = V' W V'^(-1) = exp(X) W exp(-X)$（$W in "Mat"(2, CC)^(times.o M)$）である。

    === Step 1: $gamma_2(theta_nu) = 0 => gamma(theta_nu) = 0$

    $gamma_2(theta_nu) = 0$ とする。$#ref(<det_A_theta>)$ より $gamma_1(theta_nu)^2 + gamma_2(theta_nu) gamma_2(-theta_nu) = 1$ であるから、

    $
      gamma_1(theta_nu)^2
      &=
      1 - gamma_2(theta_nu) gamma_2(-theta_nu)
      \
      &=
      1 - 0 dot.op gamma_2(-theta_nu)
      quad (because gamma_2(theta_nu) = 0)
      \
      &=
      1
    $

    $#ref(<gamma1_geq_1>)$ より $gamma_1(theta_nu) >= 1 > 0$ であるから、$gamma_1(theta_nu)^2 = 1$ と合わせて $gamma_1(theta_nu) = 1$ である。よって

    $
      gamma(theta_nu)
      &=
      "arccosh"(gamma_1(theta_nu))
      quad (because #ref(<def_gamma_theta_mu>))
      \
      &=
      "arccosh"(1)
      quad (because gamma_1(theta_nu) = 1)
      \
      &=
      0
    $

    である。

    === Step 2: $gamma_2(theta_mu) = 0$ かつ $delta^M_(mu plus.minus nu, 0) eq.not 0$ ならば $gamma(theta_nu) = 0$

    $nu in {1, dots, M}$ とし、$delta^M_(mu - nu, 0) eq.not 0$ または $delta^M_(mu + nu, 0) eq.not 0$ と仮定する。すなわち $mu equiv nu quad (mod M)$ または $mu equiv -nu quad (mod M)$ である。

    $#ref(<gamma_2_theta_is_0>)$ より $gamma_2(theta_mu) = 0$ は $sin(theta_mu) = 0$ かつ $c_1 cos(theta_mu) = s_1 c_2$ と同値である。

    $theta_kappa := (2 pi kappa) / M$（$#ref(<def_theta_mu>)$）であるから、$mu equiv nu quad (mod M)$ のとき、ある $ell in ZZ$ を用いて $nu = mu + ell M$ と書け、

    $
      theta_nu
      &=
      (2 pi (mu + ell M)) / M
      \
      &=
      theta_mu + 2 pi ell
    $

    である。$mu equiv -nu quad (mod M)$ のときは同様に $nu = -mu + ell M$ なる $ell in ZZ$ があり $theta_nu = -theta_mu + 2 pi ell$ である。いずれの場合も三角関数の周期性と偶奇性より

    $
      cos(theta_nu) = cos(theta_mu),
      quad
      sin(theta_nu) = plus.minus sin(theta_mu) = 0
    $

    が成り立つ（$cos$ は周期 $2 pi$ かつ偶関数、$sin$ は周期 $2 pi$ かつ奇関数、$sin(theta_mu) = 0$）。したがって

    $
      sin(theta_nu) = 0,
      quad
      c_1 cos(theta_nu) = c_1 cos(theta_mu) = s_1 c_2
    $

    が成り立つから、$#ref(<gamma_2_theta_is_0>)$ より $gamma_2(theta_nu) = 0$ である。Step 1 より $gamma(theta_nu) = 0$ を得る。

    === Step 3: $gamma_2(theta_mu) = 0$ のとき $[X, hat(Z)_mu^((minus))] = O$ かつ $[X, hat(Y)_mu] = O$

    まず各 $nu in {1, dots, M}$ で $gamma_2(theta_nu) eq.not 0$ なるものについて $c_nu := (1) / (2 sqrt(M) gamma_2(-theta_(nu)))$ とおくと $#ref(<def_fermi>)$ より

    $
      psi_nu^dagger
      &=
      c_nu
      (
        plus sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu))) hat(Z)_nu^((minus))
        +
        gamma_2(-theta_(nu)) hat(Y)_nu
      )
      \
      psi_(-nu)
      &=
      c_(-nu)
      (
        minus sqrt(-1) sqrt(gamma_2(theta_(-nu)) gamma_2(-theta_(-nu))) hat(Z)_(-nu)^((minus))
        +
        gamma_2(-theta_(-nu)) hat(Y)_(-nu)
      )
    $

    である（$psi_(-nu)$ はインデックス $-nu in cal(M)$ のフェルミオン）。

    $#ref(<anticommutator_of_hat_Z_and_hat_Y>)$ より、任意の $kappa, lambda in cal(M)$ について

    $
      [hat(Z)_kappa^((minus)), hat(Z)_lambda^((minus))]_(+) &= 2M delta^M_(kappa + lambda, 0) I_((CC^2)^(times.o M))
      \
      [hat(Z)_kappa^((minus)), hat(Y)_lambda]_(+) &= 0
      \
      [hat(Y)_kappa, hat(Y)_lambda]_(+) &= 2M delta^M_(kappa + lambda, 0) I_((CC^2)^(times.o M))
    $

    が成り立つ。$psi_nu^dagger$ と $psi_(-nu)$ はそれぞれ $hat(Z)_nu^((minus)), hat(Y)_nu$ および $hat(Z)_(-nu)^((minus)), hat(Y)_(-nu)$ の $CC$-線型結合であるから、反交換子の双線型性より $hat(Z)_mu^((minus))$ との反交換子は次の形にまとまる。$delta^M_(nu + mu, 0) = delta^M_(mu + nu, 0)$ かつ $delta^M_(-nu + mu, 0) = delta^M_(mu - nu, 0)$ に注意して、

    $
      [psi_nu^dagger, hat(Z)_mu^((minus))]_(+)
      &=
      c_nu
      (
        plus sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
        [hat(Z)_nu^((minus)), hat(Z)_mu^((minus))]_(+)
        +
        gamma_2(-theta_(nu)) [hat(Y)_nu, hat(Z)_mu^((minus))]_(+)
      )
      quad (because "双線型性")
      \
      &=
      c_nu
      dot.op
      (
        plus sqrt(-1) sqrt(gamma_2(theta_(nu)) gamma_2(-theta_(nu)))
      )
      dot.op
      2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
      quad (because #ref(<anticommutator_of_hat_Z_and_hat_Y>))
      \
      [psi_(-nu), hat(Z)_mu^((minus))]_(+)
      &=
      c_(-nu)
      (
        minus sqrt(-1) sqrt(gamma_2(theta_(-nu)) gamma_2(-theta_(-nu)))
        [hat(Z)_(-nu)^((minus)), hat(Z)_mu^((minus))]_(+)
        +
        gamma_2(-theta_(-nu)) [hat(Y)_(-nu), hat(Z)_mu^((minus))]_(+)
      )
      quad (because "双線型性")
      \
      &=
      c_(-nu)
      dot.op
      (
        minus sqrt(-1) sqrt(gamma_2(theta_(-nu)) gamma_2(-theta_(-nu)))
      )
      dot.op
      2M delta^M_(mu - nu, 0) I_((CC^2)^(times.o M))
      quad (because #ref(<anticommutator_of_hat_Z_and_hat_Y>))
    $

    が成り立つ。同様に $#ref(<anticommutator_of_hat_Z_and_hat_Y>)$ より $hat(Y)_mu$ との反交換子は

    $
      [psi_nu^dagger, hat(Y)_mu]_(+)
      &=
      c_nu
      dot.op
      gamma_2(-theta_(nu))
      dot.op
      2M delta^M_(mu + nu, 0) I_((CC^2)^(times.o M))
      quad (because #ref(<anticommutator_of_hat_Z_and_hat_Y>))
      \
      [psi_(-nu), hat(Y)_mu]_(+)
      &=
      c_(-nu)
      dot.op
      gamma_2(-theta_(-nu))
      dot.op
      2M delta^M_(mu - nu, 0) I_((CC^2)^(times.o M))
      quad (because #ref(<anticommutator_of_hat_Z_and_hat_Y>))
    $

    である（$[hat(Z)_kappa^((minus)), hat(Y)_mu]_(+) = 0$ を用いた）。

    いま $gamma_2(theta_mu) = 0$ である。$W in {hat(Z)_mu^((minus)), hat(Y)_mu}$ を1つ固定する。各 $nu in {1, dots, M}$ について場合分けする。

    場合 (i): $gamma(theta_nu) = 0$ のとき。$X$ における第 $nu$ 項 $gamma(theta_nu)(psi_nu^dagger psi_(-nu) - 1/2)$ は係数 $0$ ゆえ $O$ であり、$[O, W] = O$ である。

    場合 (ii): $gamma(theta_nu) eq.not 0$ のとき。Step 1 の対偶より $gamma_2(theta_nu) eq.not 0$ であり $psi_nu, psi_nu^dagger$ は定義される。さらに $#ref(<gamma_2_theta_is_0>)$ と $#ref(<relation_of_gamma_2>)$（$gamma_2(-theta_nu) = -overline(gamma_2(theta_nu))$ ゆえ $gamma_2(theta_nu) eq.not 0 <=> gamma_2(-theta_nu) eq.not 0$）より $psi_(-nu)$ も定義される。このとき Step 2 の対偶より $delta^M_(mu + nu, 0) = 0$ かつ $delta^M_(mu - nu, 0) = 0$ である。よって上で求めた反交換子はすべて $O$ となる:

    $
      [psi_nu^dagger, W]_(+) = O,
      quad
      [psi_(-nu), W]_(+) = O
      quad (because delta^M_(mu + nu, 0) = delta^M_(mu - nu, 0) = 0)
    $

    したがって $#ref(<commutator_via_anticommutators>)$ より

    $
      [psi_nu^dagger psi_(-nu), W]
      &=
      psi_nu^dagger [psi_(-nu), W]_(+) - [psi_nu^dagger, W]_(+) psi_(-nu)
      quad (because #ref(<commutator_via_anticommutators>))
      \
      &=
      psi_nu^dagger O - O psi_(-nu)
      \
      &=
      O
    $

    が成り立つ。また $[1/2 dot.op I, W] = O$（スカラー倍の単位行列は任意の行列と可換、$#ref(<scalar_identity_commutes>)$）であるから

    $
      [psi_nu^dagger psi_(-nu) - 1/2, W]
      &=
      [psi_nu^dagger psi_(-nu), W] - [1/2 dot.op I, W]
      quad (because "交換子の加法性")
      \
      &=
      O - O
      \
      &=
      O
    $

    である。ゆえに第 $nu$ 項について $[gamma(theta_nu)(psi_nu^dagger psi_(-nu) - 1/2), W] = gamma(theta_nu) [psi_nu^dagger psi_(-nu) - 1/2, W] = O$ である。

    場合 (i), (ii) いずれでも第 $nu$ 項と $W$ の交換子は $O$ であるから、交換子の加法性より

    $
      [X, W]
      &=
      sum_(nu = 1)^M
      [gamma(theta_nu)(psi_nu^dagger psi_(-nu) - 1/2), W]
      quad (because "交換子の加法性")
      \
      &=
      sum_(nu = 1)^M O
      \
      &=
      O
    $

    である。$W$ は $hat(Z)_mu^((minus)), hat(Y)_mu$ いずれでもよいから

    $
      [X, hat(Z)_mu^((minus))] = O,
      quad
      [X, hat(Y)_mu] = O
    $

    を得る。

    === Step 4: $[X, W] = O => exp(X) W exp(-X) = W$

    $W in {hat(Z)_mu^((minus)), hat(Y)_mu}$ とし $[X, W] = O$、すなわち $X W = W X$ とする。

    まず $X^n W = W X^n$（$n >= 0$）を帰納法で示す。$n = 0$ のとき $X^0 W = I W = W = W I = W X^0$。$n$ で成立と仮定すると、

    $
      X^(n+1) W
      &=
      X dot.op X^n W
      \
      &=
      X dot.op W X^n
      quad (because "帰納法の仮定")
      \
      &=
      (X W) X^n
      \
      &=
      (W X) X^n
      quad (because X W = W X)
      \
      &=
      W X^(n+1)
    $

    であるから、すべての $n >= 0$ で $X^n W = W X^n$ である。よって

    $
      (
        sum_(n=0)^N
        (X^n) / (n!)
      )
      W
      &=
      sum_(n=0)^N
      (X^n W) / (n!)
      \
      &=
      sum_(n=0)^N
      (W X^n) / (n!)
      quad (because X^n W = W X^n)
      \
      &=
      W
      (
        sum_(n=0)^N
        (X^n) / (n!)
      )
    $

    が成り立つ。$N -> infinity$ の極限で $#ref(<exp_converges>)$ より両辺は収束し（積の連続性 $#ref(<matrix_multiplication_continuity>)$）、

    $
      exp(X) W = W exp(X)
    $

    を得る。$X$ と $-X$ は可換（$X(-X) = -X^2 = (-X)X$）だから $#ref(<theorem_exp_product>)$ より $exp(X) exp(-X) = exp(X + (-X)) = exp(O) = I$（$#ref(<theorem_exp_zero>)$）であり、

    $
      T_((V'))(W)
      &=
      exp(X) W exp(-X)
      \
      &=
      W exp(X) exp(-X)
      quad (because exp(X) W = W exp(X))
      \
      &=
      W
      quad (because exp(X) exp(-X) = I)
    $

    が成り立つ。

    Step 3 より $[X, hat(Z)_mu^((minus))] = O$ かつ $[X, hat(Y)_mu] = O$ であるから、

    $
      T_((V'))(hat(Z)_mu^((minus))) = hat(Z)_mu^((minus)),
      quad
      T_((V'))(hat(Y)_mu) = hat(Y)_mu
    $

    を得る。

    $qed$
  ]
]<T_Vprime_fixes_hatZ_hatY_when_gamma2_zero>
