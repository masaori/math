#import "../../theorem.typ": theorem, claim, proof, definition, remark, note, theorem_rules
#claim([$T_((V)) = T_((V'))$])[
  $
    T_((V)) = T_((V'))
  $

  すなわち、任意の $x in "Mat"(2, CC)^(times.o M)$ に対して $V x V^(-1) = V' x V'^(-1)$ である。

  #proof[
    以下、$cal(M) := {-M, dots, -2, -1, 1, 2, dots, M}$、$omega := exp((2 pi sqrt(-1)) / M) in CC$ とおく。

    #remark[
      *標準仮定（$V'$ の well-defined 性）.*
      $#ref(<def_Vprime>)$ における $V' = exp(X)$、
      $X = sum_(nu=1)^M gamma(theta_nu) (psi_nu^dagger psi_(-nu) - 1/2)$ は、
      和に現れる全ての $nu in {1, dots, M}$ についてフェルミオン $psi_nu^dagger, psi_(-nu)$ が定義されて初めて意味をもつ。
      $#ref(<def_fermi>)$ よりフェルミオン $psi_mu^dagger, psi_mu$ は $gamma_2(theta_mu) eq.not 0$ のときに限り定義されるから、
      $V'$（したがって本 Claim の主張）が意味をもつためには
      $
        gamma_2(theta_nu) eq.not 0 quad (forall nu in {1, dots, M})
      $
      が成り立っていなければならない。以下これを標準仮定とする。
      このとき、$mu in {-M, dots, -1}$ すなわち $mu = -k$（$k in {1, dots, M}$）に対しても次のように $gamma_2(theta_mu) eq.not 0$ が従う。
      $1 <= k <= M - 1$ のとき $theta_(-k) = -theta_k$ であり、$#ref(<relation_of_gamma_2>)$
      （$gamma_2(-theta) = - overline(gamma_2(theta))$、ゆえに $gamma_2(theta) eq.not 0 <=> gamma_2(-theta) eq.not 0$）より
      $gamma_2(theta_(-k)) = gamma_2(-theta_k) eq.not 0$。$k = M$（すなわち $mu = -M$）のときは
      $#ref(<gamma2_theta_M_periodicity>)$ より $gamma_2(theta_(-M)) = gamma_2(theta_M) eq.not 0$。
      よって標準仮定の下では
      $
        gamma_2(theta_mu) eq.not 0 quad (forall mu in cal(M))
      $
      であり、$#ref(<def_fermi>)$ のフェルミオン $psi_mu^dagger, psi_mu$ は全ての $mu in cal(M)$ について定義される。
    ]

    証明の方針は次の通りである。まず両写像 $T_((V)), T_((V'))$ がともに $CC$-代数の準同型
    （和・スカラー倍・積・単位元を保つ写像）であることを示す（Step 1, 2）。
    次に両者が生成元集合
    $S := { hat(Z)_mu^((minus)), hat(Y)_mu mid(|) mu in cal(M) }$ 上で一致することを示し（Step 3, 4）、
    最後に $S$ が代数 $"Mat"(2, CC)^(times.o M)$ を生成することから（Step 5）、
    両写像が代数全体で一致することを結論する（Step 6）。

    === Step 1: $T_((V)), T_((V'))$ は共役写像であり、ともに乗法的かつ単位元を保つ

    $#ref(<def_T_V>)$ より $T_((V))$ は3つの共役写像
    $T_((V_1^((plus.minus)))^(1/2)), T_((V_2)), T_((V_1^((plus.minus)))^(1/2))$ の合成である。
    $#ref(<def_T_g>)$ より、正則元 $g in ("Mat"(2, CC)^(times.o M))^(times)$ による共役写像
    $T_g (h) = g h g^(-1)$ は、$h_1, h_2 in "Mat"(2, CC)^(times.o M)$ に対して

    $
      T_g (h_1 h_2)
      &=
      g (h_1 h_2) g^(-1)
      \
      &=
      g h_1 (g^(-1) g) h_2 g^(-1)
      quad (because g^(-1) g = I)
      \
      &=
      (g h_1 g^(-1)) (g h_2 g^(-1))
      \
      &=
      T_g (h_1) dot.op T_g (h_2)
      quad (because #ref(<def_T_g>))
    $

    を満たし、また

    $
      T_g (I)
      &=
      g I g^(-1)
      \
      &=
      g g^(-1)
      \
      &=
      I
    $

    を満たす。すなわち各共役写像は乗法的かつ単位元を保つ。乗法性・単位元保存は写像の合成で保たれるから、
    その合成である $T_((V))$ もこれらを満たす。

    $T_((V'))$ についても同様である。$#ref(<def_Vprime>)$ で $V' = exp(X)$
    （$X := sum_(nu=1)^M gamma(theta_nu) (psi_nu^dagger psi_(-nu) - 1/2)$）と定めると、
    $#ref(<action_of_T_Vprime_on_psi>)$ の証明中で示した通り $V'$ は正則で $V'^(-1) = exp(-X)$ である。
    $#ref(<def_T_g>)$ の意味で $T_((V')) = T_(V')$、すなわち $T_((V'))(h) = V' h V'^(-1)$ であるから、
    上と全く同じ計算により $T_((V'))$ も乗法的かつ単位元を保つ。

    === Step 2: $T_((V)), T_((V'))$ は線型である

    $#ref(<mat_conj>)$ より、正則元による共役写像は線型写像である。
    $T_((V))$ は線型写像の合成であるから線型であり（$#ref(<linearity_of_T>)$ も同じ事実の表式である）、
    $T_((V')) = T_(V')$ も $#ref(<mat_conj>)$ より線型である。

    Step 1, 2 より、$T_((V)), T_((V'))$ はともに和・スカラー倍・積・単位元を保つ
    $CC$-代数の準同型である。

    === Step 3: 両写像はフェルミオン $psi_mu^dagger, psi_mu$（$mu in cal(M)$）上で一致する

    標準仮定の下、$mu in cal(M)$ について、$#ref(<action_of_T_V_on_psi>)$ より

    $
      T_((V))(psi_mu^dagger)
      &=
      (
        (gamma_1(theta_mu))
        plus
        sqrt(- (gamma_2(theta_mu)) (gamma_2(-theta_mu)))
      )
      psi_mu^dagger
      \
      &=
      lambda_(plus, mu) dot.op psi_mu^dagger
      quad (because #ref(<eigenvector_of_A_theta>))
      \
      &=
      e^(gamma(theta_mu)) psi_mu^dagger
      quad (because #ref(<lambda_eq_exp_gamma>))
    $

    一方 $#ref(<action_of_T_Vprime_on_psi>)$ より

    $
      T_((V'))(psi_mu^dagger)
      =
      e^(gamma(theta_mu)) psi_mu^dagger
    $

    であるから、

    $
      T_((V))(psi_mu^dagger)
      =
      T_((V'))(psi_mu^dagger)
    $

    同様に $#ref(<action_of_T_V_on_psi>)$, $#ref(<eigenvector_of_A_theta>)$, $#ref(<lambda_eq_exp_gamma>)$ より
    $T_((V))(psi_mu) = lambda_(minus, mu) psi_mu = e^(-gamma(theta_mu)) psi_mu$ であり、
    $#ref(<action_of_T_Vprime_on_psi>)$ より $T_((V'))(psi_mu) = e^(-gamma(theta_mu)) psi_mu$ であるから、

    $
      T_((V))(psi_mu)
      =
      T_((V'))(psi_mu)
    $

    === Step 4: 両写像は $hat(Z)_mu^((minus)), hat(Y)_mu$（$mu in cal(M)$）上で一致する

    標準仮定の下、$mu in cal(M)$ をとる。$#ref(<def_fermi>)$ より

    $
      mat(psi_mu^dagger, psi_mu)
      =
      (hat(Z)_mu^((minus)), hat(Y)_mu)
      dot.op
      P_mu
    $

    である。$#ref(<a_theta_P_mu_D_mu>)$ で定めた $P_mu$ について、その行列式は

    $
      det P_mu
      &=
      ((1) / (2 sqrt(M) gamma_2(-theta_(mu))))^2
      det
      mat(
        plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))),
        minus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)));
        gamma_2(-theta_(mu)),
        gamma_2(-theta_(mu))
      )
      \
      &=
      ((1) / (2 sqrt(M) gamma_2(-theta_(mu))))^2
      gamma_2(-theta_(mu))
      (
        plus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
        -
        (minus sqrt(-1) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))))
      )
      \
      &=
      ((1) / (2 sqrt(M) gamma_2(-theta_(mu))))^2
      gamma_2(-theta_(mu))
      dot.op
      (plus 2 sqrt(-1)) sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu)))
    $

    となる。標準仮定より $gamma_2(theta_mu) eq.not 0$、
    かつ $#ref(<relation_of_gamma_2>)$ により $gamma_2(-theta_mu) = - overline(gamma_2(theta_mu)) eq.not 0$ でもあるから、
    $sqrt(gamma_2(theta_(mu)) gamma_2(-theta_(mu))) eq.not 0$ となり $det P_mu eq.not 0$、
    よって $P_mu$ は可逆である。ゆえに両辺に右から $P_mu^(-1)$ を掛けて

    $
      (hat(Z)_mu^((minus)), hat(Y)_mu)
      =
      mat(psi_mu^dagger, psi_mu)
      dot.op
      P_mu^(-1)
    $

    を得る。$P_mu^(-1)$ の各成分は $hat(Z)_mu^((minus)), hat(Y)_mu, psi_mu^dagger, psi_mu$ に依らない複素数であるから、
    $P_mu^(-1) = mat(q_(11), q_(12); q_(21), q_(22))$ とおくと

    $
      hat(Z)_mu^((minus)) = q_(11) psi_mu^dagger + q_(21) psi_mu,
      quad
      hat(Y)_mu = q_(12) psi_mu^dagger + q_(22) psi_mu
    $

    と書ける。$T_((V))$ は線型（Step 2）かつ Step 3 で $psi_mu^dagger, psi_mu$ 上 $T_((V'))$ と一致するから、

    $
      T_((V))(hat(Z)_mu^((minus)))
      &=
      q_(11) T_((V))(psi_mu^dagger) + q_(21) T_((V))(psi_mu)
      quad (because #ref(<mat_conj>))
      \
      &=
      q_(11) T_((V'))(psi_mu^dagger) + q_(21) T_((V'))(psi_mu)
      quad (because "Step 3")
      \
      &=
      T_((V'))(q_(11) psi_mu^dagger + q_(21) psi_mu)
      quad (because #ref(<mat_conj>))
      \
      &=
      T_((V'))(hat(Z)_mu^((minus)))
    $

    全く同様に $T_((V))(hat(Y)_mu) = T_((V'))(hat(Y)_mu)$ を得る。

    標準仮定の下、$mu in cal(M)$ は任意であったから、全ての $mu in cal(M)$ について
    $T_((V))(hat(Z)_mu^((minus))) = T_((V'))(hat(Z)_mu^((minus)))$ かつ
    $T_((V))(hat(Y)_mu) = T_((V'))(hat(Y)_mu)$ が成り立つ。

    === Step 5: $S = { hat(Z)_mu^((minus)), hat(Y)_mu mid(|) mu in cal(M) }$ は代数 $"Mat"(2, CC)^(times.o M)$ を生成する

    まず逆離散フーリエ変換により $Z_m, Y_m$ が $S$ の元の線型結合で表せることを示す。
    $#ref(<def_hatZ_hatY>)$ より、上付き $(minus)$ では $j = 1$ の符号が $plus$ となるから、$mu in cal(M)$ について

    $
      hat(Z)_mu^((minus))
      &=
      sum_(j=1)^M Z_j exp(- sqrt(-1) j (2 pi mu) / M)
      \
      &=
      sum_(j=1)^M Z_j omega^(- j mu)
      \
      hat(Y)_mu
      &=
      sum_(j=1)^M Y_j omega^(- j mu)
    $

    が成り立つ。$m in {1, dots, M}$ を固定し、$mu = 1, dots, M$ について重み $omega^(m mu)$ を掛けて和をとると、

    $
      sum_(mu = 1)^M hat(Z)_mu^((minus)) omega^(m mu)
      &=
      sum_(mu = 1)^M sum_(j=1)^M Z_j omega^(- j mu) omega^(m mu)
      \
      &=
      sum_(j=1)^M Z_j sum_(mu = 1)^M omega^((m - j) mu)
      \
      &=
      sum_(j=1)^M Z_j sum_(mu = 1)^M exp((m - j) dot.op (2 pi sqrt(-1) mu) / M)
      \
      &=
      sum_(j=1)^M Z_j dot.op M delta^M_((m - j, 0))
      quad (because #ref(<exp_sum>))
      \
      &=
      M Z_m
      quad (because m\, j in {1, dots, M} "より " m equiv j mod M <=> m = j)
    $

    が得られる。よって

    $
      Z_m = (1) / M sum_(mu = 1)^M hat(Z)_mu^((minus)) omega^(m mu)
    $

    であり、$Z_m$ は $hat(Z)_1^((minus)), dots, hat(Z)_M^((minus))$ の $CC$-線型結合である。
    全く同様に

    $
      Y_m = (1) / M sum_(mu = 1)^M hat(Y)_mu omega^(m mu)
    $

    であり、$Y_m$ は $hat(Y)_1, dots, hat(Y)_M$ の $CC$-線型結合である。
    したがって、$S$ の元の線型結合で表される元全体（$S$ が張る線型部分空間）は、全ての $Z_m, Y_m$
    （$m in {1, dots, M}$）を含む。

    次に、$Z_m, Y_m$ から各サイトのパウリ行列 $sigma_k^x, sigma_k^y, sigma_k^z$ が、積と線型結合で復元できることを示す。
    $#ref(<def_転送行列記号>)$ より $Z_1 = sigma_1^z$, $Y_1 = sigma_1^y$ であり、$m >= 2$ では

    $
      Z_m = sigma_1^x dots.c sigma_(m-1)^x sigma_m^z,
      quad
      Y_m = sigma_1^x dots.c sigma_(m-1)^x sigma_m^y
    $

    である。パウリ行列 $sigma^x, sigma^y, sigma^z in "Mat"(2, CC)$ は標準的な関係式
    $(sigma^a)^2 = I_("Mat"(2, CC))$（$a in {x, y, z}$）、
    $sigma^z sigma^y = - sqrt(-1) sigma^x$、$sigma^x sigma^y = sqrt(-1) sigma^z$、
    $sigma^y sigma^x = - sqrt(-1) sigma^z$ を満たし、相異なるサイトの作用素どうしは可換である。

    #note[
      ここで用いるのは、パウリ行列
      $sigma^x = mat(0, 1; 1, 0)$,
      $sigma^y = mat(0, - sqrt(-1); sqrt(-1), 0)$,
      $sigma^z = mat(1, 0; 0, - 1)$ の積に関する初等的な事実のみである。実際、
      $sigma^x sigma^y = mat(sqrt(-1), 0; 0, - sqrt(-1)) = sqrt(-1) sigma^z$,
      $sigma^z sigma^y = mat(0, - sqrt(-1); - sqrt(-1), 0) = - sqrt(-1) sigma^x$,
      $(sigma^a)^2 = I_("Mat"(2, CC))$ は直接の行列計算で確かめられる。
      また $#ref(<def_転送行列記号>)$ の $sigma_k^a := I times.o dots.c times.o overbrace(sigma^a, k"th") times.o dots.c times.o I$
      の形より、$k eq.not l$ では $sigma_k^a sigma_l^b = sigma_l^b sigma_k^a$（テンソル積の各成分が独立に積をとる）である。
    ]

    これを用いて、各サイト $m in {1, dots, M}$ のパウリ作用素を順に復元する。まず

    $
      Z_m Y_m
      &=
      (sigma_1^x dots.c sigma_(m-1)^x sigma_m^z)(sigma_1^x dots.c sigma_(m-1)^x sigma_m^y)
      \
      &=
      (sigma_1^x)^2 dots.c (sigma_(m-1)^x)^2 sigma_m^z sigma_m^y
      quad (because "相異なるサイトの可換性")
      \
      &=
      sigma_m^z sigma_m^y
      quad (because (sigma_k^x)^2 = I)
      \
      &=
      - sqrt(-1) sigma_m^x
      quad (because sigma^z sigma^y = - sqrt(-1) sigma^x)
    $

    （$m = 1$ のときは $Z_1 Y_1 = sigma_1^z sigma_1^y = - sqrt(-1) sigma_1^x$。）よって

    $
      sigma_m^x = sqrt(-1) Z_m Y_m
    $

    が、$Z_m, Y_m$ の積として得られる。これが全 $m in {1, dots, M}$ について成り立つ。
    したがって、$S$ が生成する部分代数（$S$ の元と $I$ から積と線型結合を有限回施して得られる元全体）は、
    全ての $sigma_m^x$（$m in {1, dots, M}$）を含む。次に $m >= 2$ について

    $
      sigma_(m-1)^x dots.c sigma_1^x dot.op Z_m
      &=
      sigma_(m-1)^x dots.c sigma_1^x sigma_1^x dots.c sigma_(m-1)^x sigma_m^z
      \
      &=
      (sigma_1^x)^2 dots.c (sigma_(m-1)^x)^2 sigma_m^z
      quad (because "相異なるサイトの可換性")
      \
      &=
      sigma_m^z
      quad (because (sigma_k^x)^2 = I)
    $

    （$m = 1$ では $Z_1 = sigma_1^z$ がそのまま $sigma_1^z$。）であり、左辺は既に得られた
    $sigma_k^x$（$k <= m - 1$）と $Z_m in "span"(S)$ の積であるから、$sigma_m^z$ も $S$ が生成する部分代数に属する。
    同様に $sigma_(m-1)^x dots.c sigma_1^x dot.op Y_m = sigma_m^y$ より $sigma_m^y$ も属する。

    以上より、$S$ が生成する部分代数は全てのパウリ作用素
    $sigma_m^x, sigma_m^y, sigma_m^z$（$m in {1, dots, M}$）と単位元 $I$ を含む。

    最後に、これらが $"Mat"(2, CC)^(times.o M)$ 全体を生成することを示す。
    $#ref(<def_転送行列記号>)$ のパウリ行列の表式より $I_("Mat"(2, CC)), sigma^x, sigma^y, sigma^z$ は
    $"Mat"(2, CC)$（$CC$ 上 4 次元）の基底をなす（4 個の行列が線型独立であることは
    $a I + b sigma^x + c sigma^y + d sigma^z = O$ の成分比較から $a = b = c = d = 0$ が従うことで確かめられる）。
    $#ref(<tensor_basis>)$ より、この基底のテンソル積
    $tau_(a_1) times.o dots.c times.o tau_(a_M)$（各 $tau_(a_k) in {I_("Mat"(2, CC)), sigma^x, sigma^y, sigma^z}$）の全体
    $4^M$ 個は $"Mat"(2, CC)^(times.o M)$ の基底をなす。各テンソル積基底元は、$#ref(<def_転送行列記号>)$ より

    $
      tau_(a_1) times.o dots.c times.o tau_(a_M)
      =
      sigma_1^(a_1) sigma_2^(a_2) dots.c sigma_M^(a_M)
    $

    （ただし $tau_(a_k) = I$ の因子は $I_(("Mat"(2, CC))^(times.o M))$ に置き換える）と、上で得たパウリ作用素 $sigma_k^(a_k)$ と $I$ の積で書ける。
    したがって基底のすべての元が $S$ の生成する部分代数に属し、その線型結合により
    $"Mat"(2, CC)^(times.o M)$ の任意の元が表せる。ゆえに $S$ は代数 $"Mat"(2, CC)^(times.o M)$ を生成する。

    === Step 6: 結論

    Step 1, 2 より $T_((V)), T_((V'))$ はともに $CC$-代数の準同型（和・スカラー倍・積・単位元を保つ）であり、
    Step 4 より生成元集合 $S$ 上で一致する。

    任意の $x in "Mat"(2, CC)^(times.o M)$ をとる。Step 5 より、$x$ は $S union { I }$ の元の積（単項式）の
    有限 $CC$-線型結合として

    $
      x = sum_(l) c_l dot.op (s_(l, 1) s_(l, 2) dots.c s_(l, n_l))
      quad (c_l in CC, quad s_(l, i) in S union { I })
    $

    と書ける。各単項式について、$T_((V)), T_((V'))$ がともに乗法的（Step 1）かつ単位元を保つことから

    $
      T_((V))(s_(l, 1) dots.c s_(l, n_l))
      &=
      T_((V))(s_(l, 1)) dots.c T_((V))(s_(l, n_l))
      quad (because "Step 1（乗法性）")
      \
      &=
      T_((V'))(s_(l, 1)) dots.c T_((V'))(s_(l, n_l))
      quad (because "Step 4（生成元上の一致）, " T_((V))(I) = I = T_((V'))(I))
      \
      &=
      T_((V'))(s_(l, 1) dots.c s_(l, n_l))
      quad (because "Step 1（乗法性）")
    $

    が成り立つ。ゆえに線型性（Step 2）より

    $
      T_((V))(x)
      &=
      sum_(l) c_l dot.op T_((V))(s_(l, 1) dots.c s_(l, n_l))
      quad (because #ref(<mat_conj>))
      \
      &=
      sum_(l) c_l dot.op T_((V'))(s_(l, 1) dots.c s_(l, n_l))
      quad (because "上の単項式での一致")
      \
      &=
      T_((V'))(x)
      quad (because #ref(<mat_conj>))
    $

    を得る。$x in "Mat"(2, CC)^(times.o M)$ は任意であったから、$T_((V)) = T_((V'))$ である。

    $qed$
  ]
]<T_V_eq_T_Vprime>
