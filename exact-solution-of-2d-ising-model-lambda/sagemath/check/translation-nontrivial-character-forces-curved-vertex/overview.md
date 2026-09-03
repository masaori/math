# 非自明な選択文字が曲がり型頂点を強制すること

**対象ラベル**: `claim_selection_sum_character_evaluation`,
`claim_kac_ward_determinant_fiber_stratified_phase_sum`
- 住処: 有限集合、整数、$\mathbb F_2$
- 実行: `sage sagemath/check/translation-nontrivial-character-forces-curved-vertex/check.sage`
- 状態: PASS（2026-09-04。一辺三の互いに素な偶部分グラフ対 $8{,}589$ 組と
  交差型頂点の局所偶部分集合 $16$ 件で実行済み）

一般の辺長で使う論法は次のとおりである。偶部分グラフ $E$ に均衡配向を一つ固定し、
曲がり型の次数 $4$ 頂点が無いと仮定する。任意の偶部分グラフ $H\subseteq E$ に対し
$K:=E\setminus H$ と置くと、$H,K$ は互いに素な偶部分グラフである。

$H$ と $K$ が横断する頂点とは、一方が水平二辺、他方が垂直二辺を取る頂点である。
次数 $4$ 頂点の配向は曲がり型でないから、水平二辺が入って垂直二辺が出る型、または
その逆である。従って $H$ の局所的な入次数と出次数の差は、横断頂点だけで $+2$ または
$-2$ となり、ほかの頂点では零である。有限有向辺集合では入次数の総和と出次数の総和が
等しいので、$+2$ の頂点数と $-2$ の頂点数は等しい。ゆえに横断頂点数は偶数である。

格子上の互いに素な二つの偶部分グラフの横断頂点数の偶奇は、トーラス上の交差形式

$$
\varepsilon_{\mathrm h}(H)\varepsilon_{\mathrm v}(K)
+\varepsilon_{\mathrm v}(H)\varepsilon_{\mathrm h}(K)\pmod 2
$$

に等しい。$E=H\mathbin\triangle K$ と交差形式の交代性から、これは選択文字の指数
$\varepsilon_{\mathrm h}(E)\varepsilon_{\mathrm v}(H)
+\varepsilon_{\mathrm v}(E)\varepsilon_{\mathrm h}(H)$ に等しい。したがって全ての
$H\subseteq E$ で選択文字は $1$、すなわち文字は自明である。対偶により、非自明な
選択文字を持つ $E$ の全ての均衡配向には曲がり型の次数 $4$ 頂点が存在する。

検算は、交差頂点数の偶奇と巻き付き交代積の一致を一辺三の互いに素な偶部分グラフ対
$8{,}589$ 組で、局所的な入出差の分類を全 $16$ 件で確認する。浮動小数点は使わない。
