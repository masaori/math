# 全ての証明に SageMath の検算を付ける — 状態台帳

手順は [sagemath-every-proof-runbook.md](sagemath-every-proof-runbook.md)。

## 現在地

2026-11-01: 証明を持つブロック 221 件のうち、SageMath の検算が無いもの 108 件（`node sagemath/tools/verify-every-proof-has-check.ts`）。

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

## 次の一歩

`003_exp_linear_map.ts` の `calc_formulae_000_cosh_sinh_product`（cosh・sinh の掛け算。ラベルなし。`--list` の先頭）から、文書順に検算を足す。

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
