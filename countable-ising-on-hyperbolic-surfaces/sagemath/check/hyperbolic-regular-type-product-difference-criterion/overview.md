# 双曲正則型の積差による特徴付けの検算

**対象ラベル**: `theorem_hyperbolic_regular_type_product_difference_criterion`

## 対象

- 構造化本文: 「双曲正則型の積差による特徴付け」
- 検算範囲: 自然数不等式の整数移送、零との比較への移項、両辺への四の加法、分配律による積差形への因数分解、最終同値性
- 帰属: 全て `NN` と `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_standard_embedding.sage` | 自然数の双曲不等式を整数へ移す | PASS | 三つの正則型で一致 |
| `check_order_translation.sage` | 双曲不等式を零との比較へ移す | PASS | 三つの正則型で同値 |
| `check_add_four.sage` | 両辺へ四を加える | PASS | 三つの正則型で同値 |
| `check_factorization.sage` | 分配律で積差形へ因数分解する | PASS | 三つの正則型で等式が成立 |
| `check_equivalence.sage` | 双曲型と積差不等式の同値性 | PASS | 双曲・Euclid・球面型の三例で一致 |

## 有限例

- 固定剰余類双曲セル分割の型: `(p,q)=(3,7)`
- 一面正方形トーラスの型: `(p,q)=(4,4)`
- 二面三角形球面の型: `(p,q)=(3,2)`

## 実行履歴

- 2026-08-24: 五検算をリポジトリ直下から実行し、全件が終了コード `0` で完了した。

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-product-difference-criterion/check_*.sage; do
  sage "$f"
done
```
