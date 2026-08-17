# 商の塔における向き付き辺代表元選択の整合性の検算

**対象ラベル**: `def_quotient_tower_oriented_edge_representative_selector_compatibility`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_oriented_edge_representative_selector_compatibility`）
- 範囲: 細段と粗段で別々に置いた有限な辺代表元選択写像、および細段代表元の段間像が像辺セルの粗段代表元に一致する可換条件
- 併せて検証: `def_quotient_tower_induced_coset_cell_maps`、`def_finite_quotient_oriented_coset_edge_endpoint_data`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_selector_membership.sage` | 細段と粗段の全辺剰余類について、各代表元選択写像の値が対応する剰余類に属することを照合する | PASS | 両段の全辺剰余類で選択値が対応する剰余類に属した |
| `check_stage_map_commutes.sage` | 全ての細段辺剰余類について、選択代表元の段間像が誘導された粗段辺剰余類の選択代表元に一致することを照合する | PASS | 全ての細段選択代表元の像が対応する粗段選択代表元と一致した |

## 備考

- 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この検算は代表元選択の可換条件だけを対象とする。端点写像と面境界語の保存は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-oriented-edge-representative-selectors/check_*.sage; do
  sage "$f"
done
```
