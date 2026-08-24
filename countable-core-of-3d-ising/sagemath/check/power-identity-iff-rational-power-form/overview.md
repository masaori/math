# SageMath Check: 冪等式と正の有理数の点数乗表示の同値

## 対象

**対象ラベル**: `claim_power_identity_iff_rational_power_form`

- ファイル: `structured-latex/content/partition-values.ts`（ブロック `soundness_bridge_claim_power_identity_iff_rational_power_form`）
- 範囲: 点数乗表示から交差冪等式を得る向きと、交差冪等式から素指数の商を一定にして正の有理数を有限積で復元する逆向き
- 併せて検証: `def_positive_rational_prime_exponent_data`

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_power_form_implies_cross_power.sage` | 点数乗表示から両側の交差冪が同じ冪になる式変形 | PASS | 正の有理数 4 個と箱サイズ 1 から 5 で成立 |
| `check_cross_power_exponents_are_site_count_multiples.sage` | 素指数の交差等式、隣接立方数の互いに素性、点数による可除性、商の不変性 | PASS | 正負と零を含む素指数 5 個と箱サイズ 1 から 7 で成立 |
| `check_prime_exponents_reconstruct_rational_base.sage` | 有限個の非零素指数から正の有理数を復元し、各値の点数乗表示を得る段 | PASS | 四素数を台に持つ正の有理数と箱サイズ 1 から 6 で成立 |

## 備考

- `QQ` と `ZZ` だけを使い、本文の可算側の式変形を厳密に検査する。
- 全称的な同値性は Lean 具体版で形式化する対象として残し、ここでは複数の正負の素指数、箱サイズ、正の有理数について各段を検査する。
- 浮動小数点、無限積、級数、箱の大きさの極限は使わない。
- 2026-08-24 に全ファイルを実行し、すべて通過した。

## 実行方法

```sh
for f in sagemath/check/power-identity-iff-rational-power-form/check_*.sage; do sage "$f"; done
```
