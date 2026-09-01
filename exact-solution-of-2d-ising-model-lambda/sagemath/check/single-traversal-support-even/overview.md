# SageMath Check: 非後退置換の単純通過の辺集合は偶部分グラフである

**対象ラベル**: `claim_single_traversal_edge_set_even`

一辺 $L=2$ の周期正方格子で非後退置換を全列挙し（反転対を含むものも除外しない）、
反転対の辺集合 $D(\varphi)$ と単純通過の辺集合
$E_1(\varphi)=E_{\mathrm{supp}}(\varphi)\setminus D(\varphi)$ について、
証明の各段（互いに素な分割、各頂点での入出の動く辺の個数の一致、
二通りの総和の一致 $d_{E_1(\varphi)}(v)+2a=2b$）と結論
（$E_1(\varphi)$ のすべての頂点の端点の個数が偶数）を突き合わせた。

- 実行: `sage sagemath/check/single-traversal-support-even/check.sage`
- 状態: PASS（2026-09-01）
- 結果: 非後退置換 $30{,}784$ 件（うち反転対を含むもの $30{,}287$ 件、
  含まないもの $497$ 件）の全件・全頂点で、次がすべて成り立った。
  - $E_{\mathrm{supp}}(\varphi)=E_1(\varphi)\sqcup D(\varphi)$（互いに素な合併）。
  - 単純通過の辺の上の動く向き付き辺はちょうど一つ、反転対の辺の上は二つ。
  - 各頂点で、終点とする動く辺の個数と始点とする動く辺の個数が等しい
    （証明の全単射 $\Phi$）。
  - 各頂点で $d_{E_1(\varphi)}(v)+2a=2b$（$a$ は $D(\varphi)$ の端点の指示値の
    総和、$b$ は終点とする動く辺の個数）。
  - $d_{E_1(\varphi)}(v)$ は偶数（結論 $\operatorname{Even}_L(E_1(\varphi))$）。
- 反転対を含む置換が $30{,}287$ 件と大多数であり、この主張が
  `claim_reversal_free_moved_support_even` の真の一般化であることも確認した。

すべて整数の加法と有限集合の数え上げの厳密計算であり、浮動小数点は使っていない。
