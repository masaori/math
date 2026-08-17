# 商の塔における向き付き辺端点写像の保存の検算

**対象ラベル**: `theorem_quotient_tower_oriented_edge_endpoint_map_preservation`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_oriented_edge_endpoint_map_preservation`）
- 範囲: 整合する辺代表元選択の下で、細段辺の始点・終点が誘導頂点写像により像辺の粗段始点・終点へ移る二等式
- 併せて検証: `def_two_stage_finite_quotient_tower_input`、`def_quotient_tower_role_generator_compatibility`、`def_quotient_tower_induced_coset_cell_maps`、`def_quotient_tower_oriented_edge_representative_selector_compatibility`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_source_endpoint_image.sage` | 全細段辺について、始点頂点セルの像と像辺の粗段始点が一致することを照合する | PASS | 全細段辺で二つの始点頂点セルが一致した |
| `check_target_product_image.sage` | 全細段辺について、終点代表元を作る積が段間群準同型で積へ移ることを照合する | PASS | 全細段辺で積の像と像の積が一致した |
| `check_target_endpoint_image.sage` | 全細段辺について、終点頂点セルの像と像辺の粗段終点が一致することを照合する | PASS | 全細段辺で二つの終点頂点セルが一致した |

## 備考

- 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 始点等式では代表元選択の可換条件、終点等式ではさらに段間写像の群準同型性と辺役割生成元の整合性を用いる。
- 面境界語の保存、局所全単射性、被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-oriented-edge-endpoint-preservation/check_*.sage; do
  sage "$f"
done
```
