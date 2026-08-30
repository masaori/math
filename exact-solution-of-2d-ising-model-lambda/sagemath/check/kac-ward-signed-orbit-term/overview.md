# SageMath Check: 行列式の置換展開の閉路軌道表示

**対象ラベル**: `claim_kac_ward_signed_orbit_term_product`

一辺二の周期正方格子の向き付き辺のうち先頭六本の全置換 $6!$ 個と四つのスピン構造について、
置換項を定義どおりに組んだ値と、各動く軌道の
$-x^{|C|}\prod_{\vec e\in C}\widehat M_{\vec e,\varphi(\vec e)}$ の積を
$\mathbb Q(\zeta_8)[x]$ で独立に計算して一致を検査する。
同時に全置換の和も両経路で一致することを検査する。

- 実行: `sage sagemath/check/kac-ward-signed-orbit-term/check.sage`
- 状態: PASS（2026-08-31、$4\times6!=2{,}880$ 項）
- 浮動小数点: 不使用
