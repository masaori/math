# 奇数辺長の全辺鍵の零和と平方恒等式への合成

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`,
`claim_signed_even_subgraph_square_stratified`,
`claim_selection_sum_character_evaluation`
- 住処: 有限集合、有限置換、整数、円分体
- 実行: `sage sagemath/check/translation-full-key-square-identity-composition/check.sage`
- 状態: PASS（2026-09-04。一辺三の全 $75{,}776$ 置換と選択集合 $1{,}024$ 個で実行済み）

奇数辺長 $L$ の全辺鍵 $(D,E)=(\varnothing,E_L)$ では、前段で構成した
対角共変な符号反転完全マッチングが、四つのスピン構造の位相寄与を各対で
反転する。従って

$$
\mathcal K^{a,b}_L(\varnothing,E_L)=0.
$$

選択側では、全辺集合の巻き付き偶奇が $(1,1)$ であり、全辺集合に含まれる
水平一周閉路 $H_0$ の巻き付き偶奇が $(1,0)$ なので

$$
\chi_{E_L}(H_0)=(-1)^{1\cdot0+1\cdot1}=-1.
$$

したがって選択和の文字評価により
$\mathcal U^{a,b}_L(\varnothing,E_L)=0$ である。ゆえにこの添字では
$\mathcal K=\mathcal U=0$ が一般の奇数辺長で成り立つ。行列式と符号付き
偶部分グラフ多項式の平方の二つの層別で、この添字は同じ次数
$2|D|+|E|=2L^2$ の項を与え、その係数は両側とも零になる。

これは全平方恒等式のうち全辺鍵だけを閉じる。ほかの添字の同定はまだ
示していない。検査は一辺三で、前段の $37{,}888$ 対による四位相和の消滅、
全 $1{,}024$ 選択の定義からの符号和の消滅、次数 $18$、両係数の一致を
等号 assert で固定する。浮動小数点は使わない。
