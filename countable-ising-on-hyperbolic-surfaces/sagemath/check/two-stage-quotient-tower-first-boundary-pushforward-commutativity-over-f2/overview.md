# 商の塔における F_2 一次境界写像と押し出しの可換性の検算

**対象ラベル**: `theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_first_boundary_pushforward_commutativity_over_f2`）
- 範囲: 粗段一次境界と辺係数押し出しの合成が、頂点係数押し出しと細段一次境界の合成に一致すること
- 併せて検証: `def_first_boundary_matrix_over_f2`、`theorem_quotient_tower_oriented_edge_endpoint_map_preservation`、`def_quotient_tower_edge_coefficient_pushforward_over_f2`、`def_quotient_tower_vertex_coefficient_pushforward_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coarse_boundary_expansion.sage` | 粗段一次境界と辺係数押し出しの合成を、粗段 incidence の有限和へ展開する | PASS | 全ての細段辺係数写像と粗段頂点成分で定義展開が一致した |
| `check_edge_fiber_reindexing.sage` | 粗段辺ごとのファイバー和を細段辺全体の和へ添字付け替えする | PASS | 全ての細段辺係数写像と粗段頂点成分で二つの有限和が一致した |
| `check_endpoint_fiber_identity.sage` | 端点保存から、像辺の粗段 incidence が対応する細段頂点ファイバーの incidence 和に一致することを照合する | PASS | 全ての細段辺と粗段頂点の組で一致した |
| `check_fine_boundary_vertex_fiber_expansion.sage` | 細段一次境界と頂点係数押し出しの合成を、細段頂点ファイバー上の有限和へ展開する | PASS | 全ての細段辺係数写像と粗段頂点成分で定義展開が一致した |
| `check_commuting_composites.sage` | 二つの合成写像を全ての細段辺係数写像で直接比較する | PASS | 全ての細段辺係数写像で粗段頂点係数写像が一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類頂点・辺セル集合、形式的辺端ラベル、`F_2` 上の厳密有限和だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この定理から一次サイクル空間への制限は従うが、この tick では別の主張として本文へ追加しない。第一ホモロジーへの作用、局所全単射性、被覆次数も主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-first-boundary-pushforward-commutativity-over-f2/check_*.sage; do
  sage "$f"
done
```
