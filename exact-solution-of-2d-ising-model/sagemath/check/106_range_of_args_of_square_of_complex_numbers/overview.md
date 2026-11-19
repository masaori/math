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
| 02 | `check_02_zero_radius_rows.sage` | `r = 0` の場合の `arg(z)` と `arg(z^2)` の鎖の `s_{[0,2π)}([0]) = 0`（`angle_section_of_zero_is_zero`。定義の値 `θ − 2nπ` に `θ → 0`・`n = 0` を当てた値）、半径の `0·0 = 0`（`real_zero_times_is_zero`、`x → 0`）、`0 = 2·0`（`real_times_zero_is_zero`、`x → 2`）の行（π を不定元とする `QQ[π]` の多項式で一行ずつ）と、整数を取り違えた否定の対照。`0 − 2·0·π = 0` の鎖と整数の同定は 2026-11-15 に主張へ移したので `angle_section_integer_of_zero_is_zero/`・`angle_section_of_zero_is_zero/` が確かめる | 4（等号 4）・否定の対照 1 | 厳密 | **PASS** |
| — | `check_nonzero_radius_square_row.sage` | `r ≠ 0` の場合の「`r ≠ 0` なので `r·r ≠ 0`」を `real_product_of_nonzero_is_nonzero`（`a → r`、`b → r`）の参照に替えた行。代入後の主張が `QQ[r^{-1}, r]` のイデアルの所属として成り立つこと、半径に取りうる 0 でない値 5 個（`QQ`・`AA`）で `r·r ≠ 0`、否定の対照（`r = 0`、逆元の前提を外したとき） | 6（主張 1・値 5）・否定の対照 2 | 厳密 | **PASS** |
| double argument | `check_double_argument_rows.sage` | `r ≠ 0` の場合の 2 本の鎖の最後の行 `arg(z)+arg(z) = 2arg(z)`（と `−2π` を付けた形）を割った 3 行（乗法の単位元 `1·x = x` を右辺から左辺へ、分配律 `(x+y)t = xt+yt` を右辺から左辺へ、`def_real_two` を右辺から左辺へ）を、行に書いた形と代入どおりに `QQ[A, P]` の等号で一行ずつ。多項式環は式を正規化するので、形の左右と向きは区別できず、それはレビューの目視で確かめた。対照（`1 + 1` を `1` に取り違えた形） | 7 | 厳密（`QQ`） | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない（01 だけ。02 は `QQ[π]`、`check_nonzero_radius_square_row.sage` は `QQ`・`AA` の厳密計算）。

## 実行時に出力された観測値

```
  0 <= arg < pi の場合 37 件、pi <= arg < 2pi の場合 41 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 106
```

実行ログは `sagemath/check/106_range_of_args_of_square_of_complex_numbers/logs/` に保存してある（この表の数値はそのログから取った）。
