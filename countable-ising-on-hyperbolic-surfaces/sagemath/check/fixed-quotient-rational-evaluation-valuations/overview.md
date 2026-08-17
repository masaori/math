# 固定剰余類格子の正有理評価値の付値

**対象ラベル**: `def_fixed_quotient_rational_evaluation_valuation`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_definition_fixed_quotient_rational_evaluation_valuation`）
- 範囲: 固定した `24` 頂点、`84` 辺の剰余類格子の分配多項式を三つの正有理数で評価し、指定素数に対する整数付値の定義を照合する

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_rational_evaluation_valuations.sage` | `q=1/2,2/3,3/2` について次数 `56` で分母を払った正整数を直接有限和と照合し、指定素数 `2,3,5,7` による反復除算の差が `QQ` の厳密付値と一致することを確認する | PASS | 全十二組で一致。負の付値を含み、評価値が `QQ_{>0}`、付値が `ZZ` に属することを確認した |

## 備考

- 完全因数分解は行わず、指定された一つの素数による整除判定と反復除算だけを用いる。
- 自然数、整数、有理数だけを用いた厳密検算である。浮動小数点、実数、複素数、極限、積分を用いていない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-rational-evaluation-valuations/check_rational_evaluation_valuations.sage
```
