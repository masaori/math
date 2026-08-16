# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 325 は、「開境界長方形の正の有理点での値の上からの評価（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  `claim_open_rectangle_value_upper_bound_at_positive_rational`（`claim_open_square_free_entropy_density_nonnegative` の直後・`remark_real_escape_plan` の直前、住処 Q）で、
  $a,b\ge1$、$q\in\mathbb Q_{>0}$ に対し $Z^{\mathrm{op}}_{a,b}(q)\le2^{ab}(1+q)^{2ab}$（$a=b=L$ で $2^{L^2}(1+q)^{2L^2}$）。周期境界の `claim_partition_value_upper_bound_at_positive_rational`
  と同じ論法（準備の第一〜第四はそのまま引き、第五として $b^{\mathrm{op}}_{a,b}(\sigma)\le|E^{\mathrm{op}}_{a,b}|=a(b-1)+(a-1)b\le2ab$ を $\mathbb N$ の鎖で置く）。
  SageMath 36777 検査（形 11 通り × 正の有理点 9 点、`ZZ`/`QQ`）、Lean 具体版 `openBrokenBondCount_le_two_mul`・`openPartitionValueRat_le_upperBound`・必要十分版は
  `sum_pow_le_uniform_bound_necSuf` を共有・導出版、sorry 検査 1207 件。前 tick の密度の非負性のレビューに不一致なし。台帳の名前は「正方形」だったが長方形一般で書いた
  （正方形はその $a=b=L$ の場合。次の密度の上界はそこだけを使う）。次は「開境界正方形の密度の上界（$\Lambda_{\mathbb Q}$ 版）」。

- **2026-08-16 の tick 324 は、「開境界正方形の自由エントロピー密度は非負である（$\Lambda_{\mathbb Q}$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させ、あわせて人間の削除のあとに残っていたほころび 3 件を直した。**
  `claim_open_square_free_entropy_density_nonnegative`（`claim_open_rectangle_value_ge_one_at_positive_rational` の直後・`remark_real_escape_plan` の直前、住処 Lambda）で、
  $L\ge1$、$q\in\mathbb Q_{>0}$ に対し $0\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)$。周期境界の `claim_finite_free_entropy_density_nonnegative` と同じ論法
  （準備 3 つ: $1\le Z^{\mathrm{op}}_{L,L}(q)$・$\log1=0$・$\frac1{L^2}\iota(0)=0$、$\Lambda$ の鎖 $0=\log1\le_\Lambda\log Z^{\mathrm{op}}_{L,L}(q)$、$\Lambda_{\mathbb Q}$ の鎖で `claim_scaled_embedding_order_transfer` により移送）。
  SageMath 97 検査（`ZZ`/`QQ`・素因数分解）、Lean 具体版 `rationalLogOrderLE_zero_openScaledFreeEntropy`・必要十分版は `le_base_transport_of_monotone_necSuf` を共有・導出版、sorry 検査 1204 件。
  レビューでは、削除で途切れた `claim_open_rectangle_value_ge_one_at_positive_rational` 末尾の文を直し、初出より後ろに置かれていた `def_constant_plus_configuration`・
  `claim_constant_plus_breaks_no_bond` を `claim_partition_value_ge_one_at_positive_rational` の直前へ移し、削除済みの実数値主張を対象にしていた SageMath 検証 2 件
  （`free-energy-density-lower-bound`・`open-rectangle-value-at-least-one`）を撤去して対応を `partition-value-ge-one-at-positive-rational` へ付け替えた。次は「開境界正方形の値の上界（$\mathbb Q$ 版）」。

- **2026-08-16（人間の指示）: 「実数体への脱出の宣言」以降のブロックをすべて削除した。**
  可算側の経路と実数値の経路が併存していて、実数体が最初から要るように読めるためである。
  代わりに「実数体への脱出をどう行うか（方針。まだ書いていない）」という注記を 1 つ置き、
  有限系は $\Lambda_{\mathbb{Q}}$、極限の存在は Cauchy 性、脱出は切断の一点だけ、と方針を書いた。
  消したのは本文 42 ブロックと、対応する SageMath 検証 22 件。Lean は孤立したまま残っており、
  後片付けをセクション表へ足した。削除した内容は git の履歴に残っている。

- **2026-08-16 の tick 323 は、「開境界長方形の正の有理点での値は 1 以上である（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  `claim_open_rectangle_value_ge_one_at_positive_rational`（`def_open_square_free_entropy_density` の直後・実数体脱出の宣言の直前、住処 Q）で、
  $a,b\ge1$、$q\in\mathbb Q_{>0}$ に対し $1\le Z^{\mathrm{op}}_{a,b}(q)$。周期境界の `claim_partition_value_ge_one_at_positive_rational` と同じ五段の鎖
  （$1=q^0=q^{b^{\mathrm{op}}(\tau_+)}\le$ 一項分離 $=$ 有限和 $=Z^{\mathrm{op}}_{a,b}(q)$）を $\mathbb Q$ の順序体の性質だけで述べ、実数体は現れない。
  備考どおり `def_open_rectangle_constant_plus_configuration`・`claim_open_rectangle_constant_plus_breaks_no_bond`（住処 N）を実数体脱出の前へ移した
  （$\mathbb R$ 版 `claim_open_rectangle_value_at_least_one` は併存）。SageMath 11472 検査（形 11 通り × 正の有理点 9 点、`ZZ`/`QQ`）、Lean 具体版
  `one_le_openPartitionValueRat`・必要十分版は周期境界の `one_le_sum_pow_of_exponent_zero_necSuf` を共有・導出版、sorry 検査 1201 件
  （$\tau_+$ の Lean 定義は実数体に依らない `OpenRectangleConstantPlusConfiguration.lean` へ切り出した）。セクション「値の下界 1 と密度の非負性」は
  論法が 2 つなので割り、「密度の非負性（$\Lambda_{\mathbb Q}$ 版）」を次に置いた。前 tick の開境界正方形の自由エントロピー密度の定義のレビューに不一致なし。

- **2026-08-16 の tick 322 は、「開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義」を本文・SageMath・Lean（定義と各素数での値の鎖）まで完成させた。**
  `def_open_square_free_entropy_density`（`claim_periodic_open_boundary_comparison_rational` の直後・実数体脱出の宣言の直前、住処 Lambda）で、
  $L\ge1$、$q\in\mathbb Q_{>0}$ に対し $\Psi^{\mathrm{op}}_L(q):=\frac{1}{L^2}\cdot\iota_{\Lambda\to\Lambda_{\mathbb Q}}(\log Z^{\mathrm{op}}_{L,L}(q))\in\Lambda_{\mathbb Q}$。
  周期境界側 `def_finite_free_entropy_density` と同じ形（右辺の確定・各素数での値の三段の鎖・写像と値の区別・$\psi^{\mathrm{op}}_L$ との区別・具体例 $L=2$、$q=1/2$:
  $Z^{\mathrm{op}}_{2,2}(1/2)=41/8$、$\Psi^{\mathrm{op}}_2(1/2)=\frac14\cdot\iota(\ell_{41}-3\ell_2)$）。SageMath 178 検査（`ZZ`/`QQ`・素因数分解）、Lean `openScaledFreeEntropy`・
  `openScaledFreeEntropy_apply`（`ThermodynamicLimit/OpenSquareFreeEntropyDensity.lean`）、sorry 検査 1199 件。備考どおり定義 1・主張 2 の塊を割り、
  「値の下界 1（$\mathbb Q$ 版）と密度の非負性」「値の上界（$\mathbb Q$ 版）」「密度の上界（$\Lambda_{\mathbb Q}$ 版）」を次に並べた。前 tick の周期境界と開境界の比較（$\mathbb Q$ 版）のレビューに不一致なし。

- **2026-08-16 の tick 321 は、「周期境界と開境界の比較（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  `claim_periodic_open_boundary_comparison_rational`（`claim_open_square_block_tiling_rational` の直後・実数体脱出の宣言の直前、住処 Q）で、
  $L\ge1$、$q\in\mathbb Q_{>0}$ に対し $0<q\le1$: $q^{2L}Z^{\mathrm{op}}_{L,L}(q)\le Z_L(q)\le Z^{\mathrm{op}}_{L,L}(q)$、$1\le q$: その逆向き。
  周期境界の値は分配多項式への代入 $Z_L(q)$（正値性は `claim_value_at_rational_is_positive`）、開境界の値は `def_open_rectangle_partition_value_at_positive_rational`。
  $\mathbb R$ 版と同じ論法（頂点の全単射 $v_L$・配位の読み替え $r_L$・境界横断辺の破れ本数 $s^{\mathrm{bd}}_L\le2L$・破れボンド数の分解・境界因子の自然数冪の順序・項ごとの評価の有限和）を
  $\mathbb Q$ の順序体の性質だけで述べ、実数体は現れない。SageMath 27 組（`ZZ`/`QQ`。分解・代入と配位和の一致・鎖・二場合の上下評価）、Lean 具体版・必要十分版（$\mathbb R$ 版
  `sum_pow_reindex_bounds_necSuf` と共有）・導出版、sorry 検査 1198 件。レビューでは前 tick のブロック敷き詰め（$\mathbb Q$ 版）の四層が一致し修正無し。
  次は「開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義と非負性・上界」。

（これより古い 277 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 48 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 開境界正方形の密度の上界（$\Lambda_{\mathbb Q}$ 版） | todo | $\Psi^{\mathrm{op}}_L(q)\le\iota(\ell_2)+2\cdot\iota(\log(1+q))$。`claim_finite_free_entropy_density_upper_bound` と同じ論法 |
| 熱力学極限 | ブロック敷き詰めの対数化（$\Lambda_{\mathbb Q}$ 版） | todo | $\Psi^{\mathrm{op}}_{ka}$ を $\Psi^{\mathrm{op}}_a$ と $\ell_2$・$\log q$ の有理数倍で二場合に挟む |
| 熱力学極限 | 部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版） | todo | `claim_open_square_subsquare_comparison_le_one` を $q\in\mathbb Q$ で |
| 熱力学極限 | 極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる | todo | 完備性（上限の存在）を使わずに、可算側の主張として収束の速さつきで述べる。各段の比較は有理数の比較なので決定可能 |
| 熱力学極限 | 有限系の密度の接合不等式（$\Lambda_{\mathbb{Q}}$ 版） | todo | 値の接合不等式（有理点）の両辺の対数を取り、$\Lambda_{\mathbb{Q}}$ の順序で $\Psi$ どうしの不等式にする |
| 熱力学極限 | 密度の列の Cauchy 性 | todo | $\bigl(\Psi_L(q)\bigr)_L$ の差を有理数で抑える。完備性も極限論も使わない |
| 熱力学極限 | 切断による実数体への一度きりの脱出 | todo | Cauchy 列が定める $\mathbb{Q}$ 上の切断として自由エネルギー密度を取る。引くのは「切断は実数を定める」ことだけ |
| 熱力学極限 | 削除した実数値経路の Lean の後片付け | todo | 2026-08-16 に本文から消した実数値経路（実対数・上限／下限による極限）の Lean ファイルが孤立して残っている。入口からの import と sorry 検査は通るが、対応する本文が無いので消す |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 325）: `claim_open_rectangle_value_upper_bound_at_positive_rational` を `claim_open_square_free_entropy_density_nonnegative` の直後
  （`remark_real_escape_plan` の直前）に置き四層で閉じた。周期境界の `claim_partition_value_upper_bound_at_positive_rational` の証明を開境界へ移し、準備の第一〜第四
  （冪の正値性・底の単調性・指数の単調性・定数の有限和）は格子の形に依らないのでそのまま引き、第五として $b^{\mathrm{op}}_{a,b}(\sigma)=|B^{\mathrm{op}}|\le|E^{\mathrm{op}}|
  =|E_{\mathrm h}|+|E_{\mathrm v}|=a(b-1)+(a-1)b\le ab+ab=2ab$ を $\mathbb N$ の一続きで置いた。本体は五段（代入は環準同型・底を $1+q$ へ・指数を $2ab$ へ・定数の有限和・
  $|\Sigma^{\mathrm{op}}_{a,b}|=2^{ab}$）。SageMath `open-rectangle-value-upper-bound-at-positive-rational`（形 11 通り × 正の有理点 9 点、36777 検査。準備の第五の鎖と
  本体の各行。`ZZ`/`QQ`）。Lean 具体版 `ThermodynamicLimit/OpenRectangleValueUpperBoundRational.lean`（`openBrokenBondCount_le_two_mul`・`openPartitionValueRat_le_upperBound`。
  周期境界版の補題 `pow_le_pow_of_pos_of_le_by_induction_rat`・`pow_le_pow_of_one_le_of_exp_le_by_induction_rat` を共有）、必要十分版は
  `NecSuf/ThermodynamicLimit/PartitionValueUpperBound.lean` の `sum_pow_le_uniform_bound_necSuf` をそのまま共有、導出版 `OpenRectangleValueUpperBoundRationalFromNecSuf.lean`。
  sorry 検査 1207 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 324）: `claim_open_square_free_entropy_density_nonnegative` を `claim_open_rectangle_value_ge_one_at_positive_rational` の直後
  （`remark_real_escape_plan` の直前）に置き四層で閉じた。周期境界の `claim_finite_free_entropy_density_nonnegative` の証明を、$Z_L(q)$ を $Z^{\mathrm{op}}_{L,L}(q)$
  （正値性は `claim_open_rectangle_value_at_rational_is_positive`、下界 1 は `claim_open_rectangle_value_ge_one_at_positive_rational`、いずれも $a=b=L$）に、
  $\Phi_L(q)$ を `def_rational_log` の $\log Z^{\mathrm{op}}_{L,L}(q)$ に置き換えて述べ、準備の第三（$\frac1{L^2}\iota(0)=0$）は周期境界の証明の鎖をそのまま引いた。
  SageMath `open-square-free-entropy-density-nonnegative`（$L\in\{1,2,3\}$ × 正の有理点 9 点、97 検査。周期境界の検査と同じ項目を開境界の値で。`ZZ`/`QQ`）。
  Lean 具体版 `ThermodynamicLimit/OpenSquareFreeEntropyDensityNonnegative.lean`（`logOrderLE_zero_logRat_openPartitionValueRat`・
  `rationalLogOrderLE_zero_openScaledFreeEntropy`。周期境界の `scaled_toRational_zero` を共有）、必要十分版は
  `NecSuf/ThermodynamicLimit/FiniteFreeEntropyDensityNonnegative.lean` の `le_base_transport_of_monotone_necSuf` をそのまま共有、導出版
  `OpenSquareFreeEntropyDensityNonnegativeFromNecSuf.lean`。sorry 検査 1204 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 323）: `claim_open_rectangle_value_ge_one_at_positive_rational` を `def_open_square_free_entropy_density` の直後（`remark_real_field_escape` の直前）
  に置き四層で閉じた。$\mathbb R$ 版 `claim_open_rectangle_value_at_least_one` の鎖（$1=q^0=q^{b^{\mathrm{op}}_{a,b}(\tau_+)}\le q^{b^{\mathrm{op}}(\tau_+)}+\sum_{\sigma\ne\tau_+}
  =\sum_\sigma=Z^{\mathrm{op}}_{a,b}(q)$）を $q\in\mathbb Q_{>0}$ で述べ直し、周期境界の `claim_partition_value_ge_one_at_positive_rational` と同じ文言に揃えた。
  `remark_real_field_escape` は引かない。備考どおり `def_open_rectangle_constant_plus_configuration`・`claim_open_rectangle_constant_plus_breaks_no_bond`（住処 N）を
  $\mathbb R$ 側の値の下界の直前から実数体脱出の宣言の前（新主張の直前）へ移した（本文は変えず、`verification` に新しい検査を足した）。$\mathbb R$ 版は併存（撤去のセクションで消す）。
  SageMath `open-rectangle-value-ge-one-at-positive-rational`（形 11 通り × 正の有理点 9 点、11472 検査。$\tau_+$ の所属と破れ数 0・各項の正値性・鎖の各行・
  $\mathbb Z[x]$ への代入と配位和の一致・$1\le$・$q=1$ で $2^{ab}$。`ZZ`/`QQ`）。Lean: `openAllPlusConfig` とその破れ数 0 の補題を `OpenRectangleValueAtLeastOne.lean`
  から実数体に依らない `ThermodynamicLimit/OpenRectangleConstantPlusConfiguration.lean` へ切り出し（$\mathbb R$ 側はそれを import）、具体版
  `ThermodynamicLimit/OpenRectangleValueGeOneRational.lean`（`one_le_openPartitionValueRat`。周期境界版と同じ五段の calc）、必要十分版は
  `NecSuf/ThermodynamicLimit/PartitionValueGeOneRational.lean` の `one_le_sum_pow_of_exponent_zero_necSuf` をそのまま共有、導出版
  `OpenRectangleValueGeOneRationalFromNecSuf.lean`。sorry 検査 1201 件。セクション「値の下界 1（$\mathbb Q$ 版）と密度の非負性（$\Lambda_{\mathbb Q}$ 版）」は
  論法が 2 つ（一項分離と、対数の順序移送）なので割り、残り「密度の非負性」を表の先頭に置いた。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 322）: `def_open_square_free_entropy_density` を `claim_periodic_open_boundary_comparison_rational` の直後（`remark_real_field_escape` の直前）
  に置き、記述・SageMath・Lean（定義）で閉じた。周期境界の `def_finite_free_entropy_density` と同じ形で、$\Phi_L(q)$ の代わりに `def_rational_log` の対数
  $\log Z^{\mathrm{op}}_{L,L}(q)$ を直接置く（$\Phi^{\mathrm{op}}$ のような新記号は導入しない）。値は `def_open_rectangle_partition_value_at_positive_rational`、
  正値性は `claim_open_rectangle_value_at_rational_is_positive` を引く。SageMath `open-square-free-entropy-density`（$L\in\{1,2,3\}$ × 正の有理点 9 点、178 検査。
  代入と配位和の一致・正値性・三段の鎖・台の一致・具体例）。Lean `ThermodynamicLimit/OpenSquareFreeEntropyDensity.lean`（`openScaledFreeEntropy`（`[NeZero L]`）・
  `openScaledFreeEntropy_apply`。`scaledFreeEntropy` と同じ三段の calc）。定義なので必要十分版・導出版は無い。sorry 検査 1199 件。
  セクション「定義と非負性・上界」は論法が複数（定義・下界 1 と非負性・値の上界・密度の上界）なので、備考どおり 4 つに割り、残り 3 行を表の先頭に並べた。
  式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 321）: `claim_periodic_open_boundary_comparison_rational` を `claim_open_square_block_tiling_rational` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。$\mathbb R$ 版 `claim_periodic_open_boundary_comparison` の証明（頂点の全単射
  $v_L(i,j)=(s(i),s(j))$、配位の読み替え $r_L(\tau)=\tau\circ v_L$、境界横断辺の破れ本数 $s^{\mathrm{bd}}_L(\tau)\in\mathbb N$ と $0\le s^{\mathrm{bd}}_L\le2L$、
  分解 $b(r_L(\tau))=b^{\mathrm{op}}_{L,L}(\tau)+s^{\mathrm{bd}}_L(\tau)$、$q^{m+n}=q^mq^n$、境界因子の自然数冪の順序、項ごとの評価の有限和と分配則）を
  $q\in\mathbb Q_{>0}$ で述べ直し、周期境界の値は `def_partition_polynomial` への代入（和へ配る段は `claim_value_at_rational_is_positive` の第二段）、
  各項の正値性は `claim_open_rectangle_value_at_rational_is_positive` の準備を引く。`remark_real_field_escape` は引かない。$\mathbb R$ 版は併存
  （撤去のセクションで消す）。SageMath `periodic-open-boundary-comparison-rational`（$L\in\{1,2,3\}$ × 正の有理点 9 点、27 組。分解・$\mathbb Z[x]$ への
  代入と配位和の一致・鎖・境界因子の順序・二場合の上下評価。`ZZ`/`QQ`）。Lean 具体版 `ThermodynamicLimit/PeriodicOpenComparisonInequalityRational.lean`
  （`partitionValueRat_eq_open_double_product`・`partitionValueRat_periodicOpen_bounds_of_le_one`／`_of_one_le`。$\mathbb R$ 版から `t`→`q`、`ℝ`→`ℚ`、
  `openPartitionValue`→`openPartitionValueRat`、`eval_partitionPolynomial_real`→`FreeEntropy.eval_partitionPolynomial`、冪の補題→`_rat` の置換で通った。
  全単射・分解は `PeriodicOpenComparison.lean` を共有）、必要十分版は `sum_pow_reindex_bounds_necSuf` をそのまま共有、導出版
  `PeriodicOpenComparisonInequalityRationalFromNecSuf.lean`。sorry 検査 1198 件。式変形統一は一時停止中のため実施せず。

（これより古い 288 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 325）: 前 tick の「開境界正方形の自由エントロピー密度は非負である（$\Lambda_{\mathbb Q}$ 版）」の本文・SageMath（overview の対象ラベル・実行日・帰属）・
  Lean 具体版・必要十分版（周期境界と共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、準備 3 つ・$\Lambda$ の鎖・$\Lambda_{\mathbb Q}$ の鎖の根拠が一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 324）: 前 tick の「開境界長方形の値の下界 1（$\mathbb Q$ 版）」と、その後の人間による実数値経路の削除（42 ブロック）のあとの本文・SageMath・Lean を突き合わせた。
  直したもの 3 件。(1) `claim_open_rectangle_value_ge_one_at_positive_rational` の証明末尾の文が「周期境界の〔参照〕、」で途切れていた（削除の際に $\mathbb R$ 版への言及ごと
  切れた）ので「と同じ論法である。」で結んだ。(2) `def_constant_plus_configuration`・`claim_constant_plus_breaks_no_bond` が初出（`claim_partition_value_ge_one_at_positive_rational`
  の証明）より後ろ、開境界の値の下界の直後に置かれていたので初出の直前へ移し、説明文も合わせた。(3) SageMath `free-energy-density-lower-bound`（対象に削除済みの
  `claim_free_energy_density_nonnegative` を含み ball 算術を使う）と `open-rectangle-value-at-least-one`（対象が削除済みの `claim_open_rectangle_value_at_least_one`）を撤去し、
  全て正の定数配位 2 ブロックの検証を、既にそれらを検査している `partition-value-ge-one-at-positive-rational`（overview の対象へ追記）と
  `open-rectangle-value-ge-one-at-positive-rational` へ付け替えた。本文末尾「この先に書くこと」と台帳のセクション表は食い違いなし。

- 2026-08-16（tick 323）: 前 tick の「開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義」の本文・SageMath（overview の対象ラベル・実行日・帰属）・
  Lean（`openScaledFreeEntropy`・`openScaledFreeEntropy_apply`、入口 import・sorry 検査への登録）を突き合わせ、右辺の確定・各素数での値の三段の鎖・写像と値の区別・
  具体例 $L=2$、$q=1/2$ が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 322）: 前 tick の「周期境界と開境界の比較（$\mathbb Q$ 版）」の本文・SageMath（overview の対象ラベル・実行日・帰属）・Lean 具体版・
  必要十分版（$\mathbb R$ 版と共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、二場合の上下評価・全単射と分解・境界因子の順序・鎖の各行の根拠が
  一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 321）: 前 tick の「正方形のブロック敷き詰め（$\mathbb Q$ 版）」の本文・SageMath・Lean 具体版・必要十分版（$\mathbb R$ 版と共有）・
  導出版を突き合わせ、二場合の上下評価・鎖の各段（第一座標方向の反復接合・$k$ 乗・第二座標方向の反復接合・正数の乗法）・対象ラベル・入口 import・
  sorry 検査への登録が一致し、本文に $t$ や $\le_{\mathbb R}$ の残りは無い。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

（これより古い 309 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
