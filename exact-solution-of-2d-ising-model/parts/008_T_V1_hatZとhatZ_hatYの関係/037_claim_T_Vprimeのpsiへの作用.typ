#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$T_((V'))$の$psi$への作用])[
  $gamma_2(theta_mu) eq.not 0$ なる $mu in cal(M)$について（このとき $#ref(<def_fermi>)$ より $psi_mu, psi_mu^dagger$ が定義される）、

  $
    T_((V'))(psi_mu^dagger) &= e^(gamma(theta_mu)) psi_mu^dagger
    \
    T_((V'))(psi_mu) &= e^(-gamma(theta_mu)) psi_mu
  $

  #proof[
    $#ref(<def_Vprime>)$ より $V' = exp(X)$ ただし

    $
      X
      :=
      +
      sum_(nu in {1, dots, M} : gamma_2(theta_nu) eq.not 0)
      gamma(theta_nu)
      (
        psi_nu^dagger psi_(-nu) - 1/2
      )
    $

    である（$#ref(<def_Vprime>)$ の和と同じく $gamma_2(theta_nu) eq.not 0$ なる $nu in {1, dots, M}$ にわたる。この $nu$ については $#ref(<def_fermi>)$ と $#ref(<relation_of_gamma_2>)$ より $psi_nu^dagger, psi_(-nu)$ がともに定義される）。

    $X$ と $-X$ は可換（$X(-X) = -X^2 = (-X)X$）だから $#ref(<theorem_exp_product>)$ より

    $
      exp(X) exp(-X)
      &=
      exp(X + (-X))
      \
      &=
      exp(O)
      \
      &=
      I
      quad (because #ref(<theorem_exp_zero>))
    $

    故に $V'^(-1) = exp(-X)$ であり、$T_((V'))(psi_mu^dagger) = V' psi_mu^dagger V'^(-1) = exp(X) psi_mu^dagger exp(-X)$。

    === Step 1: $[psi_nu^dagger psi_(-nu), psi_mu^dagger] = delta^M_(mu - nu, 0) psi_nu^dagger$

    $
      psi_nu^dagger psi_(-nu) psi_mu^dagger
      &=
      psi_nu^dagger (delta^M_(mu - nu, 0) I - psi_mu^dagger psi_(-nu))
      quad (because [psi_(-nu), psi_mu^dagger]_(+) = delta^M_(mu-nu,0) I "、" #ref(<anticommutator_of_psi>))
      \
      &=
      delta^M_(mu - nu, 0) psi_nu^dagger - psi_nu^dagger psi_mu^dagger psi_(-nu)
      \
      &=
      delta^M_(mu - nu, 0) psi_nu^dagger + psi_mu^dagger psi_nu^dagger psi_(-nu)
      quad (because [psi_nu^dagger, psi_mu^dagger]_(+) = 0 "、" #ref(<anticommutator_of_psi>))
    $

    $
      [psi_nu^dagger psi_(-nu), psi_mu^dagger]
      &=
      psi_nu^dagger psi_(-nu) psi_mu^dagger - psi_mu^dagger psi_nu^dagger psi_(-nu)
      \
      &=
      (delta^M_(mu - nu, 0) psi_nu^dagger + psi_mu^dagger psi_nu^dagger psi_(-nu)) - psi_mu^dagger psi_nu^dagger psi_(-nu)
      quad (because "上の計算")
      \
      &=
      delta^M_(mu - nu, 0) psi_nu^dagger
    $

    === Step 2: $[X, psi_mu^dagger] = +gamma(theta_mu) psi_mu^dagger$

    $
      [X, psi_mu^dagger]
      &=
      +
      sum_(nu in {1, dots, M} : gamma_2(theta_nu) eq.not 0)
      gamma(theta_nu)
      [psi_nu^dagger psi_(-nu), psi_mu^dagger]
      quad
      (because #ref(<scalar_identity_commutes>))
      \
      &=
      +
      sum_(nu in {1, dots, M} : gamma_2(theta_nu) eq.not 0)
      gamma(theta_nu)
      delta^M_(mu - nu, 0)
      psi_nu^dagger
      quad
      (because "Step 1")
    $

    $delta^M_(mu - nu, 0) eq.not 0$ となる $nu in {1, dots, M}$ を $mu$ の場合分けで特定する。以下で特定する $nu$ はいずれも $theta_nu equiv plus.minus theta_mu quad (mod 2pi)$ を満たし、$gamma_2$ は $theta$ の $cos, sin, e^(sqrt(-1) theta)$ のみに依存するから $gamma_2(theta_nu) = gamma_2(plus.minus theta_mu)$ である。$gamma_2(theta_mu) eq.not 0$ と $#ref(<relation_of_gamma_2>)$（$gamma_2(-theta_mu) = -overline(gamma_2(theta_mu))$）より $gamma_2(plus.minus theta_mu) eq.not 0$ であるから、特定される $nu$ は上の和の添字集合 $gamma_2(theta_nu) eq.not 0$ に属する。

    ==== a) $mu in {1, dots, M}$ のとき

    $mu equiv nu quad (mod M)$ かつ $nu in {1, dots, M}$ を満たす $nu$ は $nu = mu$ のみ。

    $
      [X, psi_mu^dagger] = gamma(theta_mu) psi_mu^dagger
    $

    ==== b) $mu = -k$ （$k in {1, dots, M-1}$）のとき

    $-k equiv nu quad (mod M)$ かつ $nu in {1, dots, M}$ を満たす $nu$ は $nu = M - k$ のみ。

    $psi_(M-k)^dagger = psi_(-k)^dagger$ かつ $gamma(theta_(M-k)) = gamma(theta_(-k))$ を示す。

    $theta_(M-k) = 2pi - theta_k$ より $e^(sqrt(-1) theta_(M-k)) = e^(-sqrt(-1) theta_k)$、$cos theta_(M-k) = cos theta_k$、$sin theta_(M-k) = -sin theta_k$。
    $exp(-sqrt(-1) j (2 pi (M-k)) / M) = exp(-sqrt(-1) j 2pi) exp(sqrt(-1) j (2 pi k) / M) = exp(-sqrt(-1) j (2 pi (-k)) / M)$（$because exp(-2 pi sqrt(-1) j) = 1$）より $hat(Z)_(M-k)^((minus)) = hat(Z)_(-k)^((minus))$、$hat(Y)_(M-k) = hat(Y)_(-k)$（$#ref(<def_hatZ_hatY>)$）。

    $
      gamma_2(theta_(M-k))
      &=
      sqrt(-1)
      e^(sqrt(-1) theta_(M-k))
      s_2^*
      (c_1 cos theta_(M-k) - sqrt(-1) sin theta_(M-k) - s_1 c_2)
      quad (because #ref(<def_A_theta>))
      \
      &=
      sqrt(-1)
      e^(-sqrt(-1) theta_k)
      s_2^*
      (c_1 cos theta_k + sqrt(-1) sin theta_k - s_1 c_2)
      \
      &=
      gamma_2(-theta_k)
      =
      gamma_2(theta_(-k))
      quad (because theta_(-k) = -theta_k)
    $

    $
      gamma_2(-theta_(M-k))
      &=
      sqrt(-1)
      e^(sqrt(-1) theta_k)
      s_2^*
      (c_1 cos theta_k - sqrt(-1) sin theta_k - s_1 c_2)
      quad (because e^(sqrt(-1)(-theta_(M-k))) = e^(sqrt(-1) theta_k) "等")
      \
      &=
      gamma_2(theta_k)
      =
      gamma_2(-theta_(-k))
    $

    $hat(Z)_(M-k)^((minus)) = hat(Z)_(-k)^((minus))$、$hat(Y)_(M-k) = hat(Y)_(-k)$、$gamma_2(theta_(M-k)) = gamma_2(theta_(-k))$、$gamma_2(-theta_(M-k)) = gamma_2(-theta_(-k))$ が揃ったから $#ref(<def_fermi>)$ より $psi_(M-k)^dagger = psi_(-k)^dagger$。また $cos theta_(M-k) = cos theta_k = cos theta_(-k)$ より $gamma_1(theta_(M-k)) = gamma_1(theta_(-k))$（$#ref(<def_A_theta>)$）ゆえ $gamma(theta_(M-k)) = gamma(theta_(-k))$。

    $
      [X, psi_(-k)^dagger] = gamma(theta_(-k)) psi_(-k)^dagger
    $

    ==== c) $mu = -M$ のとき

    $-M equiv nu quad (mod M)$ かつ $nu in {1, dots, M}$ を満たす $nu$ は $nu = M$ のみ。$#ref(<hatZ_hatY_M_periodicity>)$ より $hat(Z)_M^((minus)) = hat(Z)_(-M)^((minus))$、$hat(Y)_M = hat(Y)_(-M)$。$#ref(<gamma2_theta_M_periodicity>)$ より $gamma_2(theta_M) = gamma_2(theta_(-M))$、$gamma_2(-theta_M) = gamma_2(-theta_(-M))$。ゆえ $#ref(<def_fermi>)$ より $psi_M^dagger = psi_(-M)^dagger$、$gamma(theta_M) = gamma(theta_(-M))$。

    $
      [X, psi_(-M)^dagger] = gamma(theta_(-M)) psi_(-M)^dagger
    $

    ==== まとめ

    a)〜c) より全 $mu in cal(M)$ について $[X, psi_mu^dagger] = gamma(theta_mu) psi_mu^dagger$、すなわち

    $
      X psi_mu^dagger
      &=
      psi_mu^dagger X + gamma(theta_mu) psi_mu^dagger
      \
      &=
      psi_mu^dagger (X + gamma(theta_mu) I)
    $

    === Step 3: 帰納法 $X^n psi_mu^dagger = psi_mu^dagger (X + gamma(theta_mu) I)^n$

    $n = 0$: $X^0 psi_mu^dagger = I psi_mu^dagger = psi_mu^dagger I = psi_mu^dagger (X + gamma(theta_mu) I)^0$。$n$ で成立と仮定すると、

    $
      X^(n+1) psi_mu^dagger
      &=
      X dot.op X^n psi_mu^dagger
      \
      &=
      X dot.op psi_mu^dagger (X + gamma(theta_mu) I)^n
      quad
      (because "帰納法の仮定")
      \
      &=
      (psi_mu^dagger (X + gamma(theta_mu) I)) dot.op (X + gamma(theta_mu) I)^n
      quad
      (because "Step 2 のまとめ")
      \
      &=
      psi_mu^dagger (X + gamma(theta_mu) I)^(n+1)
    $

    よって全 $n >= 0$ について $X^n psi_mu^dagger = psi_mu^dagger (X + gamma(theta_mu) I)^n$。

    === Step 4: $exp(X) psi_mu^dagger = psi_mu^dagger exp(X + gamma(theta_mu) I)$

    $
      sum_(n=0)^N
      (X^n) / (n!)
      dot.op
      psi_mu^dagger
      &=
      sum_(n=0)^N
      (X^n psi_mu^dagger) / (n!)
      \
      &=
      sum_(n=0)^N
      (psi_mu^dagger (X + gamma(theta_mu) I)^n) / (n!)
      quad
      (because "Step 3")
      \
      &=
      psi_mu^dagger
      sum_(n=0)^N
      ((X + gamma(theta_mu) I)^n) / (n!)
    $

    $N -> infinity$ の極限で $#ref(<exp_converges>)$ より右辺は $psi_mu^dagger exp(X + gamma(theta_mu) I)$ に収束し（$#ref(<matrix_multiplication_continuity>)$）、

    $
      exp(X) psi_mu^dagger = psi_mu^dagger exp(X + gamma(theta_mu) I)
    $

    === Step 5: 結論

    $(X + gamma(theta_mu) I)$ と $(-X)$ は可換（$(X + gamma(theta_mu) I)(-X) = -X^2 - gamma(theta_mu) X = (-X)(X + gamma(theta_mu) I)$）だから $#ref(<theorem_exp_product>)$ より、

    $
      T_((V'))(psi_mu^dagger)
      &=
      exp(X) psi_mu^dagger exp(-X)
      \
      &=
      psi_mu^dagger exp(X + gamma(theta_mu) I) exp(-X)
      quad (because "Step 4")
      \
      &=
      psi_mu^dagger exp((X + gamma(theta_mu) I) + (-X))
      quad (because #ref(<theorem_exp_product>))
      \
      &=
      psi_mu^dagger exp(gamma(theta_mu) I)
      \
      &=
      psi_mu^dagger dot.op e^(gamma(theta_mu)) I
      quad (because (gamma(theta_mu) I)^n = (gamma(theta_mu))^n I)
      \
      &=
      e^(gamma(theta_mu)) psi_mu^dagger
    $

    ---

    $T_((V'))(psi_mu) = e^(-gamma(theta_mu)) psi_mu$ について。

    === Step 1': $[psi_nu^dagger psi_(-nu), psi_mu] = -delta^M_(nu + mu, 0) psi_(-nu)$

    $
      psi_nu^dagger psi_(-nu) psi_mu
      &=
      psi_nu^dagger (-psi_mu psi_(-nu))
      quad (because [psi_(-nu), psi_mu]_(+) = 0 "、" #ref(<anticommutator_of_psi>))
      \
      &=
      -psi_nu^dagger psi_mu psi_(-nu)
      \
      &=
      -(delta^M_(nu+mu,0) I - psi_mu psi_nu^dagger) psi_(-nu)
      quad (because [psi_nu^dagger, psi_mu]_(+) = delta^M_(nu+mu,0) I "、" #ref(<anticommutator_of_psi>))
      \
      &=
      -delta^M_(nu+mu,0) psi_(-nu)
      +
      psi_mu psi_nu^dagger psi_(-nu)
    $

    $
      [psi_nu^dagger psi_(-nu), psi_mu]
      &=
      psi_nu^dagger psi_(-nu) psi_mu - psi_mu psi_nu^dagger psi_(-nu)
      \
      &=
      (-delta^M_(nu+mu,0) psi_(-nu) + psi_mu psi_nu^dagger psi_(-nu)) - psi_mu psi_nu^dagger psi_(-nu)
      quad (because "上の計算")
      \
      &=
      -delta^M_(nu + mu, 0) psi_(-nu)
    $

    === Step 2': $[X, psi_mu] = -gamma(theta_mu) psi_mu$

    $
      [X, psi_mu]
      &=
      +
      sum_(nu in {1, dots, M} : gamma_2(theta_nu) eq.not 0)
      gamma(theta_nu)
      [psi_nu^dagger psi_(-nu), psi_mu]
      \
      &=
      -
      sum_(nu in {1, dots, M} : gamma_2(theta_nu) eq.not 0)
      gamma(theta_nu)
      delta^M_(nu + mu, 0)
      psi_(-nu)
      quad
      (because "Step 1'")
    $

    $delta^M_(nu + mu, 0) eq.not 0$ となる $nu in {1, dots, M}$ を $mu$ の場合分けで特定し、$psi_(-nu) = psi_mu$ を確認する（周期性の計算は Step 2 と対称的）。特定される $nu$ が和の添字集合 $gamma_2(theta_nu) eq.not 0$ に属することも Step 2 と同様に確認できる。

    a) $mu in {1, dots, M-1}$: $nu = M - mu$。$psi_(-(M-mu)) = psi_(mu-M) = psi_mu$（Step 2 b) と同様）、$gamma(theta_(M-mu)) = gamma(theta_mu)$。
    b) $mu = M$: $nu = M$。$psi_(-M) = psi_M$（Step 2 c) より）、$gamma(theta_M) = gamma(theta_M)$。
    c) $mu = -k$ ($k in {1, dots, M-1}$): $nu = k$。$psi_(-k) = psi_mu$、$gamma(theta_k) = gamma(theta_(-k))$（$cos theta_k = cos theta_(-k)$）。
    d) $mu = -M$: $nu = M$。$psi_(-M) = psi_(-M)$、$gamma(theta_M) = gamma(theta_(-M))$。

    以上より全 $mu in cal(M)$ について $[X, psi_mu] = -gamma(theta_mu) psi_mu$、すなわち $X psi_mu = psi_mu (X - gamma(theta_mu) I)$。

    Steps 3'〜5' は $psi_mu^dagger$ の証明と $gamma(theta_mu) -> -gamma(theta_mu)$（符号反転）のみ異なり同様に成立し、

    $
      T_((V'))(psi_mu)
      &=
      exp(X) psi_mu exp(-X)
      \
      &=
      psi_mu exp(X - gamma(theta_mu) I) exp(-X)
      \
      &=
      psi_mu exp((X - gamma(theta_mu) I) + (-X))
      quad (because #ref(<theorem_exp_product>))
      \
      &=
      psi_mu dot.op e^(-gamma(theta_mu)) I
      quad (because "Step 5 と同様")
      \
      &=
      e^(-gamma(theta_mu)) psi_mu
    $

    $qed$
  ]
]<action_of_T_Vprime_on_psi>
