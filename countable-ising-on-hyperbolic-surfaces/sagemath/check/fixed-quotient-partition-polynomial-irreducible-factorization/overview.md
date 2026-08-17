# 固定剰余類格子の分配多項式の既約分解

**対象ラベル**: `theorem_fixed_quotient_partition_polynomial_irreducible_factorization`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_partition_polynomial_irreducible_factorization`）
- 範囲: 固定した `24` 頂点、`84` 辺の剰余類格子の分配多項式について、整数内容、既約因子、重複度を含む完全な分解

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_irreducible_factorization.sage` | `ZZ[x]` 上で `2(x+1)^12 Q_Q` の積を全係数について復元し、`Q_Q` の原始性と次数を照合し、`GF(191)[x]` 上の有限体既約性判定を厳密実行する | PASS | `x+1` の重複度は `12`、次数 `44` の `Q_Q` の重複度は `1` で、`Q_Q` は既約である |

## 備考

- 保存済みの全 `57` 係数を入力し、整数係数多項式と有限体上の厳密演算だけを用いる。
- 既約性は `44=2^2·11` に対する有限体既約性判定の三つの剰余計算で検証する。
- 浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-partition-polynomial-irreducible-factorization/check_irreducible_factorization.sage
```
