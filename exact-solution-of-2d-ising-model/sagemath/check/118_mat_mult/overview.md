# SageMath Check: 118_mat_mult

## 対象

**対象ラベル**: `mat_mult` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`

- 範囲: mat(Aa,Ab) = A·mat(a,b)

2 本の列ベクトルを並べた行列に対する分配。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_mat_mult.sage` | 恒等式 | 125 | 3.844e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 118
```

実行ログは `sagemath/check/118_mat_mult/logs/` に保存してある（この表の数値はそのログから取った）。
