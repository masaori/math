# 商の塔が誘導する剰余類セル写像の検算

**対象ラベル**: `def_quotient_tower_induced_coset_cell_maps`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_induced_coset_cell_maps`）
- 範囲: 細段役割安定化部分群の像、面・頂点・辺の誘導剰余類セル写像、その代表元非依存性と全射性

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_stabilizer_images.sage` | `S_4` の Klein 四元部分群による六元商から交代群による二元商への段間写像が、三つの細段役割安定化部分群を対応する粗段部分群へ移すことを照合する | PASS | 三つの細段役割安定化部分群の像が対応する粗段部分群と一致した |
| `check_representative_independence.sage` | 三役割の全細段セルについて、同じ左剰余類の全代表が同じ粗段セルへ移ることを照合する | PASS | 全ての代表が同じ粗段セルへ移った |
| `check_induced_cell_maps.sage` | 段ラベルと役割ラベルを保つ三つの誘導セル写像を構成し、粗段セル集合への全射性を照合する | PASS | 三写像が段・役割ラベルを保ち、各粗段セル集合へ全射となった |

## 備考

- 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この検算はセルラベルの写像だけを対象とし、端点、面境界語、incidence、閉曲面性、正則性、向き付けの保存を主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-coset-cell-maps/check_*.sage; do
  sage "$f"
done
```
