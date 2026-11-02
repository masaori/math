# 全ての証明に SageMath の検算を付ける — 状態台帳

手順は [sagemath-every-proof-runbook.md](sagemath-every-proof-runbook.md)。

## 現在地

2026-11-02: 証明を持つブロック 346 件のうち、SageMath の検算が無いもの 74 件（`node sagemath/tools/verify-every-proof-has-check.ts`）。

済んだもの（文書順）:

- `mat_columnwise`（行列の積は列ごとに作用する）: `sagemath/check/mat_columnwise/`。証明の成分計算の四行と主張を、`QQ` 上の多項式環の不定元で厳密に確かめた。主張に `m,n,p ∈ Z_{≥1}` の帰属を足した。
- `radial_normalization_exists_unique`（非零実数対の単位円への正規化）: `sagemath/check/radial_normalization_exists_unique/`。一般の点は `QQ(x,y)` 上の「`r` が可逆なだけの環」と「`r^2 = x^2+y^2` を持つ環」に分けてどの行がどの関係式を使うかを示し、正負・大小に依る行は `AA`（実代数的数）の具体の点で厳密に確かめた。レビューの指摘で人手証明を直した（`\mathbf R` を `\mathbb R` に統一、`x^2+y^2>0` を場合分けの不等式の鎖に、`r>0`・`r x_c = x`・`r' = √(x^2+y^2) = r` を (∵) 付きの鎖に、平方根の定義・単位円の定義・平方根の一意性への `blkref` を追加、`r', x_c, y_c` の帰属を明記）。計算の誤りは無かった。
- `arcsin_is_bijection`（arcsin の値域・狭義単調増加・全単射・連続）: `sagemath/check/arcsin_is_bijection/`。証明は外部文献の引用だけだったので、弧の長さを内接折れ線と外接折れ線で `RealBallField` の区間に挟み、値域・三つの場合の狭義単調増加・全射の証人 `sin(kπ/24)`（`AA` で厳密）を確かめた。レビューの指摘で人手証明を直した（`def_arcsin` の二つの式が `y = 0` で重なっていたのを第二の式を `-1 ≤ y' < 0` に限って解消、終域を `ℝ` にして値域を主張の側へ移した、主張を四項に書き下し、文献に委ねるのを `f(y) := l(AP)` の狭義単調増加と像 `[0,π/2]` だけにして、負の側への拡張・全射・連続を本文で示した、`def_sin` を全単射の項から定める形にした）。計算の誤りは無かった。
- `arctan_argument_in_unit_interval`（arctan の引数は arcsin の定義域に入る）: `sagemath/check/arctan_argument_in_unit_interval/`。`QQ[x]` の差の恒等式と `AA` の具体の点で全て厳密に確かめた（浮動小数点なし）。レビューの指摘で人手証明を直した（平方根を取る前に `1+x^2 ≥ 1 > 0` を示す順に改め主張にも平方根が定まることを書いた、`s > 0` の推論、`|x| ≤ s` を背理法の鎖に、絶対値の商と `|s| = s` を二行に、最後の同値を必要な向きの鎖に、`x ∈ ℝ` の理由）。計算の誤りは無かった。
- `multiplicative_group_of_polar_representation`（（極座標表現）の乗法群）: レビューの指摘（1 ブロック 1 主張、一般の集合 S への抽象化、下流が右からの積だけで逆元の形を引いていたこと）で、
  `polar_multiplication_well_defined`（積の定義の前へ）・`monoid_of_polar_representation`・`polar_zero_class_criterion`・`inverse_in_polar_representation`（存在）・
  `right_inverse_in_polar_representation_is_unique`（右逆元の一意性。下流二箇所はこれを引く）・群の主張の七ブロックに分け、それぞれに `sagemath/check/<ラベル>/` を付けた。
  共通の準備 `sagemath/_shared/polar_representation.sage` は、半径を `AA`、角度を `a+bπ`（`a,b∈QQ`、π は無理数）で持ち、角度と極座標表現の同値を厳密に判定する。計算の誤りは無かった。

- `sqrt_squared_is_original`（複素数の平方根の2乗は元に戻る）: `sagemath/check/sqrt_squared_is_original/`。角度を π の有理数倍に限り、cos・sin を 1 の冪根から `QQbar` で作って十行の鎖と主張を厳密に確かめた（共通の準備 `sagemath/_shared/polar_trigonometry_exact.sage`）。φ_polar(z) の代表元の判定は arctan の値を作らず `sin α = t/√(1+t²)` で行う。レビューの指摘で、最終行の根拠「φ_cartesian ∘ φ_polar = id」を `isomorphism_of_phi_cartesian` の主張が述べていなかったので、その証明の後半を新しい主張 `phi_cartesian_after_phi_polar_is_identity` へ切り出し（検算 `sagemath/check/phi_cartesian_after_phi_polar_is_identity/`、各行へ `blkref`）、同じ事実を使う五箇所からも引いた。同値の行の根拠、和の行の分割、上流の定義が未完であることを主張に書いた。計算の誤りは無かった。

- `kronecker_transpose`（クロネッカー積の転置）: `sagemath/check/kronecker_transpose/`。因子の成分を `QQ` 上の多項式環の不定元に置き、`M = 1,…,4` で四行の鎖・ν の全単射・主張を厳密に確かめた。各行の片側を Sage 組み込みの `transpose`・`tensor_product` で作り、本文の定め方どおりの行列との一致もあわせて確かめた。主張の中で定めていた転置と、証明が根拠にしていた未定義の「2 次の行列の転置」を、新しい定義 `def_matrix_transpose`（m 行 n 列の行列の転置）へ切り出した。計算の誤りは無かった。
- `scalar_exp_is_limit_of_partial_sums`・`scalar_exp_product`・`scalar_exp_zero`（数の exp の部分和の極限・指数法則・`exp(0)=1`）: `sagemath/check/<ラベル>/`。
  共通の準備は `sagemath/_shared/one_by_one_matrix.sage`。冪・部分和・指数法則の鎖は `QQ`・`QQ(i)` 上の多項式環と形式冪級数（全次数 14 まで）で厳密に、
  極限と exp の値は具体の点で、本文の exp の部分和に尾の評価を半径として付けたボールで確かめた。
  レビューの指摘で人手証明を直した（三つの証明の散文の中の式変形を (∵) とラベル参照付きの鎖に、数の冪 `x^{m+1} := x^m x` を主張の約束に追加、
  `exp(0)=1` は数の列の極限の一意性にラベルが無いので、行列の部分和 `S_N([0])` が定数列 `[1]` であることと行列の極限の一意性から示す形に、
  `def_matrix_norm` に `K` の列の収束 `|a_N - a| → 0` の定義を追加）。計算の誤りは無かった。

- `real_exp_positive`（実数の exp は正）と `real_exp_strictly_increasing`（実数の exp は狭義単調増加）: `sagemath/check/real_exp_positive/`・`sagemath/check/real_exp_strictly_increasing/`。等号の行は `QQ[x]` の形式冪級数として次数で打ち切って厳密に、ノルムの行は `AA` で、不等号と主張は本文の exp を囲むボール（共通の準備 `sagemath/_shared/one_by_one_matrix.sage` の `body_real_exp_ball`）で確かめた。レビューの指摘で人手証明を直した（背理法と結論を (∵) 付きの鎖に、`exp(-x), exp(x/2) ∈ ℝ` の明示、`E(a) = exp(a)` を無ラベルの「実数列の極限の一意性」から 1 行 1 列の行列の極限の一意性（`matrix_norm_triangle_inequality` (4)）経由の鎖に、`‖[u]_R‖ = |u|`・`[u]-[v] = [u-v]` の鎖、Step 2 の Step 1 の適用を鎖の前へ）。計算の誤りは無かった。

- `complex_exp_of_real_argument`（実数の exp と複素数の exp は実数上で一致する）: `sagemath/check/complex_exp_of_real_argument/`。ℂ を本文どおり実数の対で持ち（共通の準備 `sagemath/_shared/complex_as_real_pairs.sage`）、
  準備の和・積・差、冪と部分和の帰納法の各段を `QQ[a,b]`・`QQ[x]` で厳密に、1 行 1 列の複素行列の差とノルムを `QQ(i)`・`AA` で、収束と主張を本文の exp を囲むボールで確かめた。
  人手証明を直した（散文の「有限個の項へ適用」を冪と部分和の二つの帰納法に、収束と「ℂ の列の極限の一意性」（ラベル無し）を 1 行 1 列の行列の極限の一意性（`matrix_norm_triangle_inequality` (4)）経由の鎖に、
  `|(a-b)_C| = |a-b|` を `abs_basic_properties` (6) から、`1_C`・`-1_C` の根拠を `inclusion_rr_to_cc` の略記に、ℝ への脱出の明示）。計算の誤りは無かった。

- `cosh_sinh_product`（cosh・sinh の掛け算。ラベルが無かったので付けた）: `sagemath/check/cosh_sinh_product/`。exp の性質を使わない行は exp の 8 つの値を `QQ` 上の独立な不定元に置いて、積の法則の行と鎖の両端は `QQ[a,b]` の形式冪級数（全次数 14 まで）で厳密に、主張は本文の exp を囲むボールで確かめた。レビューの指摘で人手証明を直した（一行に積の法則・指数の整理・並べ替え・`1/4=(1/2)(1/2)` を束ねていたのを、一ステップ一定理の 9 行の鎖に分け、`def_cosh_sinh` への `blkref` と、現れる exp が実数の exp であることを足した）。計算の誤りは無かった。

- `exp_of_diagonal_matrix`（対角行列の指数関数）と、そのために足した `scalar_limit_is_unique`（数の列の極限は一意）: `sagemath/check/exp_of_diagonal_matrix/`・`sagemath/check/scalar_limit_is_unique/`。
  積・冪の帰納法・部分和の鎖は `QQ(i)` 上の多項式環の不定元で厳密に、絶対値とノルムは `AA` で、`exp(D)` と `exp(d_k)` の値だけを本文の部分和を囲む複素数のボールで確かめた。
  人手証明を直した（冪の帰納法と極限から成分を決める段を (∵) 付きの鎖に、対角成分の極限の根拠を `real_exp_series_converges` の複素数への流用から `scalar_exp_is_limit_of_partial_sums` と新しい `scalar_limit_is_unique` へ、
  部分和の記号を `E_K` から `S_N` へ（体 `K`・行列単位 `E_{I,J}` との衝突）、主張に `k, l` の範囲・`inclusion_rr_to_cc`・ℝ への脱出を明記、積の中間目標の文字を主張の `D` と分けて `P, Q` に）。五回のレビューで指摘が無くなるまで直した。計算の誤りは無かった。

- `end_preserves_matrix_exponential`（行列表示と線型写像表示は指数関数を保つ）と、そのために足した `end_agrees_with_matrix_vector_product`（線型写像表示の値は行列と数ベクトルの積に等しい）: `sagemath/check/end_preserves_matrix_exponential/`・`sagemath/check/end_agrees_with_matrix_vector_product/`。
  `end` を定義の文言どおりに作る共通の準備 `sagemath/_shared/end_by_definition.sage`（基底の座標は基底を並べた行列の逆行列から求め、`end` の値が行列と数ベクトルの積に等しいことは使わない）を置いた。
  基底の成分・展開・主張の鎖、冪の保存、部分和の書き換えは `QQ(i)` 上の不定元で厳密に、`exp(A)` の値だけを本文の部分和を囲むボールで確かめた。
  人手証明の欠けを直した: 証明は exp 級数の各点収束（`exp_converges` (1a)。`mat_mult` の積の収束）を `end` の作用の記法 `Af := (end(A))(f)` の収束として断りなく使っていた。二つの積の一致を新しい主張 `end_agrees_with_matrix_vector_product` として成分計算で示し、証明の中では `mat_mult` の積を `B•f` と書いて区別した。
  あわせて、冪の保存の各行に `def_exp` (1)・`end_is_algebra_isomorphism` (1)〜(3) を引き、最後の散文を `exp(A)` の級数表示・`exp_converges` (1a)・ℝ への脱出を根拠に持つ鎖にした。計算の誤りは無かった。

- `def_invertible_elements_of_R`（`Mat(2^M,ℂ)` の可逆元。逆元の一意性と (i)〜(iv)）: `sagemath/check/def_invertible_elements_of_R/`。一般の等式の行は `QQ` 上の不定元で、仮定 `gh = hg = I` の代入の行は `QQ(i)` の具体の可逆行列で、(iv) は `QQ(c)` で厳密に確かめ、結論は Sage の `inverse`・`solve_left`・`solve_right` と比べた。
  証明が根拠にしていた単位行列・行列のスカラー倍・行列の積の結合律・単位行列との積・スカラー倍の性質と、`0_C z = 0_C` を述べるブロックが本文に無かったので、
  定義 `def_kronecker_delta`・`def_identity_matrix`・`def_matrix_scalar_multiple` と、主張 `mat_mult_associative`・`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・
  `scalar_multiple_factors_out_of_left_factor`・`scalar_multiple_factors_out_of_right_factor`・`scalar_multiple_is_associative`・`scalar_multiple_by_one`（`002_linear_space_general.ts` の冒頭）、
  `complex_zero_times_is_zero`（`000_calculation_formulae_20_29.ts`、`complex_numbers_form_a_field` の直後）を足し、それぞれに同名の検算を付けた（共通の準備 `sagemath/_shared/matrix_operations_by_definition.sage`）。
  人手証明を直した（(iv) が `scalar_identity_commutes`（交換子が 0）を根拠に引いていたのを、スカラー倍の性質を一つずつ引く 6 行の鎖に、(ii) の結合律を 2 回使う行を 2 行に、(i) の `II = I` に根拠を、各行に足したラベルへの `blkref`）。計算の誤りは無かった。

- `trace_basic_properties`（トレースの基本性質）: `sagemath/check/trace_basic_properties/`。(1)(2) は `QQ` 上の不定元で、(3) は ℂ を実数の対で持って、(4) は `QQ(i)` 上の不定元と具体の可逆行列で、四本の鎖の全行を厳密に確かめ、両端を Sage の `trace` と比べた。
  人手証明を直した（(1)(3) の散文を根拠付きの鎖に、(2) の「順序交換と積の可換性」を二行に、各行へ `blkref`、ℂ の演算の性質に `complex_numbers_form_a_field`、
  行列の和の定義が本文に無かったので `def_matrix_sum` を `002_linear_space_general.ts` に足した、単位行列を `I_{Mat(n,C)}` に、(3) の右辺を `Σ_{k=1}^{n} 1_C` に、
  (4) の仮定を「`P` が可逆」から「`P'P = I`」に、左辺を `tr(P(AP'))` に）。計算の誤りは無かった。

- `trace_of_idempotent`（冪等行列のトレースは像の次元）と、そのために足した `mat_mult_vector_difference`（行列と数ベクトルの差の積の分配則 `A(u−w) = Au − Aw`、`000_calculation_formulae_45_46.ts`）:
  `sagemath/check/trace_of_idempotent/`・`sagemath/check/mat_mult_vector_difference/`。準備と Step 1 の鎖は `Q` または `x` を不定元に、仮定 `Q^2 = Q` を使う行は `QQ(i)` の具体の冪等行列（`r = 0,…,n`、エルミートとは限らない）で、
  全行を厳密に確かめ、両端を Sage の `trace`・`rank`・`column_space`・`right_kernel` と比べた。人手証明を直した（`Q^2 = QQ` を `def_exp` (1) の冪から導く準備を足した、
  Step 1 の分配則・結合則・零の行を `mat_mult_vector_difference`・`mat_mult_associative`・`matrix_difference_zero_iff_equal` で引いた、`x = Qx + (x−Qx)` を成分の鎖に、
  未定義の「表現行列」「基底変換行列」をやめて基底を列に並べた `P` と対角の `D` を定め `QP = PD` を成分の鎖で示した、Step 3 を `trace_basic_properties` (4) を `P → P'`、`P' → P`（`PP' = I`）で引く鎖に、
  主張の右辺の自然数を `1_C` の和として読むことを書いた）。計算の誤りは無かった。

- `star_preserves_norm_and_limits`（共役転置の積・線型性・ノルム・極限）と、そのために足した主張 `complex_conjugate_of_sum`（複素共役は有限和を保つ）・`complex_conjugate_of_product`（積を保つ）・`complex_conjugate_of_difference`（差を保つ）・`abs_of_complex_conjugate`（`|z̄| = |z|`）（`005_exp_conjugation_proof.ts`、`def_complex_conjugate` の直後）:
  `sagemath/check/<ラベル>/`。ℂ を実数の対で持ち（`_shared/complex_as_real_pairs.sage` に `cc_conj` を足した）、行列は対を成分に持つ表として本文の定め方どおりに組んで、成分の鎖は `QQ` 上の不定元で、根号を取る行は `AA` で厳密に確かめた。両端は `QQ(i)` 係数へ送った Sage の共役転置・`conjugate_transpose`・QQbar の `abs` と比べた。
  人手証明を直した（共役が和・積を保つことを `frobenius_inner_product_axioms` の証明冒頭から引いていたのを独立の主張に、「未記載の展開」の `|z̄| = |z|` を主張に、「第 2 式も同様」の線型性を成分の 8 行の鎖に、(3) の「(1) の線型性」を `A_N^* − A^* = (A_N − A)^*` の成分の鎖に、(2)(3) で ℝ を使う理由を主張に）。
  ℂ の差と有限和を定めるブロックが本文に無かったので、定義 `def_complex_difference`（`z − w := z + (−w)`）と `def_finite_sum_of_complex_numbers`（左から順に足す有限和）を `000_calculation_formulae_00_09.ts` の `multiply_by_minus_one` の後に足し、`def_matrix_difference` と `mat_mult` から引いた。計算の誤りは無かった。

- `exp_hermitian_is_positive_definite`（エルミート行列の exp は正定値）: 四つの主張を束ねていたブロックを 1 ブロック 1 主張に分け、`real_multiple_of_hermitian_is_hermitian`・`conjugate_bilinear_value_of_congruence`（`x^*(B^*(AB))y = (Bx)^*A(By)`）・
  `congruence_preserves_positive_definite`（旧 (2)。仮定を「可逆」から左逆行列 `B'B = I` に）・`identity_matrix_is_positive_definite`・`positive_real_multiple_preserves_positive_definite`（旧 (3)）・`trace_of_positive_definite_is_positive`（旧 (4)）・
  `exp_of_negative_is_left_inverse`・`exp_of_hermitian_is_hermitian`・`exp_hermitian_is_positive_definite`（旧 (1)。`exp(S) = T^*(IT)` を合同変換の主張に `A = I` で当てはめる）の 9 ブロックにした（`009_eigenvalues_of_V.ts`）。
  補助に `real_inclusion_preserves_finite_sum`・`finite_sum_of_complex_zeros`（`000_calculation_formulae_00_09.ts`）、`complex_conjugate_of_real_inclusion`・`complex_conjugate_times_self`（`005_exp_conjugation_proof.ts`）を足し、
  `def_hermitian_positive_definite` の「x を n×1 行列とみなす」「1×1 行列を ℂ と同一視する」を、新しい定義 `def_conjugate_bilinear_value`（`x^*Ay := Σ_kΣ_l conj(x_k) A_kl y_l`）と「`z ∈ ℝ_{>0}` は `z = r_C`（`r > 0`）の略記」に置き換えた。
  13 個の主張それぞれに同名の検算を付けた（共通の準備 `sagemath/_shared/hermitian_forms_by_definition.sage`）。鎖は不定元で厳密に、exp の値は本文の部分和に尾の上界を半径として足した 256 ビットのボールで囲み、Sage の `ComplexBallField` の `exp` と比べた。
  下流（`eigenvalue_problem_eigenvalues_of_V_plus.ts`・`thermodynamic_limit_row_limit_and_max_eigenvalue.ts`・ノート二つ）の「(1)〜(4)」の参照を新しいラベルにし、`B' := exp(-½S)` で左逆行列を与えた。計算の誤りは無かった。

- `psd_cauchy_schwarz`（対称・半正定値な実数の行列の Cauchy–Schwarz）: `sagemath/check/psd_cauchy_schwarz/`。準備と展開の鎖は対称な不定元の `P` と不定元の `x, y, t` で、場合分けの等号は有理関数で、不等号の行と主張は階数の落ちるものを含む `QQ` の `P = C^T C` で、全行を厳密に確かめた（浮動小数点なし）。
  人手証明を直した（未定義だった `x^⊤Py` を新しい定義 `def_real_bilinear_value`（`Σ_kΣ_l x_k P_kl y_l`）で、対称性を `def_real_symmetric_matrix`（`P_kl = P_lk`）で定めた、「転置・行列積の分配法則」の一行を成分の和の展開・項の並べ替え・`t`・`t^2` を外へ出す段に、
  `x^⊤Py = y^⊤Px` を準備の成分の鎖に、`a ≥ 0` から `a > 0` か `a = 0` に分かれることを書いた、(i) の結論を主張の左辺から始まる鎖に）。計算の誤りは無かった。

- `riemann_sum_to_integral`（等間隔点の平均は積分に収束する）: `sagemath/check/riemann_sum_to_integral/`。点を π の有理数倍、値・積分・上限を `AA[p]`（`p` は π の不定元）とその分数体で持ち、大小を 256 ビットのボールで符号を決めて厳密に確かめた（浮動小数点なし）。試験関数は `t^2`・`cos t`・`|t - π|` で、積分は原始関数で厳密に取り、Sage の記号積分をボールで評価した値と照合した。
  人手証明の欠けを直した: 連続度 `ω(h)` は上限で定めていたが、定義の集合が上に有界であること（`ω(h)` が実数として定まること）を示していなかったので、一様連続性（`ε = 1`）と `u_j` の分点の鎖から `0 ≤ ω(h) ≤ K` を示す段を足した。
  あわせて、端点 `x_ν` と長さ `len(I_μ)` を置いて区間加法性の前提（端のつながり）を鎖で示し、距離・`|t-s| ≤ 2π`・`u_j ∈ [0,2π]`・主張の評価・`N := ⌊2π/η_0⌋+1` を (∵) 付きの鎖に、外部前提の一様連続性を使う `≤` の形で書き、実数列の極限の意味と ℝ への脱出を主張に書いた。一様連続性の幅をずらしの量 `δ` と分けて `η_0`・`η_1` にした。計算の誤りは無かった。

- `cosh_addition_and_half_angle`（cosh・sinh の加法定理・半角公式・sinh の単調性・arcsinh・`t ≤ sinh t ≤ t cosh t` を束ねていたブロック）: 1 ブロック 1 主張に分け、
  `cosh_is_even`・`sinh_is_odd`・`cosh_addition_formula`・`sinh_addition_formula`・`cosh_half_angle_formula`・`sinh_double_angle_formula`・`sinh_zero`・`sinh_strictly_increasing`・`sinh_is_injective`・`sinh_derivative`・
  `sqrt_of_square_plus_one_is_positive`・`arcsinh_argument_times_conjugate_is_one`・`arcsinh_argument_is_positive`・定義 `def_arcsinh`・`sinh_of_arcsinh`・`sinh_equation_solved_by_arcsinh`・`arcsinh_derivative`・`cosh_at_least_one`・`cosh_monotone_on_nonnegative`・
  `sinh_at_least_argument`・`sinh_at_most_argument_times_cosh` の 21 ブロックにした（`020_critical_point.ts`）。20 個の主張それぞれに同名の検算 `sagemath/check/<ラベル>/` を付けた（共通の準備 `sagemath/_shared/hyperbolic_by_definition.sage`）。
  等号は exp の値の不定元・剰余環・関数体 `QQ(y)[s]/(s²-y²-1)`（微分も）・形式冪級数（全次数 14 以下）・`AA` で厳密に、不等号と主張は本文の exp の部分和に尾の評価を足したボールで確かめた。
  人手証明を直した（「定義から直ちに従う」「同じ計算で従う」で省いていた cosh の偶関数性・sinh の奇関数性・sinh の加法定理・倍角公式・sinh' = cosh を鎖に、
  未定義の実数の絶対値に頼っていた `y + √(y²+1) > 0` を `(y+s)(s-y) = 1` と `p+q = 2s > 0` からの背理法に、`exp(-u) = s-y` を exp の積の法則からの鎖に、
  cosh の `[0,∞)` 上の単調性と `cosh ≥ 1` を積分ではなく加法定理・半角公式から、(5) の二つの不等式を主張の左辺から始まる鎖に）。
  本文で宣言していなかった微分の事実（exp' = exp、log'、平方根の微分、和・定数倍・積・商・合成の公式、微分可能なら連続）を `remark_real_analysis_facts_R3_R4` に「微分の公式」として足した。
  下流（`critical_point_and_log_divergence.ts` の約 30 箇所、`closed_form_log_integral`）の「(1)」〜「(5)」の参照を、その行を実際に支える新しいラベルに付け替えた。計算の誤りは無かった。

- `elementary_sine_bounds`（正弦の初等評価。四つの不等式と c_0 の定義・数値評価を束ねていたブロック）: 1 ブロック 1 主張に分け、`sine_zero`・`cosine_zero`・`cosine_at_most_one`・`argument_minus_sine_nonnegative`（t - sin t ≥ 0）・`cosine_quadratic_lower_bound`・`sine_cubic_lower_bound`・
  `pi_squared_numerical_bounds`・定義 `def_sine_bound_constant`（c_0）・`sine_bound_constant_numerical_bounds`・`elementary_sine_bounds`（上側 θ/2 - sin(θ/2) ≤ θ³/48 だけ）・`sine_half_angle_linear_bounds` の 11 ブロックにした（`020_critical_point.ts`）。10 個の主張に同名の検算を付けた（共通の準備 `sagemath/_shared/sine_cosine_by_definition.sage`）。
  sin・cos は角度を π の有理数倍に限って `AA` で厳密に、導関数と積分の値は SR で、π を含む大小は Arb の π のボールで確かめた。端点で等号になる行は π の不定元の多項式で両辺の一致を見た。
  人手証明の誤りを直した: 証明は `t ≥ 0` の全体で sin・cos を使っていたが、本文の sin・cos は `[-π/2, π/2]` でしか定義されていないので、範囲を `[0, π/2]` に改めた。sin 0 = 0・cos 0 = 1・1 - cos ≥ 0 の根拠、(R4) に渡す導関数、1 行 1 操作の分割を足した。
  根拠なしで使っていた sin・cos の導関数と `9.8696 ≤ π² ≤ 9.8697` を、`remark_real_analysis_facts_R3_R4` に「本文の正弦・余弦・円周率についての主張で、本文では証明しない」項（sin' = cos、cos' = -sin、`3.141592 ≤ π ≤ 3.141593`）として宣言し、π² の評価はそこから導いた。下流（`sine_integral_two_sided`・`second_derivative_log_divergence`）の参照を付け替えた。数値の誤りは無かった。

- `closed_form_log_integral`（閉じた形の積分・arcsinh と積分の log 評価・3/2 乗の積分の評価を束ねていたブロック）: 1 ブロック 1 主張に分け、`real_log_of_product`（log(ab) = log a + log b）・`log_one_plus_at_most_argument`（log(1+x) ≤ x）・
  `arcsinh_argument_two_sided_bounds`（2y ≤ y + √(y²+1) ≤ 2y + 1/(2y)）・`arcsinh_two_sided_log_bounds`・`closed_form_log_integral`（閉じた形だけ）・`log_integral_two_sided_bounds`・定義 `def_three_halves_power`（w^{3/2} := w√w）・
  `three_halves_power_integral_bound` の 8 ブロックにした（`020_critical_point.ts`）。7 個の主張に同名の検算を付けた（共通の準備 `sagemath/_shared/log_integral_by_balls.sage`）。
  等号は `QQ` 上の多項式環・有理関数体・平方根の関係式だけを持つ関数体（θ の微分も）・`AA`・`QQbar` で厳密に、π を含む等号は π を不定元に置いて、積分・log・π の値は Arb の厳密な数値積分とボールで確かめた。
  人手証明を直した（平方根の商・単調性を定めるブロックが本文に無いので、√(q²+1) = W/δ を平方根の一意性から、√(y²+1) ≤ y + 1/(2y) を (y+s)(s-y) = 1 から、√(δ²+a²π²/4) > aπ/2 を背理法の鎖で示した。
  ラベルの無かった log の積の法則と log(1+x) ≤ x を主張にし、arcsinh の下からの評価・F(0) = 0・導関数の連続性を書き、3/2 乗を定義した）。
  下流（`sine_integral_two_sided` の 2 箇所、`second_derivative_log_divergence`、注記 `remark_real_analysis_facts_R3_R4`）の参照と Lean のコメント・`lean/docs/ch020-formalization.md` を新しいラベルに付け替えた（Lean の証明は変えていない）。計算の誤りは無かった。

- `sine_integral_two_sided`（2 log(π/δ) ≤ ∫_0^π dθ/√(δ²+sin²(θ/2)) ≤ 2 log(π/δ) + 2δ²/π² + B）: 主張の中で置いていた B の定義と B ≤ 0.88 を、定義 `def_sine_integral_constant`・主張 `sine_integral_constant_numerical_bound` へ分け、平方根どうしの大小の根拠として主張 `nonnegative_real_order_from_squares`（u, v ≥ 0 で u² ≤ v² なら u ≤ v）を足した（`020_critical_point.ts`）。3 個の主張に同名の検算を付けた。
  等号と不等号の差の因数分解は QQ[u,v]・QQ[c]・有理関数体・D1²・D2² の関係式のイデアルで厳密に、各点の大小は sin を AA で厳密に・π をボールで、積分は Arb の厳密な数値積分で確かめた。
  人手証明を直した（本文に無い平方根の単調性に頼っていた D2 ≤ D1・D1 ≥ p・D2 ≥ c0 p・分母 ≥ δ を新しい主張から、0 ≤ c0 p ≤ s・被積分関数の連続性・F(θ) = θ²/2 の導関数を準備に、各点評価と B の数値評価を 1 行 1 操作の鎖に、逆数の大小を独立の鎖に）。
  「これが対数発散の源である」の段落は解釈なので注記へ移した。下流 `second_derivative_log_divergence` の B と 0.88 の行に新しいラベルの参照を足した。計算の誤りは無かった。

- `sigma_z_diagonal_action`（σ_m^z の基底 f_{ι(μ)} への作用。固有ベクトルの等式・積の等式・二つの対角性の 4 つの主張を束ねていたブロック）: 1 ブロック 1 主張に分け、`sigma_z_diagonal_action`（`σ_m^z f_{ι(μ)} = μ(m)_C f_{ι(μ)}`）・`sigma_z_product_action`・`site_sigma_z_is_diagonal`・`site_sigma_z_product_is_diagonal` にした（`partition_function_transfer_matrix_representation.ts`）。
  定義 `def_diagonal_matrix`（`004_transfer_matrix.ts`。`exp_of_diagonal_matrix` の括弧書きを置き換えた）・`def_finite_product_of_complex_numbers` と、主張 `finite_product_with_zero_factor_is_zero`・`finite_product_of_complex_ones`・`finite_sum_with_single_nonzero_term`（`000_calculation_formulae_20_29.ts`）・`real_inclusion_preserves_product`（`000_calculation_formulae_00_09.ts`）・`config_basis_vector_own_component`（`(f_I)_{ν(I)} = 1`）・`site_sigma_z_product_diagonal_entry`（`(σ_m^zσ_{m'}^z)_{kk} = μ(m)_C μ(m')_C`）を足した。10 個の主張に同名の検算を付けた（共通の準備 `sagemath/_shared/site_sigma_z_kronecker.sage`。すべて `ZZ`・`QQ[…]`・`QQ(i)` で厳密）。
  人手証明を直した: スカラーを `inclusion_rr_to_cc` の `μ(m)_C` と書き、場合分けを (∵) 付きの鎖に、ラベルの無かった根拠（行列と列ベクトルの積・恒等行列の作用・行列作用の線型性・スカラー倍の結合律）をラベル参照に。旧い「基底 (f_I) に関して対角行列」は f_I の成分を経ずに成分の意味の対角性へ渡していたので、クロネッカー積の成分（0 の因子）と積の成分の和から示す形にした。
  主張を分けたのに合わせ、下流 `first_transfer_matrix_pauli_form` の前半を、`D` の非対角成分・対角成分・`K_1 D` の成分の鎖に書き直し（`D f_{ι(μ)}` の固有ベクトルの鎖は外した）、成分の一致の鎖に `exp((K_1)_C d(μ)_C) = exp((K_1 d(μ))_C) = (exp(K_1 d(μ)))_C` の 2 行を足した。その検算（`check_D_entries_chain.sage`・`check_exp_inclusion_lines.sage`）を足し、旧 `check_bond_sum_diagonal_action.sage` を置き換え、`__file__` を使っていた読み込みを相対パスに直した。`thermodynamic_limit_column_limit_and_closed_form.ts` の Step 1 の参照を新しい主張へ付け替えた。計算の誤りは無かった。

- `def_positive_coupling_tanh`・`def_real_logarithm_positive`・`def_first_dual_coupling_constant`・`def_second_dual_coupling_constant`（正の結合定数の tanh・正の実数上の実対数・二つの双対結合定数）: 実対数の定義が「定義・log の狭義単調増加（証明なし）・0<y<1 なら log y<0」を束ねていたので、1 ブロック 1 主張に分け、主張 `real_log_strictly_increasing`（exp の狭義単調増加からの背理法の証明を付けた）・`real_log_negative_below_one` を置いた（`partition_function_transfer_matrix_representation.ts`）。
  tanh・二つの双対結合定数・新しい二つの主張に同名の検算を付けた（共通の準備 `sagemath/_shared/positive_coupling_and_real_log.sage`）。等号は `QQ(E)`（E は exp(K) の値の不定元）と `K = log q` の点の `QQ` で厳密に、`K ∈ QQ` の点は本文の exp の部分和のボールで、実対数の値は 2 進の有理数の端点 lo<hi で挟み `exp(lo) < y < exp(hi)` を本文の exp のボールで確かめて判定した。
  双対結合定数の「log(tanh K)<0」と、log の単調性を def_real_logarithm_positive から引いていた 3 か所（`eigenvalue_problem_diagonalization_and_exponential_form.ts` の arccosh ≥ 0、`020_critical_point.ts` の arcsinh の log 評価の 2 行）を新しい主張の参照へ付け替えた。tanh の値域と K^*>0 は定義が終域として宣言しているので、定義の中の証明のまま残した。計算の誤りは無かった。

- `two_by_two_transfer_identity`（2×2 の転送行列の恒等式 `A = (2s_2)^{1/2} exp(K_2^*σ^x)`）: `sagemath/check/two_by_two_transfer_identity/`。冪・各項の成分・部分和の行は
  `GAUSSIAN[τ]` の行列で、包含 `a ↦ a_C` は `QQ[τ] → GAUSSIAN[τ]` の環準同型として、双曲線関数の行は `QQ(E)` と `K_2 = log x` の点の `AA` で厳密に、
  極限・実対数・exp の値の行は本文の exp の部分和のボールで確かめた。人手証明の誤りを直した: 倍角公式とテイラー展開の根拠が `cosh_sinh_basic_properties` を
  引いていた（そこには無い）。倍角公式は `sinh_double_angle_formula` へ付け替え、テイラー展開（本文の `sinh_cosh_taylor_series` には証明が無い）には頼らず、
  部分和の成分を `(E_N(τ)±E_N(-τ))/2` で書いて `scalar_exp_is_limit_of_partial_sums` と三角不等式で極限を取る形にした。本文に無い行列の冪の指数法則・
  非負実数の平方根の積の法則を、冪の定義による帰納法と二乗の比較に置き換えた。`t` を二つの意味に使っていたのを直し、実数のスカラー倍を `a_C` と明示した。
  計算の誤りは無かった。

- `first_dual_coupling_relation`（第一の結合定数と双対結合定数の双対関係 `sinh(2K_1)sinh(2K_1^*) = 1`）: `sagemath/check/first_dual_coupling_relation/`。等号の行は、証明に現れる実数（`exp(±K_1)`・`tanh K_1`・`exp(±2K_1^*)` など）を独立な不定元に置いた有理関数体で、
  各行の差がその行の根拠の関係だけを代入して 0 になることで厳密に確かめ（代入しなければ一致しないことも見る）、代入した exp の関係は形式冪級数で、大小の行と主張は `K_1 = log q` の点の `QQ` と `K_1 ∈ QQ` の点の本文の exp のボールで確かめた。
  レビューの指摘で人手証明の根拠の欠けを直した: `exp(-log tanh K_1)tanh K_1 = 1` の行は `exp(log y) = y` だけを根拠に書き、直前の独立の鎖 `exp(-L)exp(L) = exp(0) = 1` を引いていなかったので、`exp(-L)tanh K_1` から始まる一本の鎖にまとめた。計算の誤りは無かった。

- `epsilon_projector_properties`（`P^{(+)} = (1/2)(I + ε)` の冪等性と、像が `F^{(+)} = {f | εf = f}` に等しいこと）: `sagemath/check/epsilon_projector_properties/`。ε と `P^{(+)}` を本文の定め方（成分の式のクロネッカー積と積）と Sage 組み込みの二経路で作り、四つの鎖の全行を `QQ` 上の多項式環の不定元のベクトルで、`M_col = 1,…,5` で厳密に確かめた。ε を不定元の行列に、`f` を任意のベクトルに置き換えて、`ε^2 = I` と仮定 `εf = f` をそれぞれ一行だけが使っていることを差の形で確かめた。主張 (2) は `P` の列空間と `ε - I` の核の `QQ` 上の一致で確かめた。
  レビューの指摘で人手証明を直した（分配法則と単位行列を一行に束ねた行、スカラー倍の出し入れ・結合法則を根拠なしで行っていた行、`P(Px) = (P^2)x` で結合法則を引いていなかった行、`(I+ε)+(ε+I) = 2I+2ε` の行を、`002_linear_space_general.ts` の行列の演算の主張を引く一行一操作に分けた。`X^2 := XX` を主張に、スカラーが `inclusion_rr_to_cc` による ℂ の元であることを証明の冒頭に置き、数の積の行に `real_inclusion_preserves_product` を引いた）。計算の誤りは無かった。Lean の具体版 `ClaimEpsilonProjectors.lean` は人手の新しい行の並びとまだ 1 行ずつは対応していない（Lean の連続実行の受け持ち）。

- `epsilon_commutes_with_transfer_matrices`（ε は V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2} と可換。四つの主張と、下流が「Step 1」「Step 3」と番号で引く関係を束ねていた）: 1 ブロック 1 主張に分け、ラベルを消した。
  一般の主張 `matrix_equals_negation_if_sum_is_zero`・`product_of_anticommuting_matrices_commutes`・`commuting_with_scalar_multiple`・`commuting_with_finite_sum`・`commuting_with_difference`（`002_linear_space_general.ts`）、`commuting_matrix_commutes_with_exp`（`003_exp_linear_map.ts`。可換なら冪・部分和・極限とも可換を、散文 4 回から一つの主張へ）、`tensor_commutation_from_all_sites`（`006_Z_Y_anticommutation.ts`）、
  `site_pauli_prefix_product_kronecker_form`・`global_spin_flip_kronecker_form`・`epsilon_commutes_with_site_sigma_x`・`epsilon_anticommutes_with_site_sigma_z`・`epsilon_anticommutes_with_site_sigma_y`・`epsilon_anticommutes_with_jordan_wigner_Z`・`epsilon_anticommutes_with_jordan_wigner_Y`（`def_global_spin_flip_matrix` の後）、
  `epsilon_commutes_with_bond_sum`・`epsilon_commutes_with_V1`・`epsilon_commutes_with_V2`・`epsilon_commutes_with_H1_plus`・`epsilon_commutes_with_V1_plus`・`epsilon_commutes_with_V1_plus_square_root`（旧ブロックの位置）の 20 個の主張を置き、それぞれに同名の検算を付けた（共通の準備 `sagemath/_shared/pauli_sites_exact.sage`）。
  鎖は `QQ(i)` 上の不定元と具体の Pauli 行列で厳密に、仮定を外した対照でその行だけが崩れることを確かめ、exp を含む行だけを本文の部分和と尾の上界のボールで、V_1・V_2 の主張は成分の式の exp の値を不定元に置いて厳密に確かめた。
  人手証明の欠けを直した（ε・Z_m・Y_m のクロネッカー積表示を根拠なしで使っていた、相異なるサイトの可換性・スカラー倍との可換性・有限和への分配・冪と極限との交換を散文で済ませていた、反可換性を二回使う段を (-1)^2 の一行に束ねていた）。
  下流（`epsilon_projectors_commute_with_transfer_matrices`・`epsilon_commutes_with_W`・`eigenvalue_problem_eigenvector_of_max_eigenvalue.ts` の 3 か所・Lean のコメントと `lean/docs/ch010-formalization.md`・043 の検算の説明）の参照を新しいラベルに付け替えた。計算の誤りは無かった。Lean の具体版 `ClaimEpsilonCommutes.lean` は分けた主張と 1 対 1 ではない（Lean の連続実行の受け持ち）。

- `epsilon_projectors_commute_with_transfer_matrices`（P^{(+)} は V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2} と可換。四つの主張を束ねていた）: 1 ブロック 1 主張に分け、ラベルを消した。
  一般の主張 `epsilon_projector_commutes_with_epsilon_commuting_matrix`（εX = Xε なら P^{(+)}X = XP^{(+)}）と、その適用 `epsilon_projector_commutes_with_V1`・`epsilon_projector_commutes_with_V2`・`epsilon_projector_commutes_with_V1_plus`・`epsilon_projector_commutes_with_V1_plus_square_root` の 5 個の主張にし、それぞれに同名の検算を付けた（共通の準備 `sagemath/_shared/epsilon_projector_exact.sage`）。
  一般の主張の 9 行の鎖は `QQ(i)` 上の不定元の行列 X := Y + εYε で厳密に（仮定を外すと第 5→6 行だけが崩れる）、主張は ε と可換な行列の空間の基底で、V_1・V_2 は成分の exp の値を不定元に置いて厳密に、V_1^{(+)} と平方根は exp を本文の部分和と尾の上界のボールで確かめた。
  人手証明を直した（「分配法則」「IX = X」「X = XI」「分配法則とスカラー倍との可換性」を `002_linear_space_general.ts` の主張の参照の一行一操作に、1/2 が `inclusion_rr_to_cc` の ℂ の元であることを明記）。下流 `symmetrized_transfer_matrix_on_sectors` の 5 か所・不採用のノート `minus_sector_not_adopted.ts` の 2 か所・Lean のコメントと `lean/README.md`・`lean/docs/ch010-formalization.md`・043 の検算の説明を新しいラベルに付け替えた。計算の誤りは無かった。Lean の具体版 `commute_epsProjPlus_of_commute_epsilon` は人手の 9 行の鎖と 1 対 1 ではない（Lean の連続実行の受け持ち）。

- `symmetrized_transfer_matrix_on_sectors`（`W P^{(+)} = V^{(+)} P^{(+)}`）: `sagemath/check/symmetrized_transfer_matrix_on_sectors/`。証明の三つの鎖（f ∈ F^{(+)} で `Bf = Cf` の 9 等号、`end(BP)(x) = ⋯ = end(CP)(x)` の 5 等号、`WP = ⋯ = V^{(+)}P` の 16 等号）を一行ずつ確かめた。
  `Bf = Cf` は exp の値だけを本文の部分和と尾の上界のボールで、定義と和の形の行は `QQ(i)` で厳密に（first_transfer_matrix_pauli_form の行は exp((1/2)K_1 n) を不定元の冪に置いて厳密に）、end は def_end_iso の文言どおりに組んだ写像で計算した。
  後の二つの鎖は、仮定（`Bf = Cf`、`BP = CP`・`PC = CP`・`PV_2 = V_2P`）を満たす一般の組（不定元の行列、M_col = 3, 4 は `QQ(i)` の乱数）で厳密に確かめ、仮定を一つずつ外すとその仮定を引く行だけが崩れることを見た。主張は本文の行列のボールで確かめた。
  人手証明を直した: 主張に `M_col ≥ 2`・`K_1, K_2 > 0` を書いた。散文の「K_1/2 を代入すると Bf = Cf」を、結合定数 (1/2)K_1 の `V_1'` を置いた一行一操作の鎖にした。「すべての数ベクトルへの作用が等しいため BP = CP」は、`end_is_algebra_isomorphism` (1) の単射性から示す形にした。ラベルの無かった「行列積の結合則」は `mat_mult_associative` の参照にした。
  `def_symmetrized_transfer_matrix` と `def_V_plus` の三つの行列の積に括弧を明示し、`WP` の鎖を括弧どおりの 16 等号にした。044 の九本の浮動小数点の行単位検査は、証明の行が変わったので削除した。計算の誤りは無かった。Lean の具体版 `Ising2D.symmetrized_transfer_matrix_on_sectors`（`PhysicalSymTransferBridge.lean`）は旧い九段の形のままで、新しい鎖（end を通す段・16 等号）と 1 対 1 ではない（Lean の連続実行の受け持ち）。

- `antiperiodic_exp_sum`（半整数運動量 θ̃_μ の指数和）: `sagemath/check/antiperiodic_exp_sum/`。exp(i(2πq)_C)（q ∈ `QQ`）を 1 の冪根として `UniversalCyclotomicField` で持ち、証明の全ての鎖（像の 6 行、k_R θ̃_μ の 6 等号は π を不定元にして、S の書き換え、T_{2M,k} の 9 等号、exp_sum の適用、偶数・奇数・非整除の鎖、「とくに」の背理法の鎖）を M_col = 2..8、k = -3M..3M で厳密に確かめた。1 の冪根が本文の exp の値であることと主張は、本文の exp の部分和と尾の上界のボールで確かめた。
  レビューの指摘で人手証明を直した: 主張の左辺と S を結ぶ散文を鎖に、θ̃ の鎖・奇偶の分割・約分・偶数と奇数の場合の差の行を一行一操作に、非整除の段の散文を 7 等号の鎖に、δ の値に `def_delta_M` と `(2(M)_N)_Z = 2M_col` を根拠として挙げ、`2_R`・`1_C` の添字をそろえ、`real_inclusion_preserves_product`・`def_complex_difference`・`multiply_by_minus_one` を引いた。計算の誤りは無かった。

- `half_integer_phase_antiperiodicity`・`half_integer_checkZ_periodicity`・`half_integer_checkY_periodicity`（θ̃_μ の反周期性 `exp(-i((M_col)_R θ̃_μ)_C) = -1_C` と、Ž・Y̌ の添字周期性）: 二つの周期性の証明が同じ二つの鎖を重複して持っていたので、係数の一致を新しい主張 `half_integer_phase_periodicity`（`exp(-i(j_R θ̃_{μ+M})_C) = exp(-i(j_R θ̃_μ)_C)`）に切り出した。
  三つの主張が「euler_formula_cos_sin の証明冒頭で導いた exp(-ix) = cos x - i sin x」（証明の中の式でラベルが無い）を根拠にしていたので、`euler_formula_cos_sin` の主張から導く新しい主張 `exp_of_negative_i_real_as_cos_minus_i_sin` を `000_calculation_formulae_30_44.ts` の末尾に置いた。5 個の主張に同名の検算を付けた（共通の準備 `sagemath/_shared/half_integer_phase_exact.sage`）。
  角度の鎖は π を不定元にした有理関数体で、exp と cos・sin の鎖は 1 の冪根と AA で厳密に組んだ。ただしその `QQbar` の比較は 1 の冪根の表し方で自明に成り立つので、周期性・偶奇性・特殊値の行は Arb の cos・sin で、exp と cos・sin を結ぶ行と主張は本文の exp の部分和と尾の上界のボールで確かめた（各 overview に自明な比較を明記）。Ž・Y̌ は Jordan–Wigner 行列を円分体の行列で組んで比べた。
  人手証明を直した: 実数・複素数に像の記号を付け、θ̃ の定義の式から角度の鎖を始め、`cos(2πμ-π) = -1` と `sin(2πμ-π) = 0` を一行に束ねていたのを周期性・偶奇性・特殊値の一行一操作に、`-1_C` までを差の定義・`multiply_by_minus_one`・体の公理の鎖にした。全実数上の cos・sin（`def_sin`・`def_cos` は [-π/2, π/2] だけ）の性質に依ることを三つの主張に書いた。計算の誤りは無かった。Lean の `DefinitionHalfIntegerModes.lean` は旧い証明の形のままで、新しい鎖と 1 対 1 ではない（Lean の連続実行の受け持ち）。

- `V1_plus_half_invertible`・`V2_invertible`・`V_plus_factors_invertible`（(V_1^{(+)})^{1/2}・V_2・V^{(+)} の可逆性）: `sagemath/check/<ラベル>/`（共通の準備 `sagemath/_shared/transfer_matrix_factor_inverses.sage`）。
  K_1 = 2 log y・K_2 = log x と選ぶと、iH_1^{(+)}・iH_2 が整数の固有値をもつ整数行列なので exp(±X)・exp(±Y) が固有値の射影の和として `QQ`・`AA` に乗り、V_2 も成分の定義で `QQ` に乗る。三つの証明の全行と主張をこれで厳密に確かめ、本文の部分和の exp のボールの検算を補助に置いた。包含 a_ℂ の行は ℂ を実数の対で持つ `complex_as_real_pairs.sage` で確かめた。
  人手証明を直した: `V1_plus_half_invertible` の鎖が逆元 `((V_1^{(+)})^{1/2})^{-1}` から始めて可逆性を前提にしていたのを、`def_invertible_elements_of_R` の定義の h = exp(-X) を両側から掛けて I に着く二つの鎖（`exp_of_negative_is_left_inverse`・`matrix_double_negation`）にした。`V2_invertible` は `(2s_2)^{M/2}I·exp(...)` とスカラー倍を単位行列との積に読み替えていたのを、`V_plus_is_invertible` と同じ係数を出す鎖にし、a > 0 を `def_second_transfer_matrix_prefactor` から引いた。`V_plus_factors_invertible` の末尾の参照の一覧を各行の根拠へ移した。K_1・K_2^*・a は `inclusion_rr_to_cc` の像として書いた。計算の誤りは無かった。Lean の `DefinitionVPlus.lean` の `isUnit_V1plusHalf`・`isUnit_V2`・`isUnit_VPlus` は単元を渡すだけの形で、新しい鎖と 1 対 1 ではない（Lean の連続実行の受け持ち）。

## 次の一歩

`eigenvalue_problem_reduction_to_A_theta.ts` の `T_V_plus_is_conjugation`（`--list` の先頭）から、文書順に検算を足す。

番号付きの古い検算のディレクトリ（`043_…`・`044_…` など 90 余り）は、`_prelude.sage` を `__file__` から作ったパスで読み込んでおり、この VM の SageMath 10.9 で `run-all-checks.sh` から走らせると `__file__` が Sage 本体のファイルを指して読み込みに失敗する（2026-11-02 に `043_claim_transfer_matrix_bridge`・`044_claim_max_eigenvalue` で確かめた）。新しい検算は相対パスの `load("_prelude.sage")` を使っているので影響を受けない。直すには、各ディレクトリの読み込みを相対パスにする。これはゴールラインの判定（足した検算が通ること）の外なので、この連続実行では扱わない。

## 検算で見つかった本文の誤り

- 2026-11-02、`V2_invertible` のレビューで見つかった（暗黙の包含）: `def_V1_plus_square_root`・`V2_exponential_representation` は `K_1, K_2^*, s_2 ∈ ℝ_{>0} ⊂ ℂ` と書き、実数を包含の像を書かずに ℂ の係数として掛けている（係数 `(2s_2)^{M_col/2}` も同じ）。この単位では使う側の証明で `(K_1)_ℂ`・`(K_2^*)_ℂ`・`a_ℂ` と読み替える行を置いた。定義の側を像の記号で書き直すのは、検算の付いたブロックの見直しで扱う。

- 2026-11-02、`half_integer_phase_antiperiodicity` の検算で見つかった（表記の揺れと未整備の前提）: 主張を `exp(-i((M_col)_R θ̃_μ)_C) = -1_C` と像の記号付きに直したが、下流の `nesting_of_commutator_of_H_and_check_Z` などは旧い `exp(-iM_col θ̃_μ) = -1` の形で引いている。下流の検算を足すときに表記をそろえる。また全実数上の cos・sin（2π 周期性・偶奇性・cos π・sin π）と Euler の公式は本文に無く、`euler_formula_cos_sin`・`exp_sum`・この単位の三つの主張がそれを前提にしている。直すには、計算公式の章に全実数上の cos・sin の定義とこれらの性質の主張を置く。

- 2026-11-02、`antiperiodic_exp_sum` のレビューで見つかった（記号の省略）: `exp_sum` の主張は `exp(2πijk/M_col) = M_col δ` と像の記号を省いて書いており、`antiperiodic_exp_sum` は適用の前に読み方を地の文で述べて引いている。`def_delta_M` も写像を `δ^{M_col}`、値を `δ^{(M_col)}` と書き分けが混在し、値の `1`・`0` を `1_C`・`0_C` と書かず、自然数 M_col による整数の合同を ℤ への像を書かずに使っている。どちらも既に検算が付いたブロックなので、この単位では直さず、検算の付いたブロックの見直しで扱う。

- 2026-11-02、`symmetrized_transfer_matrix_on_sectors` の検算で見つかった（括弧の無い積）: `def_symmetrized_transfer_matrix` と `def_V_plus` の定義に積の括弧を明示した。しかし、ほかのブロックは括弧を省いた `V_1^{1/2}V_2V_1^{1/2}`・`BV_2B` を、結合律を引かずに使っている（`thermodynamic_limit_column_limit_and_closed_form.ts` の `εW = Wε` の鎖、`thermodynamic_limit_row_limit_and_max_eigenvalue.ts` の `W = BV_2B`、`V_plus_exponential_form` の鎖など）。定義のブロックには「括弧によらず同じ行列なので省いて書く」と書いたが、各鎖の括弧の付け替えは、それぞれのブロックの検算を足すときに扱う。

- 2026-11-02、`epsilon_commutes_with_transfer_matrices` の分割で見つかった（重複）: `V1_in_Z_Y_epsilon` の証明 Step 1 は、新しい主張 `site_pauli_prefix_product_kronecker_form` と同じ帰納法を証明の中で示し直している。`V1_restriction_to_eigenspaces` の証明 Step 1・Step 2 も、`epsilon_anticommutes_with_jordan_wigner_Z`・`_Y`・`product_of_anticommuting_matrices_commutes` と同じ内容を散文と未ラベルの根拠で示している。どちらも既に検算が付いているので、この単位では書き換えず、新しい主張を引く形への置き換えは検算の付いたブロックの見直しで扱う。

- 2026-11-02、`epsilon_projector_properties` のレビューで見つかった（未定義の表記と同一視）: 行列の二乗 `X^2` を定めるブロックが本文に無く、`epsilon_square_and_eigenvalues` の `ε^2` などが定義なしで使っている（このブロックでは主張の中で `X^2 := XX` と書いた）。直すには `002_linear_space_general.ts` に行列の冪の定義を置き、使う側から引く。また (⊇) の鎖は `Mat(n,1,ℂ)` についての主張を `f ∈ ℂ^n` にそのまま当てており、`mat_mult` の「n 行 1 列の行列とみなし」（`mat_columnwise` の項の同一視の課題）に依存する。

- 2026-11-02、`first_dual_coupling_relation` のレビューで見つかった（根拠の欠け）: 同じ形の `second_dual_coupling_relation`（第二の双対関係）の証明も、
  `exp(-log tanh K_2)tanh K_2 = 1` の行が `exp(log y) = y` だけを根拠にし、直前の独立の鎖 `exp(-L)exp(L) = exp(0) = 1` を引いていない。
  第一の双対関係と同じく一本の鎖にまとめれば直る。その検算 `sagemath/check/second_dual_coupling_relation/` は各行を 200 bit の浮動小数点で比べており、
  厳密計算を優先する規律にも合わない。この単位では直さなかった。検算の付いたブロックの見直しで扱う。
- 2026-11-01、`mat_columnwise` のレビューで見つかった（計算の誤りではなく「同一視をしない」規律への違反）:
  行列の積の定義（`mat_mult`）は「数ベクトルは n 行 1 列の行列とみなし」と書き、正定値行列の定義
  （`def_hermitian_positive_definite`）も「1×1 行列を ℂ と同一視する」と書いている。ベクトルの転置 `x^⊤`・
  共役転置 `x^*` は本文で定義されておらず、`psd_cauchy_schwarz`・`exp_hermitian_is_positive_definite`・
  熱力学極限の二つのファイルの `x^⊤Px`・`x^*Ax` が約 60 箇所これに依存する。`mat_mult` から同一視だけを
  削ると依存先の根拠が無くなるので、この単位では直さなかった。直すには、ベクトルと n×1 行列・1×1 行列と ℂ の
  間の写像に名前を付けて定義するか、双線型形式 `x^⊤Py := Σ x_k P_{kl} y_l` を定義して依存先を書き換える。
  依存先のブロックの検算を足すときに合わせて扱う。
- 2026-11-01、`arctan_argument_in_unit_interval` のレビューで見つかった（計算の誤りではなく未定義の概念）:
  実数の絶対値 `|q|` を定義するブロックが本文に無い。本文にある絶対値の定義は複素数の絶対値と偏角（`def_abs_arg`、
  `000_calculation_formulae_30_44.ts`）だけで、しかも後ろにある。`arctan_argument_in_unit_interval` の根拠
  （絶対値の二乗・商・`q ≤ |q|`）と `arcsin_is_bijection` の連続性の証明（`|y-y_0|<δ`）がこれに依存する。
  直すには、計算公式の章の前の方に `|q| := max(q,-q)` の定義と、使う性質の主張を置き、依存先から引く。この単位では直さなかった。
- 2026-11-01、`multiplicative_group_of_polar_representation` のレビューで見つかった（根拠の欠け）: `isomorphism_of_phi_cartesian`（φ_cartesian の同型性）は、
  極座標表現がモノイドであること（`monoid_of_polar_representation`）を引かずに「モノイド準同型」と述べている。この単位では直さず、
  そのブロックの検算を足すときに扱う。
  同じレビューで、もう一つ欠けが見つかった。`isomorphism_of_phi_cartesian` の主張は、積を保つことと全単射であることの二つだけで、
  単位元を保つこと（`φ_cartesian([(1,0)]) = 1_C`）を述べていない。「全単射なモノイド準同型の逆写像はモノイド準同型で、単位元を単位元へ写す」という一般論も、本文には無い。
  それなのに、`arg_of_quotient_of_complex_numbers` と、`1/z` の偏角の主張の「第一に」「第二に」の段は、この一般論を根拠にしている。
  直し方は、`φ_polar(1_C)` を `def_phi_polar` から直接 `[(1, arctan 0)] = [(1,0)]` と計算することである。
  同じ形の計算は `000_calculation_formulae_30_44.ts` の 2595 行付近にある。これらのブロックの検算を足すときに扱う。
- 2026-11-01、`sqrt_squared_is_original` のレビューで見つかった（根拠の取り違えと未証明の主張）:
  `isomorphism_of_phi_cartesian` の主張の「φ_cartesian は全単射」は、単射性が証明されていない（証明は合成が恒等写像であること、
  すなわち全射までしか示さない）。`000_calculation_formulae_30_44.ts` の偏角の公式の五つの証明は「全単射なモノイド準同型の逆写像」
  として φ_polar が積を保つことを導いており、この未証明の単射性に依存する。また同じファイルの四箇所（「φ_polar が積を保つこと」の行）
  は、φ_cartesian が積を保つことを述べる `isomorphism_of_phi_cartesian` を根拠に引いている。直すには、φ_polar ∘ φ_cartesian = id
  （単射性）を示す主張を置くか、φ_polar が積を保つことを独立の主張にして引き直す。この単位では直さなかった。

- 2026-11-01、`kronecker_transpose` のレビューで見つかった（根拠の欠け）: 転置を定めるブロックが本文に無かったので `def_matrix_transpose` を足したが、
  ほかの章の転置はまだそれを引いていない（`thermodynamic_limit_row_limit_and_max_eigenvalue.ts` の `B^⊤`・`x^⊤`、
  `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `(σ^y)^⊤ = -σ^y` と、根拠が文言だけのクロネッカー積の転置の式）。
  `thermodynamic_limit_row_limit_and_max_eigenvalue.ts` は「転置の積の法則 `(ABC)^⊤ = C^⊤B^⊤A^⊤`」を本文で証明されていない根拠として使っている。
  実ベクトル `x ∈ ℝ^d` の転置は、複素行列の転置として定めた `def_matrix_transpose` の対象外で、ℝ から ℂ への写像も置かれていない。
  `def_kronecker` の「I を ν(I) と同一視して使う」も「同一視をしない」の規律に反する。これらのブロックの検算を足すときに扱う。
- 2026-11-01、`scalar_exp_is_limit_of_partial_sums` などのレビューで見つかった（定義域の欠けと根拠の欠け）:
  行列の積の定義（`mat_mult`）は `Mat(m,n,ℂ)` についてだけ述べているが、`K = ℝ` の `Mat(n,K)` の積にも引かれている（数の exp の三つの証明、
  行列の exp の章の全体）。直すには、`mat_mult` を `K = ℝ` または `ℂ` について述べる。また `K` の列の極限の一意性を述べるブロックが無く、
  `real_exp_strictly_increasing` と `complex_exp_of_real_argument` がラベル無しで使っている。これらのブロックの検算を足すときに扱う（極限の一意性は、`real_exp_strictly_increasing`・`complex_exp_of_real_argument` とも 1 行 1 列の行列の極限の一意性を引く形に直して解消した）。
- 2026-11-01、同じレビューで見つかった（1 ブロック 1 主張との緊張）: `def_matrix_norm` は、数ベクトルと行列のノルム・行列の列の収束・級数の記法・
  `K^d` の列の収束・`K` の列の収束（この単位で足した）を一つのブロックに束ねている。分けるには、収束の定義をノルムの定義から別のブロックへ移し、
  引いている箇所のラベルを直す。この単位では分けなかった。
- 2026-11-01、`complex_exp_of_real_argument` のレビューで見つかった（未定義の演算）: ℂ の減法 `z - w` を定めるブロックが本文に無い。`multiply_by_minus_one` は記号 `-z := (-1_C)z` を定めるだけで、
  それが加法の逆元であることは `complex_numbers_form_a_field` の証明の中にしか書かれていない。行列の差 `A - B` と「行列の差は成分ごと」も本文に定義が無い。
  どちらも本文全体で使われている。直すには、`multiply_by_minus_one` の後に `z - w := z + (-w)` を、行列の和の定義の近くに `A - B := A + (-1)B` と成分の式を置き、依存先から引く。この単位では直さなかった。
- 2026-11-01、`exp_of_diagonal_matrix` の検算で見つかった（重複と、Lean との対応の欠け）: `real_exp_strictly_increasing` と `complex_exp_of_real_argument` は、数の列の極限の一意性を 1 行 1 列の行列を通してそれぞれの証明の中で示し直している。
  同じ事実を述べる `scalar_limit_is_unique` を足したので、二つの証明はそれを引く形に縮められる。この単位では直さなかった。
  また Lean の具体版 `lean/Ising2D/MathematicalTools/MatrixExponentialAndCommutators/ClaimExpOfDiagonalMatrix.lean` は mathlib の `Matrix.exp_diagonal` に委ねていて、人手証明（対角行列の積・冪の帰納法・部分和・極限の一意性）と 1 対 1 に対応していない。Lean の連続実行の状態台帳へ渡す。
- 2026-11-01、`end_preserves_matrix_exponential` のレビューで見つかった（記号の衝突と記法の欠け）: `def_end_iso` は「`Af` は以後つねに `(end(A))(f)` を意味する」と書き、`mat_mult` がすでに定めた積 `Af` の記号を定義し直している。
  二つが一致することは `end_agrees_with_matrix_vector_product` で示したが、`def_end_iso` の記法の文はそれを引いていない（主張が定義より後ろにあるため）。直すには、記法の文を `end_agrees_with_matrix_vector_product` の後へ移すか、記法を置かずに `(end(A))(f)` と書く。
  また `def_matrix_norm` は `lim` の記法を行列の列についてだけ定め、`K^d` の列は「同様に」としか書いていない。`mat_mult` は数ベクトルを「n 行 1 列の行列とみなし」ており、同一視をしない規律に反する。この単位では直さなかった（`end_preserves_matrix_exponential` の証明の冒頭で、`K^d` の列の極限の記法と一意性を書いて補った）。
- 2026-11-01、`def_invertible_elements_of_R` のレビューで見つかった（根拠の欠けと順序）: 単位行列・行列のスカラー倍・結合律・スカラー倍の性質のブロックを `002_linear_space_general.ts` の冒頭に足したが、
  ほかのブロックはまだそれを引いていない（
  `eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`・`thermodynamic_limit_row_limit_and_max_eigenvalue.ts` の散文の「結合法則」、`004_transfer_matrix.ts` がその場で定める `δ_{I,J}`）。`scalar_identity_commutes` の「スカラー倍は行列の積の外へ出せる」「単位行列の性質」は、2026-11-01 に Lean の通しの証明の連続実行がラベル参照へ直した。
  また `mat_conj`（`000_calculation_formulae_00_09.ts`）は行列のスカラー倍とその性質を使うが、定義は文書順で後ろの `002_linear_space_general.ts` にある。直すには、定義と性質を `mat_mult` の直後へ移すか、引く側を後ろへ移す。
  有限和の操作（分配律を項の数だけ繰り返す、和の順序の入れ替え、一つの項を分ける、空和）を述べるブロックも無く、足した主張の証明はこれらを体の公理を挙げた一行で使っている。
  `def_invertible_elements_of_R` は定義と逆元の一意性と (i)〜(iv) を一つのブロックに束ねている（下流が「(ii)」「(iv)」で引くので、分けるときは引く側も直す）。この単位では直さなかった。
- 2026-11-01、`trace_basic_properties` のレビューで見つかった（未定義の写像と根拠の取り違え）: 整数 `n` を ℂ の元として扱う写像（ℤ → ℝ）が本文に無い
  （`set_and_algebra_notation` は `𝐙` と `𝐑` を別の集合として置くだけ）。`trace_basic_properties` (3) は右辺を `Σ_{k=1}^{n} 1_C` に改めて避けたが、
  `eigenvalue_problem_eigenvalues_of_V_plus.ts` の `tr(I) = 2^{M_col}`（1298 行付近）はこの写像に頼っており、次の行の根拠「ℂ の四則」は ℤ の指数の計算である。
  `trace_of_idempotent` の Step 3 は「`P`（可逆）」と `P^{-1}` を未定義のまま使い、(4) を `P → P^{-1}`、`P' → P` と当てはめる形（`PP^{-1} = I` が要る）を根拠に書いていない。
  それぞれのブロックの検算を足すときに扱う。
  同じレビューで、Lean の具体版 `DefinitionTrace.lean` が人手証明と一対一でなくなったことが見つかった: `trace_one_eq_card` は `tr(I) = (card n : ℂ)`（人手は `Σ_{k=1}^{n} 1_C`）、
  `trace_conj` は `(P * A * Q).trace`（Lean では `(PA)Q`、人手は `P(AP')`）で、証明の手順も人手の 5 行と対応しない。Lean の連続実行の状態台帳へ渡す。
  (4) を括弧なしで引く下流（`trace_of_idempotent` の `tr(P^{-1}QP)`、`eigenvalue_problem_eigenvalues_of_V_plus.ts` の 2803 行付近）も、検算を足すときに括弧を書く。
- 2026-11-01、`trace_of_idempotent` の検算で見つかった（未定義の概念）: 次元 `dim_C`・基底・部分空間の直和と、「部分空間に基底が取れる」「直和の基底を合わせると全体の基底」
  「基底を列に並べた行列は `P'P = PP' = I` を満たす `P'` を持つ」を述べるブロックが本文に無い。`trace_of_idempotent` の Step 2・3、`004_transfer_matrix.ts` の `dim_C F = 2^M`、
  `002_linear_space_general.ts` の `tensor_basis` まわりの `dim_C Mat(2^M,C) = 4^M`、`eigenvalue_problem_eigenvalues_of_V_plus.ts`・`eigenvalue_problem_eigenvector_of_max_eigenvalue.ts` の
  `dim_C im Q̌_ε = 1` がこれに依存する。また自然数を ℂ の元として読む写像も無く、`trace_of_idempotent` の主張は「`1_C` をその個数だけ足した和として読む」と書いて避けた。
  下流の `dim im Q̌_ε = tr(Q̌_ε) = 1` から `dim = 1` を読むには、その和が `1_C` に等しい個数は 1 だけであること（ℕ から ℂ への単射性）が要る。この単位では直さなかった。
  Lean の具体版 `DefinitionTrace.lean` の `trace_of_idempotent` は mathlib の `IsIdempotentElem.isProj_range`・`LinearMap.IsProj.trace` に委ねていて、直した人手証明（準備・Step 1〜3 の鎖）と一対一でない。Lean の連続実行の状態台帳へ渡す。
- 2026-11-01、`star_preserves_norm_and_limits` の検算で見つかった（定義域の欠けと重複）: `star_preserves_norm_and_limits` (1) と共役転置（`def_hermitian_positive_definite`）は正方行列 `Mat(n,ℂ)` についてだけ述べているが、
  次の `exp_hermitian_is_positive_definite` の証明は「積の共役転置を `n × 1` 行列 `x` へ適用」と、`x^*` を n 行 1 列の行列の共役転置として使う（`def_hermitian_positive_definite` の「`n×1` 行列とみなす」「`1×1` 行列を ℂ と同一視する」も同一視をしない規律に反する）。そのブロックの検算を足すときに、共役転置を `Mat(m,p,ℂ)` に広げるか、`x^*Ax := Σ conj(x_k) A_kl x_l` を定義して扱う。
  `frobenius_inner_product_axioms` の証明冒頭は、足した `complex_conjugate_of_sum`・`complex_conjugate_of_product` と同じ計算を証明の中で示し直しており、それらを引く形に縮められる。この単位では直さなかった。
  Lean の `ClaimPositiveDefinite.lean` は `star_preserves_norm_and_limits` の (2)(3) を形式化せず mathlib の `Matrix.exp_conjTranspose` を使っていて、書き直した人手証明（(1) の第 2 式、(3) の準備の鎖）と足した 4 つの主張・2 つの定義に対応する Lean は無い。Lean の連続実行の状態台帳へ渡す。
- 2026-11-01、`exp_hermitian_is_positive_definite` の検算で見つかった（下流の依存と Lean との対応の欠け）: `x^*Ax` を成分の和で定める `def_conjugate_bilinear_value` を足したが、`psd_cauchy_schwarz`・熱力学極限の二つのファイルは、
  `x^*Ax`・`x^⊤Px` を行列の積として結合律で組み替えている。それらのブロックの検算を足すときに、`conjugate_bilinear_value_of_congruence` と同じ形の成分の鎖へ直す。
  Lean の `ClaimPositiveDefinite.lean` の `posDef_exp_of_isHermitian` は mathlib の `Matrix.PosDef.conjTranspose_mul_self` で示していて、書き換えた人手証明（`exp(S) = T^*(IT)`、合同変換の主張の `A = I`）と一対一でない。
  足した `congruence_preserves_positive_definite`・`identity_matrix_is_positive_definite`・`trace_of_positive_definite_is_positive`・`exp_of_negative_is_left_inverse`・`exp_of_hermitian_is_hermitian` と補助の 4 主張に対応する Lean の具体版は無い。Lean の連続実行の状態台帳へ渡す。
- 2026-11-01、`psd_cauchy_schwarz` のレビューで見つかった（下流の型の食い違いと読み方の食い違い）: 主張は `P ∈ Mat(n,ℝ)`・`x, y ∈ ℝ^n` を要求するが、
  `thermodynamic_limit_row_limit_and_max_eigenvalue.ts` は `P = W ∈ Mat(2^M,ℂ)`（成分が実数の値をとるだけ）や行列の積の値 `W^a x` をそのまま当てはめている。成分が実数の `Mat(n,ℂ)` から `Mat(n,ℝ)` への写像も、`ℂ^n` から `ℝ^n` への写像も本文に無い（`def_rayleigh_sup` の「実行列とみなせる」も同一視）。
  また `def_real_bilinear_value` は `x^⊤Py` を一つの記号として定めたが、下流は転置と行列の積として読んでいる（`(W^bx)^⊤W(W^ax) = x^⊤W^{a+b+1}x` を `(W^b)^⊤ = W^b` で導く段、`‖v‖² = v^⊤v`、879 行付近の「行列の積の成分表示」）。直すには、`(Bu)^⊤Pv = u^⊤(B^⊤P)v` のような `def_real_bilinear_value` と `mat_mult`・`def_matrix_transpose` を結ぶ主張が要る。
  `P = I` で当てはめる二箇所は、`I` が実数の行列として対称・半正定値であることと `y^⊤Ix = Σ y_k x_k` を示していない。これらのブロックの検算を足すときに扱う。
  Lean の具体版 `ClaimPsdCauchySchwarz.lean` は必要十分版からの一行の導出（`simpa`）で、直した人手証明（準備・展開・二つの場合）と 1 対 1 に対応しない。Lean の連続実行の状態台帳へ渡す。
- 2026-11-02、`riemann_sum_to_integral` の検算で見つかった（Lean との対応の欠けと下流の記述）: Lean の具体版 `TheoremRiemannSumToIntegral.lean` は `δ ∈ [0,1)`（人手は `[0,1]`）で、必要十分版 `NecSuf/RiemannSum.lean` の冒頭は人手の主張を「周期 `2π`」と書いているが、人手は周期性を仮定しない。直した人手証明（`ω(h)` の有界性の段、端点 `x_ν` の鎖）と 1 対 1 にも対応していない。Lean の連続実行の状態台帳へ渡す。
  `thermodynamic_limit_column_limit_and_closed_form.ts` の「積分について外部から持ち込む事実は (R1)(R2) の 2 つだけ」は、人手証明が使う `ℝ` の上限の存在とアルキメデス性を数えていない（積分についての事実ではないので矛盾ではないが、`ℝ` の性質の一覧としては欠ける）。この単位では直さなかった。
- 2026-11-02、`cosh_addition_and_half_angle` の分割で見つかった（文書順と未宣言の事実）: `def_arcsinh`・`sinh_of_arcsinh`・`remark_real_analysis_facts_R3_R4` の微分の公式は、文書順で後ろの
  `partition_function_transfer_matrix_representation.ts` にある実対数 `def_real_logarithm_positive` を引く（旧ブロックは log を参照なしで使っていたので表に出ていなかった）。
  組み直した章の並び（`tools/content-modules.ts` の `TRAILING_CONTENT_FILES`）を変えないため、この単位では動かさなかった。直すには、実対数の定義を `003_exp_linear_map.ts` の
  `real_exp_strictly_increasing` の後へ移す（依存は実数の exp の三つのブロックだけ）。目録の道具 `tools/build-flat-inventory.ts` には実対数を数学的道具立てとして登録した
  （この道具は origin/main の時点で、他の単位が足した項目について「数学的道具立てが2次元イジングモデルの項を前提にしています」で止まっている）。
  `elementary_sine_bounds`・`sine_integral_two_sided` は sin・cos の微分（`(cos t-1+t²/2)' = t-sin t` など）を使うが、微分の公式は sin・cos の導関数を宣言していない。次の単位で扱う。
  `second_derivative_log_divergence` の `δ ≤ sinh(1/4) ≤ 0.2527` の数値の上界には根拠が無い（旧 (5) からは `(1/4)cosh(1/4) ≈ 0.2579` までしか出ない）。そのブロックの検算を足すときに扱う。
  Lean の具体版 `ClaimCoshAdditionAndHalfAngle.lean`（mathlib の `Real.cosh_add` などへ委ねていて人手証明と 1 対 1 でない）と、`DefinitionKappaAndCritical.lean`・
  `ClaimCriticalPointSinhKcAndSecondDerivativeLogDivergence.lean`・`ClaimGammaDerivativesInKappa.lean`・`ClaimClosedFormLogIntegral.lean`・`NecSuf/HyperbolicBounds.lean`・`lean/docs/ch020-formalization.md` のコメントは、
  消えたラベル `cosh_addition_and_half_angle` の (1)〜(5) を指したままである。Lean の連続実行の状態台帳へ渡す。
- 2026-11-02、`elementary_sine_bounds` の分割で見つかった（外部の前提と Lean との対応）: 本文の sin・cos（弧の長さで定めた arcsin の逆関数）の導関数と π の数値は、本文では証明せず `remark_real_analysis_facts_R3_R4` で外部から持ち込んだ。本文の中で示すなら、arcsin の導関数と逆関数の微分から sin' = cos を導き、π の評価を折れ線の弧の長さから導く。
  `critical_point_and_log_divergence.ts` の `second_derivative_log_divergence` の `9.8696 ≤ π²`・`π ≤ 3.1416` は、まだ `pi_squared_numerical_bounds` と円周率の数値の評価を引いていない。そのブロックの検算を足すときに扱う。
  Lean の `ClaimElementarySineBounds.lean` と `lean/docs/ch020-formalization.md` は、`c0`・`c0_bounds`・`elementary_sine_bounds_linear` をラベル `elementary_sine_bounds` に対応づけたままで、実際の対応は `def_sine_bound_constant`・`sine_bound_constant_numerical_bounds`・`sine_half_angle_linear_bounds` である。`elementary_sine_bounds_cube` は下側 0 ≤ θ/2 - sin(θ/2) も述べるが、人手の主張は上側だけになった。足した主張（`sine_zero` から `sine_cubic_lower_bound` まで、`pi_squared_numerical_bounds`）に 1 対 1 の Lean は無く、今の Lean は mathlib の `Real.sin_le`・`Real.sin_ge_sub_cube` に委ねている。Lean の連続実行の状態台帳へ渡す。
- 2026-11-02、`sine_integral_two_sided` の分割で見つかった（Lean との対応）: Lean の具体版 `ClaimSineIntegralTwoSided.lean` は、各点評価を必要十分版の系と `nlinarith` で示しており、直した人手証明（`nonnegative_real_order_from_squares` を引く平方根の大小、差の各点評価の 12 行の鎖、分母の逆数の評価）と 1 対 1 に対応しない。`Bconst_le` も `nlinarith` で、`sine_integral_constant_numerical_bound` の鎖と対応しない。`nonnegative_real_order_from_squares` に対応する Lean は無い（コメントの対応づけだけ新しいラベルへ直した）。Lean の連続実行の状態台帳へ渡す。
- 2026-11-02、`sigma_z_diagonal_action` のレビューで見つかった（散文の推論と記号の帰属）: `thermodynamic_limit_column_limit_and_closed_form.ts` の Step 1 は「`D` は対角行列で対角成分は `(Σμμ)_C` なので `½K_1D` は対角」を散文で述べている（参照は新しい主張へ付け替えた）。
  `eigenvalue_problem_eigenvector_of_max_eigenvalue.ts` の `D0_G_diagonal_action` は、積の等式（`sigma_z_product_action`）を引かずに単サイトの作用を二回使って導き直しており、`mat_mult_associative` の行が無く、根拠の一つが `\blkref` でなく文字列、スカラーが `μ(m)`（`μ(m)_C` でない）。それぞれのブロックの検算を足すときに扱う。
- 2026-11-02、同じレビューで見つかった（定義の書き分けの欠け）: `def_transfer_matrix` の `V_1`・`V_2` の成分の `exp(K_1 Σ μμ)` が実数の exp の値なのか、その ℂ への包含なのかを書いていない（`V_1` は `Mat(2^{M_col},ℂ)` の元）。`first_transfer_matrix_pauli_form` の鎖は `(exp(K_1 d(μ)))_C` まで書いたが、最後の `δ_{μ=μ'} exp(K_1 Σ μμ)` の行は定義の書き方に従ったままである。`def_transfer_matrix` の検算を足すときに扱う。
- 2026-11-02、同じ作業で見つかった（検算の実行の方法）: 既存の検算のうち 94 ディレクトリ（`043_claim_transfer_matrix_bridge` ほか、番号付きのものの大半）は `_dir = os.path.dirname(os.path.abspath(__file__))` で準備を読み込んでおり、`bash sagemath/tools/run-all-checks.sh` から走らせると準備が見つからずに落ちる（SageMath は `__file__` を自分のパッケージの位置にする）。`first_transfer_matrix_pauli_form` だけは相対パスの `load("_prelude.sage")` に直した。ほかは手で `cd` して走らせた当時のログが残っている。ゴールラインの「足した検算が `run-all-checks.sh` で全部通る」は足した検算だけが対象なので妨げないが、まとめて相対パスに直すかを決める。
- 2026-11-02、同じレビューで見つかった（重複）: `complex_exp_of_real_argument` の証明の準備は、`real_inclusion_preserves_product`（この単位で足した）と同じ計算をラベル無しで書いている。そのブロックを直すときに引く形にする。
- 2026-11-02、`def_real_logarithm_positive` のレビューで見つかった（根拠の欠け）: `exp: ℝ → ℝ_{>0}` の全射性を「実解析の標準的な事実（連続性と中間値の定理）」として参照なしで使っており、log の定義の成立がこれに依る。
  外部の事実として注記（`remark_real_analysis_facts_R3_R4` と同じ形）に宣言するか、本文で示す。また `thermodynamic_limit_row_limit_and_max_eigenvalue.ts`（1047 行付近）・`thermodynamic_limit_column_limit_and_closed_form.ts`（855 行付近）・
  `critical_point_and_log_divergence.ts`（1628・1630・1652・2051・2214 行付近）が log の単調性をラベル参照なしで使っている。`real_log_strictly_increasing` を引く形に、それぞれのブロックの検算を足すときに直す。この単位では直さなかった。
- 2026-11-02、`two_by_two_transfer_identity` の検算で見つかった（根拠の欠けと、Lean との対応の欠け）: 下流 `second_transfer_matrix_pauli_form` の結論の鎖は、
  `kronecker_multilinear` でスカラーを前へ出した後の `((2s_2)^{1/2})_C` の `M_col` 乗を `((2s_2)^{1/2})^{M_col}` の像にする段に `real_inclusion_preserves_product` を引いておらず、
  主張の実数のスカラー倍・行列の実数の成分の読み方（`two_by_two_transfer_identity` の主張に書いた `a_C` の略記）も書いていない。書き直し前からの欠けで、そのブロックの検算を見直すときに扱う。
  本文の `sinh_cosh_taylor_series`（`008_TV1_hatZ_hatY_part1.ts`）は証明が無い（`--list` にも出ない）。実数の絶対値と三角不等式を定めるブロックも本文に無い（`two_by_two_transfer_identity` は「実数の絶対値の三角不等式」を高校の範囲として使った）。
  Lean の具体版 `ClaimTwoByTwoTransferIdentity.lean`（中間目標 `exp_smul_pauliX_eq_cosh_add_sinh`）は書き直し前の人手証明（冪の指数法則・級数の偶奇の分割）に対応していて、
  書き直した人手証明（`B_τ` の冪の帰納法・`(E_N(τ)±E_N(-τ))/2` と三角不等式による極限・`q/(2r)` の二乗の比較）と 1 対 1 でない。Lean の連続実行の状態台帳へ渡す。
