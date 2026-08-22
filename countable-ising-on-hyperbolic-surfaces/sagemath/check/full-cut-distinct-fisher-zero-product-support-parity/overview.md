# 全辺二分割をもつ有限グラフの相異なる Fisher 零点積と零点台の奇偶の検算

**対象ラベル**: `theorem_full_cut_distinct_fisher_zero_product_support_parity`

## 対象

- ファイル: `structured-latex/content/main-text.ts`（ブロック `finite_graph_theorem_full_cut_distinct_fisher_zero_product_support_parity`）
- 範囲: 零点台が奇数の場合の奇接続辺数頂点・積・符号、零点台が偶数の場合の全接続辺数の偶数性・積・符号、最終等式
- 併せて検証: `theorem_full_cut_fisher_zero_support_parity_characterization`、`theorem_full_cut_distinct_fisher_zero_product`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_odd_support_incidence.sage` | 奇数濃度の零点台で奇接続辺数頂点が存在することを照合する | PASS | 全五例のうち奇数濃度の全例で確認 |
| `check_odd_support_product.sage` | 奇数濃度の零点台で相異なる零点積が `-1` になることを照合する | PASS | 全五例のうち奇数濃度の全例で確認 |
| `check_odd_support_sign.sage` | 奇数濃度で `-1=(-1)^{2n+1}=(-1)^{|Z_G|}` となることを照合する | PASS | 全五例のうち奇数濃度の全例で確認 |
| `check_even_support_incidence.sage` | 偶数濃度の零点台で全頂点の接続辺数が偶数になることを照合する | PASS | 全五例のうち偶数濃度の全例で確認 |
| `check_even_support_product.sage` | 偶数濃度の零点台で相異なる零点積が `1` になることを照合する | PASS | 全五例のうち偶数濃度の全例で確認 |
| `check_even_support_sign.sage` | 偶数濃度で `1=(-1)^{2n}=(-1)^{|Z_G|}` となることを照合する | PASS | 全五例のうち偶数濃度の全例で確認 |
| `check_product_support_parity_formula.sage` | 相異なる零点積が `(-1)^{|Z_G|}` に等しいことを照合する | PASS | 全五例で最終等式を確認 |

## 備考

- 一頂点無辺、一辺、三頂点道、四頂点サイクル、二本の平行辺を用いる。零点台が空である無辺グラフも含める。
- 有限集合、`NN`、`QQbar` の厳密演算だけを用いる。複素平面への埋め込み、浮動小数点近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-distinct-fisher-zero-product-support-parity/check_*.sage; do
  sage "$file"
done
```
