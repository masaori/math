# 主第一コホモロジーから双対第一ホモロジーへの誘導写像の検算

**対象ラベル**: `def_primal_cohomology_to_dual_homology_transport`

## 対象

- ファイル: `structured-latex/content/finite-fourier-duality.ts`（ブロック `finite_fourier_definition_primal_cohomology_to_dual_homology_transport`）
- 範囲: 主一次コサイクル空間の主一次余境界空間による剰余集合、双対一次サイクル空間の双対面境界空間による剰余集合、および係数移送から誘導される写像の代表元非依存性
- 併せて検証: `def_primal_cocycle_to_dual_cycle_transport`、`theorem_primal_coboundary_transport_is_dual_boundary`

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_quotient_sets.sage` | 四元の主一次コサイクル空間と双対一次サイクル空間が、それぞれ二元の余境界空間・面境界空間によって二つの互いに素な剰余集合へ分かれることを全列挙する | PASS | 両空間とも二つの互いに素な剰余集合へ分かれた |
| `check_transport_additivity.sage` | 全ての主一次コサイクルと主一次余境界の組について、係数移送が成分ごとの和を保つことを照合する | PASS | 全ての係数の組で移送前後の和が一致した |
| `check_representative_independence.sage` | 全ての主一次コサイクル対について、同じ主剰余集合に属することと移送後に同じ双対剰余集合へ属することの一致を照合する | PASS | 各主第一コホモロジー類の全代表が一つの双対第一ホモロジー類へ移った |

## 備考

- 有限集合と `GF(2)` の等号だけを用いる厳密検算である。
- 非可算への脱出はない。浮動小数点、実数、複素数、極限、積分を用いない。
- 誘導写像が全単射であるという一般定理は、この tick の主張に含めない。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/primal-cohomology-to-dual-homology-transport/check_*.sage; do
  sage "$f"
done
```
