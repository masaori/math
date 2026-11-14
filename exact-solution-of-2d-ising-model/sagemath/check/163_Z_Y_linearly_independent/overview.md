# SageMath Check: 163_Z_Y_linearly_independent

## 対象

**対象ラベル**: `Z_Y_linearly_independent` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

- 範囲: {Z_1..Z_M, Y_1..Y_M} の C-線型独立性（check_01）。Step 1 の `𝓑 = {I, σ^x, σ^y, σ^z}` の線型独立性を成分の比較で示す鎖（check_02）。Step 2 の族 `(F_q)` の線型独立性、Step 4 の `F_{q_Z(m)} = Z_m`・`F_{q_Y(m)} = Y_m`、Step 5 の `q_Z`・`q_Y` の値が相異なること、Step 6 の係数の族 `d_q` をクロネッカーのデルタで置く鎖（check_03）。Step 3 の `Z_m`・`Y_m` のクロネッカー積による表示の鎖（check_04）

check_01 は、各作用素を 4^M 次元ベクトルへ平坦化した (2M)×4^M 行列の特異値を見る。最小特異値が 0 から十分離れていることを確認し、条件数も記録する。重複を足してもランクが増えないことで判定が有意味であることも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_rank.sage` | 数値ランクと最小特異値 | 12 | 0.000e+00 | **PASS** |
| 02 | `check_02_step1_pauli_family_independence.sage` | Step 1: `L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z` の `L_11`・`L_12`・`L_21`・`L_22` の鎖（`L` の定義・`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_identity_matrix`・`def_kronecker_delta`・`def_pauli_matrices` の成分・`complex_times_zero_is_zero`・`complex_zero_plus_is_original`・加法と積の単位元・積の可換律・`negative_i_times_complex_is_negation_of_i_times`・`multiply_by_minus_one`・`def_complex_difference`。和とスカラー倍は成分ごとに別に組む）、`L = O` から (p)〜(s) の各 3 行の鎖（`L_ij` の鎖・`L = O`・`def_zero_matrix`）、`c_0`・`c_z`・`c_x`・`ic_y`・`c_y` が零になる 5 本の鎖（`twice_times_inverse_of_two_is_original_in_cc`・`sum_plus_difference_is_twice_first_in_cc`・`sum_minus_difference_is_twice_second_in_cc`・加法の可換律・`negation_plus_self_is_zero_in_cc`・`negative_i_times_i_is_one_in_cc`。引く主張の文字の置き換えどおりの当てはめも別に 9 件確かめる）を、`c_0, c_x, c_y, c_z` を不定元にした QQ(i) 上の有理関数体で厳密に。仮定を使う 9 行は、前の行で仮定の左辺の式を `0_ℂ` に置いた形が後の行であることを「前の行 = 後の行 + (仮定の左辺)×(係数)」の恒等式で確かめる。否定の対照 40 件（`L_12` の符号、`(σ^z)_22` を 1 と読む、`c_z` の鎖で `sum_minus_difference_is_twice_second_in_cc` の代わりに `sum_plus_difference_is_twice_first_in_cc`、(q) の `-i` を `i` と読むと係数行列が退化、仮定を使う 9 行のそれぞれで使う仮定を他の 4 つに取り替えると移れない） | 139 | 厳密 | **PASS** |
| 03 | `check_03_step6_delta_coefficients.sage` | 行は等号の行で数える。Step 2: `((c_1I+c_2σ^x)+c_3σ^y)+c_4σ^z` から `Σ_a c_a e_a` までの鎖（`e_a` の定義、`def_finite_sum_of_matrices` の `r=1, 2, 3, 4` の段。Pauli 行列は成分で別に組む）、`F_q`（def_kronecker (2) の成分の式で組み、Sage の tensor_product と比べる）の族の階数が `N = 4^M`。Step 4 の `F_{q_Z(m)} = Z_m`・`F_{q_Y(m)} = Y_m` の 6 行の鎖（`ζ(m)`・`η(m)` の定義の行と `e_a` の定義の行を含む。`Z_m`・`Y_m` はサイトの Pauli 行列の積で別に組む）。Step 5 の場合分けの各場合で比べる成分の値、`π^{-1}` の単射性の 3 行の鎖（`π^{-1}(p) = π^{-1}(p')` を満たす組。全単射ではその組は `p = p'` だけなので、単射でない写像では仮定から `p = p'` へ移れないことを否定の対照にした）、`q_Z(1..M)`・`q_Y(1..M)` が相異なること。Step 6 の準備 (t)・(u)・(v) の鎖を全ての `q, m, m_0` で、`Σ_q d_qF_q` の 11 行の鎖の 10 行目まで（`α_m`・`β_m` を QQ(i) 上の多項式環の不定元に置き、各行を書かれた和の順序で組む。仮定を使う最後の行 `= O` は仮定そのものなので検算の対象外）、`α_{m_0}`・`β_{m_0}` の各 8 行の鎖の 7 行目 `d_{q_Z(m_0)}`・`d_{q_Y(m_0)}` まで（最後の行 `d_q = 0_ℂ` は Step 2 の階数の確認が担う）。主張全体も確かめた（行の検算ではない）: `(α,β) ↦ (d_q)_q` の係数行列と、`d_q`・`F_q` を経た `(α,β) ↦ Σ_q d_qF_q` の係数行列の階数が `2M`、`Z_m`・`Y_m` から直接組んだ係数行列の階数が `2M`。`π` は辞書式と乱数の全単射の 2 通り、`M = 1, 2, 3`。否定の対照（`π` の逆写像でない写像で `q_Z` を取る、`d_q` の `α` の項の δ を `δ_{q q_Y(m)}` に取り違える、(u) を `m = m_0` で使う、`α` の鎖が `d_{q_Y(m_0)}` に着く） | 3898 | 厳密 | **PASS** |
| 04 | `check_04_step3_kronecker_form.sage` | 行は等号の行で数える。Step 3: (k) `F_j^{(z)} = σ_j^{a_j^{(z)}}`・`F_j^{(y)} = σ_j^{a_j^{(y)}}` の各 2 行の鎖を全ての `m, j` で。`Z_m`・`Y_m` の各 4 行の鎖（定義 → (k) → `site_pauli_prefix_product_kronecker_form` → `a_j^{(z)}`・`a_j^{(y)}` の定義。左辺の有限積は `def_finite_product_of_matrices` どおり左から掛けて組み、右辺のクロネッカー積は `def_kronecker` の成分の式で組み、Sage の `tensor_product` とも比べる）。`M = 1, 2, 3, 4`。`Z_m`・`Y_m` の左辺を定義の式から別に組んで比べる。否定の対照（(k) で `a_m^{(z)}` を `x` と読む、`Z_m`・`Y_m` の表示の `σ^z`・`σ^y` の位置をずらす） | 232 | 厳密 | **PASS** |

check_01 の許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  M=2: 2M=4, sigma_min=2.000000e+00, sigma_max=2.000000e+00, cond=1.000
  M=3: 2M=6, sigma_min=2.828427e+00, sigma_max=2.828427e+00, cond=1.000
  M=4: 2M=8, sigma_min=4.000000e+00, sigma_max=4.000000e+00, cond=1.000
  M=5: 2M=10, sigma_min=5.656854e+00, sigma_max=5.656854e+00, cond=1.000
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 163
```

実行ログは `sagemath/check/163_Z_Y_linearly_independent/logs/` に保存してある（この表の数値はそのログから取った）。
