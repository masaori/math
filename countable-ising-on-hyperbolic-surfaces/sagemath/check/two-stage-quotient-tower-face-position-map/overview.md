# 商の塔が誘導する剰余類面の巡回位置写像の検算

**対象ラベル**: `def_quotient_tower_induced_face_position_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_induced_face_position_map`）
- 範囲: 細段面位置を対応する粗段面位置へ送る有限写像の well-defined 性と、面回転による次位置写像との可換性
- 併せて検証: `def_quotient_tower_induced_coset_cell_maps`、`def_quotient_tower_role_generator_compatibility`、`def_finite_quotient_face_cyclic_position_system`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_position_image_membership.sage` | 全細段面位置の像が、誘導された粗段面の位置集合に属することを照合する | PASS | 全細段面位置の像が対応する粗段面位置集合に属した |
| `check_successor_product_image.sage` | 面回転との積の像が、各因子の像の積に一致することを照合する | PASS | 全細段面位置で積の像と像の積が一致した |
| `check_face_role_generator_image.sage` | 細段の面役割生成元の像が粗段の面役割生成元に一致することを照合する | PASS | 全細段面位置で面役割生成元の置換が一致した |
| `check_successor_commutation.sage` | 全細段面位置で、位置写像と次位置写像の合成順序を交換しても結果が一致することを照合する | PASS | 全細段面位置で二つの合成写像の値が一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 粗段の面役割生成元は単位元になるため、細段の三位置が粗段の一位置へ移る。この非単射性を許した上で可換性を検査する。
- 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 向き付き面境界語、局所全単射性、被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-face-position-map/check_*.sage; do
  sage "$f"
done
```
