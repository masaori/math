# 正則型の双曲性と負の Euler 標数の同値性の検算

**対象ラベル**: `theorem_hyperbolic_regular_type_iff_negative_euler_characteristic`

## 対象

- 構造化本文: 「正則型の双曲性と負の Euler 標数の同値性」
- 検算範囲: 既存の順方向、負の Euler 標数への正因子の乗算、Euler incidence 等式の代入、正の辺数因子の消去、整数不等式の移項、自然数不等式への反映、最終同値性
- 帰属: 全て `NN` と `ZZ`。除算、実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_forward_implication.sage` | 双曲正則型から負の Euler 標数への順方向 | PASS | 三つの正則セル分割で含意が成立 |
| `check_positive_factor_multiplication.sage` | 負の Euler 標数へ正の incidence 因子を掛ける | PASS | 固定剰余類双曲セル分割で一致 |
| `check_euler_incidence_substitution.sage` | Euler incidence 等式で二つの積を置換する | PASS | 固定剰余類双曲セル分割で一致 |
| `check_positive_edge_factor_cancellation.sage` | 正の辺数因子から係数の負性を反映する | PASS | 辺数 `84` で一致 |
| `check_integer_inequality_rearrangement.sage` | 係数の負性を整数の双曲不等式へ移す | PASS | 整数の順序比較が一致 |
| `check_natural_inequality_reflection.sage` | 整数の双曲不等式を自然数へ反映する | PASS | 型 `(3,7)` で一致 |
| `check_equivalence.sage` | 双曲型と負の Euler 標数の同値性 | PASS | 双曲・Euclid・球面型の三例で一致 |

## 有限例

- 固定剰余類双曲セル分割: `(p,q,|V|,|E|,|F|)=(3,7,24,84,56)`
- 一面正方形トーラス: `(4,4,1,2,1)`
- 二面三角形球面: `(3,2,3,3,2)`

## 実行履歴

- 2026-08-24: 七検算をリポジトリ直下から実行し、全件が終了コード `0` で完了した。

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/check_*.sage; do
  sage "$f"
done
```
