# SageMath Check: 121_multiplicative_group_of_cc

## 対象

**対象ラベル**: `multiplicative_group_of_cc` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`

- 範囲: C^× = C∖{0} が乗法群をなすこと、z^{-1} = 1/z

閉性（非零どうしの積が非零）・結合律・単位元・逆元を多数のサンプルで確認する。逆元は成分から明示的に構成したものと 1/z を突き合わせる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_group.sage` | 群の公理と逆元の表示 | 5520 | 3.163e-16 | **PASS** |
| 02 | `check_02_zero_factor_rows.sage` | 証明の積の単位元の鎖・`a = b = 0` の平方和の鎖・`1_C` の平方和の鎖を一行ずつ。`0` を因子にもつ積の行は `real_times_zero_is_zero`（積の単位元の鎖、`x → b, a`）・`real_zero_times_is_zero`（平方和の二つの鎖、`x → 0`）、平方を積に開く行は `square_of_real_number_is_product` に当たる。積の単位元の鎖の `a − 0 = a` の行は `real_minus_zero_is_self`（`a → a`）、続く行は `0` は ℝ の加法の単位元（`set_and_algebra_notation`。`0 + x = x` の `x → b`）に当たる。`QQ[a, b]` の多項式の等号で比べ、平方和の鎖には対照（仮定なしでは `a² + b² ≠ 0`）を置く | 鎖 3 本 | 厳密（`QQ`） | **PASS** |
| 03 | `check_03_additive_identity_rows.sage` | 証明の 7 行（うち積の単位元の鎖の最後の行は 2026-11-17 に `complex_one_is_multiplicative_identity` へ、閉性の恒等式の行は同じ日に `product_of_sums_of_two_squares_identity` へ移った）の「`0` は ℝ の加法の単位元（`set_and_algebra_notation`）」を、行に書いた形（`0 + x = x` または `x + 0 = x`）と代入どおりに一行ずつ。置き換えた行を含む鎖の両端の一致と、対照（`1 + b ≠ b`）を置く。`QQ[a, b, c, d]` の多項式の等号で比べる | 7 行 | 厳密（`QQ`） | **PASS** |
| 04 | `check_unit_rows_cite_set_and_algebra_notation.sage` | 積の単位元の鎖の `(a·1 − b·0, a·0 + b·1) = (a − b·0, a·0 + b)`（`x·1 = x` の `x → a, x → b`）と `1_C` の平方和の鎖の `1·1 + 0·0 = 1 + 0·0`（`x → 1`）を、行に書いた形と代入どおりに（`set_and_algebra_notation`）。対照（`2a ≠ a`）。`QQ[a, b]` の多項式の等号で比べる | 2 行 | 厳密（`QQ`） | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 121
```

実行ログは `sagemath/check/121_multiplicative_group_of_cc/logs/` に保存してある（この表の数値はそのログから取った）。

2026-11-17: 証明の「積の結合律」「積の単位元」の段は、独立した主張 `complex_multiplication_is_associative`・`complex_one_is_multiplicative_identity` の証明へ移った（式は不変）。`check_01_group.sage` の結合律・単位元の判定、`check_02_zero_factor_rows.sage` の積の単位元の鎖、`check_03_additive_identity_rows.sage` の積の単位元の鎖の最後の行（`0 + x = x` の `x → b`）、`check_04` の積の単位元の鎖の行は、移った先の鎖と同じ式を確かめている。移った先の鎖の一行ずつの検算は `sagemath/check/complex_multiplication_is_associative/`・`sagemath/check/complex_one_is_multiplicative_identity/` にある。

2026-11-17: 証明の「積について閉じること」の段の恒等式 `(ac−bd)²+(ad+bc)² = (a²+b²)(c²+d²)` は、独立した主張 `product_of_sums_of_two_squares_identity` の証明へ移った（式は不変）。`check_03_additive_identity_rows.sage` の閉性の恒等式の行（`x + 0 = x`）は、移った先の鎖と同じ式を確かめている。移った先の鎖の一行ずつの検算は `sagemath/check/product_of_sums_of_two_squares_identity/` にある。
