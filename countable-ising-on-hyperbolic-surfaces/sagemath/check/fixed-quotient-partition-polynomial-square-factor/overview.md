# 固定剰余類格子の分配多項式の平方因子

**対象ラベル**: `theorem_fixed_quotient_partition_polynomial_has_square_factor`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_partition_polynomial_has_square_factor`）
- 範囲: 固定した `24` 頂点、`84` 辺の剰余類格子の分配多項式と形式微分の最大公約多項式が非定数であること

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_square_factor.sage` | 偶奇別の係数和、次数重み付き係数和、`x=-1` での多項式と形式微分の零点、共通因子 `x+1`、最大公約多項式の正次数、平方因子の存在を `QQ[x]` 上で照合する | PASS | 全ての等式と平方因子判定が一致した |

## 備考

- 保存済みの全 `57` 係数を入力し、整数と有理係数多項式の厳密演算だけを用いる。
- 浮動小数点、実数、複素数、完全因数分解、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-partition-polynomial-square-factor/check_square_factor.sage
```
