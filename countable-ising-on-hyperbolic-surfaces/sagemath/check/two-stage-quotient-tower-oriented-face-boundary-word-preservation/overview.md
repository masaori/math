# 商の塔における剰余類面の向き付き境界語保存の検算

**対象ラベル**: `theorem_quotient_tower_oriented_face_boundary_word_preservation`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_oriented_face_boundary_word_preservation`）
- 範囲: 整合する辺代表元選択と誘導面位置写像の下で、細段面位置の辺セルと形式的向きラベルが対応する粗段面位置の境界語へ一致して移ること
- 併せて検証: `def_two_stage_finite_quotient_tower_input`、`def_quotient_tower_role_generator_compatibility`、`def_quotient_tower_induced_coset_cell_maps`、`def_quotient_tower_oriented_edge_representative_selector_compatibility`、`def_quotient_tower_induced_face_position_map`、`def_finite_quotient_oriented_coset_face_boundary_word`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_edge_cell_image.sage` | 全細段面位置について、そこに置かれた細段辺セルの像が対応する粗段面位置の辺セルに一致することを照合する | PASS | 全細段面位置で二つの辺セルが一致した |
| `check_reverse_case.sage` | 細段代表元が位置元に等しい場合、粗段でも代表元が像位置元に等しく、`reverse` が保存されることを照合する | PASS | 全ての細段 `reverse` 境界出現が粗段 `reverse` 境界出現へ移った |
| `check_forward_case.sage` | 細段代表元が位置元と辺半回転の積に等しい場合、粗段でも対応する積に等しく、`forward` が保存されることを照合する | PASS | 全ての細段 `forward` 境界出現が粗段 `forward` 境界出現へ移った |
| `check_boundary_word_preservation.sage` | 誘導辺セル写像と向きラベルの恒等写像を細段境界語へ作用させた結果が、像位置での粗段境界語に一致することを照合する | PASS | 全細段面位置で向き付き境界語の段間等式が成立した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 粗段の面役割生成元は単位元であり、三つの細段面位置が一つの粗段面位置へ移るが、辺セル成分と形式的向きラベルは各位置で保存される。
- 有限置換群、有限商群、有限部分群、有限剰余類集合、形式的向きラベルだけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 局所全単射性と被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-oriented-face-boundary-word-preservation/check_*.sage; do
  sage "$f"
done
```
