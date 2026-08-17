# 固定剰余類格子の係数列の支持と偶数性

**対象ラベル**: `theorem_fixed_quotient_coefficient_support`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_coefficient_support`）
- 範囲: 固定した `24` 頂点、`84` 辺の剰余類格子の破れ辺数別係数について、大域スピン反転による偶数性と保存済み係数列の支持を照合する

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_support_and_parity.sage` | 入力三置換から全 `2^24` 配位を再列挙した既存検算を読み込み、非零係数の次数集合、全非零係数の偶数性、大域スピン反転による端点不一致条件の保存を照合する | PASS | 支持は `{0,7,12,14,15} ∪ {17,...,56}` であり、その全係数は正の偶数だった |

## 備考

- 係数の偶数性の理由は、全頂点のスピンを同時に反転する不動点のない対合が破れ辺集合を保存することである。
- 有限集合、自然数、整数だけを用いた厳密検算である。浮動小数点、実数、複素数、極限、積分を用いていない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-coefficient-support/check_support_and_parity.sage
```
