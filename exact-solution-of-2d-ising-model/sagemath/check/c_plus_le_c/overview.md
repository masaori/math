# SageMath Check: c_plus_le_c

## 対象

**対象ラベル**: `c_plus_le_c` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`（ブロック `maxeig_claim_c_plus_le_c`）
- 範囲: `c_+(M_col) ≤ c(M_col)`。証明が引く「`R_+` は空でない」（`def_sector_rayleigh_sup` の後半の
  単位ベクトル `x^{(+)}` の構成）も含める

```
c(M)   := sup{ x^⊤ W_ℝ x | x ∈ R^{2^M}, ‖x‖ = 1 }              (def_rayleigh_sup)
c_+(M) := sup{ x^⊤ W_ℝ x | x ∈ R^{2^M}, ε_ℝx = x, ‖x‖ = 1 }    (def_sector_rayleigh_sup。ε_ℝ := ϱ(ε) は def_epsilon_real)
W      := V_1^{1/2} V_2 V_1^{1/2}                               (def_symmetrized_transfer_matrix)
W_ℝ    := ϱ(W)（成分の包含が W の成分になる実数の行列）           (def_W_real)
```

`x^⊤W_ℝx` は `def_real_bilinear_value` の実数の値である。検算は `W` の成分を倍精度の実数 `RDF` で作るので、
組んだ行列は `W_ℝ` そのものであり、`x * W * x` は `x^⊤W_ℝx` を計算している。

## チェック一覧

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_even_sector_unit_vector_exists.sage` | `a_+ ∈ ℝ^2`、`b_+ := ι^2(a_+)` について `σ^xb_+ = b_+` の 3 行、`x^{(+)}` の成分の値の 3 行 `(x^{(+)})_{ν(I)} = Π_k(a_+)_{i_k} = Π_k 1/√2 = (1/√2)^M`（全 `I`。冪は `def_power_of_real_number` どおりに組む）、`ι(x^{(+)})_{ν(I)} = (b_+⊠⋯⊠b_+)_{ν(I)}` の 5 行（全 `I`）、`ει(x^{(+)}) = (σ^x⊠⋯)ι(x^{(+)}) = (σ^x⊠⋯)(b_+⊠⋯) = (σ^xb_+)⊠⋯ = b_+⊠⋯ = ι(x^{(+)})` の各行、`ε_ℝ := ϱ(ε)` と `ε_ℝx^{(+)} = x^{(+)}`、`2_ℝ := 1 + 1`（`def_real_two`）の `0 < 2`（`real_zero_less_than_two`）と `<` の意味の前半による `2 ∈ ℝ_{≥0}`、`2 ≠ 0`（`real_two_is_nonzero`）、`2·2^{-1} = 1`、`0 < 2` と `sqrt_of_positive_real_is_positive`（`x → 2_ℝ`）の `0 < √2`、`<` の意味の後半と等号の対称律の対偶による `√2 ≠ 0`、`√2√2 ≠ 0`（`real_product_of_nonzero_is_nonzero`）、`√2·√2^{-1} = 1`・`(√2√2)(√2√2)^{-1} = 1`、`‖x^{(+)}‖² = 1` の 20 行の鎖（`def_matrix_norm` → `definition_of_sqrt_r_positive` → `square_of_real_absolute_value` → 各成分の値 → `finite_sum_of_constant_real_number` → `inclusion_zz_to_rr_of_power_of_two` → `square_of_real_number_is_product` → `product_of_real_powers_is_power_of_product` → `def_real_quotient`（`y → 1`、`z → √2 ≠ 0`、2 つの因子へ） → `1` は `ℝ` の乗法の単位元 `1·x = x`（`x → √2^{-1}`）（`set_and_algebra_notation`）を 2 つの因子へ → `real_product_of_inverses_is_inverse_of_product`（`a, b → √2`） → `1` は `ℝ` の乗法の単位元 `1·x = x`（`x → (√2√2)^{-1}`）（`set_and_algebra_notation`）を右辺から左辺へ → `def_real_quotient`（`y → 1`、`z → √2√2 ≠ 0`、右辺から左辺へ） → `square_of_real_number_is_product`（右辺から左辺へ） → `definition_of_sqrt_r_positive` → `product_of_real_powers_is_power_of_product` → `def_real_quotient`（`y → 1`、`z → 2_ℝ ≠ 0`） → `1` は `ℝ` の乗法の単位元 `1·x = x`（`x → 2_ℝ^{-1}`）（`set_and_algebra_notation`） → `def_real_quotient` の乗法の逆元 `z z^{-1} = 1_ℝ` → `power_of_real_one_is_one`。冪は `def_power_of_real_number` どおりに組む）、`‖x^{(+)}‖ = 1` を導く段（`‖x^{(+)}‖ ∈ ℝ_{≥0}`、`‖x‖ = 0` を入れた側の `‖x‖^2 = ‖x‖‖x‖ = 0·0 = 0`（1 段目は `square_of_real_number_is_product`、最後の段は `real_times_zero_is_zero`（`x → 0`）） が `1` と違うこと（体 `ℝ` の公理の `0 ≠ 1`）、等号の対称律の対偶の `0 ≠ ‖x^{(+)}‖` と `<` の意味（`x ≤ y` かつ `x ≠ y`）で `‖x^{(+)}‖ ∈ ℝ_{>0}`、`real_zero_less_than_one` の `0 < 1`、`‖x‖^2 = 1 = 1·1 = 1^2` の 3 行（2 段目は `1` は `ℝ` の乗法の単位元 `1·x = x`（`x → 1`）（`set_and_algebra_notation`）を右辺から左辺へ、最後は `square_of_real_number_is_product` を右辺から左辺へ）と `positive_real_square_injective` の結論 `‖x^{(+)}‖ = 1`）。否定コントロール 5 件（`(√2+√2)^{-1} ≠ √2^{-1}√2^{-1}`、`σ^x(1,0) ≠ (1,0)`、成分の符号を 1 つ変えたベクトルは `ε_ℝ` で動く、成分を二乗し忘れた `2^M(1/√2)^M ≠ 1`、`b → -1`（`ℝ_{>0}` でない）では二乗が一致しても `a ≠ b`） | **PASS** | `M_col=1,…,5` で実数の側は `AA`、複素数の側は `QQbar` 上の厳密等号（鎖の等号 651 個） |
| `check_unit_rows_cite_set_and_algebra_notation.sage` | `x^{(+)}` のノルムの鎖で「1 は ℝ の乗法の単位元」（`set_and_algebra_notation`）を引く 4 行: `1·x = x` の `x → √2^{-1}` を 2 つの因子へ、`x → (√2√2)^{-1}` を右辺から左辺へ、`x → 2_ℝ^{-1}`、`‖x^{(+)}‖^2 = 1 = 1·1` の `x → 1` を右辺から左辺へ。行に書いた形と代入で形の両辺を作り、前後の行が同じ文脈の穴にそれを入れたものと `QQ[s, q, h, two]` で等しいことを確かめる（`M_col = 2,…,6`）。式を正規化するので、形の左右と向きは区別できず、それはレビューの目視で確かめた。対照（`2s ≠ s`） | **PASS** | 厳密（4 行） |
| `check_c_plus_le_c.sage` | `c_+(M) ≤ c(M)`。`c_+` を二通りに独立に求めて一致を確かめたうえで、`R_+ ⊆ R` の標本・`x^{(+)}` の商・`c_+ ≤ c` を判定 | **PASS** | 30 ケースで違反 0 件。二通りの `c_+` の一致と前提の最大相対残差 `1.8e-15` |

### `check_c_plus_le_c.sage` の中身

`W` は成分定義から作る（`V_1^{1/2}` は対角成分 `exp(K_1Σ_mμ(m)μ(m+1)/2)`、`V_2` は成分 `exp(K_2Σ_mμ(m)μ'(m))`。
行・列番号は `def_row_configuration_numbering` の `ord`）。`ε` は `σ^x_1⋯σ^x_M` を `QQ` で作ってから倍精度へ移す。

- **`c(M)`**: `W` は実対称なので、`R^{2^M}` の単位ベクトル上の Rayleigh 商の上限は `W` の最大固有値に等しい。これで求める。
- **`c_+(M)` を二通りに**:
  (a) `{x ∈ R^{2^M} | ε_ℝx = x}` の正規直交基底 `B`（列 `(e_k + e_{k̄})/√2`、`k̄` は全スピン反転した配位の番号）へ
  `W` を制限した `B^⊤WB` の最大固有値、
  (b) `{x ∈ R^{2^M} | ε_ℝx = x}` の乱数単位ベクトルから出発した冪乗法の Rayleigh 商（`εW = Wε` なので反復はこの集合を出ない。
  `W` は正定値なので最大固有値へ収束する）。両者が一致し、(b) の極限ベクトルが `εy = y` を満たすことを確かめる。
  これで「偶セクターでの上限」と「`W` を偶セクターへ制限した行列の最大固有値」が同じものであることを確認している。
- **判定**: (1) `{x ∈ R^{2^M} | ε_ℝx = x}` の乱数単位ベクトル 20 本について `x^⊤Wx ≤ c_+ ≤ c`（`R_+ ⊆ R` の標本）、
  (2) `x^{(+)}` の Rayleigh 商が `c_+` 以下、(3) `c_+ ≤ c`。
- **観測（本文は使わない）**: `c_+/c` を出力する。全ケースで `0.999999999999999`〜`1.000000000000001`、すなわち倍精度の丸めの範囲で `1` に一致する。`c_+` が `c` を相対 `1e-15` だけ上回る出力があるのは丸めであり、不等号の判定の余裕（下記）の内側にある。

パラメータは `M_col = 2,…,6` と `(K_1, K_2)` 6 組（厳密な臨界点 2 組〔非等方・等方〕、臨界点近傍、一般点 2 組、高温極限付近）。

### 許容誤差とその根拠

- `W` の成分は `exp` の値なので ℝ に住む（指数評価による ℝ への脱出）。倍精度 `RDF` で計算する。
- 二通りの `c_+` の一致と前提（`W^⊤ = W`、`εW = Wε`、`εB = B`、`B^⊤B = I`）は相対 `1e-9` で判定する（リポジトリの既定）。
- 不等号は相対余裕 `1e-12` で判定する（`a ≤ b(1 + 1e-12)`）。LAPACK の対称固有値計算の誤差は `‖W‖ × 1e-16` 程度であり、
  `1e-12` はその `1e4` 倍の余裕である。実際の `c_+` と `c` の差は相対 `1e-15` 程度で、`c_+ = c` の観測と整合する。
- 有限個のパラメータでの浮動小数点計算であり、一般の証明ではない。本文の主張は集合の包含 `R_+ ⊆ R` と上限の単調性だけから従う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh c_plus_le_c
```

実行ログは `sagemath/check/c_plus_le_c/logs/` に保存してある（`check_c_plus_le_c.sage` は 2026-09-26、`check_even_sector_unit_vector_exists.sage` は 2026-11-16。SageMath 10.9）。
