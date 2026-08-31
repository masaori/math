# SageMath Check: V₁ の Jordan--Wigner 表示

## 対象

**対象ラベル**: `V1_in_Z_Y_epsilon` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: `V₁ = exp(iK₁(Y₁Z₂+…+Y_{M−1}Z_M − εY_MZ₁))`

## チェック一覧

| ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---|---:|---:|---|
| `check_bulk_Jordan_Wigner_identity.sage` | 非境界項 `σ^z_mσ^z_{m+1}=iY_mZ_{m+1}` | 15 | `0.000e+00` | **PASS** |
| `check_boundary_Jordan_Wigner_identity.sage` | 周期境界項 `σ^z_Mσ^z_1=-iεY_MZ_1` | 5 | `0.000e+00` | **PASS** |
| `check_exponent_sum.sage` | 指数の肩の総和 | 5 | `0.000e+00` | **PASS** |
| `check_matrix_exponential.sage` | `V₁` の行列としての一致 | 24 | `0.000e+00` | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`。実行ログは同ディレクトリの `logs/` に保存した。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V1_Jordan_Wigner_representation
```
