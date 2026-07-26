# SageMath Check: 120_range_of_args_of_multiple_of_complex_numbers

## 対象

**対象ラベル**: `range_of_args_of_multiple_of_complex_numbers` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.mjs`

- 範囲: arg(z₁z₂) = π のとき arg z₁ + arg z₂ = π または π + 2π

arg(z₁z₂) = π になる組を z₂ = −t/z₁（t > 0）で構成し、arg z₁ + arg z₂ がどちらの値になるかを分類する。両方の場合を実際に踏んでいることをカウントで確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arg_pi_split.sage` | 場合分けの両方 | 181 | 0.000e+00 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行時に出力された観測値

```
  第1の場合 99 件、第2の場合 81 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 120
```

実行ログは `sagemath/check/120_range_of_args_of_multiple_of_complex_numbers/logs/` に保存してある（この表の数値はそのログから取った）。
