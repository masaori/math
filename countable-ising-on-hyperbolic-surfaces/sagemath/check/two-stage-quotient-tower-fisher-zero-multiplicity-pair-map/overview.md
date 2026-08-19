# 商の塔に沿う二段 Fisher 零点重複度対写像の検算

**対象ラベル**: `def_quotient_tower_two_stage_fisher_zero_multiplicity_pair_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_fisher_zero_multiplicity_pair_map`）
- 範囲: 二段の分配多項式の零点台の和集合と、各代数的数における零延長した重複度対の定義

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_multiplicity_pair_definition.sage` | 四頂点サイクルと二頂点二重辺グラフの分配多項式について、`QQbar` 上の零点台の和集合と零延長した重複度対を照合する | PASS | 和集合は六元であり、細段だけの四根は `(1,0)`、粗段だけの二根は `(0,1)` |

## 備考

- 細段多項式は `2 + 12*x^2 + 2*x^4`、粗段多項式は `2 + 2*x^2` である。
- 根は `QQbar` の厳密な代数的数として構成し、浮動小数点近似へ変換しない。
- 複素平面への埋め込み、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-pair-map/check_multiplicity_pair_definition.sage
```
