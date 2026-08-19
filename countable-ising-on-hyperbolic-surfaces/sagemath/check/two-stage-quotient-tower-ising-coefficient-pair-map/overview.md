# 商の塔に沿う二段 Ising 係数対写像の検算

**対象ラベル**: `def_quotient_tower_two_stage_ising_coefficient_pair_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_ising_coefficient_pair_map`）
- 範囲: 細段・粗段の破れ辺数多重度を自然数全体へ零延長して一つの係数対にする定義

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_pair_definition.sage` | 端点を保存する二段写像を照合し、四頂点サイクルと二頂点二重辺グラフの全配位から生係数と次数外の零延長を検算する | PASS | 全四辺で端点が保存され、係数対 `(2,2),(0,0),(12,2),(0,0),(2,0),(0,0)` と一致 |

## 備考

- 細段は四頂点サイクル、粗段は二頂点を二本の平行辺で結ぶ有限グラフである。
- 両段で同じ二元スピン集合、破れ辺規則、不定元を使う。
- 係数は頂点数、辺数、被覆次数で割らない生の配位数である。
- 浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-ising-coefficient-pair-map/check_coefficient_pair_definition.sage
```
