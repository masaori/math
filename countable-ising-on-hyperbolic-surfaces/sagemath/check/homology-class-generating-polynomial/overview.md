# 第一ホモロジー類別の高温生成多項式の検算

**対象ラベル**: `def_homology_class_generating_polynomial`

## 対象

- 構造化本文: 「第一ホモロジー類別の高温生成多項式」
- 検算範囲: 第一ホモロジー類写像の各ファイバーに属する偶辺部分集合の単項式を `ZZ[u,v]` で有限和する定義
- 併せて検証: `def_even_edge_subset_homology_class_map`
- 帰属: 形式的有限頂点・辺・面集合、`GF(2)` 上の有限商、`ZZ[u,v]`。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_fiber_definition.sage` | 三本の平行辺からなる有限グラフで、二つのホモロジー類のファイバーと類別多項式を全列挙し、商集合の同じ元を与える二代表で値が変わらないことを確認する | PASS | 零類は `u^3 + uv^2`、非零類は `2uv^2` となり、ファイバーは全偶辺部分集合を重複なく分割した |

実行日: 2026-08-16

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/homology-class-generating-polynomial/check_fiber_definition.sage
```
