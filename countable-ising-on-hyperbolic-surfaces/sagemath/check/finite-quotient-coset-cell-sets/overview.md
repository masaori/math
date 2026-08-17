# 役割安定化部分群と剰余類セル集合の検算

**対象ラベル**: `def_finite_quotient_role_stabilizers_and_coset_cell_sets`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_definition_role_stabilizers_and_coset_cell_sets`）
- 範囲: 三つの生成元が生成する役割安定化部分群、左剰余類集合、形式的役割ラベルを付けたセル集合

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 位数 `168` の明示的有限置換群について、三部分群の位数、左剰余類による分割、代表元非依存性、形式的役割ラベルを付けた三セル集合の非交差性を厳密に照合する | PASS | 三つの部分群と剰余類分割、代表元非依存性、三セル集合の非交差性が全て一致した |

## 備考

- 明示的置換群は、先行する双曲三角群の有限置換商入力の検算と同じ有限データを用いる。
- セル数 `56,24,84` はこの有限データに対する検算値であり、本文では一般入力のセル数を主張していない。
- 有限置換と有限集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-quotient-coset-cell-sets/check_definition.sage
```
