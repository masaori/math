# 向き付き剰余類辺の端点写像の検算

**対象ラベル**: `def_finite_quotient_oriented_coset_edge_endpoint_data`

## 対象

- ファイル: `structured-latex/content/finite-quotient-lattice.ts`（ブロック `finite_quotient_lattice_definition_oriented_coset_edge_endpoint_data`）
- 範囲: 各辺剰余類の有限代表元選択、選択代表と辺半回転から定まる二つの頂点剰余類、および代表元選択の反転による始点・終点の交換

## チェック一覧

実行日: 2026-08-17

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition.sage` | 位数 `168` の明示的有限置換群について、全ての辺剰余類で選択代表とその辺半回転が同じ辺剰余類に属すること、対応する二頂点が辺と incident で相異なること、および選択代表の半回転が始点・終点を交換することを厳密に照合する | PASS | `84` 本の全ての剰余類辺で端点写像が定義され、代表元選択の反転は二端を交換した |

## 備考

- 代表元選択は辺の向きを指定する追加の有限データであり、辺剰余類そのものとは同一視しない。
- 二端の相異性はこの明示例では PASS したが、一般の有限置換商入力から無条件には結論せず、生成後の有限セル分割検査で判定する。
- この検算は端点写像だけを対象とする。面境界の巡回順序、閉曲面性、正則性、向き付けの検査は後続の主張に含める。
- 有限置換と有限集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/finite-quotient-oriented-edge-endpoints/check_definition.sage
```
