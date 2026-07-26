# SageMath Check: 113_cos_arctan_sin_arctan

## 対象

**対象ラベル**: `cos_arctan_sin_arctan` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_10_19.mjs`

- 範囲: cos(arctan x) = 1/√(1+x²)、sin(arctan x) = x/√(1+x²)

x/√(1+x²) ∈ [−1,1]（arcsin の定義域に入ること）も併せて確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arctan.sage` | 両式、定義域、tan(arctan x)=x | 204 | 2.070e-11 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 113
```

実行ログは `sagemath/check/113_cos_arctan_sin_arctan/logs/` に保存してある（この表の数値はそのログから取った）。
