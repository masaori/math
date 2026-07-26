# SageMath Check: 110_square_of_sqrt

## 対象

**対象ラベル**: `square_of_sqrt` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: z = √(z²) または −√(z²)

arg z が [0,π) か [π,2π) かで符号が決まる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_square_of_sqrt.sage` | 場合分けの両方 | 80 | 3.125e-16 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  0<=arg<pi の場合 30 件、pi<=arg<2pi の場合 40 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 110
```

実行ログは `sagemath/check/110_square_of_sqrt/logs/` に保存してある（この表の数値はそのログから取った）。
