# SageMath Check: V1_plus_square_root_property

## 対象

**対象ラベル**: `V1_plus_square_root_property`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `bridge_claim_V1_pm_square_root_squares_to_V1_pm`（((V_1^{(+)})^{1/2})^2 = V_1^{(+)}、A^2 := AA。(V_1^{(+)})^{1/2} は def_V1_plus_square_root、V_1^{(+)} は def_V1_plus）
- 範囲: 証明の準備（XX = XX、1_ℂ + 1_ℂ = 2_ℂ の 4 行、c + c = iκ の 10 行）と主張の鎖（9 行）の全ての行と、行の根拠に引いた主張の個々の場合と、主張。

## 組み方

- Y_m・Z_m は def_jordan_wigner_Y_matrices・def_jordan_wigner_Z_matrices の σ_1^x⋯σ_{m−1}^xσ_m^{y/z} を、サイトの Pauli 行列を def_kronecker (2) の成分の式で組んで mat_mult の成分の式で左から掛けたもの、H_1^{(+)} は def_H1_plus の Σ_{m=1}^{M_col−1} Y_mZ_{m+1} − Y_{M_col}Z_1（`_shared/pauli_sites_exact.sage`）。
- 積・スカラー倍・和・有限和・差は本文の定め方の成分の式（`_shared` の `body_*`）、複素数の有限和は def_finite_sum_of_complex_numbers の左から足す形、1_ℂ + 1_ℂ は definition_of_cc の加法を QQ の対で、(r)_ℂ は inclusion_rr_to_cc の (r, 0)。
- 2_ℂ^{-1} は QQ(i) の 2 の逆元で、2_ℂ2_ℂ^{-1} = 2_ℂ^{-1}2_ℂ = 1_ℂ と (1/2)_ℂ = 2_ℂ^{-1}（real_inclusion_of_one_half_is_inverse_of_two）も確かめる。
- 係数の行と exp の中身の行列の行は、κ := (K_1)_ℂ を不定元に置いた QQ(i)[κ] で厳密に比べる（K_1 の値によらない）。
- exp は def_exp の部分和を QQ(i) で厳密に作り、尾の上界を各成分の半径に足した複素数のボールの行列で囲む（`body_exp_ball`）。Sage の ComplexBallField の行列の exp とも重なることを確かめてから使う（`exp_ball`）。ボールを使うので K_1 は有理数に置く。
- 主張は Sage の `tensor_product`・`*`・`-`・ComplexBallField の exp だけで組んだ H_1^{(+)} でも独立に確かめる。

## 証明の行との対応

表の「◯行目」は、その鎖の◯番目の等号（◯行目の式から◯+1 行目の式への変形）を指す。

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| 準備 XX = XX（等号の反射律） | `check_chain.sage` | 厳密（QQ(i)[κ]）。M_col = 2..5 |
| 準備 1_ℂ + 1_ℂ = 2_ℂ の 1 行目（1_ℂ = ι(1_ℝ)） | `check_chain.sage` | 厳密。1_ℂ = (1,0) と ι(1_ℝ) = (1_ℝ, 0) はどちらも同じ対なので、この行は定義を読んだ一致を見るだけである |
| 同 2 行目（real_inclusion_preserves_sum） | `check_chain.sage` | 厳密。根拠も別に確かめる |
| 同 3・4 行目（ℝ で 1+1 = 2、2_ℂ の定義） | `check_chain.sage` | 厳密 |
| 準備 c + c = iκ の 1 行目（c の定義） | `check_chain.sage` | 厳密（κ は不定元） |
| 同 2・4 行目（分配律） | `check_chain.sage` | 厳密 |
| 同 3・10 行目（1_ℂ は積の単位元） | `check_chain.sage` | 厳密 |
| 同 5 行目（1_ℂ + 1_ℂ = 2_ℂ） | `check_chain.sage` | 厳密。1_ℂ + 1_ℂ は definition_of_cc の加法で組む |
| 同 6 行目（積の可換律）、7・8 行目（積の結合律） | `check_chain.sage` | 厳密 |
| 同 9 行目（2_ℂ^{-1} は 2_ℂ の逆元） | `check_chain.sage` | 厳密。逆元であることも別に確かめる |
| 主張の鎖 1 行目（A^2 := AA） | `check_chain.sage` | ボール。左辺は Sage の `^`、右辺は mat_mult の成分の式。M_col = 2..4、K_1 = 1/3, 1, 7/4 |
| 主張の鎖 2 行目（def_V1_plus_square_root と X の定義） | `check_chain.sage` | ボール。定義を展開しただけの行なので、両辺は同じ exp(cH_1^{(+)}) から組んだ一致を見るだけである。c が def_V1_plus_square_root の (i 2_ℂ^{-1})(K_1)_ℂ の読み方であることは、準備の鎖と (1/2)_ℂ = 2_ℂ^{-1} の確かめで見る |
| 主張の鎖 3 行目（theorem_exp_product を X, X に） | `check_chain.sage` | ボール。ボールの比較は両辺を同じ exp_ball(X) から組むので、この行の検出力は次の係数の比較と、可換でない X, W の否定コントロールが受け持つ。加えて、exp(tX)exp(tX) と exp(t(X+X)) の t^n の係数 Σ_{p+q=n} X^pX^q/(p!q!) = (X+X)^n/n! を κ を不定元のまま n ≤ 8、M_col = 2, 3 で厳密に |
| 主張の鎖 4 行目（X の定義） | `check_chain.sage` | exp の中身を厳密（M_col = 2..5）、exp の値をボール |
| 主張の鎖 5 行目（def_finite_sum_of_matrices の r = 1, 2 の段） | `check_chain.sage` | 同上。r = 2 の段も別に確かめる |
| 主張の鎖 6 行目（finite_sum_of_scalar_multiples_of_one_matrix の r = 2） | `check_chain.sage` | 同上。根拠を関係の無い二つの不定元の係数でも確かめる |
| 主張の鎖 7 行目（def_finite_sum_of_complex_numbers） | `check_chain.sage` | 同上 |
| 主張の鎖 8 行目（準備の c + c = iκ） | `check_chain.sage` | 同上 |
| 主張の鎖 9 行目（V1_plus_exponential_representation） | `check_chain.sage` | 右辺 V_1^{(+)} は def_V1_plus の exp(iκ(Σ Y_mZ_{m+1} − Y_{M_col}Z_1)) で組む。中身が (iκ)H_1^{(+)} と一致することを厳密に、exp の値をボールで |
| 主張 | `check_chain.sage` | Sage の経路だけで M_col = 2..5、K_1 = 1/3, 7/4（ボール） |

否定コントロールのうち、誤りを見つける力があるのは、2_ℂ^{-1} を 2_ℂ に替えると iκ にならないこと、可換でない X, W で t^2 の係数と exp(X)exp(W) = exp(X + W) が外れること、二乗が exp(2iκH_1^{(+)}) と離れることである。残り（c ≠ iκ、X + X ≠ X、(iκ)H ≠ cH、(V_1^{(+)})^{1/2} ≠ V_1^{(+)}）は、比べ方が等号を見分けていることを確かめるだけである。一覧: c ≠ iκ、2_ℂ^{-1} を 2_ℂ に替えると iκ にならない、X + X ≠ X、(iκ)H ≠ cH、可換でない X と W := (iκ)Y_1 では t^2 の係数が一致しない（厳密）、(V_1^{(+)})^{1/2} と V_1^{(+)} のボールが離れる、二乗が exp(2iκH_1^{(+)}) のボールと離れる、可換でない X, W では exp(X)exp(W) と exp(X + W) のボールが離れる。

浮動小数点の値を使うのは exp の値だけで、全てボール（256 ビットの区間演算。部分和の尾の上界を半径に含む）であり、丸めの誤差も半径に入る。等しいはずの二つのボールは重なること、等しくないはずの二つは少なくとも一つの成分で離れることを見る。証明は M_col ∈ ℤ_{≥2}、K_1 ∈ ℝ_{>0} の全てについてのものだが、検算は上に書いた M_col と K_1 に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 準備と主張の鎖の全ての行、根拠の個々の場合、theorem_exp_product の係数の一致、主張、否定コントロール | 実行済み | PASS（等号・主張 165 件、否定コントロール 41 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh V1_plus_square_root_property
```
