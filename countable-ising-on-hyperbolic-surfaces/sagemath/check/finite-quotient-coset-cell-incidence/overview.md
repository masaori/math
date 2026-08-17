# 剰余類セル間の incidence 関係の検算

**対象ラベル**: `def_finite_quotient_coset_cell_incidence_relation`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_definition_coset_cell_incidence_relation`）
- 範囲: 面・頂点、面・辺、頂点・辺の左剰余類の交わりによる有限 incidence 関係と代表元非依存性

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 位数 `168` の明示的有限置換群について、剰余類の交わりと部分群元による等式 witness の同値性を全ての剰余類対・全ての代表元で照合し、三種の incidence 数と各セルの次数を厳密に数える | PASS | 三種の関係はいずれも `168` 組で、各面は `3` 頂点・`3` 辺、各頂点は `7` 面・`7` 辺、各辺は `2` 面・`2` 頂点に incident となった |

## 備考

- incidence は剰余類を有限部分集合として直接比較して定め、代表元を定義データに含めない。
- この検算は incidence 関係だけを対象とする。端点写像、面境界の巡回順序、閉曲面性、正則性、向き付けの検査は後続の主張に含める。
- 有限置換と有限集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-quotient-coset-cell-incidence/check_definition.sage
```
