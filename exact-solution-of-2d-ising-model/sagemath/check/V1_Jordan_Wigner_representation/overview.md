# SageMath Check: V₁ の Jordan--Wigner 表示

## 対象

**対象ラベル**: `V1_in_Z_Y_epsilon` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`
- 範囲: `V₁ = exp(iK₁(Y₁Z₂+…+Y_{M−1}Z_M − εY_MZ₁))`

## チェック一覧

| ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---|---:|---:|---|
| `check_step0_single_site_chains.sage` | Step 0 の 3 本の鎖 `σ^yσ^x = -iσ^z`・`σ^xσ^y = iσ^z`・`σ^zσ^y = -iσ^x` を 1 行ずつ（`mat_mult` の段、ℂ の事実を 1 段に 1 つずつ使う段（`0·z = 0`・左から足す 0 を消す `complex_zero_plus_is_original`・右から足す 0 を消す加法の単位元・`z·0 = 0`・積の単位元・可換律・結合律・`-z := (-1)·z`・`(-1)·(-1) = 1`）、`def_matrix_scalar_multiple` の段を別の行として）。`mat_mult`・`def_matrix_scalar_multiple` の成分の式と Sage の積・スカラー倍の一致。否定コントロール: スカラーの符号を取り違えた等式は偽。`QQ[i]` の厳密計算 | 37 | 厳密 | **PASS** |
| `check_bulk_Jordan_Wigner_identity.sage` | 非境界項 `σ^z_mσ^z_{m+1}=iY_mZ_{m+1}` | 15 | `0.000e+00` | **PASS** |
| `check_boundary_Jordan_Wigner_identity.sage` | 周期境界項 `σ^z_Mσ^z_1=-iεY_MZ_1` | 5 | `0.000e+00` | **PASS** |
| `check_exponent_sum.sage` | 指数の肩の総和 | 5 | `0.000e+00` | **PASS** |
| `check_matrix_exponential.sage` | `V₁` の行列としての一致 | 24 | `0.000e+00` | **PASS** |

`check_step0_single_site_chains.sage` は浮動小数点を使わない。ほかの許容誤差は既定の相対誤差 `1.0e-09`。実行ログは同ディレクトリの `logs/` に保存した。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V1_Jordan_Wigner_representation
```
