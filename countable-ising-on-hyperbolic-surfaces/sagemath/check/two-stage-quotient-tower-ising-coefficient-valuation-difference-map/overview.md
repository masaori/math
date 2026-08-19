# 商の塔に沿う二段 Ising 係数付値差写像の検算

**対象ラベル**: `def_quotient_tower_two_stage_ising_coefficient_valuation_difference_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_ising_coefficient_valuation_difference_map`）
- 範囲: 二段 Ising 係数付値対の細段成分から粗段成分を引く整数値写像

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_coefficient_valuation_difference_definition.sage` | 四頂点サイクルと二頂点二重辺グラフの二段係数付値対について、細段成分から粗段成分を `ZZ` 上で引く | PASS | 次数 `0` では四素数全てで `0`、次数 `2` では素数 `2,3` で `1`、素数 `5,7` で `0`。値域を整数全体とし、負値を定義から排除しないことも整数減法で確認した |

## 備考

- 有限グラフ例の差は非負だが、定義は付値の単調性や差の符号を主張しない。
- 係数の完全因数分解は行わず、既存の反復除算による指定素数付値対だけを用いる。
- 自然数と整数だけを用いた厳密検算であり、浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-ising-coefficient-valuation-difference-map/check_coefficient_valuation_difference_definition.sage
```
