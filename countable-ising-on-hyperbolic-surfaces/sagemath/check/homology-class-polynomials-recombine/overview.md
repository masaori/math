# 第一ホモロジー類別生成多項式の再結合の検算

**対象ラベル**: `theorem_homology_class_polynomials_recombine`

## 対象

- 構造化本文: 「第一ホモロジー類別生成多項式の再結合」
- 検算範囲: 類別多項式の定義展開、ホモロジー類写像のファイバーによる有限和の分割、偶部分グラフ多項式の定義への帰着
- 併せて検証: `def_homology_class_generating_polynomial`、`def_even_edge_subset_homology_class_map`、`def_even_subgraph_polynomial`
- 帰属: 形式的有限頂点・辺・面集合、`GF(2)` 上の有限商、`ZZ[u,v]`。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_expand_sector_definitions.sage` | 全ホモロジー類について類別生成多項式の定義を展開する | PASS | 類別多項式の総和と二重有限和はともに `u^3 + 3uv^2` となった |
| `check_fiber_partition_sum.sage` | ファイバーが全偶辺部分集合を重複なく分割し、有限和が一致することを確認する | PASS | 二つのファイバーは互いに素で、その和集合は全偶辺部分集合に一致した |
| `check_even_subgraph_polynomial_definition.sage` | 再結合後の有限和が偶部分グラフ多項式の定義に一致することを確認する | PASS | 再結合後の有限和は `u^3 + 3uv^2` となり、偶部分グラフ多項式に一致した |

実行日: 2026-08-16

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/homology-class-polynomials-recombine/check_*.sage; do
  sage "$f"
done
```
