# SageMath Check: 106_range_of_args_of_square_of_complex_numbers

## 対象

**対象ラベル**: `range_of_args_of_square_of_complex_numbers` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: arg^[0,2π)(z²) = 2arg z または 2arg z − 2π

arg z が [0,π) か [π,2π) かで分岐する。両方の場合を踏んでいることを確認する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_arg_square.sage` | 場合分けの両方 | 79 | 0.000e+00 | **PASS** |
| 02 | `check_02_zero_radius_rows.sage` | `r = 0` の場合の冒頭に置いた準備の `0 − 2·0·π = 0 − 0·π = 0 − 0 = 0`（`real_times_zero_is_zero`（`x → 2`）・`real_zero_times_is_zero`（`x → π`）・`a − 0 = a`）、半径の `0·0 = 0`、`0 = 2·0` の行（π を不定元とする `QQ[π]` の多項式で一行ずつ）、`0 ≤ 0 − 2kπ < 2π` を満たす整数が `k = 0` だけであること（RIF の π で区間演算）と、整数を取り違えた否定の対照 | 7（等号 5・整数の同定 1・否定の対照 1） | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない（01 だけ。02 は `QQ[π]` の厳密計算）。

## 実行時に出力された観測値

```
  0 <= arg < pi の場合 37 件、pi <= arg < 2pi の場合 41 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 106
```

実行ログは `sagemath/check/106_range_of_args_of_square_of_complex_numbers/logs/` に保存してある（この表の数値はそのログから取った）。
