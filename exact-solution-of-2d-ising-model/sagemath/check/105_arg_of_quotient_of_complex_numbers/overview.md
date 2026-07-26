# SageMath Check: 105_arg_of_quotient_of_complex_numbers

## 対象

**対象ラベル**: `arg_of_quotient_of_complex_numbers` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: arg^[0,2π)(z₁/z₂) の 2 通りの場合分け

104 と同じ方式で商について確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arg_quotient.sage` | 場合分けの両方 | 1226 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  第1の場合 636 件、第2の場合 589 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 105
```

実行ログは `sagemath/check/105_arg_of_quotient_of_complex_numbers/logs/` に保存してある（この表の数値はそのログから取った）。
