# 固定剰余類格子の係数付値

**対象ラベル**: `def_fixed_quotient_coefficient_valuation`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_definition_fixed_quotient_coefficient_valuation`）
- 範囲: 固定した `24` 頂点、`84` 辺の剰余類格子の全非零係数について、指定素数で割り切れる最大冪指数の定義を照合する

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_valuation_profiles.sage` | 全 `2^24` 配位の既存検算と照合済みの保存係数を読み込み、各非零係数を指定素数 `2,3,5,7` で反復除算して、定義中の最大冪指数と保存した付値列を照合する | PASS | 全 `45` 非零係数で一致し、`2` 進付値は `1` から `7` の範囲になった |

## 備考

- 係数の完全因数分解は行わず、指定された一つの素数による整除判定と反復除算だけを用いる。
- 自然数と整数だけを用いた厳密検算である。浮動小数点、実数、複素数、極限、積分を用いていない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-coefficient-valuations/check_valuation_profiles.sage
```
