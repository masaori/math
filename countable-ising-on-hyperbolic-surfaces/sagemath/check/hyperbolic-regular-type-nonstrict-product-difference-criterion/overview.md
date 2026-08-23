# 双曲正則型の非狭義積差による特徴付けの検算

**対象ラベル**: `theorem_hyperbolic_regular_type_nonstrict_product_difference_criterion`

## 対象

- 構造化本文: 「双曲正則型の非狭義積差による特徴付け」
- 検算範囲: 整数の狭義下界 `4` と非狭義下界 `5` の同値性、双曲条件との最終同値性
- 帰属: 全て `NN` と `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_integer_discreteness.sage` | 整数順序の離散性により `4<n` と `5<=n` が同値 | PASS | 三つの正則型で一致 |
| `check_equivalence.sage` | 双曲型と非狭義積差不等式の同値性 | PASS | 双曲・Euclid・球面型の三例で一致 |

## 有限例

- 固定剰余類双曲セル分割の型: `(p,q)=(3,7)`
- 一面正方形トーラスの型: `(p,q)=(4,4)`
- 二面三角形球面の型: `(p,q)=(3,2)`

## 実行履歴

- 2026-08-24: 二検算をリポジトリ直下から実行し、全件が終了コード `0` で完了した。
- 2026-08-24: 最終再実行を `structured-latex/` から起動したため、リポジトリ直下相対パスの対象 glob を解決できず `File 'countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-nonstrict-product-difference-criterion/check_*.sage' is missing` で ERROR。数学的検算は実行されていない。リポジトリ直下へ戻して同じ二検算を再実行し、全件 PASS を確認した。

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-nonstrict-product-difference-criterion/check_*.sage; do
  sage "$f"
done
```
