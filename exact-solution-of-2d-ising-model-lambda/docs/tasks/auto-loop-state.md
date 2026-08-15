# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-16 の tick 317 は、「接合不等式（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  `claim_open_rectangle_gluing_inequality_rational`（`claim_open_rectangle_value_at_rational_is_positive` の直後・実数体脱出の宣言の直前、住処 Q）で、
  $a,b,c\ge1$、$q\in\mathbb Q_{>0}$ に対し第一・第二の座標方向 × $0<q\le1$・$1\le q$ の四つの不等式（例: $q^bZ^{\mathrm{op}}_{a,b}(q)Z^{\mathrm{op}}_{c,b}(q)
  \le Z^{\mathrm{op}}_{a+c,b}(q)\le Z^{\mathrm{op}}_{a,b}(q)Z^{\mathrm{op}}_{c,b}(q)$）。$\mathbb R$ 版と同じ論法（接合の全単射・破れボンド数の三項分解・
  接合面因子の自然数冪の順序・項ごとの評価の有限和・有限和の分配則）を $\mathbb Q$ の順序体の性質だけで述べ、実数体は現れない。$\mathbb R$ 版に
  揃えて 1 ブロックに置いた。SageMath 414 組（`ZZ`/`QQ`）、Lean 具体版・必要十分版（$\mathbb R$ 版と共有）・導出版、sorry 検査 1182 件。
  レビューでは前 tick の開矩形の値（$\mathbb Q$ 版）の四層が一致し修正無し。次は「反復接合の第一（$\mathbb Q$ 版）」。

- **2026-08-16 の tick 316 は、「開矩形の可算な定義群を実数体脱出の前へ移し、正の有理点での値（$\mathbb Q$ 版）を定義する」を
  本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。** 開境界長方形の頂点・辺・配位・破れボンド数・分配多項式の
  五つの定義（住処 N/Z、中身は変えない）を実数体脱出の宣言の前へ移し、その直後に $Z^{\mathrm{op}}_{a,b}(q):=(\sum_\sigma x^{b^{\mathrm{op}}_{a,b}(\sigma)})(q)
  =\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}\in\mathbb Q$（`def_open_rectangle_partition_value_at_positive_rational`、住処 Q）と
  $Z^{\mathrm{op}}_{a,b}(q)\in\mathbb Q_{>0}$（`claim_open_rectangle_value_at_rational_is_positive`、住処 Q。各項の正値性と
  $|\Sigma^{\mathrm{op}}_{a,b}|=2^{ab}\ge1$ から、周期境界の正値性と同じ論法）を置いた。実数体は現れない。レビューでは前 tick の
  $\Lambda_{\mathbb Q}$ 版上界の四層が一致し修正無し。次は「接合不等式（$\mathbb Q$ 版）」。

- **2026-08-16 の tick 315 は、「有限系の自由エントロピー密度の上からの評価（$\Lambda_{\mathbb Q}$ 版）」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** $L\ge1$、$q\in\mathbb Q_{>0}$ に対し $\Psi_L(q)\le_{\Lambda_{\mathbb Q}}\iota(\ell_2)+2\cdot\iota(\log(1+q))$
  （`claim_finite_free_entropy_density_upper_bound`、正の有理点での上からの評価の直後・実数体脱出の宣言の直前、住処 Lambda）。準備は
  $Z_L(q)\le2^{L^2}(1+q)^{2L^2}$・$\log2=\ell_2$（各素数での四段）・$n\cdot\iota(\nu)=\iota(n\nu)$（分母払いの証明の補助等式）。$\Lambda$ の鎖は
  五段（定義・対数の順序保存・加法性・冪を二項へ・$\log2=\ell_2$）、$\Lambda_{\mathbb Q}$ の鎖は八段（定義・順序の移送・$\iota$ の加法性・分配則・
  準備の第三・結合則・約分・$1\cdot\lambda=\lambda$）で、実数も実対数も使わない。レビューでは前 tick の $\mathbb Q$ 版上界の四層が一致し修正無し。
  次は「開矩形の可算な定義群を実数体脱出の前へ移し、正の有理点での値（$\mathbb Q$ 版）を定義する」。

- **2026-08-16 の tick 314 は、「正の有理点での分配多項式の値の上からの評価（$\mathbb Q$ 版）」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** $L\ge1$、$q\in\mathbb Q_{>0}$ に対し $Z_L(q)\le2^{L^2}\cdot(1+q)^{2L^2}$
  （`claim_partition_value_upper_bound_at_positive_rational`、密度の非負性の直後・実数体脱出の宣言の直前、住処 Q）。準備は $\mathbb R$ 版と同じ
  四つ（冪の正値性・底の単調性・指数の単調性・定数の有限和。いずれも $\mathbb Q$ の四則と順序と帰納法だけ）、鎖は五段（代入は環準同型・底を
  $1+q$ へ・指数を $2L^2$ へ・定数の有限和・$|\Sigma_L|=2^{L^2}$）。$\iota_{\mathbb Q\to\mathbb R}$ も実数体も現れない。必要十分版は $\mathbb R$ 版と
  共有（係数の住処は順序付き加法モノイドかつモノイドで足りる）。レビューでは前 tick の密度の非負性の四層が一致し修正無し。次は
  「有限系の自由エントロピー密度の上界（$\Lambda_{\mathbb Q}$ 版）」（上界の底は $\max(1,q)$ ではなく本 tick に揃えて $1+q$）。

- **2026-08-16 の tick 313 は、「有限系の自由エントロピー密度は非負である（$\Lambda_{\mathbb Q}$ 版）」を本文・SageMath・Lean（具体版・必要十分版・
  導出版）まで完成させた。** $L\ge1$、$q\in\mathbb Q_{>0}$ に対し $0\le_{\Lambda_{\mathbb Q}}\Psi_L(q)$（`claim_finite_free_entropy_density_nonnegative`、
  値 1 以上の直後・実数体脱出の宣言の直前、住処 Lambda）。準備は $1\le Z_L(q)$・$\log1=0$・$\frac{1}{L^2}\cdot\iota(0)=0$（各素数での五段の鎖）、
  $\Lambda$ の鎖 $0=\log1\le_\Lambda\log Z_L(q)=\Phi_L(q)$（対数の順序保存）と $\Lambda_{\mathbb Q}$ の鎖 $0=\frac{1}{L^2}\cdot\iota(0)
  \le_{\Lambda_{\mathbb Q}}\frac{1}{L^2}\cdot\iota(\Phi_L(q))=\Psi_L(q)$（順序の移送）の二本で、実数も実対数も使わない。レビューでは前 tick の
  値 1 以上の四層が一致し修正無し。次は「正の有理点での分配多項式の値の上界（$\mathbb Q$ 版）」。

（これより古い 270 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
- 熱力学極限: 41 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 熱力学極限 | 反復接合の第一（$\mathbb Q$ 版） | todo | 帰納法 1 本 |
| 熱力学極限 | 反復接合の第二（$\mathbb Q$ 版） | todo | 帰納法 1 本 |
| 熱力学極限 | 正方形のブロック敷き詰め（$\mathbb Q$ 版） | todo | 第一・第二の合成 |
| 熱力学極限 | 周期境界と開境界の比較（$\mathbb Q$ 版） | todo | |
| 熱力学極限 | 開境界正方形の自由エントロピー密度（$\Lambda_{\mathbb Q}$ 値）の定義と非負性・上界 | todo | $\Psi^{\mathrm{op}}_L(q):=\frac{1}{L^2}\cdot\iota(\log Z^{\mathrm{op}}_{L,L}(q))$。値の下界 1・上界（$\mathbb Q$ 版）もここで（定義 1・主張 2 なら割る） |
| 熱力学極限 | ブロック敷き詰めの対数化（$\Lambda_{\mathbb Q}$ 版） | todo | $\Psi^{\mathrm{op}}_{ka}$ を $\Psi^{\mathrm{op}}_a$ と $\ell_2$・$\log q$ の有理数倍で二場合に挟む |
| 熱力学極限 | 部分正方形との比較（$0<q\le1$。$\mathbb Q$ 版） | todo | `claim_open_square_subsquare_comparison_le_one` を $q\in\mathbb Q$ で |
| 熱力学極限 | 極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる | todo | 完備性（上限の存在）を使わずに、可算側の主張として収束の速さつきで述べる。各段の比較は有理数の比較なので決定可能 |
| 熱力学極限 | 切断による ℝ への一度きりの脱出 | todo | 「この有理数の列が定める切断として実数が存在する」だけを引く。章頭の「実数体への脱出の宣言」をここへ移し、完備性の宣言は不要になれば畳む |
| 熱力学極限 | 旧実数値経路を撤去する | todo | 可算側の密度・Cauchy 性・切断からの実数化が揃ったあと、$\varphi_L$ と実数値の上下限・上限／下限による極限経路、および対応する SageMath・Lean を削除し、参照と台帳を新経路へ揃える |
| 熱力学極限 | 開境界正方形と部分正方形の値の比較（$1\le t$ の場合） | todo | $1\le a<L$、$c=L-a$ に対し、接合不等式の $1\le t$ 側と値の下界 $1$・配位数による上界 $2^{ab}t^{2ab}$ で挟む。予定: $Z_{a,a}\le Z_{L,L}\le2^{L^2-a^2}t^{a+L+2(L^2-a^2)}Z_{a,a}$（$0<t\le1$ 側は済。Lean は `split_twice_bounds_necSuf` と同型の必要十分版で書ける見込み） |
| 熱力学極限 | 部分正方形との比較の対数化 | todo | $\psi^{\mathrm{op}}_L(t)$ を $\iota(a^2/L^2)\psi^{\mathrm{op}}_a(t)$ と $\log_{\mathbb R}t$・$\log_{\mathbb R}2$ の有理数倍で二場合に挟む |
| 熱力学極限 | 開境界密度の極限（$0<t\le1$ の場合） | todo | 任意近接の $a$ を固定し、$ka\le L<(k+1)a$ で $\psi^{\mathrm{op}}_L$ を $\psi^{\mathrm{op}}_{ka}$ で挟んで、下限 $v$ への $\varepsilon$–$N$ の言明を閉じる |
| 熱力学極限 | 開境界密度の極限（$1\le t$ の場合） | todo | 同じ論法で上限 $u$ への収束を閉じる |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-16（tick 317）: `claim_open_rectangle_gluing_inequality_rational` を `claim_open_rectangle_value_at_rational_is_positive` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。$\mathbb R$ 版 `claim_open_rectangle_gluing_inequality` の証明（接合の全単射・
  破れボンド数の三項分解・接合面因子 $q^s$ の自然数冪の順序 $q^b\le q^s\le1$／$1\le q^s\le q^b$・項ごとの評価の有限和・有限和の分配則）を
  $q\in\mathbb Q_{>0}$ で述べ直し、値は `def_open_rectangle_partition_value_at_positive_rational`、各項の正値性は
  `claim_open_rectangle_value_at_rational_is_positive` の準備を引く。`remark_real_field_escape` は引かない。四つの不等式は $\mathbb R$ 版に
  揃えて 1 ブロック（下流の反復接合が「第一座標方向の接合の下側」のように引くため）。$\mathbb R$ 版は併存（撤去のセクションで消す）。
  SageMath `open-rectangle-gluing-inequality-rational`（形 23 通り × 正の有理点 9 点、414 組。$\mathbb Z[x]$ への代入と配位和の一致・全単射・
  三項分解・接合面因子の順序・四つの不等式。`ZZ`/`QQ`）。Lean 具体版 `ThermodynamicLimit/OpenRectangleGluingInequalityRational.lean`
  （`pow_le_one_by_induction_rat`・`pow_le_pow_of_le_one_of_exp_le_by_induction_rat`・`openPartitionValueRat_glueFirst_eq`・
  `openPartitionValueRat_mul_eq_double_sum`・`openPartitionValueRat_glueSecond_eq`・四つの `openPartitionValueRat_glue*_bounds_of_*`。
  $\mathbb R$ 版の帰納法を ℚ で書き直し、指数 0 の底の場合は `rw [pow_zero]`）、必要十分版は $\mathbb R$ 版の `sum_pow_glue_bounds_necSuf` を
  そのまま共有（可換半環と順序だけ。有理数体・実数体は本質でない）、導出版 `OpenRectangleGluingInequalityRationalFromNecSuf.lean`。
  sorry 検査 1182 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 316）: `def_open_rectangle_vertices`・`def_open_rectangle_edges`・`def_open_rectangle_configuration`・
  `def_open_rectangle_broken_bond_count`・`def_open_rectangle_partition_polynomial` を `claim_finite_free_entropy_density_upper_bound` の直後
  （`remark_real_field_escape` の直前）へ移した（中身は変えない。参照先はすべて前の章なので参照は壊れない）。その直後に
  `def_open_rectangle_partition_value_at_positive_rational`（$\mathbb Z[x]$ の分配多項式への $q$ の代入。代入は環準同型なので
  $\sum_\sigma q^{b^{\mathrm{op}}_{a,b}(\sigma)}$）と `claim_open_rectangle_value_at_rational_is_positive`（各項 $0<q^{b^{\mathrm{op}}_{a,b}(\sigma)}$、
  $|\Sigma^{\mathrm{op}}_{a,b}|=2^{ab}\ge1$、正の有理数を 1 個以上足したものは正）を置いた。$\mathbb R$ 版
  `def_open_rectangle_partition_value` は併存（撤去のセクションで消す）。`def_open_rectangle_constant_plus_configuration` と
  `claim_open_rectangle_constant_plus_breaks_no_bond`（住処 N）は $\mathbb R$ 側の値の下界の直前に残してある（開境界正方形の密度の
  非負性のセクションで移す）。SageMath `open-rectangle-partition-value-at-positive-rational`（長方形 10 形・正の有理点 9 点、43446 件、
  `ZZ`/`QQ`）。Lean 具体版 `ThermodynamicLimit/OpenRectanglePartitionValueRational.lean`（`openPartitionValueRat`・
  `openPartitionValueRat_eq_sum`・`openPartitionValueRat_pos`）、必要十分版は周期境界の `NecSuf/FreeEntropy/ValuePositive.lean` の
  `sum_pow_pos` を共有（有限で空でない添字型と順序半環の正の元の冪の和だけ。開境界・長方形の形・多項式は本質でない）、導出版
  `OpenRectanglePartitionValueRationalFromNecSuf.lean`。sorry 検査 1169 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 315）: `claim_finite_free_entropy_density_upper_bound` を `claim_partition_value_upper_bound_at_positive_rational` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。準備の第一は `claim_value_at_rational_is_positive`・
  `claim_partition_value_upper_bound_at_positive_rational`、第二は $\log2=\ell_2$（`def_rational_log`・`def_prime_exponent`・`def_log_order_group` の
  四段）、第三は `claim_scaled_free_entropy_denominator_clearing` の証明末尾の $n\cdot\iota(\nu)=\iota(n\nu)$。$\Lambda$ の鎖は
  `claim_rational_log_order_iff`・`claim_log_additive`・`claim_log_power`、$\Lambda_{\mathbb Q}$ の鎖は `claim_scaled_embedding_order_transfer` の ←・
  `claim_rational_log_order_group_embedding`・`def_rational_log_order_group` の分配則・結合則・$1\cdot\lambda=\lambda$。SageMath
  `finite-free-entropy-density-upper-bound`（$L\le3$・正の有理点 9 点、141 件、`ZZ`/`QQ`。決定手続きと $N=L^2$ での証人の比較の一致も見る）。Lean 具体版
  `ThermodynamicLimit/FiniteFreeEntropyDensityUpperBound.lean`（`logRat_upperBound_eq`・`logOrderLE_freeEntropy_upperBound`・
  `scaled_toRational_upperBound_eq`・`rationalLogOrderLE_scaledFreeEntropy_upperBound`。`logRat_two`・`toRational_intSmul` を再利用）、必要十分版
  `NecSuf/ThermodynamicLimit/FiniteFreeEntropyDensityUpperBound.lean` の `upperBound_transport_through_two_monotone_maps_necSuf`（順序を保つ二写像と
  二つの等式だけ。対数・有理数倍・埋め込みは本質でない。導出版では第一の写像の定義域を正の有理数の部分型に取る）、導出版。sorry 検査 1166 件。
  式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 314）: `claim_partition_value_upper_bound_at_positive_rational` を `claim_finite_free_entropy_density_nonnegative` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。$\mathbb R$ 版 `claim_partition_value_upper_bound` の準備四つと五段の鎖を $q\in\mathbb Q$ で
  述べ直したもので、順序体の性質は $\mathbb Q$ のものとして使い `remark_real_field_escape` を引かない（$\mathbb R$ 版は併存、撤去のセクションで消す）。
  上界の底は $\mathbb R$ 版と同じ $1+q$（場合分けを避ける）。次セクションの備考の $\max(1,q)$ はこれに揃えて $1+q$ へ書き換えた。SageMath
  `partition-value-upper-bound-at-positive-rational`（$L\le4$・正の有理点 9 点、準備 1251 件・鎖の各行と主張 332 件、`ZZ`/`QQ`）。Lean 具体版
  `ThermodynamicLimit/PartitionValueUpperBoundRational.lean`（`pow_le_pow_of_pos_of_le_by_induction_rat`・`one_le_pow_by_induction_rat`・
  `pow_le_pow_of_one_le_of_exp_le_by_induction_rat`・`partitionPolynomial_eval_rat_le_upperBound`。$\mathbb R$ 版の帰納法を ℚ で書き直し、
  `pow_pos_by_induction` は共通のものを使う）、必要十分版は $\mathbb R$ 版の `NecSuf/ThermodynamicLimit/PartitionValueUpperBound.lean` の
  `sum_pow_le_uniform_bound_necSuf` をそのまま共有（新規の仮定は無い）、導出版 `PartitionValueUpperBoundRationalFromNecSuf.lean`。
  sorry 検査 1160 件。式変形統一は一時停止中のため実施せず。

- 2026-08-16（tick 313）: `claim_finite_free_entropy_density_nonnegative` を `claim_partition_value_ge_one_at_positive_rational` の直後
  （`remark_real_field_escape` の直前）に置き四層で閉じた。準備の第一は `claim_value_at_rational_is_positive`・
  `claim_partition_value_ge_one_at_positive_rational`、第二は `claim_log_power` の $k=0$（$\log1=0$）、第三は $\frac{1}{L^2}\cdot\iota(0)=0$ の
  各素数での五段の鎖（有理数倍の定義・$\iota$ の定義・$\Lambda$ の零写像・$\mathbb Q$ の積・$\Lambda_{\mathbb Q}$ の零写像）。$\Lambda$ の鎖は
  `claim_rational_log_order_iff` を $q:=1$、$q':=Z_L(q)$ で、$\Lambda_{\mathbb Q}$ の鎖は `claim_scaled_embedding_order_transfer` の ← を
  $\lambda:=0$、$\mu:=\Phi_L(q)$ で読む。SageMath `finite-free-entropy-density-nonnegative`（$L\le3$・正の有理点 9 点、準備 16 件・鎖の各行と主張
  81 件、`ZZ`/`QQ`。$N=L^2$ での証人の比較と決定手続きの一致も見る）。Lean 具体版 `ThermodynamicLimit/FiniteFreeEntropyDensityNonnegative.lean`
  （`scaled_toRational_zero`・`logOrderLE_zero_freeEntropy`・`rationalLogOrderLE_zero_scaledFreeEntropy`）、必要十分版
  `NecSuf/ThermodynamicLimit/FiniteFreeEntropyDensityNonnegative.lean` の `le_base_transport_of_monotone_necSuf`（述語上で順序を**保つ**写像と
  基点が基点へ移ることだけ。引いた二主張は同値だが使うのは一方向のみ。対数・有理数倍・埋め込みは本質でない）、導出版は必要十分版を二度
  （$\mathbb Q_{>0}\to\Lambda$、$\Lambda\to\Lambda_{\mathbb Q}$）特殊化。sorry 検査 1155 件。式変形統一は一時停止中のため実施せず。

（これより古い 281 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

- 2026-08-16（tick 317）: 前 tick の「開矩形の可算な定義群の移動と正の有理点での値（$\mathbb Q$ 版）」の本文・SageMath・Lean 具体版・
  必要十分版（周期境界と共有）・導出版を突き合わせ、定義の二つの等号・準備二つ・二段の鎖・対象ラベル・入口 import・sorry 検査への登録が一致した。
  本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 316）: 前 tick の「有限系の自由エントロピー密度の上からの評価（$\Lambda_{\mathbb Q}$ 版）」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせ、準備三つ・$\Lambda$ の五段と $\Lambda_{\mathbb Q}$ の八段の鎖・対象ラベル・入口 import・sorry 検査への
  登録が一致した。本文末尾「この先に書くこと」と台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 315）: 前 tick の「正の有理点での分配多項式の値の上からの評価（$\mathbb Q$ 版）」の本文・SageMath・Lean 具体版・必要十分版
  （$\mathbb R$ 版と共有）・導出版を突き合わせ、準備四つ・五段の鎖・対象ラベル・入口 import・sorry 検査への登録が一致した。本文末尾「この先に書くこと」と
  台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 314）: 前 tick の「有限系の自由エントロピー密度は非負である」の本文・SageMath・Lean 具体版・必要十分版・導出版を
  突き合わせ、準備三つ・$\Lambda$ の鎖と $\Lambda_{\mathbb Q}$ の鎖・対象ラベル・入口 import・sorry 検査への登録が一致した。本文末尾「この先に書くこと」と
  台帳のセクション表も食い違いなし。修正は無い。

- 2026-08-16（tick 313）: 前 tick の「正の有理点での分配多項式の値は 1 以上である」の本文・SageMath・Lean 具体版・必要十分版・導出版を
  突き合わせ、五段の鎖・対象ラベル・入口 import・sorry 検査への登録が一致した。本文末尾「この先に書くこと」と台帳のセクション表も
  食い違いなし。修正は無い。

（これより古い 302 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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
