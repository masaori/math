# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

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

- **2026-08-16 の tick 320 は、「正方形のブロック敷き詰め（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  `claim_open_square_block_tiling_rational`（`claim_open_rectangle_iterated_gluing_second_rational` の直後・実数体脱出の宣言の直前、住処 Q）で、
  $a,k\ge1$、$q\in\mathbb Q_{>0}$ に対し $0<q\le1$: $q^{(k-1)(ka)}(q^{(k-1)a}Z^{\mathrm{op}}_{a,a}(q)^k)^k\le Z^{\mathrm{op}}_{ka,ka}(q)\le(Z^{\mathrm{op}}_{a,a}(q)^k)^k$、$1\le q$: その逆向き。
  $\mathbb R$ 版と同じ合成（第一座標方向の反復接合（$\mathbb Q$ 版、$b=a$）→ 準備「正の底の自然数冪は順序を保つ」で両辺を $k$ 乗 → 第二座標方向の反復接合（$\mathbb Q$ 版、第一座標の長さ $ka$）→ 正数の乗法と推移律）を
  $\mathbb Q$ の順序体の性質だけで述べ、実数体は現れない。SageMath 45 組（`ZZ`/`QQ`。鎖の各段を検査）、Lean 具体版・必要十分版（$\mathbb R$ 版 `two_direction_pow_bounds_necSuf` と共有）・導出版、
  sorry 検査 1194 件。レビューでは前 tick の反復接合の第二（$\mathbb Q$ 版）の四層が一致し修正無し。次は「周期境界と開境界の比較（$\mathbb Q$ 版）」。

- **2026-08-16 の tick 319 は、「反復接合の第二（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  `claim_open_rectangle_iterated_gluing_second_rational`（`claim_open_rectangle_iterated_gluing_first_rational` の直後・実数体脱出の宣言の直前、住処 Q）で、
  $a,b,k\ge1$、$q\in\mathbb Q_{>0}$ に対し $0<q\le1$: $q^{(k-1)a}Z^{\mathrm{op}}_{a,b}(q)^k\le Z^{\mathrm{op}}_{a,kb}(q)\le Z^{\mathrm{op}}_{a,b}(q)^k$、$1\le q$: その逆向き。
  $\mathbb R$ 版と同じ帰納法 1 本（底は等号の鎖、帰納段は $ka=a+(k-1)a$・帰納法の仮定へ正数を掛ける・第二座標の長さ $kb$ と $b$ への接合不等式（$\mathbb Q$ 版））を
  $\mathbb Q$ の順序体の性質だけで述べ、実数体は現れない。SageMath 126 組（`ZZ`/`QQ`。帰納段も検査）、Lean 具体版・必要十分版（$\mathbb R$ 版・第一と共有）・導出版、
  sorry 検査 1190 件。レビューでは前 tick の反復接合の第一（$\mathbb Q$ 版）の四層が一致し修正無し。次は「正方形のブロック敷き詰め（$\mathbb Q$ 版）」。

（これより古い 275 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 46 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 開境界正方形の密度の非負性（$\Lambda_{\mathbb Q}$ 版） | todo | $0\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)$。`claim_finite_free_entropy_density_nonnegative` と同じ論法（`claim_open_rectangle_value_ge_one_at_positive_rational` の $1\le Z^{\mathrm{op}}_{L,L}(q)$ → `claim_log_power` の $k=0$・`claim_rational_log_order_iff`・`claim_scaled_embedding_order_transfer`）。`claim_open_rectangle_value_ge_one_at_positive_rational` の直後に置く。Lean は `FiniteFreeEntropyDensityNonnegative*.lean` を開境界へ移し、必要十分版 `le_base_transport_of_monotone_necSuf` を共有できる見込み |
| 熱力学極限 | 開境界正方形の値の上界（$\mathbb Q$ 版） | todo | $Z^{\mathrm{op}}_{L,L}(q)\le2^{L^2}(1+q)^{2L^2}$。`claim_partition_value_upper_bound_at_positive_rational` と同じ論法（辺数 $2L(L-1)\le2L^2$） |
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

- 2026-08-16（tick 320）: `claim_open_square_block_tiling_rational` を `claim_open_rectangle_iterated_gluing_second_rational` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。$\mathbb R$ 版 `claim_open_square_block_tiling` の合成（第一座標方向の反復接合を $b=a$ で、
  両辺の $k$ 乗、第二座標方向の反復接合を第一座標の長さ $ka$ で、正数 $q^{(k-1)(ka)}$ の乗法と推移律）を $q\in\mathbb Q_{>0}$ で述べ直し、
  反復接合は `claim_open_rectangle_iterated_gluing_first_rational`・`claim_open_rectangle_iterated_gluing_second_rational` を引く。
  「正の底の自然数冪は順序を保つ」は準備として置き `claim_partition_value_upper_bound_at_positive_rational` の準備の第二を引く。
  `remark_real_field_escape` は引かない。$\mathbb R$ 版は併存（撤去のセクションで消す）。SageMath `open-square-block-tiling-rational`
  （形 5 通り × 正の有理点 9 点、45 組。$\mathbb Z[x]$ への代入と配位和の一致・鎖の各段・二場合の上下評価。`ZZ`/`QQ`）。Lean 具体版
  `ThermodynamicLimit/OpenSquareBlockTilingRational.lean`（`openPartitionValueRat_squareBlockTiling_bounds_of_le_one`／`_of_one_le`。$\mathbb R$ 版の
  合成を ℚ で書き直し、`pow_le_pow_of_pos_of_le_by_induction_rat` を引く）、必要十分版は `two_direction_pow_bounds_necSuf` をそのまま共有、導出版
  `OpenSquareBlockTilingRationalFromNecSuf.lean`。sorry 検査 1194 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 319）: `claim_open_rectangle_iterated_gluing_second_rational` を `claim_open_rectangle_iterated_gluing_first_rational` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。$\mathbb R$ 版 `claim_open_rectangle_iterated_gluing_second` の帰納法（$k=1$ の底の等号の鎖、
  帰納段の $ka=a+(k-1)a$・冪の指数法則・積の結合則・帰納法の仮定と正数の乗法・第二座標の長さ $kb$ と $b$ の二長方形への接合不等式）を
  $q\in\mathbb Q_{>0}$ で述べ直し、接合不等式は `claim_open_rectangle_gluing_inequality_rational` を引く。`remark_real_field_escape` は引かない。
  $\mathbb R$ 版は併存（撤去のセクションで消す）。SageMath `open-rectangle-iterated-gluing-second-rational`（形 14 通り × 正の有理点 9 点、126 組。
  $\mathbb Z[x]$ への代入と配位和の一致・二場合の上下評価・帰納段の各段。`ZZ`/`QQ`）。Lean 具体版
  `ThermodynamicLimit/OpenRectangleIteratedGluingSecondRational.lean`（`openPartitionValueRat_iteratedGlueSecond_bounds_of_le_one`／`_of_one_le`。
  $\mathbb R$ 版の帰納法を ℚ で書き直し、`OpenRectangleGluingInequalityRational.lean` の第二方向の接合不等式を引く）、必要十分版は
  `iterated_glue_pow_bounds_necSuf` をそのまま共有（接ぐ向きにも体にも依らない）、導出版 `OpenRectangleIteratedGluingSecondRationalFromNecSuf.lean`。
  sorry 検査 1190 件。式変形統一は一時停止中のため実施せず。

（これより古い 286 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 323）: 前 tick の「開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義」の本文・SageMath（overview の対象ラベル・実行日・帰属）・
  Lean（`openScaledFreeEntropy`・`openScaledFreeEntropy_apply`、入口 import・sorry 検査への登録）を突き合わせ、右辺の確定・各素数での値の三段の鎖・写像と値の区別・
  具体例 $L=2$、$q=1/2$ が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 322）: 前 tick の「周期境界と開境界の比較（$\mathbb Q$ 版）」の本文・SageMath（overview の対象ラベル・実行日・帰属）・Lean 具体版・
  必要十分版（$\mathbb R$ 版と共有）・導出版（入口 import・sorry 検査への登録）を突き合わせ、二場合の上下評価・全単射と分解・境界因子の順序・鎖の各行の根拠が
  一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 321）: 前 tick の「正方形のブロック敷き詰め（$\mathbb Q$ 版）」の本文・SageMath・Lean 具体版・必要十分版（$\mathbb R$ 版と共有）・
  導出版を突き合わせ、二場合の上下評価・鎖の各段（第一座標方向の反復接合・$k$ 乗・第二座標方向の反復接合・正数の乗法）・対象ラベル・入口 import・
  sorry 検査への登録が一致し、本文に $t$ や $\le_{\mathbb R}$ の残りは無い。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 320）: 前 tick の「反復接合の第二（$\mathbb Q$ 版）」の本文・SageMath・Lean 具体版・必要十分版（$\mathbb R$ 版・第一と共有）・
  導出版を突き合わせ、二場合の上下評価・帰納段の鎖・対象ラベル・入口 import・sorry 検査への登録が一致し、本文に $t$ や $\le_{\mathbb R}$ の残りは無い。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 319）: 前 tick の「反復接合の第一（$\mathbb Q$ 版）」の本文・SageMath・Lean 具体版・必要十分版（$\mathbb R$ 版と共有）・
  導出版を突き合わせ、二場合の上下評価・帰納段の鎖・対象ラベル・入口 import・sorry 検査への登録が一致し、本文に $t$ や $\le_{\mathbb R}$ の残りは無い。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

（これより古い 307 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

停止するには `launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop`。
再開するには `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`。
