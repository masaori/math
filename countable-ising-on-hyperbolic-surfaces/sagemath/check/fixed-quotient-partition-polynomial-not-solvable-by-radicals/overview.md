# 固定剰余類格子の Ising 分配多項式の根式非可解性

**対象ラベル**: `theorem_fixed_quotient_partition_polynomial_not_solvable_by_radicals`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_partition_polynomial_not_solvable_by_radicals`）
- 範囲: 固定剰余類格子の分配多項式の根集合が、根式で解けない次数四十四の既約因子の根集合を含むこと
- 併せて検証: `theorem_fixed_quotient_partition_polynomial_irreducible_factorization`、`theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_partition_polynomial_obstruction.sage` | 分配多項式の既約因子による整除、既約因子の次数と係数体、および既存同定先 `Sym(44)` の非可解性 | PASS | `Z_Q=2(x+1)^12Q_Q`、`Q_Q\mid Z_Q`、`\deg Q_Q=44`、`char(QQ)=0`、`Q_Q` の既約性、`Sym(44)` の非可解性を確認 |

## 備考

- `Q_Q\mid Z_Q` から `Q_Q` の全根が `Z_Q` の根であることが従うため、`Z_Q` の全根を含む根式拡大の塔があれば `Q_Q` の全根も含む。これは既存の Fisher 既約因子の根式非可解性に反する。
- SageMath は、この包含の多項式側の前提と、既存の Galois 障害の有限データを厳密検算する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-partition-polynomial-not-solvable-by-radicals/check_partition_polynomial_obstruction.sage
```
