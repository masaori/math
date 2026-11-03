# SageMath Check: def_check_Vprime

## 対象

**対象ラベル**: `def_check_Vprime`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evenfermi_005_definition_check_Vprime`（V̌' の定義。X̌ が R = Mat(2^{M_col}, ℂ) の元であることと、V̌' の可逆性）
- 範囲: 証明 (1) の 11 行と有限和の行（X̌ ∈ R）、証明 (2) の -X̌ ∈ R、V̌' exp(-X̌) の 3 等号、exp(-X̌) V̌' の 2 等号、
  V̌' ∈ R^×・(V̌')^{-1} = exp(-X̌)・T_{(V̌')} の 3 行、主張

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| (1) の 1 行目 ν = M_col+1-μ ∈ 𝓜̌ | `check_membership.sage` | M_col = 2..40 の全 μ で、μ ↦ M_col+1-μ が 𝓜̌ の全単射であること。対照: μ ↦ M_col-μ と μ ↦ -μ は 𝓜̌ の外へ出る | **PASS** | 成り立つ |
| (1) の 2・3 行目 ψ̌^†_μ, ψ̌_ν ∈ R | `check_membership.sage` | 結合定数 4 組 × M_col = 2..5 の全 μ で、def_check_fermi の分母 2√M_col γ_2(-θ̃_λ) が 0 でないこと（γ_2(-θ̃_λ) = -conj(γ_2(θ̃_λ)) ≠ 0 を L で厳密に）と、ψ̌ を本文の係数の式で組んだ行列が 2^M 次であること。対照: 分母 0 では係数が作れない | **PASS** | 成り立つ |
| (1) の 4 行目 積 | `check_membership.sage` | mat_mult の成分の式で組んだ積が 2^M 次で、Sage の行列積と一致する | **PASS** | 成り立つ |
| (1) の 5〜8 行目 I、(1/2)_C、(1/2)_C I、差 | `check_membership.sage` | def_identity_matrix・def_matrix_scalar_multiple・def_matrix_difference の成分の式で組んだ行列が、Sage の identity_matrix・スカラー倍・差と一致する | **PASS** | 成り立つ |
| (1) の 9 行目 γ(θ̃_μ) ∈ ℝ_{≥0} | `check_membership.sage` | γ_1(θ̃_μ) が L の実の元で 1 以上（AA で厳密）、arccosh(γ_1) = log(γ_1 + √(γ_1²-1)) のボールが 0 以上で cosh が γ_1 と重なる | **PASS** | 成り立つ |
| (1) の 10・11 行目と有限和の行 X̌ ∈ R | `check_membership.sage` | γ(θ̃_μ)・r_λ を不定元 g_μ・ρ_λ に置いた P の中で、スカラー倍と def_finite_sum_of_matrices の和を成分の式で組み、Sage の演算と一致し、X̌ ≠ O であること | **PASS** | 成り立つ |
| (2) の -X̌ ∈ R | `check_inverse.sage` | M_col = 2, 3 × 結合定数 2 組で、def_matrix_negation の成分の式の -X̌ が Sage の -X̌ と一致する（P の中で厳密） | **PASS** | 成り立つ |
| (2) の V̌' exp(-X̌) の鎖の第 2 行 exp(X̌) = exp(-(-X̌)) | `check_inverse.sage` | 厳密: P の中で -(-X̌) = X̌（matrix_double_negation の成分の式で二回反転して比べる）。ボールの段の同じ比較は自明（下の「作り方で自明な比較」） | **PASS** | 成り立つ |
| (2) の V̌' exp(-X̌) の鎖の第 3 行と exp(-X̌) V̌' の鎖の第 2 行（= I） | `check_inverse.sage` | 厳密: exp_of_negative_is_left_inverse の当てはめ（A → -X̌、A → X̌）を、def_exp の部分和の積の k 次の部分 Σ_{a+b=k} (-A)^a A^b/(a! b!) が k = 0 で I、k = 1..N で O になることとして P の中で確かめる（M_col = 2 は N = 8、M_col = 3 は N = 4）。ボール: 結合定数 4 組 × M_col = 2..5 で、積の各成分のボールが δ_{ij} を含む。対照: 符号を取り違えた和は k = 1 で O にならない、V̌'V̌' は I を含まない成分を持つ | **PASS** | 成り立つ |
| (2) の V̌' ∈ R^× と (V̌')^{-1} = exp(-X̌) | `check_inverse.sage` | 二つの積が I を含むこと（上の行）と、Sage の逆行列（独立な経路）のボールが exp(-X̌) のボールと重なる | **PASS** | 成り立つ |
| (2) の T_{(V̌')} の定義 | `check_inverse.sage` | W = Ž_1, Y̌_1 で V̌' W exp(-X̌) と V̌' W (V̌')^{-1}（Sage の逆行列）のボールが重なる | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: (1) の全行と (2) の -X̌・-(-X̌) = X̌・級数の段。行列は円分体 L = QQ(ζ_{4M}) の成分と、r_λ = |γ_2(θ̃_λ)|・γ(θ̃_λ) を不定元 ρ_λ・g_λ に置いた L 上の多項式環 P の成分で組む（全ての値について一度に確かめる）。σ = √M_col は L の元。γ_1 ≥ 1 は AA で見る。
- **ℝ への脱出**: γ(θ̃_μ) = arccosh(γ_1(θ̃_μ))（実対数）、r_λ（ℝ_{≥0} の平方根）、exp(±X̌) の値（def_exp の級数の極限）。これらは RealBallField(512)・ComplexBallField(512) のボールで囲む。exp(±X̌) は def_exp の部分和（積は mat_mult の成分の式）に、尾の上界 s^{N+1}/(N+1)!/(1 - s/(N+2))（s は成分の 2 乗和の平方根の上界で、def_matrix_norm のノルム以上）を各成分の半径として足し、Sage の行列の exp と重なることも見る。等号の行はボールが重なること、I との等号は各成分のボールが δ_{ij} を含むことで判定するので、反例があれば区間が十分狭い（512 ビット）限り検出される。
- **作り方で自明な比較**（中身は括弧の中が担う）:
  - (1) の 2・3・5・7 行目と有限和の行は、行列が R の元であること（2^M 次であること）を見るだけである。中身は分母が 0 でないこと（2・3 行目）と、成分の式で組んだ行列が Sage の演算と一致すること（4・7・8・11 行目、有限和の行）である。
  - (2) の V̌' exp(-X̌) = exp(X̌)exp(-X̌) と exp(-X̌)V̌' = exp(-X̌)exp(X̌) は V̌' の定義を当てる行で、検算でも同じ exp(X̌) から作るので比較しない。
  - ボールの段の exp(-(-X̌))exp(-X̌) と exp(X̌)exp(-X̌) の比較は、ボールの符号反転が誤差を生まず -(-X̌) のボールが X̌ のボールと同じになるので、必ず重なる。この行の中身は厳密の段の -(-X̌) = X̌ が担う。
  - 級数の段の Σ_{a+b=k} (-A)^a A^b/(a! b!) = O（k ≥ 1）は A によらず成り立つ恒等式で、X̌ の中身には依らない。ここで確かめているのは、exp_of_negative_is_left_inverse を A → X̌・A → -X̌ に当てはめたこと（X̌ と -X̌ が R の元として組めること）と、積・符号反転を本文の成分の式で組んだことの照合である。X̌ の値に依る中身はボールの段（二つの積が I を含み、V̌'V̌' は I を含まない）が担う。
- 範囲外: 級数の段で M_col ≥ 4（不定元 2M_col 個の多項式の行列の冪の計算量のため）。ボールの段で M_col ≥ 6（2^M 次の行列の部分和の計算量のため）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh def_check_Vprime
```

実行ログは `logs/` に保存する。
