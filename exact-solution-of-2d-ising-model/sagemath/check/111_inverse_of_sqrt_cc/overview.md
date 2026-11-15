# SageMath Check: 111_inverse_of_sqrt_cc

## 対象

**対象ラベル**: `inverse_of_sqrt_cc` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: √(1/z) と 1/√z の関係（<sqrt_cc_of_inverse> と同内容）

arg z = 0 のときだけ符号が一致し、それ以外では反転する。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_inverse.sage` | 場合分けの両方 | 155 | 4.965e-16 | **PASS** |
| 02 | `check_phi_polar_of_one_chain.sage` | 証明の第四の φ_polar(1_C) の鎖の根号の中の ℝ の計算（1^2 = 1、0^2 = 0·0、0·0 = 0（`real_zero_times_is_zero`）、1 + 0 = 1（`set_and_algebra_notation` の加法の単位元））と √1 = 1・1 ≠ 0（体の公理）・0/1 = 0（`real_zero_divided_is_zero`（`x → 1`））を ℚ・AA で厳密に（最後の行 arctan 0 = 0 は `arctan_zero` の検算） | 7 | 0 | **PASS** |
| 03 | `check_sqrt_of_one_chain.sage` | 証明の第四の √(1_C) の鎖の偏角の ℝ の計算 3 行（0/2 = 0（`real_zero_divided_is_zero`（`x → 2`。`2` は `def_real_two` の `1 + 1`、`2 ≠ 0` は `real_two_is_nonzero`））、0·π = 0（`real_zero_times_is_zero`）、0 − 0 = 0（`real_minus_zero_is_self`（`a → 0`）））と cos 0 = 1・sin 0 = 0（`cosine_zero`・`sine_zero`）・1·x = x（`set_and_algebra_notation` の乗法の単位元）の行を QQ・AA・記号計算で厳密に。否定の対照 2 件 | 13 | 0 | **PASS** |
| 04 | `check_zero_angle_integer_chain.sage` | 証明の準備の第三の `0_C·0_C = 0_C`（`complex_zero_times_is_zero` の `z → 0_C`）の成分の鎖を ℚ の対で、第四で引く `angle_section_integer_of_zero_is_zero` の当てはめ（代表元 `(1, 0)` の偏角 `0` に対する整数が `0`）を、RIF の π で `0 ≤ 0 − 2kπ < 2π` を満たす整数を `−5 ≤ k ≤ 5` で走査して `k = 0` だけになることで確かめる（当てはめの裏取りとして残した。主張そのものの検算は `angle_section_integer_of_zero_is_zero/`。`0 − 2·0·π = 0` の鎖は 2026-11-15 にその主張へ移した）。否定の対照 2 件 | 8 | 0 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

<sqrt_cc_of_inverse> は同じ内容を (√z)^{-1} の側から述べたもので、同じ check で併せて確認している。

## 実行時に出力された観測値

```
  arg=0 の場合 3 件、0<arg<2pi の場合 73 件
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 111
```

実行ログは `sagemath/check/111_inverse_of_sqrt_cc/logs/` に保存してある（この表の数値はそのログから取った）。
