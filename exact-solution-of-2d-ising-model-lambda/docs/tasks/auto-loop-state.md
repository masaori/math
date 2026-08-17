# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-17 の tick 390 は、台帳の先頭行「零点密度: 一次因子の冪どうしが互いに素であること」を、`claim_qbar_bezout_power_propagation` を $a:=t-\widehat w$、$b:=t-\widehat{w'}$ と入れ替えて二度適用する形で四層で閉じた（住処 Qbar、脱出なし）。**
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
| 熱力学極限 | 零点密度: 互いに素な整除からの商への整除の遺伝（ユークリッドの補題型。$(t-\widehat{w'})^m\mid(t-\widehat w)^kg$ かつ $w\ne w'$ ならば $(t-\widehat{w'})^m\mid g$） | todo | 上の互いに素性から Bezout の式へ $g$ を掛けて構成的に示す |
| 熱力学極限 | 零点密度: 有限集合上の重複度の和は係数の上界を超えない（$\sum_{w\in s}\mathrm{mult}_w(f)\le n$） | todo | 帰納法（`claim_qbar_distinct_roots_card_bound` の形。上の遺伝の補題で他の根の重複度が商へ引き継がれることを使う） |
| 熱力学極限 | 零点密度: 重複度付きの個数 $N^{\mathrm{mult}}_L(c,r):=\sum_{\xi\in\mathcal F_L\cap D(c,r)}\mathrm{mult}_\xi(\widehat{Z_L}^{\,F})$ と $N_L\le N^{\mathrm{mult}}_L\le2L^2$ | todo | 定義と挟み込み。論法が二つなら割る |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
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
