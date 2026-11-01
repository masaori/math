# 全ての証明に SageMath の検算を付ける — 状態台帳

手順は [sagemath-every-proof-runbook.md](sagemath-every-proof-runbook.md)。

## 現在地

2026-11-01: 証明を持つブロック 234 件のうち、SageMath の検算が無いもの 100 件（`node sagemath/tools/verify-every-proof-has-check.ts`）。

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

## 次の一歩

`009_eigenvalues_of_V.ts` の `star_preserves_norm_and_limits`（`--list` の先頭）から、文書順に検算を足す。

## 検算で見つかった本文の誤り

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
