# 商の塔における剰余類セル incidence の順方向保存の検算

**対象ラベル**: `theorem_quotient_tower_coset_cell_incidence_forward_preservation`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_coset_cell_incidence_forward_preservation`）
- 範囲: 細段で交わる面・頂点、面・辺、頂点・辺の左剰余類が、誘導セル写像の下で粗段でも交わること
- 併せて検証: `def_finite_quotient_coset_cell_incidence_relation`、`def_quotient_tower_induced_coset_cell_maps`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_common_witness_image.sage` | 細段剰余類の全ての共通元について、その段間像が二つの剰余類像の双方に属することを照合する | PASS | 全ての共通元の像が二つの剰余類像の双方に属した |
| `check_coset_image_equalities.sage` | 三役割の全細段セルについて、左剰余類の直接像が誘導セル写像で用いる粗段左剰余類に等しいことを照合する | PASS | 全ての直接像が対応する粗段左剰余類と一致した |
| `check_incidence_forward_preservation.sage` | 細段の全 incidence 対について、二つの誘導セル像が粗段でも共通元をもつことを照合する | PASS | 三種の全 incidence 対が粗段でも incident となった |

## 備考

- 有限置換群、有限商群、有限部分群、有限剰余類集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 順方向の incidence 保存だけを検証する。逆方向、端点写像、面境界語、閉曲面性、正則性、向き付けの保存は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-incidence-forward-preservation/check_*.sage; do
  sage "$f"
done
```
