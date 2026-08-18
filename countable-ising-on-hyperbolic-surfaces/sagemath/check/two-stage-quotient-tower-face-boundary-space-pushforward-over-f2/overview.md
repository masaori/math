# 商の塔における面境界空間の押し出しの検算

**対象ラベル**: `theorem_quotient_tower_face_boundary_space_pushforward_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_face_boundary_space_pushforward_over_f2`）
- 範囲: 細段面境界空間の各元を辺係数押し出しで送ると粗段面境界空間に属すること
- 併せて検証: `def_face_boundary_space_over_f2`、`def_quotient_tower_face_coefficient_pushforward_over_f2`、`def_quotient_tower_edge_coefficient_pushforward_over_f2`、`theorem_quotient_tower_second_boundary_pushforward_commutativity_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_boundary_image_membership.sage` | 全ての細段面境界を列挙し、辺係数押し出しの像が粗段二次境界の像に含まれることを照合する | PASS | 全細段面境界の押し出しが粗段面境界空間に属した |
| `check_commutativity_witness.sage` | 各細段面係数について、その面係数押し出しが押し出された面境界の粗段 witness になることを照合する | PASS | 全細段面係数で二次境界と押し出しの可換等式が witness を与えた |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類面・辺セル集合、有限境界位置集合、`F_2` 上の厳密有限和だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 第一ホモロジー群上の誘導写像、局所全単射性、被覆次数はこの主張に含めない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-face-boundary-space-pushforward-over-f2/check_*.sage; do
  sage "$f"
done
```
