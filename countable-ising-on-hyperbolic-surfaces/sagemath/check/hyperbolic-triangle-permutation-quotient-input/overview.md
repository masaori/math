# 双曲三角群の有限置換商入力の検算

**対象ラベル**: `def_hyperbolic_triangle_permutation_quotient_input`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_definition_hyperbolic_triangle_permutation_quotient_input`）
- 範囲: 三つの指定置換の生成する有限群、各置換の位数、三角群関係、置換作用の推移性、双曲型有理不等式

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 八点上の三つの明示的置換について、生成群の位数が `168`、指定置換の位数が `3,7,2`、積が恒等置換、作用が推移的、`1/3 + 1/7 < 1/2` であることを厳密に照合する | PASS | 全ての有限群条件と `QQ` 上の不等式が一致した |

## 備考

- この検算は有限置換群入力の定義だけを対象とする。剰余類セル集合、incidence、閉曲面性は後続の主張で検査する。
- 置換と有理数の厳密演算だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-triangle-permutation-quotient-input/check_definition.sage
```
