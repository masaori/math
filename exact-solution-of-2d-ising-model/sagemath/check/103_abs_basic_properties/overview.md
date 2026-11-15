# SageMath Check: 103_abs_basic_properties

## 対象

**対象ラベル**: `abs_basic_properties` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_30_44.ts`

- 範囲: (1) |z|=√(x²+y²)、(2) |z|²=x²+y²、(3) |z|=0⟺z=0、(4) 乗法性、(5) 三角不等式、(6) 実数の包含との整合

|z| := pr₁(φ_polar(z)) という定義どおりの経路（`_prelude.sage` で φ_polar を場合分けから組んだもの）と、成分から直接計算した √(x²+y²) を突き合わせる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_abs.sage` | (1)〜(6) と三角不等式の等号（同じ偏角） | 1493 | 5.393e-16 | **PASS** |
| 02 | `check_02_sqrt_of_square_lines_exact.sage` | (1) の `x = 0, y > 0` の行 `√(y^2) = y` と `x = 0, y < 0` の行 `√((−y)^2) = −y`（`definition_of_sqrt_r_positive` のただ一つの非負の元。`QQ` の `y` と `AA` で厳密）と、符号を取り違えた元が根でない否定の対照 | 24（等号 12・否定の対照 12） | 厳密 | **PASS** |
| part6 | `check_part6_sqrt_of_square_lines_exact.sage` | (6) の `x ≥ 0` の行 `√(x^2) = x`（`x = 0` を含む）と `x < 0` の行 `√((−x)^2) = −x`（`definition_of_sqrt_r_positive` のただ一つの非負の元。`QQ` の `x` と `AA` で厳密）と、符号を取り違えた元が根でない否定の対照 | 25（等号 13・否定の対照 12） | 厳密 | **PASS** |
| 03 | `check_03_zero_square_rows.sage` | (1) の `x = 0` の三つの場合・(3) の `|z| = 0` の場合・(6) の鎖の `0^2 = 0·0`（`square_of_real_number_is_product`、`r → 0`）と `0·0 = 0`（`real_zero_times_is_zero`、`x → 0`）の行（平方根の中身を `QQ[x, y]` の多項式で一行ずつ）と、代入をしない否定の対照 | 15（等号 13・否定の対照 2） | 厳密 | **PASS** |
| square product | `check_square_product_and_sqrt_definition_rows.sage` | 非負実数の平方の比較の鎖の両端 `u^2 = u·u`・`v·v = v^2`（`square_of_real_number_is_product`、`QQ[u, v]` で厳密）と、(2) の行 `(√(x^2+y^2))^2 = x^2+y^2`（`definition_of_sqrt_r_positive` の `u^2 = s`、`QQ` の `x, y` と `AA` で厳密）と、因子の取り違え・負の根の否定の対照 | 162（等号） | 厳密 | **PASS** |
| negation square | `check_negation_square_rows.sage` | (1) の `x = 0, y < 0` の鎖と (6) の `x < 0` の鎖の平方根の中身の 3 行 `t^2 = t·t`（`square_of_real_number_is_product`、`r → t`）・`t·t = (−t)·(−t)`（`real_negation_times_negation_is_product`、`a, b → t` を右辺から左辺へ。`−t` を不定元に置き、その段だけを `−t` の代入で確かめる）・`(−t)·(−t) = (−t)^2`（`r → −t` を右辺から左辺へ）を `t` について確かめ、`t → y`・`t → x` の 2 つの鎖で共用する（`QQ[t, nt]` で厳密）と、片方の因子だけ符号を反転した否定の対照 | 4（等号 3・否定の対照 1） | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない（01 だけ。02・part6・square product は `AA`（square product の平方の行は `QQ[u, v]`）、03 は `QQ[x, y]`、negation square は `QQ[t, nt]` の厳密計算）。

## 備考

サンプルには 0、実軸上、虚軸上、各象限、1e-9 スケール、1e6 スケール、単位円上を 15° 刻みで含めている。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 103
```

実行ログは `sagemath/check/103_abs_basic_properties/logs/` に保存してある（この表の数値はそのログから取った）。
