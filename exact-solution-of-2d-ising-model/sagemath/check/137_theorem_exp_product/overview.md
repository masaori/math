# SageMath Check: 137_theorem_exp_product

## 対象

**対象ラベル**: `theorem_exp_product` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.mjs`

- 範囲: AB=BA ⟹ exp A exp B = exp(A+B)

可換な組（同じ行列の多項式、対角行列）で等式を確認し、**非可換な組では実際に破れる**ことも数えている。可換性の仮定が本質的であることの確認。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_exp_product.sage` | 可換な場合の等式と、非可換な場合に破れること | 76 | 5.972e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  非可換な組で等式が破れた事例: 30 件（可換性の仮定が本質的）
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 137
```

実行ログは `sagemath/check/137_theorem_exp_product/logs/` に保存してある（この表の数値はそのログから取った）。
