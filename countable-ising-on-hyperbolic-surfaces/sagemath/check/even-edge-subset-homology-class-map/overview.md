# 偶辺部分集合の第一ホモロジー類写像の検算

**対象ラベル**: `def_even_edge_subset_homology_class_map`

## 対象

- 構造化本文: 「偶辺部分集合の第一ホモロジー類写像」
- 検算範囲: 偶辺部分集合を辺係数写像へ送り、一次サイクル空間から第一ホモロジー群への商写像を合成する定義
- 併せて検証: `def_edge_subset_coefficient_map_over_f2`、`claim_even_edge_subset_maps_to_first_cycle`、`def_first_homology_group_over_f2`
- 帰属: 形式的有限頂点・辺・面集合と `GF(2)` 上の有限行列・有限商。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_composition_definition.sage` | 三本の平行辺からなる有限グラフの全ての偶辺部分集合について、係数写像が一次サイクルとなり、その商写像による像が面境界剰余集合の直接構成と一致して第一ホモロジー群へ入ること | PASS | 四つの偶辺部分集合の全てで合成写像と剰余集合の直接構成が一致し、二元の第一ホモロジー群へ入った |

実行日: 2026-08-16

## 実行方法

```bash
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/even-edge-subset-homology-class-map/check_composition_definition.sage
```
