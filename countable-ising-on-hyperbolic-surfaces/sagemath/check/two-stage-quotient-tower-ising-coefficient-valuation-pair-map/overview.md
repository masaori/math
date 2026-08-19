# 商の塔に沿う二段 Ising 係数付値対写像の検算

**対象ラベル**: `def_quotient_tower_two_stage_ising_coefficient_valuation_pair_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_ising_coefficient_valuation_pair_map`）
- 範囲: 細段・粗段の係数がともに正である次数と指定素数から、二つの整数付値を一つの対として返す定義

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_valuation_pair_definition.sage` | 四頂点サイクルと二頂点二重辺グラフの二段係数対について、両係数が正である全次数と指定素数 `2,3,5,7` に対する反復除算の回数を厳密付値と照合する | PASS | 定義域は次数 `0,2`。付値対は次数 `0` で `(1,1),(0,0),(0,0),(0,0)`、次数 `2` で `(2,1),(1,0),(0,0),(0,0)` と一致し、零成分をもつ次数が定義域外であることを確認した |

## 備考

- 係数の完全因数分解は行わず、指定された一つの素数による整除判定と反復除算だけを用いる。
- 自然数と整数だけを用いた厳密検算であり、浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-pair-map/check_coefficient_valuation_pair_definition.sage
```
