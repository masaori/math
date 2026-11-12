# SageMath Check: 163_Z_Y_linearly_independent

## 対象

**対象ラベル**: `Z_Y_linearly_independent` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

- 範囲: {Z_1..Z_M, Y_1..Y_M} の C-線型独立性（check_01）。Step 1 の `𝓑 = {I, σ^x, σ^y, σ^z}` の線型独立性を成分の比較で示す鎖（check_02）

各作用素を 4^M 次元ベクトルへ平坦化した (2M)×4^M 行列の特異値を見る。最小特異値が 0 から十分離れていることを確認し、条件数も記録する。重複を足してもランクが増えないことで判定が有意味であることも見る。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_rank.sage` | 数値ランクと最小特異値 | 12 | 0.000e+00 | **PASS** |
| 02 | `check_02_step1_pauli_family_independence.sage` | Step 1: `L := c_0 I + c_x σ^x + c_y σ^y + c_z σ^z` の `L_11`・`L_12`・`L_21`・`L_22` の鎖（`L` の定義・`def_matrix_sum`・`def_matrix_scalar_multiple`・`def_identity_matrix`・`def_kronecker_delta`・`pauli_matrix_products` の成分・`complex_times_zero_is_zero`・加法と積の単位元・積の可換律・`negative_i_times_complex_is_negation_of_i_times`・`multiply_by_minus_one`・`def_complex_difference`。和とスカラー倍は成分ごとに別に組む）、`L = O` から (p)〜(s) の各 3 行の鎖（`L_ij` の鎖・`L = O`・`def_zero_matrix`）、`c_0`・`c_z`・`c_x`・`ic_y`・`c_y` が零になる 5 本の鎖を、`c_0, c_x, c_y, c_z` を不定元にした QQ(i) 上の有理関数体で厳密に。仮定を使う 9 行は、前の行で仮定の左辺の式を `0_ℂ` に置いた形が後の行であることを「前の行 = 後の行 + (仮定の左辺)×(係数)」の恒等式で確かめる。否定の対照 40 件（`L_12` の符号、`(σ^z)_22` を 1 と読む、`c_z` の鎖で (e) の代わりに (d)、(q) の `-i` を `i` と読むと係数行列が退化、仮定を使う 9 行のそれぞれで使う仮定を他の 4 つに取り替えると移れない） | 126 | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

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
