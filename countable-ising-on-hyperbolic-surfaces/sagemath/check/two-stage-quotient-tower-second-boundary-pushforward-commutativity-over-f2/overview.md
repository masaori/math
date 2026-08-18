# 商の塔における F_2 二次境界写像と押し出しの可換性の検算

**対象ラベル**: `theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_second_boundary_pushforward_commutativity_over_f2`）
- 範囲: 粗段二次境界と面係数押し出しの合成が、辺係数押し出しと細段二次境界の合成に一致すること
- 併せて検証: `def_second_boundary_matrix_over_f2`、`def_quotient_tower_induced_face_position_map`、`theorem_quotient_tower_oriented_face_boundary_word_preservation`、`def_quotient_tower_face_coefficient_pushforward_over_f2`、`def_quotient_tower_edge_coefficient_pushforward_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_position_fiber_oddness.sage` | 全細段面と像の全粗段位置について、誘導位置写像のファイバーが三元であり `F_2` で奇数となることを照合する | PASS | 全位置ファイバーが三元であり、その `F_2` 濃度が `1` である |
| `check_coarse_boundary_expansion.sage` | 粗段二次境界と面係数押し出しの合成を粗段面・境界位置・面ファイバーの有限和へ展開する | PASS | 粗段二次境界の定義展開が全成分で一致する |
| `check_face_fiber_reindexing.sage` | 粗段面ごとのファイバー和を細段面全体の和へ添字付け替えする | PASS | 面ファイバーによる有限和の添字付け替えが全成分で一致する |
| `check_odd_position_fiber_incidence.sage` | 向き付き境界語の辺成分保存と奇数位置ファイバー条件から、細段面と像の粗段面の辺 incidence が `F_2` 上で一致することを照合する | PASS | 奇数位置ファイバー条件から両段の辺 incidence が全成分で一致する |
| `check_edge_fiber_reindexing.sage` | 細段面位置の和を誘導辺セル写像のファイバーごとにまとめ直す | PASS | 辺ファイバーによる有限和の添字付け替えが全成分で一致する |
| `check_commuting_composites.sage` | 二つの合成写像を全ての細段面係数写像で直接比較する | PASS | 全ての細段面係数写像について二つの合成が一致する |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。この例では各細段面の三位置が像の粗段面の一位置へ移るため、位置ファイバーは三元である。
- 位置写像が非単射である場合、向き付き境界語の点ごとの保存だけでは二次境界との可換性は従わない。本文では各位置ファイバーの `F_2` 濃度が `1` である奇数ファイバー条件を明示した。
- 有限剰余類面・辺セル集合、有限境界位置集合、`F_2` 上の厳密有限和だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この定理から面境界空間への押し出しは従うが、この tick では別の主張として本文へ追加しない。第一ホモロジーへの作用、局所全単射性、被覆次数も主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-second-boundary-pushforward-commutativity-over-f2/check_*.sage; do
  sage "$f"
done
```
