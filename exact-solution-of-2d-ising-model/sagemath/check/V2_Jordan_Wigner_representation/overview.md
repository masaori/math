# SageMath Check: V₂ の Jordan--Wigner 表示

## 対象

**対象ラベル**: `V2_in_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- 範囲: `V₂ = (2s₂)^{M/2}exp(iK₂*(Z₁Y₁+…+Z_MY_M))`

## チェック一覧

| ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---|---:|---:|---|
| `check_step0_single_site_chain.sage` | Step 0 の鎖 `σ^zσ^y = -iσ^x` を 1 行ずつ（`mat_mult` の段、ℂ の事実を 1 段に 1 つずつ使う段（`0·z = 0`・左から足す 0 を消す `complex_zero_plus_is_original`・右から足す 0 を消す加法の単位元・`z·0 = 0`・積の単位元・可換律・`-z := (-1)·z`）、`def_matrix_scalar_multiple` の段を別の行として）。`mat_mult`・`def_matrix_scalar_multiple` の成分の式と Sage の積・スカラー倍の一致。否定コントロール: スカラーの符号を取り違えた等式は偽。`QQ[i]` の厳密計算 | 12 | 厳密 | **PASS** |
| `check_single_site_Jordan_Wigner_identity.sage` | 各サイトの `Z_mY_m=-iσ^x_m` | 20 | `0.000e+00` | **PASS** |
| `check_exponent_sum.sage` | 指数の肩の総和 | 5 | `0.000e+00` | **PASS** |
| `check_matrix_exponential.sage` | `V₂` の行列としての一致 | 24 | `0.000e+00` | **PASS** |
| `check_normalization_factor.sage` | 規格化因子 `(2s₂)^{M/2}` の必要性 | 24 | `0.000e+00` | **PASS** |

`check_step0_single_site_chain.sage` は浮動小数点を使わない。ほかの許容誤差は既定の相対誤差 `1.0e-09`。実行ログは同ディレクトリの `logs/` に保存した。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V2_Jordan_Wigner_representation
```
