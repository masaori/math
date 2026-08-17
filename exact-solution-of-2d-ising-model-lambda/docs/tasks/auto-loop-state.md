# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-17 の tick 395 は、台帳の先頭行「零点密度: 重複度付きの個数と挟み込み」を三行へ割り（持ち上げた分配多項式が零でなく係数の上界が $2L^2$ であること／$N^{\mathrm{mult}}_L$ の定義／挟み込み）、その最初を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound`（`claim_fisher_zero_finset_card_bound` の直前、住処 Qbar）: $L\ge1$ について、(1) $\mathrm{ac}_k(\widehat{Z_L}^{\,F})=\Omega_L(k)$（$k\le2L^2$）・$=0$（$2L^2<k$）、(2) $\widehat{Z_L}^{\,F}\ne0$、(3) $2L^2<k$ で係数が零。理由: 重複度 $\mathrm{mult}_\xi(\widehat{Z_L}^{\,F})$ が定まるには持ち上げが零でないことが要り、和の上界には係数の上界が要る。どちらも `claim_fisher_zero_finset_card_bound` の証明の中に埋まっていて引けなかったので、独立の主張へ持ち上げ、元の証明はこの主張を引く形へ直した（議論の重複を作らない）。
  SageMath `check/partition-polynomial-qbar-lift-nonzero-coeff-bound/`（3 節。$L=1,2,3$。分配多項式は配位から作り、多重度の列は独立に数える。係数の総和が $2^{L^2}$ であることも確認。`QQbar` 厳密。通過）。Lean は既存の `integerPolynomialQbarLift_partitionPolynomial_ne_zero` と `..._coeff_eq_zero_of_lt` を引くので新規ファイルは無し。check 485 ブロック・verify-check-linkage 272 件・build:pdf 264 ページ通過。
  式変形統一: 姉妹側「$c_2^*=s_2^*c_2$」（`008_TV1_hatZ_hatY_part1.ts`）で、散文中の一行の鎖 $c_2^*=\frac{c_2}{s_2}=c_2\cdot\frac1{s_2}=c_2s_2^*=s_2^*c_2$ を一続き四段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_finite_root_multiplicity_sum_le_coeff_bound` の本文（係数上界の帰納法）と Lean を突き合わせ、一致した。修正なし。
- **2026-08-17 の tick 394 は、台帳の先頭行「零点密度: 有限集合上の根の重複度の和は係数の上界を超えない」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_finite_root_multiplicity_sum_le_coeff_bound`: $f\ne0$ かつ $n<i\Rightarrow\mathrm{ac}_i(f)=0$ ならば、任意の有限集合 $s\subset\overline{\mathbb Q}$ について $\sum_{w\in s}\mathrm{mult}_w(f)\le n$。係数上界 $n$ の帰納法で、正の重複度を持つ一点 $w_0$ の一次因子を割り出し、$w_0$ には `claim_qbar_root_multiplicity_le_quotient_succ`、残りの点には `claim_qbar_other_root_multiplicity_le_quotient` を当てた。
  SageMath `check/qbar-finite-root-multiplicity-sum-le-coeff-bound/`、Lean 具体版・有限和比較だけへ落とした必要十分版・導出版を追加。check 484 ブロック、verify-check-linkage 271 件、sorry 検査 1376 件、PDF 264 ページ通過。式変形統一は姉妹側「$T$ の（定数倍を除いた）単射性」の Step 4 冒頭の二つの同値を、一続き二段・行末根拠つきへ揃えた（内容は不変）。姉妹側 check 300 ブロック・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_other_root_multiplicity_le_quotient` の本文・SageMath・Lean 具体版・必要十分版からの導出版を突き合わせ、一致したので修正なし。「何も言っていない主張」の観点では、$g\ne0$ は重複度の well-defined 性を担い、主不等式は今 tick の帰納法が残りの各点へ繰り返し使うため、いずれも残す。
- **2026-08-17 の tick 393 は、台帳の先頭行「零点密度: 他の点の重複度は商へ引き継がれる」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_other_root_multiplicity_le_quotient`（`claim_qbar_root_multiplicity_le_quotient_succ` の直後・「この先に書くこと」の直前）: $w\ne w'$、$f\ne0$、$f=(t-\widehat{w'})g$ ならば $g\ne0$ かつ $\mathrm{mult}_w(f)\le\mathrm{mult}_w(g)$。$M:=\mathrm{mult}_w(f)=M'+1$ の場合、読み取り 1 と仮定から $(t-\widehat w)^{M'+1}\mid(t-\widehat{w'})^{0+1}g$ を得て、`claim_qbar_coprime_divides_cofactor` を $k:=0,m:=M'$ で当て、読み取り 2 へ戻した。
  SageMath `check/qbar-other-root-multiplicity-le-quotient/`（相異なる $w,w'$ と $g$ の全組で整除の遺伝・不等式・実際の等号を `QQbar` で厳密検査）、Lean 具体版 `QbarOtherRootMultiplicityLeQuotient.lean`、既存の必要十分版 `coprime_divides_cofactor_necSuf`（可換環のみ）からの導出版を追加。sorry 検査 1373 件、check 483 ブロック、verify-check-linkage 270 件、PDF 263 ページ通過。
  式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」の Step 3 順方向で、左から $g^{-1}$、右から $g'$ を掛ける二つの同値変形を各一続き二段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check（300 ブロック）・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_root_multiplicity_le_quotient_succ` の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致したので修正なし。「何も言っていない主張」の観点では、この主張は次の重複度の和の帰納法が割り出した点へ使うため残す。$g\ne0$、$M=0$ の場合、両辺へ 1 を足す操作は独立ブロックにせず証明内に置かれている。
- **2026-08-17 の tick 392 は、台帳の先頭行「零点密度: 有限集合上の重複度の和は係数の上界を超えない」を三行へ割り（一次因子を 1 つ割り出したときの同じ点の重複度の減り方／他の点の重複度が商へ引き継がれること／和の上界（係数の上界の帰納法））、その最初を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_root_multiplicity_le_quotient_succ`（`claim_qbar_coprime_divides_cofactor` の直後・「この先に書くこと」の直前、住処 Qbar）: $f\ne0$、$f=(t-\widehat w)g$ ならば $g\ne0$ かつ $\mathrm{mult}_w(f)\le\mathrm{mult}_w(g)+1$。証明は $M:=\mathrm{mult}_w(f)$ が $0$ の場合を $\mathbb N$ の順序で済ませ、$M=M'+1$ のときは読み取り 1 で $f=(t-\widehat w)^{M'+1}h$ の証人を取り、$(t-\widehat w)\left((t-\widehat w)^{M'}h\right)=(t-\widehat w)^{M'+1}h=f=(t-\widehat w)g$ の一続き三段のあと `claim_qbar_poly_linear_factor_cancellation`（係数の上界は両者の非零係数の番号の最大元の大きい方）で一次因子を消去し、読み取り 2 で $M'\le\mathrm{mult}_w(g)$。
  SageMath `check/qbar-root-multiplicity-le-quotient-succ/`（4 節: $f\ne0$／結論の不等式／消去の段（$(t-\widehat w)^{M'}h=g$ と読み取り 2）／上界が最良（実際は等号）。$w$ 5 種・$g$ 7 種、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarRootMultiplicityLeQuotientSucc.lean`（`qbarRootMultiplicityLeQuotientSucc`。補助に `qbarQuotientNeZero`。`qbarPolyTopIndex_coeff_bound` を両者へ当てて `max` を上界に取り `qbarPolyLinearFactorCancellation`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarRootMultiplicityLeQuotientSucc.lean`（`root_multiplicity_le_quotient_succ_necSuf`。重複度を経由せず整除の指数だけで述べ、`poly_linear_factor_cancellation_necSuf` と `natDegree` 由来の係数の上界で可換環のみを要求。mathlib に monic による消去の補題は無かった）、導出版 `QbarRootMultiplicityLeQuotientSuccFromNecSuf.lean`。sorry 検査 1371 件。check 482 ブロック・verify-check-linkage 269 件・build:pdf 263 ページ通過。
  式変形統一: 姉妹側「$C(R^\times)$ の元はスカラー行列」（`008_TV1_hatZ_hatY_part1.ts`）で、一行で書かれていた $Wx=W(x+tI)-W(tI)=(x+tI)W-(tI)W=xW$ を一続き三段（行末根拠つき。分配律と二つの可換関係）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_coprime_divides_cofactor` の本文（一続き五段）と Lean 具体版・必要十分版を突き合わせ、一致した。修正なし。
- 2026-08-17 の tick 391 は、台帳の先頭行「零点密度: 互いに素な整除からの商への整除の遺伝（ユークリッドの補題型）」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_coprime_divides_cofactor`（`claim_qbar_linear_factor_powers_bezout` の直後・「この先に書くこと」の直前、住処 Qbar）: $w\ne w'\in\overline{\mathbb Q}$、$k,m\in\mathbb N$、$g\in\overline{\mathbb Q}[t]$ について $(t-\widehat{w'})^{m+1}\mid(t-\widehat w)^{k+1}g\Rightarrow(t-\widehat{w'})^{m+1}\mid g$。証明は Bezout 恒等式 $Pa^{k+1}+Qb^{m+1}=1$（`claim_qbar_linear_factor_powers_bezout`）へ $g$ を掛け、仮定の証人 $a^{k+1}g=b^{m+1}h$ を代入する一続き五段（積の単位元／Bezout の代入／分配則と結合則／仮定の代入／可換則・結合則と分配則）で、証人は $Ph+Qg$。
  SageMath `check/qbar-coprime-divides-cofactor/`（Bezout の構成・鎖の各段・結論の整除・含意が空虚でないことの 4 節。$w,w'$ は相異なる組すべて、$k,m=0,1,2$、$g$ は $b^{m+1}$ に 5 種を掛けたもの、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarCoprimeDividesCofactor.lean`（`qbarCoprimeDividesCofactor`。`calc` 四段と `ring`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarCoprimeDividesCofactor.lean`（`coprime_divides_cofactor_necSuf`。一次因子・冪・多項式環を落とし「$PA+QB=1$ かつ $B\mid Ag$ ならば $B\mid g$」として可換環だけを要求）、導出版 `QbarCoprimeDividesCofactorFromNecSuf.lean`。`Ising2DLambda.lean` の import と `check-no-sorry.sh` の登録リストへ 3 件追加。sorry 検査 1368 件。check 481 ブロック・verify-check-linkage 268 件・build:pdf 262 ページ通過。
  台帳のセクション表から先頭行を消した。
  式変形統一: 姉妹側「$T_g$ が $R^\times$ を $R^\times$ へ写すこと」（`008_TV1_hatZ_hatY_part1.ts` の (ii) の証明の冒頭）で、一行で書かれていた二つの鎖 $T_g(h)T_g(h^{-1})=I$・$T_g(h^{-1})T_g(h)=I$ を各一続き四段（行末根拠つき。結合則で $g^{-1}g$ を作る段を明示）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_linear_factor_powers_bezout` の本文（Bezout の伝播の二度適用）と Lean 具体版・必要十分版を突き合わせ、一致した。修正なし。
- 2026-08-17 の tick 390 は、台帳の先頭行「零点密度: 一次因子の冪どうしが互いに素であること」を、`claim_qbar_bezout_power_propagation` を $a:=t-\widehat w$、$b:=t-\widehat{w'}$ と入れ替えて二度適用する形で四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_linear_factor_powers_bezout`（`claim_qbar_bezout_power_propagation` の直後・「この先に書くこと」の直前、住処 Qbar）: $w\ne w'\in\overline{\mathbb Q}$、$k,m\in\mathbb N$ について、ある $P,Q\in\overline{\mathbb Q}[t]$ が存在して $P(t-\widehat w)^{k+1}+Q(t-\widehat{w'})^{m+1}=1$。証明は `claim_qbar_distinct_linear_factors_bezout` の Bezout 式 $u_{w,w'}a-u_{w,w'}b=1$（$a:=t-\widehat w$、$b:=t-\widehat{w'}$）を出発点に、`claim_qbar_bezout_power_propagation` を $n:=m$ で一度適用して $P_1a+Q_1b^{m+1}=1$ を得、これを $a':=b^{m+1}$、$b':=a$、$p':=Q_1$、$q':=P_1$ と読み替えて再び $n:=k$ で適用し $P_2b^{m+1}+Q_2a^{k+1}=1$ を得て $P:=Q_2,\ Q:=P_2$ とする、という二度適用の議論。
  SageMath `check/qbar-linear-factor-powers-bezout/`（`propagate` 関数で再帰式を $n$ まで構成し、一度目・入れ替え・二度目を追跡、$w,w'$ を相異なる組すべて・$k,m=0,\dots,3$、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarLinearFactorPowersBezout.lean`（`qbarLinearFactorPowersBezout`。`qbarDistinctLinearFactorsBezout` と `qbarBezoutPowerPropagation` を二度呼び、`linear_combination` で書き直し）、必要十分版 `NecSuf/ThermodynamicLimit/QbarLinearFactorPowersBezout.lean`（`linear_factor_powers_bezout_necSuf`。可換環だけを要求。`bezout_power_propagation_necSuf` を二度呼ぶだけ）、導出版 `QbarLinearFactorPowersBezoutFromNecSuf.lean`。`lean/Ising2DLambda.lean` に import を追加、`scripts/check-no-sorry.sh` の登録定理リストに 3 件追加。sorry 検査 1365 件。check 481 ブロック・verify-check-linkage 267 件・build:pdf 261 ページ通過。
  台帳のセクション表から先頭行を消した。
  式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」（`008_TV1_hatZ_hatY_part1.ts` の Step 1 末尾）で、散文中の三段の等式の鎖 $T_g(x)=T_g(x+tI)-T_g(tI)=T_{g'}(x+tI)-T_{g'}(tI)=T_{g'}(x)$ を一続き三段（行末根拠つき。$T_g,T_{g'}$ の加法性と仮定 $T_g|_{R^\times}=T_{g'}|_{R^\times}$）へ揃えた（内容は不変）。姉妹側 check（300 ブロック）・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_bezout_power_propagation` の本文（帰納法。出発点五段・一歩七段）と Lean 具体版（`qbarBezoutPowerPropagation`）・必要十分版（`bezout_power_propagation_necSuf`。可換環のみ）を突き合わせ、一致した。修正なし。
- 2026-08-17 の tick 389 は、台帳の先頭行「零点密度: 一次因子の冪どうしが互いに素であること」の下準備として、`claim_qbar_distinct_linear_factors_bezout` の一般化「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（住処 Qbar、脱出なし）。
  `claim_qbar_bezout_power_propagation`（`claim_qbar_distinct_linear_factors_bezout` の直後・「この先に書くこと」の直前、住処 Qbar）: $a,b\in\overline{\mathbb Q}[t]$、$p,q\in\overline{\mathbb Q}[t]$ が $pa+qb=1$ を満たすとき、任意の $n\in\mathbb N$ について、ある $P,Q\in\overline{\mathbb Q}[t]$ が存在して $Pa+Qb^{n+1}=1$。証明は $n$ の帰納法（出発点 $n=0$: $P:=p,Q:=q$、$b^1=b^0b=1\cdot b=b$ の一続き五段。一歩: $P_{n+1}:=P_np a+Q_np b^{n+1}+P_nq b$、$Q_{n+1}:=Q_nq$ と置き、$P_{n+1}a+Q_{n+1}b^{(n+1)+1}=(pa+qb)(P_na+Q_nb^{n+1})=1\cdot1=1$ を一続き七段で示す。中心は「$(pa+qb)$ と帰納法の仮定の式の積を展開し、定義した $P_{n+1},Q_{n+1}$ の式へ戻す」という、二つの Bezout 式の積を取る構成）。理由: 次の「$(t-\widehat w)^k$ と $(t-\widehat{w'})^m$ が互いに素であること」は、この一般補題を $a:=t-\widehat w$、$b:=t-\widehat{w'}$ と、$a,b$ を入れ替えて二度使うだけで従うため、その根拠となる一般形を先に独立に立てた。
  SageMath `check/qbar-bezout-power-propagation/`（$a:=t-w$、$b:=t-w'$、$p,q:=u_{w,w'},-u_{w,w'}$、$w,w'$ を $0,\pm1,\tfrac23,\zeta_3,\sqrt2$ から取った相異なる組すべて、$n=0,\dots,5$、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarBezoutPowerPropagation.lean`（`qbarBezoutPowerPropagation`。`induction n`、`pow_one`・`Nat.zero_add`、`pow_succ'`、`ring`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarBezoutPowerPropagation.lean`（`bezout_power_propagation_necSuf`。可換環だけを要求。多項式環も体も代数閉性も要らない）、導出版 `QbarBezoutPowerPropagationFromNecSuf.lean`（`R:=QbarPoly` への特殊化）。sorry 検査 1362 件。check 479 ブロック・verify-check-linkage 266 件・build:pdf 261 ページ通過。
  台帳のセクション表「一次因子の冪どうしが互いに素であること」の備考を、この主張を使う形へ更新した。
  式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」（`008_TV1_hatZ_hatY_part1.ts` の Step 4 末尾）で、散文の「$g^{-1}g'=cI$ と $g'=cg$ が同値」の二つの含意を各一続き三段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check（300 ブロック）・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_distinct_linear_factors_bezout` の本文（一続き六段）と Lean 具体版（`qbarDistinctLinearFactorsBezout`）・必要十分版（環の分配則 1 本）を突き合わせ、一致した。修正なし。
- **2026-08-17 の tick 388 は、台帳の先頭行「零点密度: 有限集合上の重複度の和は係数の上界を超えない」を論法で四行へ割り（相異なる代数的数に対応する一次因子は互いに素である（Bezout の明示式）／一次因子の冪どうしが互いに素であること／互いに素な整除からの商への整除の遺伝（ユークリッドの補題型）／重複度の和の上界（帰納法。上の 3 つを使う）、その最初「相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_qbar_distinct_linear_factors_bezout`（`claim_qbar_root_multiplicity_ge_one_iff_root` の直後・「この先に書くこと」の直前、住処 Qbar）: $w\ne w'\in\overline{\mathbb Q}$ について $u_{w,w'}:=\widehat{(w'-w)^{-1}}$（体 $\overline{\mathbb Q}$ の逆元。$w'-w\ne0$ で well-defined）と置くと $u_{w,w'}(t-\widehat w)-u_{w,w'}(t-\widehat{w'})=1$。証明は一続き六段（分配則／$t$ の相殺／定数embeddingが和を保つことと加法の逆元の一意性／$u$ の定め方／定数embeddingが積を保つこと／体の逆元と $\widehat1=1$）。理由: この後の「有限集合上の重複度の和の上界」の帰納法が、異なる根に対応する一次因子の互いに素性（ユークリッドの補題型の除去）を要求するため、まずその根拠となる明示的 Bezout 恒等式を独立に立てた。
  SageMath `check/qbar-distinct-linear-factors-bezout/`（$w,w'$ を $0,\pm1,\tfrac23,\zeta_3,\zeta_5,\sqrt2$ から取った相異なる組 42 通り、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarDistinctLinearFactorsBezout.lean`（`qbarDistinctLinearFactorsBezout`。`Polynomial.C_sub`・`Polynomial.C_mul`・`Polynomial.C_1`、`inv_mul_cancel₀`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarDistinctLinearFactorsBezout.lean`（`distinct_linear_factors_bezout_necSuf`。環の分配則 `mul_sub` 1 本だけを要求。体も多項式環も代数閉性も要らない）、導出版 `QbarDistinctLinearFactorsBezoutFromNecSuf.lean`。sorry 検査 1359 件。check 478 ブロック・verify-check-linkage 265 件・build:pdf 260 ページ通過。
  式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」（`008_TV1_hatZ_hatY_part1.ts` の Step 3 末尾）で、散文の等式 $g(hu)g'^{-1}=ghg^{-1}$ と $g(uh)g'^{-1}=g'hg'^{-1}$ を、それぞれ一続き四段（$u$ の定め方／積の結合則／$gg^{-1}=I$ または $g'g'^{-1}=I$／積の単位元。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 325 ページ通過。
  レビュー: 前 tick の `claim_qbar_root_multiplicity_ge_one_iff_root` の本文（二つの含意。準備三段・鎖五段・上界と因数定理からの含意）と Lean 具体版（`qbarRootMultiplicityGeOneIffRoot`）を突き合わせ、一致した。修正なし。
- 2026-08-17 の tick 387 は、台帳の先頭行「零点密度: 重複度が 1 以上であることと $\mathrm{aev}_w(f)=0$ は同じこと」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた（住処 Qbar、脱出なし）。
  `claim_qbar_root_multiplicity_ge_one_iff_root`（`def_qbar_root_multiplicity` の直後・「この先に書くこと」の直前、住処 Qbar）: $f\ne0$、$w\in\overline{\mathbb Q}$ について $\mathrm{mult}_w(f)\ge1\Leftrightarrow\mathrm{aev}_w(f)=0$。証明は二つの含意。前半は $m:=\mathrm{mult}_w(f)-1$ と整除の証人 $g$ を取り、準備 $\mathrm{aev}_w(t-\widehat w)=\mathrm{aev}_w(t)-\mathrm{aev}_w(\widehat w)=w-w=0$ の一続き三段のあと、$\mathrm{aev}_w(f)=\mathrm{aev}_w((t-\widehat w)^m(t-\widehat w)g)=\mathrm{aev}_w((t-\widehat w)^m)\cdot0\cdot\mathrm{aev}_w(g)=0$ の一続き五段（代入が積を保つことを二回）。後半は非零係数の番号の最大元 $n_f$ を上界にして `def_qbar_linear_factor_power_divides` の二つめの読み取りで $(t-\widehat w)^1\mid f$ を得、`def_qbar_root_multiplicity` の二つめの読み取りを $k:=1$ へ当てる。本文末尾「この先に書くこと」の内訳から済んだ項目を消した。
  SageMath `check/qbar-root-multiplicity-ge-one-iff-root/`（$w$ 6 個・$f$ 7 個（重複度 2・3 の因子を持つものを含む）、重複度は整除する指数の最大元として計算、`QQbar` 厳密。通過）。Lean 具体版 `ThermodynamicLimit/QbarRootMultiplicityGeOneIffRoot.lean`（`qbarRootMultiplicityGeOneIffRoot`。重複度を指数 $k$ と証人 $g$ へ移してから `calc`（`hf` への依存で `rw` の motive が壊れるのを避けるため）、`qbarPolyEval_eq_eval`・`Polynomial.eval_mul`、`qbarLinearFactorPowDivides_one_of_root`・`qbarPolyTopIndex_coeff_bound`）、必要十分版 `NecSuf/ThermodynamicLimit/QbarRootMultiplicityGeOneIffRoot.lean`（`poly_root_multiplicity_ge_one_iff_root_necSuf`。重複度を経由せず「指数 1 以上の整除の存在」で述べ、可換環だけを要求（`Polynomial.dvd_iff_isRoot`）。$f\ne0$ も要らない）、導出版 `QbarRootMultiplicityGeOneIffRootFromNecSuf.lean`（最大元の読み取り 1・2 でその形と結ぶ）。sorry 検査 1356 件。check 477 ブロック・verify-check-linkage 264 件・PDF 260 ページ通過。
  式変形統一: 姉妹側「$T_g$ の核（スカラー倍の自由度）」（`008_TV1_hatZ_hatY_part1.ts` の Step 2）で、散文中の $g\,u=g(g^{-1}g')=(gg^{-1})g'=g'$ を一続き四段（$u$ の定め方／積の結合則／$gg^{-1}=I$／積の単位元。行末根拠つき）へ揃えた（内容は不変）。姉妹側の check・PDF 324 ページ通過。
  レビュー: 前 tick の `def_qbar_root_multiplicity` の本文（$\mathcal K_w(f)$ の空でないこと・有限性・読み取り三つ）と Lean 具体版（`qbarRootMultiplicityExponentSet` ほか）を突き合わせ、一致した。修正なし。
- **2026-08-17 の tick 386 は、台帳の先頭行「零点密度: 根の重複度 $\mathrm{mult}_w(f)$ の定義」（$f\ne0$ について、$(t-\widehat w)^k\mid f$ を満たす $k\in\mathbb N$ の集合 $\mathcal K_w(f)$ の最大元）を本文・Lean 具体版まで書いて閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_qbar_root_multiplicity`（`claim_qbar_linear_factor_pow_divides_exponent_le` の直後・「この先に書くこと」の直前）。$\mathcal K_w(f)$ が空でないこと（$0\in\mathcal K_w(f)$、`def_qbar_linear_factor_power_divides`）と有限であること（$f\ne0$ の非零係数の番号の最大元 $n_f$ を取り、`claim_qbar_linear_factor_pow_divides_exponent_le` で $\mathcal K_w(f)\subseteq\{0,\dots,n_f\}$）を定義の中で言い、$\mathrm{mult}_w(f):=\max\mathcal K_w(f)$。定義から読める三つ（$(t-\widehat w)^{\mathrm{mult}}\mid f$／$(t-\widehat w)^k\mid f\Rightarrow k\le\mathrm{mult}$／係数の上界 $n$ ならば $\mathrm{mult}\le n$）も定義の中に置いた。本文末尾「この先に書くこと」の内訳から済んだ項目を消した。
  Lean 具体版 `ThermodynamicLimit/QbarRootMultiplicity.lean`（`qbarPolyTopIndex`（`f.support.max'`）・`qbarRootMultiplicityExponentSet`（`Finset.range (n_f+1)` の `filter`。`mem_…` で整除と同値）・`_nonempty`・`qbarRootMultiplicity`（`Finset.max'`）・`_divides`・`_ge_of_divides`・`_le_of_coeff_bound`・橋渡し `_eq_rootMultiplicity`（mathlib の `Polynomial.le_rootMultiplicity_iff` で両向き））。sorry 検査 1353 件。check 476 ブロック・verify-check-linkage 263 件・PDF 259 ページ通過。
  式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 の末尾で、散文中の $\mathrm{ad}_{\alpha X}^{\,n}=(\alpha\,\mathrm{ad}_X)^n=\alpha^n\mathrm{ad}_X^{\,n}$ を一続き二段（行末根拠つき。$n=0$ の断りも根拠へ）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
  レビュー: 前 tick の `claim_qbar_linear_factor_pow_divides_exponent_le` の本文（背理法）と Lean 具体版・必要十分版を突き合わせ、一致した。修正なし。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 零点密度: 重複度付きの個数 $N^{\mathrm{mult}}_L(c,r):=\sum_{\xi\in\mathcal F_L\cap D(c,r)}\mathrm{mult}_\xi(\widehat{Z_L}^{\,F})$ の定義 | todo | 持ち上げが零でないこと（`claim_partition_polynomial_qbar_lift_nonzero_coeff_bound`）で重複度が定まる。有限和は `def_fisher_zero_count_in_rational_disc` と同じ有限集合の上 |
| 熱力学極限 | 零点密度: 挟み込み $N_L\le N^{\mathrm{mult}}_L\le2L^2$ | todo | 左は各項が 1 以上（`claim_qbar_root_multiplicity_ge_one_iff_root`）、右は `claim_qbar_finite_root_multiplicity_sum_le_coeff_bound` を $n:=2L^2$ で当てる |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-17（tick 395）: 台帳の先頭行「零点密度: 重複度付きの個数と挟み込み」を三行へ割り（持ち上げの非零性と係数の上界／$N^{\mathrm{mult}}_L$ の定義／挟み込み。理由: 重複度が定まる前提と和の上界の前提が、既存の証明の中に埋まっていて引けなかったため）、その最初 `claim_partition_polynomial_qbar_lift_nonzero_coeff_bound` を四層で閉じた。既存 `claim_fisher_zero_finset_card_bound` の証明からその議論を持ち上げ、元の証明はこの主張を引く形へ直した。SageMath 3 節（$L=1,2,3$）、Lean は既存定理を引くので新規なし。check 485 ブロック・linkage 272 件・PDF 264 ページ通過。式変形統一: 姉妹側 $c_2^*=s_2^*c_2$ の一行の鎖を一続き四段（行末根拠つき）へ揃えた。姉妹側 check・PDF 325 ページ通過。
- 2026-08-17（tick 394）: 台帳の先頭行「零点密度: 有限集合上の根の重複度の和は係数の上界を超えない」を四層で閉じた。係数上界の帰納法で正の重複度を持つ一点の一次因子を割り出し、その点の重複度は高々 1 だけ減ること、他の各点の重複度は失われないこと、商の係数上界が 1 下がることを組み合わせた。式変形統一は姉妹側「$T$ の（定数倍を除いた）単射性」Step 4 冒頭の同値の鎖を揃えた。
- 2026-08-17（tick 393）: 台帳の先頭行「零点密度: 他の点の重複度は商へ引き継がれる」を四層で閉じ、`claim_qbar_other_root_multiplicity_le_quotient` を `claim_qbar_root_multiplicity_le_quotient_succ` の直後に置いた。$w\ne w'$、$f=(t-\widehat{w'})g$ ならば $\mathrm{mult}_w(f)\le\mathrm{mult}_w(g)$ を、重複度の読み取り 1 → `claim_qbar_coprime_divides_cofactor`（$k:=0$）→読み取り 2 で示した。SageMath・Lean 具体版・既存必要十分版からの導出版まで通過。式変形統一は姉妹側「$T$ の（定数倍を除いた）単射性」Step 3 順方向の二つの同値変形を一続きの鎖へ揃えた（内容は不変）。
- 2026-08-17（tick 392）: 台帳の先頭行「零点密度: 有限集合上の重複度の和は係数の上界を超えない」を三行へ割った（同じ点の重複度の減り方／他の点の重複度が商へ引き継がれること／和の上界（係数の上界の帰納法）。理由: 帰納法の一歩で $f=(t-\widehat{w_0})g$ へ移るとき、$w_0$ の分の重複度と他の点の重複度をそれぞれ別の補題で評価する必要があるため）。その最初「一次因子を 1 つ割り出すと、その点の重複度は 1 しか下がらない」を四層で閉じ、`claim_qbar_root_multiplicity_le_quotient_succ` を `claim_qbar_coprime_divides_cofactor` の直後に置いた。$f\ne0$、$f=(t-\widehat w)g$ ならば $g\ne0$ かつ $\mathrm{mult}_w(f)\le\mathrm{mult}_w(g)+1$（読み取り 1 で証人を取り、一続き三段のあと一次因子を消去して読み取り 2）。SageMath（4 節。$w$ 5 種・$g$ 7 種）、Lean 具体版・必要十分版（整除の指数だけで述べ可換環のみ）・導出版、sorry 検査 1371 件。式変形統一: 姉妹側「$C(R^\times)$ の元はスカラー行列」の $Wx=\dots=xW$ を一続き三段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
- 2026-08-17（tick 391）: 台帳の先頭行「零点密度: 互いに素な整除からの商への整除の遺伝（ユークリッドの補題型）」を四層で閉じ、`claim_qbar_coprime_divides_cofactor` を `claim_qbar_linear_factor_powers_bezout` の直後に置いた。$(t-\widehat{w'})^{m+1}\mid(t-\widehat w)^{k+1}g\Rightarrow(t-\widehat{w'})^{m+1}\mid g$（Bezout 恒等式へ $g$ を掛け、仮定の証人を代入する一続き五段。証人は $Ph+Qg$）。SageMath（4 節。相異なる組すべて・$k,m=0,1,2$・$g$ 5 種）、Lean 具体版・必要十分版（一次因子と冪を落として可換環のみ）・導出版、sorry 検査 1368 件。式変形統一: 姉妹側「$T_g$ が $R^\times$ を $R^\times$ へ写すこと」（`008_TV1_hatZ_hatY_part1.ts` の (ii) 冒頭）の二つの鎖を各一続き四段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
- 2026-08-17（tick 390）: 台帳の先頭行「零点密度: 一次因子の冪どうしが互いに素であること」を、`claim_qbar_bezout_power_propagation` の二度適用で四層で閉じ、`claim_qbar_linear_factor_powers_bezout` を `claim_qbar_bezout_power_propagation` の直後に置いた。$w\ne w'$、$k,m\in\mathbb N$ について $\exists P,Q,\ P(t-\widehat w)^{k+1}+Q(t-\widehat{w'})^{m+1}=1$（`claim_qbar_distinct_linear_factors_bezout` の Bezout 式を出発点に、`claim_qbar_bezout_power_propagation` を $n:=m$ で適用後、$a,b$ を入れ替えて $n:=k$ で再適用）。SageMath（相異なる組すべて・$k,m=0,\dots,3$）、Lean 具体版・必要十分版（可換環のみ。二度呼ぶだけ）・導出版、`Ising2DLambda.lean` の import と `check-no-sorry.sh` の登録リストへ 3 件追加、sorry 検査 1365 件。台帳のセクション表から先頭行を消した。式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」（`008_TV1_hatZ_hatY_part1.ts` の Step 1 末尾）で、散文の三段の等式の鎖 $T_g(x)=T_g(x+tI)-T_g(tI)=T_{g'}(x+tI)-T_{g'}(tI)=T_{g'}(x)$ を一続き三段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check（300 ブロック）・PDF 325 ページ通過。
- 2026-08-17（tick 389）: 台帳の先頭行「零点密度: 一次因子の冪どうしが互いに素であること」の下準備として、`claim_qbar_distinct_linear_factors_bezout` の一般化「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」を四層で閉じ、`claim_qbar_bezout_power_propagation` を `claim_qbar_distinct_linear_factors_bezout` の直後に置いた。$pa+qb=1$ ならば任意の $n\in\mathbb N$ で $\exists P,Q,\ Pa+Qb^{n+1}=1$（$n$ の帰納法。一歩は二つの Bezout 式の積を取って展開し直す一続き七段）。SageMath（$a,b$ を相異なる $w,w'$ から作った一次因子、$n=0,\dots,5$）、Lean 具体版・必要十分版（可換環のみ）・導出版、sorry 検査 1362 件。台帳のセクション表「一次因子の冪どうしが互いに素であること」の備考をこの主張を使う形へ更新した。式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」（`008_TV1_hatZ_hatY_part1.ts` の Step 4 末尾）で、散文の「$g^{-1}g'=cI$ と $g'=cg$ が同値」の二つの含意（$g'=g(g^{-1}g')=g(cI)=cg$、$g^{-1}g'=g^{-1}(cg)=c(g^{-1}g)=cI$）を各一続き三段（行末根拠つき。ラベル参照は生成器が `\blkref` を持たないので直後の散文に残した）へ揃えた（内容は不変）。姉妹側 check（300 ブロック）・PDF 325 ページ通過。
- 2026-08-17（tick 388）: 台帳の先頭行「零点密度: 有限集合上の重複度の和は係数の上界を超えない」を四行へ割った（一次因子は互いに素である（Bezout の明示式）／一次因子の冪どうしが互いに素であること／互いに素な整除からの商への整除の遺伝（ユークリッドの補題型）／重複度の和の上界（帰納法）。理由: 帰納法の一歩で「他の根の重複度が商へそのまま引き継がれる」ことが要り、それは一次因子どうしの互いに素性からユークリッドの補題型の議論で示す必要があるため）。その最初「相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）」を四層で閉じ、`claim_qbar_distinct_linear_factors_bezout` を `claim_qbar_root_multiplicity_ge_one_iff_root` の直後に置いた。$u_{w,w'}:=\widehat{(w'-w)^{-1}}$ と置くと $u_{w,w'}(t-\widehat w)-u_{w,w'}(t-\widehat{w'})=1$（一続き六段）。SageMath（相異なる組 42 通り）、Lean 具体版・必要十分版（環の分配則 1 本だけを要求）・導出版、sorry 検査 1359 件。式変形統一: 姉妹側「$T$ の（定数倍を除いた）単射性」（`008_TV1_hatZ_hatY_part1.ts` Step 3 末尾）の散文中の等式 $g(hu)g'^{-1}=ghg^{-1}$・$g(uh)g'^{-1}=g'hg'^{-1}$ を各一続き四段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check・PDF 325 ページ通過。
- 2026-08-17（tick 387）: 台帳の先頭行「零点密度: 重複度が 1 以上であることと $\mathrm{aev}_w(f)=0$ は同じこと」を四層で閉じ、`claim_qbar_root_multiplicity_ge_one_iff_root` を `def_qbar_root_multiplicity` の直後に置いた。二つの含意（代入が積を保つことと $\mathrm{aev}_w(t-\widehat w)=0$ による鎖／上界 $n_f$ と因数定理の読み取りから $(t-\widehat w)^1\mid f$）。SageMath（$w$ 6 個・$f$ 7 個）、Lean 具体版・必要十分版（可換環。重複度を経由せず指数 1 以上の整除の存在で述べる）・導出版、sorry 検査 1356 件。式変形統一: 姉妹側「$T_g$ の核」（`008_TV1_hatZ_hatY_part1.ts` の Step 2）の散文中の $g\,u=g'$ の鎖を一続き四段（行末根拠つき）へ揃えた（内容は不変）。姉妹側 check・PDF 324 ページ通過。
- 2026-08-17（tick 386）: 台帳の先頭行「零点密度: 根の重複度 $\mathrm{mult}_w(f)$ の定義」を本文・Lean 具体版で閉じ、`def_qbar_root_multiplicity` を `claim_qbar_linear_factor_pow_divides_exponent_le` の直後に置いた（定義ブロック。必要十分版・SageMath は無し）。$\mathcal K_w(f):=\{k\mid(t-\widehat w)^k\mid f\}$ が空でなく（$k=0$）有限（非零係数の番号の最大元 $n_f$ と前主張で $\subseteq\{0,\dots,n_f\}$）なので最大元 $\mathrm{mult}_w(f)$。読み取り三つを定義の中に。Lean は `Finset.range (n_f+1)` の `filter` の `max'`、mathlib の `rootMultiplicity` との橋渡し一本。sorry 検査 1353 件。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 の末尾の散文中の $\mathrm{ad}_{\alpha X}^{\,n}=(\alpha\,\mathrm{ad}_X)^n=\alpha^n\mathrm{ad}_X^{\,n}$ を一続き二段（行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。

## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-17（tick 394）: 前 tick の「相異なる点の重複度は、一次因子を割り出した商へ引き継がれる」の本文・SageMath・Lean 具体版・必要十分版からの導出版を突き合わせ、一致した。修正なし。「何も言っていない主張」の観点では、$g\ne0$ は重複度の well-defined 性を担い、主不等式は今 tick の帰納法が残りの各点へ繰り返し使うため残す。
- 2026-08-17（tick 393）: 前 tick の「一次因子を 1 つ割り出すと、その点の重複度は 1 しか下がらない」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 前 tick の主張は重複度の和の帰納法が割り出した点へ使い、今 tick の主張は同じ帰納法が残りの各点へ繰り返し使うので、いずれも独立した内容を持つ。$g\ne0$、$M=0$ の場合、$M'+1\le\mathrm{mult}_w(g)$ からの読み替えは証明内に置き、独立ブロックにしていない。
- 2026-08-17（tick 390）: 前 tick の「Bezout 恒等式は、もう一方の元の冪についても構成できる（帰納法）」の本文（帰納法。出発点五段・一歩七段）と Lean 具体版（`qbarBezoutPowerPropagation`）・必要十分版（`bezout_power_propagation_necSuf`。可換環のみ）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張（二度適用で $(t-\widehat w)^{k+1}$ と $(t-\widehat{w'})^{m+1}$ を結ぶ）は次の「互いに素な整除からの商への整除の遺伝」が直接引く構成的な結果であり、単なる言い換えではないので独立ブロックとして残す。入れ替えた組 $(a',b',p',q')$ の読み替えは証明中の一行に置き、独立ブロックにしなかった。
- 2026-08-17（tick 389）: 前 tick の「相異なる代数的数に対応する一次因子は互いに素である（明示的な Bezout 恒等式）」の本文（一続き六段）と Lean 具体版（`qbarDistinctLinearFactorsBezout`）・必要十分版（`distinct_linear_factors_bezout_necSuf`。環の分配則 1 本）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張（Bezout 恒等式の冪への伝播）は、次の「一次因子の冪どうしが互いに素であること」が $a,b$ を入れ替えて二度引く形で使う一般補題であり、単独では何も新しい情報を持たない散文ではなく、構成的な帰納法そのものが主張の中身なので独立ブロックとして残す。$P_{n+1},Q_{n+1}$ の定め方は独立ブロックにせず証明中の一行に置いた。
- 2026-08-17（tick 388）: 前 tick の「重複度が 1 以上であることと $\mathrm{aev}_w(f)=0$ は同じこと」の本文（二つの含意。準備三段・鎖五段・上界と因数定理からの含意）と Lean 具体版（`qbarRootMultiplicityGeOneIffRoot`。`calc` 五段、`qbarPolyEval_eq_eval`・`Polynomial.eval_mul`）・必要十分版（可換環。`Polynomial.dvd_iff_isRoot`）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張は明示的な Bezout 恒等式であり、次の「一次因子の冪どうしが互いに素であること」の帰納法（二項係数展開）が引く（後で引く形）ので独立ブロックとして残す。$u_{w,w'}$ の well-defined 性（$w'-w\ne0$ で逆元が取れること）は主張の中の前置きとして扱い、独立ブロックにしなかった。
- 2026-08-17（tick 386）: 前 tick の「零でない多項式を割る一次因子の冪の指数は係数の上界を超えない」の本文（背理法。準備の $g\ne0$ 三段・非零係数の最大元 $m$・鎖三段・$k\le m+k\le n$ 二段）と Lean 具体版（`obtain`、`mul_zero`、`g.support.max'`、`qbarLinearFactorPowMulLeadingCoeff`、`by_contra`、`Nat.le_add_left`）・必要十分版（可換環）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick は定義ブロックで、独立の主張ブロックは足していない。$\mathcal K_w(f)$ が空でない・有限であることは最大元が定まるための well-defined 性（住処の確定）、読み取り三つ（整除する・整除する指数以上・係数の上界以下）は後の「重複度 1 以上と根の一致」「重複度の和の上界」が繰り返し引く形なので、いずれも定義の中に置いた。本文末尾「この先に書くこと」の内訳から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 の末尾で、散文中の $\mathrm{ad}_{\alpha X}^{\,n}=(\alpha\,\mathrm{ad}_X)^n=\alpha^n\mathrm{ad}_X^{\,n}$ を一続き二段（行末根拠つき。$n=0$ の断りも根拠へ）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。
- 2026-08-17（tick 385）: 前 tick の「一次因子の冪との積の先頭の係数はもとの先頭の係数」の本文（帰納法。出発点三段・冪の等式二段・一歩四段）と Lean 具体版（`induction j`、`calc` 三段・四段、`Nat.add_assoc`、`qbarLinearFactorPowMulCoeffBound`、`qbarPolyLinearFactorLeadingCoeff`）・必要十分版（可換環）を突き合わせ、一致した。修正なし。
  「何も言っていない主張」の観点: 今 tick の主張は背理法で示す指数の上界であり、次の「根の重複度の定義」の well-defined 性（整除する指数の集合が上に有界）が引く（後で引く形）ので独立ブロックとして残す。$g\ne0$（$g=0$ なら $f=0$）、非零係数の番号の最大元 $m$ の存在（有限・空でない）、$k\le m+k$（$\mathbb N$ の加法の単調性）は独立ブロックにせず証明の中の準備と一続きの行に置いた。本文末尾「この先に書くこと」の内訳から済んだ項目を消し、台帳のセクション表（先頭行を消した）と揃えた。式変形統一: 姉妹側「$H$ と $\hat Z$・$\hat Y$ の交換子の入れ子」（`008_TV1_hatZ_hatY_part1.ts`）の補題 1 で、散文中の $\mathrm{ad}_{\alpha X}(W)=[\alpha X,W]=\alpha[X,W]=\alpha\,\mathrm{ad}_X(W)$ を一続き三段（行末根拠つき）へ揃えた（内容は不変）。姉妹側の check（300 ブロック）・PDF 324 ページ通過。

## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止・再開・頻度変更は、**自分で `launchctl` を叩かず** tmux セッション `local-pc-management` の
ウィンドウ `tick窓口` へ依頼する（2026-08-16 に経路が固定された。`launchd-tick-loop` skill）。
