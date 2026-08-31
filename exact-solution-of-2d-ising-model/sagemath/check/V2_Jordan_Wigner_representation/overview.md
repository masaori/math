# SageMath Check: V₂ の Jordan--Wigner 表示

## 対象

**対象ラベル**: `V2_in_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/004_transfer_matrix.ts`
- 範囲: `V₂ = (2s₂)^{M/2}exp(iK₂*(Z₁Y₁+…+Z_MY_M))`

## チェック一覧

| ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---|---:|---:|---|
| `check_single_site_Jordan_Wigner_identity.sage` | 各サイトの `Z_mY_m=-iσ^x_m` | 20 | `0.000e+00` | **PASS** |
| `check_exponent_sum.sage` | 指数の肩の総和 | 5 | `0.000e+00` | **PASS** |
| `check_matrix_exponential.sage` | `V₂` の行列としての一致 | 24 | `0.000e+00` | **PASS** |
| `check_normalization_factor.sage` | 規格化因子 `(2s₂)^{M/2}` の必要性 | 24 | `0.000e+00` | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`。実行ログは同ディレクトリの `logs/` に保存した。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh V2_Jordan_Wigner_representation
```
