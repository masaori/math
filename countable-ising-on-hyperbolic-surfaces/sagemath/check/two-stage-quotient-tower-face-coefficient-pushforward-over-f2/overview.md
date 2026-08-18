# 商の塔が誘導する F_2 面係数押し出し写像の検算

**対象ラベル**: `def_quotient_tower_face_coefficient_pushforward_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_face_coefficient_pushforward_over_f2`）
- 範囲: 細段面係数写像を、誘導面セル写像の各有限ファイバーで加えて粗段面係数写像へ送る写像の始域・終域・作用
- 併せて検証: `def_quotient_tower_induced_coset_cell_maps`、`def_second_boundary_matrix_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_fiber_sum_definition.sage` | 全細段面係数写像と全粗段面セルについて、押し出し後の係数が誘導面セル写像のファイバー上の厳密な `F_2` 和に一致することを照合する | PASS | 全ての細段面係数写像と粗段面セル成分で、押し出し後の係数が有限ファイバー上の厳密な `F_2` 和に一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類面セル集合と `F_2` 上の厳密有限和だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この検算は面係数空間間の写像だけを対象とし、二次境界写像との可換性、面境界空間への作用、第一ホモロジーへの作用、局所全単射性、被覆次数を主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-face-coefficient-pushforward-over-f2/check_fiber_sum_definition.sage
```
