# 商の塔における一次サイクルの押し出しの検算

**対象ラベル**: `theorem_quotient_tower_first_cycle_pushforward_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_first_cycle_pushforward_over_f2`）
- 範囲: 細段一次サイクルの辺係数押し出しが粗段一次サイクル空間に属すること
- 併せて検証: `def_first_cycle_space_over_f2`、`def_quotient_tower_edge_coefficient_pushforward_over_f2`、`def_quotient_tower_vertex_coefficient_pushforward_over_f2`、`theorem_quotient_tower_first_boundary_pushforward_commutativity_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_boundary_commutativity_application.sage` | 一次境界写像と押し出しの可換性を全ての細段一次サイクルへ適用する | PASS | 全ての細段一次サイクルで二つの合成の値が一致した |
| `check_fine_cycle_boundary_zero.sage` | 細段一次サイクルの境界が零であることを用いた式変形を照合する | PASS | 全ての細段一次サイクルで境界の押し出しと零写像の押し出しが一致した |
| `check_zero_vertex_pushforward_components.sage` | 零頂点係数写像の押し出しが各粗段頂点成分で零になる二つの等号を照合する | PASS | 全ての粗段頂点成分でファイバー上の零元の有限和が零になった |
| `check_coarse_cycle_membership.sage` | 辺係数押し出し後の粗段一次境界が零であることを直接照合する | PASS | 全ての細段一次サイクルの押し出しが粗段一次サイクル空間に属した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類頂点・辺セル集合と `F_2` 上の厳密有限和だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 第一ホモロジーへの作用、局所全単射性、被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-first-cycle-pushforward-over-f2/check_*.sage; do
  sage "$f"
done
```
