# `F_2` 上の面境界空間の検算

**対象ラベル**: `def_face_boundary_space_over_f2`

## 対象

- 構造化本文: 「`F_2` 上の面境界空間」
- 検算範囲: 二次境界行列の像による定義と、`境界の境界が零` による一次サイクル空間への包含
- 併せて検証: `theorem_boundary_of_boundary_is_zero_over_f2`、`def_first_cycle_space_over_f2`
- 帰属: 形式的な有限ラベル集合と `GF(2)` 上の有限行列。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_image_definition.sage` | 反対向きの三角形二面について、二次境界行列を全ての面係数列へ作用させた集合が行列の列空間および零係数列・全辺係数列と一致することを比較する | PASS | 二次境界行列の像、列空間、期待する二元集合が一致した |
| `check_image_contained_in_cycle_space.sage` | 全ての面係数列について、二つの境界写像の逐次作用と行列積の作用が一致して零となり、像が一次境界写像の核へ含まれることを比較する | PASS | 四つの面係数列全てで合成が零となり、像が核へ含まれた |

実行日: 2026-08-16

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/face-boundary-space-over-f2/check_*.sage; do sage "$f"; done
```
