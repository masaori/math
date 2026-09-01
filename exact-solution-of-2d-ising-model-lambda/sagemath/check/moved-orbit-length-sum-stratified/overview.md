# SageMath Check: 軌道の長さの総和は反転対と単純通過で数えられる

**対象ラベル**: `claim_moved_orbit_length_sum_stratified`

任意の置換 $\varphi\in\operatorname{Perm}(\vec E_L)$ についての等式
$\sum_{C\in\mathcal C(\varphi)}|C|=|M(\varphi)|=2|D(\varphi)|+|E_1(\varphi)|$
を検査する。証明の各段も全数で検査する:

- $M(\varphi)$ が台の辺ごとの部分集合 $\{e\}\times M_e(\varphi)$ の互いに素な合併であること、
- $E_{\mathrm{supp}}(\varphi)=D(\varphi)\sqcup E_1(\varphi)$（互いに素な合併）であること、
- $|M_e(\varphi)|$ が $D(\varphi)$ の上で $2$、$E_1(\varphi)$ の上で $1$ であること、
- 軌道族 $\mathcal C(\varphi)$ の長さの総和が $|M(\varphi)|$ に等しいこと、
- $|M(\varphi)|=2|D(\varphi)|+|E_1(\varphi)|$（結論）。

範囲は二段である。$L=1$ では向き付き辺 $4$ 本の置換 $24$ 個を全列挙する
（非後退に限らない任意の置換。主張の全称の範囲をこの大きさで尽くす）。
$L=2$ では非後退置換 $30{,}784$ 個を全列挙する（行列式の和に実際に現れる範囲）。

- 実行: `sage sagemath/check/moved-orbit-length-sum-stratified/check.sage`
- 状態: PASS（2026-09-02）
- 結果: $L=1$ は置換 $24$ 個（反転対を含むもの $19$ 個）、$L=2$ は非後退置換
  $30{,}784$ 個（反転対を含むもの $30{,}287$ 個）で、全段が成立した。

すべて有限集合の数え上げであり、浮動小数点は使わない。
