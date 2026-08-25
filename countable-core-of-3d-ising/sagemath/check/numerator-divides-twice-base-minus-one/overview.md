# SageMath Check: 二つの箱の整除を箱の大きさに依存しない形へまとめる

## 対象

**対象ラベル**: `claim_numerator_divides_twice_base_minus_one`

- ファイル: `structured-latex/content/partition-values.ts`
- 範囲: 最大公約数の二倍への移送、隣接指数の互いに素性による箱サイズの消去、最終整除

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_gcd_scaling.sage` | `gcd(2u,2v)=2gcd(u,v)` を相互整除とともに確認する | PASS | `ZZ` 上の有限標本で成立 |
| `check_gcd_chain.sage` | 隣接指数の最大公約数から `2(c-1)` へ至る三段を確認する | PASS | `ZZ` 上の有限標本で成立 |
| `check_final_divisibility.sage` | 二つの整除を最大公約数でまとめた最終整除を確認する | PASS | `ZZ` 上の有限標本で成立 |

## 備考

- `ZZ` の厳密計算だけを使う。
- 箱の大きさの極限、浮動小数点、実対数、指数関数、無限和、級数、積分、微分は使わない。
- 実行日: 2026-08-26。三検査とも `RESULT: PASS`。

## 実行方法

```bash
for f in sagemath/check/numerator-divides-twice-base-minus-one/check_*.sage; do sage "$f"; done
```
