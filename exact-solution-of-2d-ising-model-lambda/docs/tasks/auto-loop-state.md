# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-17 の tick 356 は、台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_density_sequence_cauchy_le_one`（`claim_open_square_density_difference_bound_core_nonneg_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）: $0<q\le1$ で列 $(\Psi^{\mathrm{op}}_L(q))_{L\ge1}$ は `def_rational_log_order_group_cauchy_sequence` の Cauchy 列。証明は準備三つ（核の非負から Archimedes 性で $\Gamma(q)\le n\varepsilon$ の $n$、$a:=n+2$、$N:=a^2$（$\mathbb N$ の事実 $a\ge1$、$n\le a$、$a<a^2$、$N\ge1$）／$N\le L,M$ から $a<L,M$、$a^2\le L,M$／`claim_rational_log_order_group_div_ge_multiplier_le` で $\frac1a\Gamma(q)\le\varepsilon$）と、上端一続き三段（差の上からの評価 $\le R_a$、核の等式で $=\frac1a\Gamma(q)$、$\le\varepsilon$）・下端一続き三段（逆元の順序反転で $-\varepsilon\le-\frac1a\Gamma(q)$、$=-R_a$、差の下からの評価）。完備性も極限の値も使わない。`remark_real_escape_plan` の Cauchy の項をこの主張への参照に書き換え、本文末尾の「この先に書くこと」から Cauchy 性を消した。
  SageMath `check/open-square-density-sequence-cauchy/`（$q\in\{1,\frac12,\frac23\}$、$n=1$・$a=3$・$N=9$ になる $\varepsilon$、$L,M\in\{9,10\}$。105 検査、35 秒。一辺 9 以上の分配関数は行ごとの動的計画法で計算し一辺 2, 3 で全列挙と一致を確認、$\Lambda_{\mathbb Q}$ の元は素因数分解を避けて「正の有理数の対数の形式和」で持ち、順序は共通分母を掛けて $\mathrm{rat}_\Lambda$ で比べる。理由は overview に記した）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensitySequenceCauchy.lean`（`openSquareDensitySequence`（$L=0$ で $0$。定義は $L\ge1$ しか見ない）、`openSquareDensitySequence_of_ne_zero`、`isCauchyRationalLogOrder_openSquareDensitySequence_of_le_one`），
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensitySequenceCauchy.lean`（`cauchy_of_uniform_difference_bounds_necSuf`。`[Zero X] [Neg X] [SMul ℚ X]` と推移律・逆元の順序反転・核の等式・差の上下の一様な評価・核の Archimedes 性・倍率以上で割る評価を仮定として受けるだけ。加法も群の公理も順序の線形性も要らない。$a:=n+2$、$N:=a^2$ は $\mathbb N$ のまま）、導出版。sorry 検査 1329 件。
  前 tick のレビューでは修正なし。次は「切断による実数体への一度きりの脱出」。

- **2026-08-17 の tick 355 は、台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」を論法の数で二行へ割り、その最初「Archimedes 性の倍率以上の自然数で割れば上界を超えない」（$0\le_{\Lambda_{\mathbb Q}}\varepsilon$、$\mu\le_{\Lambda_{\mathbb Q}}n\cdot\varepsilon$、$a\ge1$、$n\le a$ で $\frac1a\cdot\mu\le_{\Lambda_{\mathbb Q}}\varepsilon$）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_rational_log_order_group_div_ge_multiplier_le`（`claim_rational_log_order_group_scalar_compare_nonpos` の直後・`claim_rational_embedded_log_order_iff` の直前、住処 Lambda。$\Lambda_{\mathbb Q}$ の順序と有理数倍の一般的な性質なので、密度の評価の列ではなく係数比較の並びに置いた）。$0\le\mu$ は要らない。証明は準備（$0\le\frac1a$、$\frac na\le1$。$\mathbb Q$ の順序）と本体一続き五段（$\frac1a\mu\le\frac1a(n\varepsilon)$（`claim_rational_log_order_group_nonneg_scalar_monotone`）$=(\frac1a n)\varepsilon$（有理数倍の結合則を右から左）$=\frac na\varepsilon$（$\mathbb Q$ の四則）$\le1\cdot\varepsilon$（`claim_rational_log_order_group_scalar_compare_nonneg`）$=\varepsilon$（$1\cdot\lambda=\lambda$））。加法にも逆元にも触れない。
  SageMath `check/rational-log-order-group-div-ge-multiplier-le/`（素数 $2,3,5$ の 64 ベクトル、$n\le3$、$a\le5$。仮定を満たす 28491 組で主張と五段、$n\le a$ を外すと落ちる例 878 組。数秒）。Lean 具体版 `ThermodynamicLimit/RationalLogOrderGroupDivGeMultiplierLe.lean`（`rationalLogOrderLE_inv_natSmul_le_of_le_natSmul`。`one_div_pos`・`div_le_one`・`← mul_smul`・`ring`・`one_smul`・`rationalLogOrderLE_trans`），
  必要十分版 `NecSuf/ThermodynamicLimit/RationalLogOrderGroupDivGeMultiplierLe.lean`（`inv_smul_le_of_le_smul_necSuf`。`[Zero X] [SMul ℚ X]` と推移律・非負係数の作用の順序保存・非負の元の係数比較・作用の結合則・単位を仮定として受けるだけ。加法も群の公理も順序の線形性も要らない。係数は $\mathbb Q$ のまま）、導出版。sorry 検査 1325 件。
  割り方: 「Archimedes 性の倍率以上の自然数で割れば上界を超えない」（係数の鎖）→「密度の列の Cauchy 性」（Archimedes 性で $n$、$a:=n+2$、$N:=a^2$ を選ぶ存在の構成。上端・下端に核の等式とこの主張を代入し、下端は逆元の順序反転）。前 tick のレビューでは修正なし。次は「密度の列の Cauchy 性（$0<q\le1$）」本体。

- **2026-08-17 の tick 354 は、台帳の先頭行「核は非負である（$0\le_{\Lambda_{\mathbb Q}}\Gamma(q)$、$0<q\le1$）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_density_difference_bound_core_nonneg_le_one`（`claim_open_square_density_difference_bound_is_core_over_base_side` の直後・`remark_real_escape_plan` の直前、住処 Lambda）: $0<q\le1$ で $0\le_{\Lambda_{\mathbb Q}}\Gamma(q)$。証明は準備 4 つ（符号 $\iota(\log q)\le0$（ここだけ $q\le1$）・$0\le\iota(\ell_2)$・$0\le\iota(\log(1+q))$ を `claim_rational_embedded_log_order_iff` から／$0=2\cdot0\le2\iota(\ell_2)$、$0=4\cdot0\le4\iota(\log(1+q))=0+4\iota(\log(1+q))\le X$（非負有理数倍の順序保存・単位元・加法単調性）／$Y\le4\cdot0=0$、$0=-0\le-Y$（`claim_rational_log_order_group_neg_reverses_order`）／$0\le C$ の既出の一続きと $0=2\cdot0\le2C$）と、本体（$0=0+0\le X+0=0+X\le(-Y)+X=X+(-Y)=0+(X+(-Y))\le2C+(X+(-Y))=(X+(-Y))+2C=\Gamma(q)$。加法単調性を三度と交換則・単位元）。結合則も逆元律も使わない。
  SageMath `check/open-square-density-difference-bound-core-nonneg/`（分配関数不要。$q\le1$ の 7 点で各段 38 検査、$q>1$ の 2 点で否定側（$\iota(\log q)\le0$ が落ちる）1 検査、計 268 検査、10 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensityDifferenceBoundCoreNonneg.lean`（`rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCoreX`・`rationalLogOrderLE_zero_neg_openSquareDensityDifferenceBoundCoreY_of_le_one`・`rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCore_of_le_one`。既出の符号補題三つと `rationalLogOrderLE_zero_openSquareUpperBoundConstant` を引く），
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensityDifferenceBoundCoreNonneg.lean`（`zero_le_core_of_signs_necSuf`。`[AddCommMonoid X] [Neg X] [SMul ℚ X]` と推移律・右加法単調性・非負有理数倍の順序保存・逆元の順序反転・$c\cdot0=0$・$-0=0$、三つの符号を仮定として受けるだけ。結合則・逆元律・順序の線形性は要らない）、導出版。sorry 検査 1322 件。
  前 tick のレビューでは修正なし。次は「密度の列の Cauchy 性（$0<q\le1$）」（備考の手順どおり。論法が二つ以上なら着手時に割る）。

- **2026-08-17 の tick 353 は、台帳の先頭行「差の両側の評価を $\frac1a$ 倍の形へまとめる（$0<q\le1$）」を論法の数で二行へ割り、その最初「差の一様な評価に現れる量は核の基準辺分の一倍である」——核 $\Gamma(q):=\bigl(2\iota(\ell_2)+4\iota(\log(1+q))\bigr)+\bigl(-(4\iota(\log q))\bigr)+2\cdot\bigl(\iota(\ell_2)+2\iota(\log(1+q))\bigr)\in\Lambda_{\mathbb Q}$ の定義と、$a\ge1$、$q>0$ で $\frac1a\cdot\Gamma(q)=R_a$（差の上からの評価の右辺・下からの評価の左辺の逆元の中身）——を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `def_open_square_density_difference_bound_core` と `claim_open_square_density_difference_bound_is_core_over_base_side`（`claim_open_square_large_sides_density_difference_lower_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は準備 4 つ（$r\cdot(-\lambda)=-(r\cdot\lambda)$ を `def_rational_log_order_group` の等号の判定どおり素数ごとに五段（有理数倍の定義・逆元の定義・$\mathbb Q$ の四則 $r(-u)=-(ru)$・有理数倍の定義・逆元の定義）／$\frac1a X=\frac2a\iota(\ell_2)+\frac4a\iota(\log(1+q))$（分配則・結合則を右から左へ二箇所同時・$\mathbb Q$ の四則）／$\frac1a(-Y)=-(\frac4a\iota(\log q))$（第一・結合則・$\mathbb Q$ の四則）／$\frac1a(2C)=\frac2aC$（結合則・$\mathbb Q$ の四則））と、本体（分配則二段で三つの項へ配り、第二・第三・第四で読み替える）。順序は使わない。$q\le1$ も要しないので主張は $q>0$ で述べた。
  SageMath `check/open-square-density-difference-bound-is-core-over-base-side/`（分配関数不要。$a\in\{1,2,3,5\}$ × 8 点（$q>1$ も含む）、692 検査、10 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareDensityDifferenceBoundCore.lean`（`openSquareDensityDifferenceBoundCore`、`ratSmul_neg_eq_neg_ratSmul`（`ext p` の五段 calc）、`one_div_smul_openSquareDensityDifferenceBoundCore`（`set` で略記、`smul_add`・`← mul_smul`・`ring`）），
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareDensityDifferenceBoundCore.lean`（`one_div_smul_core_eq_scaled_terms_necSuf`。`[Add X] [Neg X] [SMul ℚ X]` と分配則・結合則・逆元との入れ替えの三つを仮定として受けるだけ。群の公理も順序も要らない。係数は $\mathbb Q$ のまま）、導出版。sorry 検査 1317 件。
  割り方: 「核の定義と $\frac1a$ 倍の等式」→「核は非負である」（符号 $0\le\iota(\ell_2)$、$0\le\iota(\log(1+q))$、$\iota(\log q)\le0$ から）。$\pm\frac1a\Gamma(q)$ の形の上端・下端は上下の評価にこの等式を代入するだけなので独立の主張にはせず、Cauchy 性の証明の中で読み替える（「何も言っていない主張」を増やさない）。前 tick のレビューでは修正なし。次は「核は非負である」。

- **2026-08-17 の tick 352 は、台帳の先頭行「基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（$0<q\le1$）」（$a\ge1$、$a<L$、$a<M$、$a^2\le L$、$a^2\le M$、$0<q\le1$ で $-R\le\Psi^{\mathrm{op}}_L+(-\Psi^{\mathrm{op}}_M)$、$R:=U+(-D)+\frac2aC$ は差の上からの評価の右辺と同じ元）を本文・SageMath・Lean（具体版・必要十分版・導出版）まで書いて四層で閉じた。**
  `claim_open_square_large_sides_density_difference_lower_le_one`（`claim_open_square_large_sides_density_difference_upper_le_one` の直後・`remark_real_escape_plan` の直前、住処 Lambda）。証明は、差の上からの評価を第一の辺 $M$・第二の辺 $L$ で読み（仮定が $L,M$ について対称で右辺 $R$ が $L,M$ によらないので読める）$\Psi_M+(-\Psi_L)\le R$、準備で $-(\Psi_M+(-\Psi_L))=\Psi_L+(-\Psi_M)$ を `def_rational_log_order_group` の等号の判定どおり素数ごとに六段（逆元の定義・加法の定義・逆元の定義・$\mathbb Q$ の四則 $-(u+(-v))=v+(-u)$・逆元の定義・加法の定義）で示し、本体は `claim_rational_log_order_group_neg_reverses_order` で $-R\le-(\Psi_M+(-\Psi_L))$、準備の結論で読み替えるだけ。有理数倍の係数には触れない。
  SageMath `check/open-square-large-sides-density-difference-lower/`（$a=1$、$(L,M)\in\{2,3\}^2$ × 6 点、199 検査、11 秒）。Lean 具体版 `ThermodynamicLimit/OpenSquareLargeSidesDensityDifferenceLower.lean`（`neg_add_neg_eq_add_neg_swap`（`ext p` と `Finsupp.neg_apply`・`Finsupp.add_apply`・`ring` の六段 calc）、`rationalLogOrderLE_openSquareLargeSidesDensityDifference_lower_of_le_one`）、
  必要十分版 `NecSuf/ThermodynamicLimit/OpenSquareLargeSidesDensityDifferenceLower.lean`（`difference_lower_bound_from_swapped_upper_necSuf`。`[Add X] [Neg X]` と逆元の順序反転・準備の等式（仮定として受ける）だけ。推移律も加法単調性も群の公理も要らない）、導出版。sorry 検査 1313 件。
  前 tick のレビューでは修正なし。次は「差の両側の評価を $\frac1a$ 倍の形へまとめる（$0<q\le1$）」（$E$ を置き $R=\frac1aE$ を有理数倍の定義から素数ごとに読み、$0\le E$ を符号から示す）。

（これより古い 308 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 11 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 73 セクション
- 全章（何も言っていない主張の一掃）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-17（tick 356）: 台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」を実行し、`claim_open_square_density_sequence_cauchy_le_one` を `claim_open_square_density_difference_bound_core_nonneg_le_one` の直後に置いた。
  証明は核の非負・Archimedes 性で $n$ を取り $a:=n+2$、$N:=a^2$ と置く存在の構成と、上端・下端の一続き三段ずつ（差の一様な評価・核の等式・倍率以上で割る評価・逆元の順序反転・推移律）だけ。SageMath `open-square-density-sequence-cauchy`（一辺 9, 10 は行ごとの動的計画法）、Lean 具体版・必要十分版（`Zero`・`Neg`・`SMul ℚ`、推移律・逆元の順序反転と、核の等式・差の上下の評価・Archimedes 性・割る評価を仮定として受けるだけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1329 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 355）: 台帳の先頭行「密度の列の Cauchy 性（$0<q\le1$）」は、Archimedes 性で選んだ倍率以上の自然数で割ると $\varepsilon$ 以下になる係数の鎖（非負有理数倍の順序保存・結合則・係数比較）と、$N$ を選んで上端・下端をつなぐ存在の構成の二つの論法を含むので二行へ割った。その最初「Archimedes 性の倍率以上の自然数で割れば上界を超えない」を実行し、`claim_rational_log_order_group_div_ge_multiplier_le` を `claim_rational_log_order_group_scalar_compare_nonpos` の直後（係数比較の並び）に置いた。
  証明は準備（$\mathbb Q$ の順序 $0\le\frac1a$、$\frac na\le1$）と一続き五段だけ。SageMath `rational-log-order-group-div-ge-multiplier-le`、Lean 具体版・必要十分版（`Zero`・`SMul ℚ`、推移律・非負係数の作用の順序保存・非負の元の係数比較・結合則・単位を仮定として受けるだけ）・導出版を書き、入口 import・sorry 検査へ 3 件登録（計 1325 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 354）: 台帳の先頭行「核は非負である（$0\le_{\Lambda_{\mathbb Q}}\Gamma(q)$、$0<q\le1$）」を実行し、`claim_open_square_density_difference_bound_core_nonneg_le_one` を `claim_open_square_density_difference_bound_is_core_over_base_side` の直後に置いた。
  証明は三つの符号（$q\le1$ は $\iota(\log q)\le0$ にだけ要る）から非負有理数倍の順序保存・逆元の順序反転・加法単調性で三つの項の非負を作り、加法単調性で順に足し込むだけ。SageMath `open-square-density-difference-bound-core-nonneg`、Lean 具体版・必要十分版（`AddCommMonoid`・`Neg`・`SMul ℚ`、推移律・右加法単調性・非負有理数倍の順序保存・逆元の順序反転・$c\cdot0=0$・$-0=0$ と三つの符号だけ）・導出版を書き、入口 import・sorry 検査へ 5 件登録（計 1322 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 353）: 台帳の先頭行「差の両側の評価を $\frac1a$ 倍の形へまとめる（$0<q\le1$）」は、核 $\Gamma(q)$ の $\frac1a$ 倍が評価の右辺に等しいこと（有理数倍の分配則・結合則）と、核が非負であること（符号と加法単調性）の二つの論法を含むので二行へ割った。$\pm\frac1a\Gamma(q)$ の形の上端・下端そのものは代入だけなので行にせず、Cauchy 性の中で読み替える。その最初「差の一様な評価に現れる量は核の基準辺分の一倍である」を実行し、`def_open_square_density_difference_bound_core` と `claim_open_square_density_difference_bound_is_core_over_base_side` を `claim_open_square_large_sides_density_difference_lower_le_one` の直後に置いた。
  証明は $r\cdot(-\lambda)=-(r\cdot\lambda)$ を素数ごとに読み、分配則・結合則・$\mathbb Q$ の四則で三つの項を $\frac1a$ 倍するだけ。SageMath `open-square-density-difference-bound-is-core-over-base-side`、Lean 具体版・必要十分版（`Add`・`Neg`・`SMul ℚ`、分配則・結合則・逆元との入れ替えを仮定として受けるだけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1317 件）。式変形統一は一時停止中のため実施せず。

- 2026-08-17（tick 352）: 台帳の先頭行「基準辺の平方以上の二つの辺の密度の差の一様な下からの評価（$0<q\le1$）」を実行し、`claim_open_square_large_sides_density_difference_lower_le_one` を `claim_open_square_large_sides_density_difference_upper_le_one` の直後に置いた。
  証明は差の上からの評価を辺を入れ替えて読み、逆元の順序反転で向きを返し、$-(\Psi_M+(-\Psi_L))=\Psi_L+(-\Psi_M)$ を素数ごとに読むだけ。SageMath `open-square-large-sides-density-difference-lower`、Lean 具体版・必要十分版（`Add`・`Neg`、逆元の順序反転と準備の等式だけ）・導出版を書き、入口 import・sorry 検査へ 4 件登録（計 1313 件）。式変形統一は一時停止中のため実施せず。

（これより古い 318 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-17（tick 356）: 前 tick の「Archimedes 性の倍率以上の自然数で割れば上界を超えない」の本文（準備二つ・本体五段）・SageMath overview（28491 組）・Lean 具体版（`h0`・`h1`・`s1`・`hcoef`・`s2`・`one_smul`・`rationalLogOrderLE_trans` が本文の準備と五段に 1 対 1）・必要十分版（`Zero`・`SMul ℚ`、推移律・非負係数の作用の順序保存・非負の元の係数比較・結合則・単位）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: この主張は係数の鎖で、Cauchy 性が上端・下端の両方で引くので残す。今 tick の Cauchy 性は $\varepsilon$ から $N$ を与える存在の構成そのもので、切断による脱出が引く。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-17（tick 355）: 前 tick の「核は非負である」の本文（準備 4 つ・本体九段）・SageMath overview（268 検査）・Lean 具体版（`rationalLogOrderLE_zero_openSquareDensityDifferenceBoundCoreX`・`…CoreY_of_le_one`・`…Core_of_le_one` が本文の準備第二〜第四と本体に 1 対 1）・必要十分版（`AddCommMonoid`・`Neg`・`SMul ℚ`、推移律・右加法単調性・非負有理数倍の順序保存・逆元の順序反転・$c\cdot0=0$・$-0=0$）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 核の非負は Archimedes 性の前提 $0\le\mu$ そのもので、値の属する側を言っているので残す。今 tick の「Archimedes 性の倍率以上の自然数で割れば上界を超えない」は係数の鎖であり、Cauchy 性が上端・下端の両方で引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-17（tick 354）: 前 tick の「開境界正方形の密度の差の評価の核」の定義と「差の一様な評価に現れる量は核の基準辺分の一倍である」の本文（準備 4 つ・本体五段）・SageMath overview（692 検査）・Lean 具体版（`ratSmul_neg_eq_neg_ratSmul` の五段 calc・`hX`・`hY`・`hC`・本体の calc が本文の準備第一〜第四と本体に 1 対 1）・必要十分版（`Add`・`Neg`・`SMul ℚ`、分配則・結合則・逆元との入れ替え）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 核の定義は Cauchy 性で Archimedes 性の $\mu$ に置く名前で、$\frac1a$ 倍の等式は上端・下端の両方が引くので残す。今 tick の「核は非負である」も Archimedes 性を読む前提（$0\le\mu$）で、値の属する側（非負）を言っているので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-17（tick 353）: 前 tick の「基準辺の平方以上の二つの辺の密度の差の一様な下からの評価」の本文（入れ替えた上端・準備六段・本体二段）・SageMath overview（199 検査）・Lean 具体版（`hswap`・`neg_add_neg_eq_add_neg_swap`・`rationalLogOrderLE_neg_le_neg`・`rwa` が本文の入れ替えた上端・準備・本体に 1 対 1）・必要十分版（`Add`・`Neg`、逆元の順序反転・準備の等式）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 差の下端は Cauchy 性が上端と対で引く評価なので残す。今 tick で置いた $\frac1a\cdot\Gamma(q)=R_a$ は有理数倍の分配則だけの等式だが、核に名前を与えて Archimedes 性で $a$ を選ぶ土台になり、Cauchy 性が上端・下端の両方で引くので残す（同じ理由で $\pm\frac1a\Gamma(q)$ の形の上端・下端は独立の主張にしなかった）。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-17（tick 352）: 前 tick の「有理係数の対数順序群の逆元は順序を反転する」の本文（左辺三段・右辺四段）・SageMath overview（125 ベクトル）・Lean 具体版（`h'`・`hl`・`hr` が本文の加法単調性と左右の鎖に 1 対 1）・必要十分版（`AddCommMonoid`・`Neg`、右加法単調性・逆元律 1 本）・導出版を突き合わせ、根拠が一致した。
  「何も言っていない主張」の観点: 順序の一般的な性質で、差の下からの評価と Cauchy 性が繰り返し引くので残す。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

（これより古い 339 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
