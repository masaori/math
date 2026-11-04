# SageMath Check: 050_claim_even_sector_eigenvalues

## 対象

**対象ラベル**: `eigenvalues_of_V_plus` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`、`eigenvalue_problem_diagonalization_and_exponential_form.ts`（`def_check_number_operator`）
- 併せて検証（この章の全ブロック）:
  - `def_check_number_operator`（数演算子 `ň_μ := ψ̌_μ^† ψ̌_{1−μ}`）
  - `check_number_operator_idempotent`（証明の各行の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/check_number_operator_idempotent/` へ移した（旧い check_28 と check_23 の前半）。旧い名前との対応はその overview.md の「由来」にある。冪等性そのものの浮動小数点の確認は、ここの check_01）
  - `check_number_operators_commute`（証明の各行の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/check_number_operators_commute/` へ移した（旧い check_29 と check_23 の後半）。旧い名前との対応はその overview.md の「由来」にある。可換性そのものの浮動小数点の確認は、ここの check_01）
  - `trace_of_check_number_operator_product`（`tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M−k}`。証明の各行の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/trace_of_check_number_operator_product/` へ移した（旧い check_47）。旧い名前との対応はその overview.md の「由来」にある。ň のみの積のトレースの浮動小数点の確認は、ここの check_01）
  - `check_joint_eigenspace_decomposition`（`Q̌_ε`、**各同時固有空間は 1 次元**、`2^M` 個。証明の各行の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/check_joint_eigenspace_decomposition/` へ移した（旧い check_24・check_30〜36・check_48・check_joint_eigenspace_step5_direct_sum_first_line）。旧い名前との対応はその overview.md の「由来」にある。(1)〜(5) の浮動小数点の確認は、ここの check_02）
  - `eigenvalues_of_check_Vprime`（`V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`。証明の各行の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/eigenvalues_of_check_Vprime/` へ移した（旧い check_25・check_eigenvalues_of_check_Vprime_step1_left_chain・step1_right_chain・step3_partial_sum_chains・step3_limit_chains・step4_eigenvector_chain・positivity）。旧い名前との対応はその overview.md の「由来」にある。主張の浮動小数点の確認と縮退の組の記録は、ここの check_03）
  - `eigenvalues_of_inverse_of_check_Vprime`（`(V̌')^{-1}Q̌_ε = (exp(−ǧ(ε)))_ℂ Q̌_ε`。証明の 11 行の鎖の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/eigenvalues_of_inverse_of_check_Vprime/` へ移した（旧い check_eigenvalues_of_inverse_of_check_Vprime）。旧い名前との対応はその overview.md の「由来」にある）
  - `trace_of_check_Vprime`（`tr(V̌') = tr((V̌')^{−1}) = Π_μ 2cosh(γ(θ~_μ)/2) > 0`。証明の各行の検算は、2026-11-04 に専用のディレクトリ `sagemath/check/trace_of_check_Vprime/` へ移した（旧い check_trace_of_check_Vprime_step1_chain・step2_real_inclusion・step2_exp_product・step2_expansion・step2_cosh）。旧い名前との対応はその overview.md の「由来」にある。主張の浮動小数点の確認は、ここの check_04）
  - `V_plus_is_positive_definite`（`V^{(+)}` は正定値）
  - `V_plus_is_invertible`（明示した候補が `V^{(+)}` の右逆かつ左逆）
  - `V_plus_inverse_is_positive_definite`（`(V^{(+)})^{-1}` の正定値性。下の注を見よ）
  - `trace_V_plus_is_positive`（`tr(V^{(+)})` の正値性）
  - `V_plus_inverse_positive_and_trace_positivity`（`tr((V^{(+)})^{-1})` の正値性。下の注を見よ）
- 注: `V_plus_inverse_is_positive_definite` と `V_plus_inverse_positive_and_trace_positivity` は、どの章のゴールの主張からも
  使われないので、2026-10-31 に本文から参照用ノート `structured-latex/notes/claims_unused_by_chapter_goals_not_adopted.ts`
  へ退避した。それらの検算（check_05 の一部と check_V_plus_inverse_positive_definite）は記録として残す。
  - `constant_c_value_even_sector`（**`c = (2 sinh 2K_2)^{M/2}`**）
  - `eigenvalues_of_V_plus`（`Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(Σ_μ γ(θ~_μ)(ε_μ − 1/2))`）
  - `max_eigenvalue_of_V_plus_simple`（`Λ̌_max = Λ^{(1/2)}_M` であり**単純固有値**。(3) の左から `Q̌_{ε'}` を掛ける鎖は check_26、(1) の 4 行の鎖は check_max_eigenvalue_simple_step1_lambda_half_chain、(2) の `ǧ(1,…,1) − ǧ(ε)` と `Λ̌_ε` の鎖は check_max_eigenvalue_simple_step2_strict_inequality_chains、(3) の後半の差・割り算・項を消す・逆向きの鎖は check_max_eigenvalue_simple_step3_eigenspace_chains）
  - `iH_is_real_symmetric`（証明の各行の検算 11 本は、2026-11-03 に専用のディレクトリ `sagemath/check/iH_is_real_symmetric/` へ移した。旧い名前 check_22・check_37〜check_46 との対応はその overview.md の「由来」にある。実対称性そのものの数値の確認は、ここの check_05 の (a)）
  - `sign_flip_conjugation`（証明の各行の検算 12 本は、2026-11-03 に専用のディレクトリ `sagemath/check/sign_flip_conjugation/` へ移した。旧い名前 check_09・check_11〜check_21 との対応はその overview.md の「由来」にある。`U` 共役そのものの数値の確認は、ここの check_05 の (d)）

### 何を確定させるための検証か

章 C′（偶セクターの半整数運動量モード）の C′-15 にあたる。016 章の到達点は
`V^{(+)} = c V̌'`（ある `c ∈ ℂ^×`）までで、**`c` の値は未決定**だった。この章で

1. `V̌'` を数演算子 `ň_μ` の同時固有空間で対角化し（009 章と同じ道筋）、
2. `tr(V^{(+)})/tr((V^{(+)})^{−1}) = c²` と符号反転共役 `U`、および `V^{(+)}` の正定値性から
   `c = (2 sinh 2K_2)^{M/2}` を決め、
3. `V^{(+)}` の固有値 `Λ̌_ε` を全部求めて `Λ̌_max = Λ^{(1/2)}_M`（012 章 `def_Lambda_delta_M`
   の `Λ^{(δ)}_M` で `δ = 1/2`）を確定させ、
4. `γ(θ~_μ) > 0` から **最大固有値が単純**であることを言う

までを本文で閉じる。この検証はその各段を**ラベル単位で個別に**確かめる。

### 009 章（整数運動量）との差

| | 009 章（整数運動量） | 017 章（半整数運動量） |
|---|---|---|
| 添字集合 | `I = {μ : γ_2(θ_μ) ≠ 0}`、臨界点では `m = |I| = M−1` | `μ = 1,…,M` の全部（`m = M`） |
| 同時固有空間の次元 | `2^{M−m}`（臨界点で 2 次元） | 常に `1` 次元 |
| `tr(Q_ε)` | `2^{M−m}` | `1` |
| `tr(V')` の前因子 | `2^{M−m}` | `1`（消える） |
| 最大固有値 | `γ(θ_M) = 0` になりうるので縮退しうる | `γ(θ~_μ) > 0` ゆえ**必ず単純** |

`ň_μ` の対になる添字は `−μ` ではなく `1−μ` である（`def_half_integer_modes` (3)）。
check_01 では対を `−μ` に取り違えると冪等性が壊れることも対照として示す。

**本文が主張しないこと（一次情報で確認した）**: `V^{(+)}` の固有値が「すべて相異なる」ことは
**成り立たない**。`periodicity_of_check_fermi` (3) より `γ(θ~_μ) = γ(θ~_{M+1−μ})` なので、
`μ ↔ M+1−μ` で `ε` を入れ替えても `Λ̌_ε` は変わらない（check_03 で縮退ペアの実在を記録）。
単純性を主張するのは**最大固有値だけ**である。

## 検証の枠組み

`_prelude.sage` は `_shared/spin_ops.sage`（`Z_j, Y_j, H_1^{(±)}, H_2, σ_k^a` の明示行列）の上に、
016 章までの道具（`Ž_μ, Y̌_μ, γ_1, γ_2, γ, P̌_μ, ψ̌_μ^†, ψ̌_μ, X̌, V̌', V^{(+)}`）と
本章の道具を積む。

```
ň_μ      := ψ̌_μ^† ψ̌_{1−μ}
Q̌_ε      := Π_{μ=1}^{M} ( ε_μ ň_μ + (1−ε_μ)(I − ň_μ) )        (ε ∈ {0,1}^M)
ǧ(ε)     := Σ_{μ=1}^{M} γ(θ~_μ)(ε_μ − 1/2)
Λ̌_ε      := (2 sinh 2K_2)^{M/2} exp(ǧ(ε))
Λ^{(δ)}_M := (2 sinh 2K_2)^{M/2} exp( (1/2) Σ_{μ=1}^{M} γ(2π(μ−δ)/M) )
S_1^{(+)} := i K_1 H_1^{(+)},   S_2 := i K_2^* H_2
U        := E F,  E = E_1⊠…⊠E_M（E_m = σ^x（m 奇数）, I（m 偶数））,  F = σ^z⊠…⊠σ^z
```

`V^{(+)}` と `V̌'` はいずれも**行列指数関数から直接構成する**（証明が使う交換子の級数展開とは
独立な経路）。`V_2` の前因子 `(2 s_2)^{M/2}` も明示的に付けてある。

パラメータ:

- `M = 2, 3, 4, 5`、`ε` は `{0,1}^M` を**全列挙**（`M = 5` で 32 通り）
- `(K_1, K_2)` は 6 組。**厳密な臨界点**（`K_2 = arcsinh(1/sinh 2K_1)/2` で構成）2 組
  （非等方・等方 `K_1 = K_2 = K_c`）、臨界点近傍 1 組、一般点 2 組、高温側 1 組。

判定閾値は `TOL = 1e-8`（`report()` で最大残差と比較）。固有値の一致は**相対誤差**で見る。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_number_operator.sage | `def_check_number_operator` / `check_number_operator_idempotent`（`(ψ̌_μ^†)² = 0`、`ψ̌_{1−μ}ψ̌_μ^† = I − ň_μ`、`ň_μ² = ň_μ`）/ `check_number_operators_commute` / `trace_of_check_number_operator_product`（`{1..M}` の**全部分集合**について `tr = 2^{M−|T|}`）。**対照: 対を `−μ` に取り違えると冪等性が破れる** | PASS | 残差 ≤ 7.1e-15、誤った対の破れ `2.59e0` |
| 02 | check_02_joint_eigenspace.sage | `check_joint_eigenspace_decomposition` の (1)〜(5)。`tr(Q̌_ε) = 1`、**特異値で `rank Q̌_ε = 1` を判定**、`Σ_ε Q̌_ε = I`、個数 `2^M` | PASS | 残差 ≤ 2.6e-15、rank 違反 0 件 |
| 03 | check_03_Vprime_eigenvalues.sage | `eigenvalues_of_check_Vprime`。`X̌ Q̌_ε = ǧ(ε)Q̌_ε`、`V̌'Q̌_ε = e^{ǧ(ε)}Q̌_ε`、Sage の固有値集合（`2^M` 個）との一致、正値性。**縮退ペアの実在も記録** | PASS | 残差 ≤ 8.0e-12、固有値最小 `9.4e-4 > 0`、縮退ペア 144 件（正常） |
| 04 | check_04_trace_Vprime.sage | `trace_of_check_Vprime`。`V̌'(V̌')^{−1} = I`、`tr(V̌') = Π_μ 2cosh(γ/2)`、`tr((V̌')^{−1}) = tr(V̌')`、正値性 | PASS | 残差 ≤ 6.9e-12、`min tr(V̌') = 4.90e0` |
| 05 | check_05_positive_definite_and_c.sage | `V_plus_is_positive_definite` / `trace_V_plus_is_positive` / `V_plus_inverse_positive_and_trace_positivity` / `constant_c_value_even_sector`。(a) `S_1^{(+)}, S_2` が実対称（`iH_is_real_symmetric` の **(+) 側**）、(b) `V^{(+)} = (2s_2)^{M/2}exp(S_1/2)exp(S_2)exp(S_1/2)`、(c) `V^{(+)}` のエルミート性と固有値の正値性、候補逆行列のエルミート性、二つのトレース正値性、(d) `U S_1^{(+)}U^{−1} = −S_1^{(+)}`（`sign_flip_conjugation` の **(+) 側**）、(e) `tr(exp(−S_1)exp(−S_2)) = τ`、(f) `tr(V^{(+)})/tr((V^{(+)})^{-1}) = (2s_2)^M`、(g) `c = (2 sinh 2K_2)^{M/2}` と `V^{(+)} = cV̌'` | PASS | 実対称性の残差 `0.0`、`U` 共役の残差 `0.0`、`c` の相対差 ≤ 4.3e-15、`V^{(+)}` の固有値最小 `3.2e-4 > 0` |
| 06 | check_06_eigenvalues_V_plus.sage | `eigenvalues_of_V_plus` / `max_eigenvalue_of_V_plus_simple`。`V^{(+)}Q̌_ε = Λ̌_εQ̌_ε`、**`V^{(+)}` の `2^M` 個の固有値全体が `{Λ̌_ε}` に相対誤差 1e-8 以下で一致**、`Λ̌_max = Λ^{(1/2)}_M`、`γ(θ~_μ) > 0`、**最大固有値の単純性**。対照として `Λ^{(0)}_M`（整数運動量）とは一致しないこと | PASS | 固有値一致の相対差 ≤ 9.0e-12、`Λ̌_max = Λ^{(1/2)}_M` の相対差 `0.0`、`min γ = 5.4e-1`、単純性の相対差 ≥ 4.17e-1 |
| 07 | check_07_V_plus_mul_inverse.sage | `V_plus_is_invertible` の右逆検査。本文と同じ明示式で作った `R^{(+)}` について `V^{(+)}R^{(+)} = I` | PASS | 相対残差 ≤ 1.889e-11 |
| 08 | check_08_inverse_mul_V_plus.sage | `V_plus_is_invertible` の左逆検査。本文と同じ明示式で作った `R^{(+)}` について `R^{(+)}V^{(+)} = I` | PASS | 相対残差 ≤ 2.197e-11 |
| 10 | check_10_V_plus_inverse_chains.sage | `V_plus_is_invertible` の Step 2・Step 3 の鎖の 2 行目以降を一行ずつ（1 行目の表示は check_07・check_08 が覆う）。`E_±, A_±` の代わりに `QQ` 上の可逆行列と逆行列を置き（各段は Step 1 の左右逆だけを使う）、スカラー倍の 5 段・結合律・左右逆・単位行列を左右から掛ける段を本文と同じ括弧で確かめる。否定コントロール 1 件 | PASS | 252 段、全段で厳密に一致 |
| 26 | check_26_max_eigenvalue_simple_left_projection_chain.sage | `max_eigenvalue_of_V_plus_simple` (3) の、固有方程式 `V^{(+)}x = Λ̌_max x` に左から `Q̌_{ε'}` を掛ける鎖（5 行: 左の因子のスカラー倍の外出し、`eigenvalues_of_V_plus` (1)、`mat_mult_associative`（`q → 1`）、固有方程式、右の因子のスカラー倍の外出し）を、括弧どおりに一行ずつ `QQ` で厳密に。仮定（(1) の `Q̌_εV^{(+)} = Λ̌_εQ̌_ε` と固有方程式）を満たす模型として Jordan–Wigner のフェルミ演算子から `Q̌_ε` を作り、有理数 `Λ_ε` で `V := Σ_εΛ_εQ̌_ε`、`x := Q̌_{(1,…,1)}y` を取る（`M = 2, 3, 4`、`ε'` を全列挙）。否定コントロールとして、不定元の行列 `Q, V` と不定元 `λ, λ_max, x` では (1) と固有方程式を使う 2 行だけが外れ、スカラー倍と結合律を引く 3 行は成り立つことを確かめる | **PASS** | 厳密等号 143 段（模型と不定元の行列の合計）、否定コントロール 2 行 |
| 27 | check_27_V_plus_inverse_real_inclusion_chains.sage | `V_plus_is_invertible` の Step 2 の `a := (2s_2)^{M_col/2} ∈ ℝ_{>0}`・`a^{-1} = (2s_2)^{-M_col/2}`（`a` を `√((2s_2)^M)` と `(√(2s_2))^M` の 2 経路で、`a^{-1}` を `a` を使わず `√((2s_2)^{-M})` で計算して比べる）と、Step 2・Step 3 の鎖のうち係数を包含 `a_ℂ`・`(a^{-1})_ℂ` で扱う 2〜8 行目（左右の因子のスカラー倍の外出し、`scalar_multiple_is_associative`、`real_inclusion_preserves_product`、`ℝ` の `aa^{-1} = 1`、`1_ℂ = (1)_ℂ`、`scalar_multiple_by_one`）を一行ずつ。`ℝ` は `AA`、`ℂ` は `QQbar`、包含は `ι(r) = (r, 0)` を実部・虚部で確かめた `QQbar(r)`。係数の `M` は `2..5`、`s_2 ∈ {1/3, 2, 5/7}`（`M` が奇数なら `a` は無理数）、`X, Y` は虚部を持つ `QQbar` の `2^{min(M,3)}` 次の行列（係数の段は行列の大きさに依らない）。否定コントロールは同じ鎖を係数 `a, a` で回し、`ℝ` の `cd = 1` を引く段だけが外れること | **PASS** | 厳密等号 168 段、否定コントロール 12 行 |
| (1) の Λ^{(1/2)} の鎖 | check_max_eigenvalue_simple_step1_lambda_half_chain.sage | `max_eigenvalue_of_V_plus_simple` (1) の 4 行（`eigenvalues_of_V_plus` (2)・`θ̃_μ` の定義・`def_Theta_delta_M`（`δ → 1/2`）・`def_Lambda_delta_M`（`δ → 1/2`））。角の行は各項の角を π の有理数倍として `QQ` で厳密に、exp・arccosh・実数冪を含む行は `RealField(200)` で（ℝ 脱出: 超越関数の値）。`M_col = 2..8`、結合定数 4 組と臨界点。1 行目は `Λ̌_{(1,…,1)}` の定義の値と比べる。否定コントロール: `Λ^{(0)}_M`・前因子の冪を `M` にしたもの・和の `1/2` を落としたもの | PASS | 角の一致 35 項、隣どうしの行 140 段（差 `< 10^{-50}`）、否定コントロール 105 件 |
| (2) の狭義の不等号の鎖 | check_max_eigenvalue_simple_step2_strict_inequality_chains.sage | `max_eigenvalue_of_V_plus_simple` (2) の二つの鎖。`ǧ(1,…,1) − ǧ(ε)` の 10 行（`ǧ` の定義・`finite_sum_of_real_differences`・ℝ の分配法則・ℝ の計算・`a_μ` の置き方・`finite_sum_of_nonnegative_reals_is_at_least_each_term`・`a_μ` の置き方・`ε_{μ_0} = 0`・積の単位元・`gamma_theta_tilde_mu_positive`）を、等号の行は `γ_μ` を不定元に置いた `QQ` 上の多項式環で `M = 2..6`・`ε ≠ (1,…,1)` と `μ_0` を全列挙して恒等式として、不等号の行は `γ_μ` を正の有理数に置いて厳密に（鎖が使う `γ` の性質は `γ_μ > 0` だけ）。不等号の 2 行は、両辺の差が `Σ_{μ≠μ_0} a_μ` と `γ_{μ_0}` に恒等的に一致することも多項式環で確かめる。`Λ̌_ε` の 8 行と、物理の `γ(θ̃_μ) = arccosh(γ_1(θ̃_μ))` での `ǧ` の鎖の端は、結合定数 4 組（臨界点を含む）× `M = 2..6` で `RealField(200)`（ℝ 脱出: exp・arccosh・実数冪の値の比較）。`Λ̌_ε` の鎖の定義の展開の行（`Λ̌_ε`・`s_2`・`ǧ` の定義）は同じ定義から組むので構成上一致する。実質の比較は狭義不等号の行と、最後の行の `Λ̌_{(1,…,1)} = (2 sinh 2K_2)^{M/2}exp(½Σγ)`（`eigenvalues_of_V_plus` (2) の表式）である。否定コントロールとして、`γ_{μ_0} = 0` だと最後の狭義不等号が外れることを確かめる | **PASS** | 等号 3200 段（多項式環。差の恒等式を含む）、不等号 1920 段（正の有理数）、物理の結合定数で 476 通り |
| (3) の後半の固有空間の鎖 | check_max_eigenvalue_simple_step3_eigenspace_chains.sage | `max_eigenvalue_of_V_plus_simple` (3) の後半の 5 本の鎖を、括弧どおりに一行ずつ `QQ` で厳密に。`d(Q̌_{ε'}x) = O` の 4 行（`d` の置き方・`difference_of_scalar_multiples_of_one_matrix`・上の鎖の両端・`matrix_difference_zero_iff_equal`）、`Q̌_{ε'}x = O` の 5 行（`scalar_multiple_by_one`・`d^{-1}d = 1`・`scalar_multiple_is_associative`・上の鎖・`scalar_multiple_of_zero_matrix`）、`x = Q̌_{(1,…,1)}x` の 4 行（`identity_matrix_is_left_unit_of_mat_mult`・`check_joint_eigenspace_decomposition` (2)・`sum_over_binary_words_distributes_in_left_factor`・`sum_over_binary_words_with_one_nonzero_term`）、逆向きの `Q̌y = y` の 8 行と `V^{(+)}y = Λ̌_max y` の 6 行。模型は check_26 と同じ（Jordan–Wigner のフェルミ演算子からの `Q̌_ε`、`(1,…,1)` で狭義に最大な有理数 `Λ_ε` で `V := Σ_εΛ_εQ̌_ε`、`M = 2, 3, 4`、`ε' ≠ (1,…,1)` を全列挙）。否定コントロールとして、固有ベクトルでない `x` では差の鎖の 3 行目・割り算の鎖の 4 行目・項を消す行だけが、`im Q̌_{(1,…,1)}` に入らない `y` では `Q̌y = y` の最後の行だけが外れることを確かめる。`(Λ̌_{(1,…,1)}Q̌)y = (Λ̌_maxQ̌)y` の行は模型では `Λ̌_max := Λ̌_{(1,…,1)}` なので構成上成り立ち、写し間違いの検出だけに効く | **PASS** | 厳密等号 279 段、否定コントロール 12 件 |
| 逆行列の正定値性 | check_V_plus_inverse_positive_definite.sage | `V_plus_inverse_is_positive_definite`。本文の候補逆行列について全固有値の虚部が許容誤差以下で、実部がすべて正であることを独立検査 | PASS | 虚部の最大絶対値 `1.732e-14`、実部の最小値 `5.145e-4 > 0` |

## 結論

- `ň_μ = ψ̌_μ^† ψ̌_{1−μ}` は冪等かつ互いに可換で、`tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M−k}`（check_01）。
  対になる添字は `1−μ` であり、`−μ` では成り立たない。
- `Q̌_ε` は `2^M` 個の互いに直交する冪等元で、和が `I`、**各々の像は 1 次元**（check_02）。
  009 章の `2^{M−m}` 重の縮退は `m = M` により起こらない。
- `V^{(+)}` の固有値は `Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(Σ_μ γ(θ~_μ)(ε_μ − 1/2))` で尽きる。
  `M = 2,3,4,5`・6 組の `(K_1,K_2)` すべてで、`2^M` 個の固有値全体が相対誤差 `9.0e-12` 以下で
  一致した（check_06）。
- `c = (2 sinh 2K_2)^{M/2}`（相対差 ≤ 4.3e-15、check_05）。009 章の証明経路
  （`tr(V)/tr(V^{−1}) = c²` と符号反転共役 `U`、正定値性からの符号確定）が
  `H_1^{(+)}` でもそのまま通ることを、実対称性と `U` 共役の残差 `0.0` で確認した。
- 本文で明示した候補 `R^{(+)}` が `V^{(+)}` の右逆かつ左逆であることを別々に検査し、
  右積は相対残差 `1.889e-11` 以下、左積は `2.197e-11` 以下で単位行列に一致した
  （check_07、check_08）。
- 候補逆行列の全固有値を独立に検査し、虚部の最大絶対値は `1.732e-14`、実部の最小値は
  `5.145e-4 > 0` だった（check_V_plus_inverse_positive_definite）。
- `Λ̌_max = Λ̌_{(1,…,1)} = Λ^{(1/2)}_M` が相対差 `0.0` で成立し、`γ(θ~_μ) > 0` により
  2 番目の固有値との相対差は `4.17e-1` 以上ある（＝**最大固有値は単純**、check_06）。
  これで `c_+(M) = Λ^{(1/2)}_M` を示す準備が整う。

## μ の量化範囲の絞り込み（2026-07-27）

`def_check_number_operator` の `ň_μ` を `ψ̌^†_μ ψ̌_{1−μ}` から `ψ̌^†_μ ψ̌_{M+1−μ}`
（`μ ∈ 𝓜̌ = {1,…,M}`）へ書き換え、017 章の全主張の量化範囲を `𝓜̌` に絞ったのに合わせて
`_prelude.sage` / check_01 を更新し、**再実行した**（`run-log.txt` はその出力）。

check_01 には次を追加してある。

- `def_check_index_set` (2) の `1 ≤ M+1−μ ≤ M` と対合 `M+1−(M+1−μ) = μ` を `assert` で確認。
- **書き換えの正当性** `ψ̌_{M+1−μ} = ψ̌_{1−μ}`（添字の周期性による）を残差で確認。

`check_number_operators_commute` で消えるデルタは、以前は
`δ^M_{(μ+(1−ν),1)} = δ^M_{(μ−ν,0)}` という合同式の書き換えを要したが、
`𝓜̌` に絞ったことで `δ_{M+1−ν, M+1−μ} = δ_{μ,ν} = 0`（`μ ≠ ν`）だけで済む。

## 実行

```bash
cd sagemath/check/050_claim_even_sector_eigenvalues
for f in check_0*.sage; do /usr/local/bin/sage "$f"; done
```

実行出力は `run-log.txt`。
