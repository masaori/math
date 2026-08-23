# 正則セル分割の Euler 標数と incidence 数の等式の検算

**対象ラベル**: `theorem_regular_cellulation_euler_incidence_identity`

## 対象

- 構造化本文: 「正則セル分割の Euler 標数と incidence 数の等式」
- 検算範囲: `pq chi = (2p + 2q - pq)|E|` に至る九つの整数等式
- 帰属: 全て `ZZ`。実数、複素数、浮動小数点、極限、積分を用いない

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_euler_definition.sage` | Euler 標数の定義の代入 | PASS | 三例で整数等式が一致 |
| `check_distributive_expansion.sage` | 整数分配律による展開 | PASS | 三例で整数等式が一致 |
| `check_factor_grouping.sage` | 整数乗法の結合律・交換律による括り直し | PASS | 三例で整数等式が一致 |
| `check_embedding_products.sage` | 標準単射による二つの自然数積の移送 | PASS | 三例で整数等式が一致 |
| `check_vertex_edge_substitution.sage` | `q|V|=2|E|` の代入 | PASS | 三例で整数等式が一致 |
| `check_vertex_edge_embedding.sage` | 頂点側の `2|E|` の整数移送 | PASS | 三例で整数等式が一致 |
| `check_face_edge_substitution.sage` | `p|F|=2|E|` の代入 | PASS | 三例で整数等式が一致 |
| `check_face_edge_embedding.sage` | 面側の `2|E|` の整数移送 | PASS | 三例で整数等式が一致 |
| `check_final_factorization.sage` | 最終的な整数分配律による因数分解 | PASS | 三例で整数等式が一致 |

## 有限例

- 二面三角形球面: `(p,q,|V|,|E|,|F|)=(3,2,3,3,2)`
- 一面正方形トーラス: `(4,4,1,2,1)`
- 固定剰余類双曲セル分割: `(3,7,24,84,56)`

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/regular-cellulation-euler-incidence-identity/check_*.sage; do
  sage "$f"
done
```
