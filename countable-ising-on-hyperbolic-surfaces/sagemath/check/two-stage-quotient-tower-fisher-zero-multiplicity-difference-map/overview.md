# 商の塔に沿う二段 Fisher 零点重複度差写像の検算

**対象ラベル**: `def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_fisher_zero_multiplicity_difference_map`）
- 範囲: 二段 Fisher 零点重複度対の細段成分から粗段成分を引く整数値写像

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_multiplicity_difference_definition.sage` | `QQbar` 上の共有零点、細段だけの零点、粗段だけの零点について、重複度対の整数差を照合する | PASS | 共有零点 `-1` は `0`、細段だけの四根は `1`、粗段だけの二根は `-1` |

## 備考

- 片段だけの零点は既存の四頂点サイクルと二頂点二重辺グラフの分配多項式で検算した。
- 共有零点を含む例は、両多項式へ一辺グラフの分配多項式 `2(1+x)` を掛けた非連結和として構成した。共通因子 `x+1` により `-1` は両段で重複度 `1` の零点になる。
- 根は `QQbar` の厳密な代数的数として構成し、浮動小数点近似へ変換しない。
- 複素平面への埋め込み、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-difference-map/check_multiplicity_difference_definition.sage
```
