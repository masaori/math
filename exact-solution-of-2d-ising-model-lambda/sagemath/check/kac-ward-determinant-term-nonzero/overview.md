# SageMath Check: Kac--Ward 行列式の置換項の非零条件

**対象ラベル**: `claim_kac_ward_determinant_term_nonzero_iff`

一辺二の周期正方格子の四つのスピン構造について、向き付き辺の先頭六本の全置換 $6!$ 個を取り、
残りを固定した。各置換で

$$
\prod_{\vec e\in\vec E_L}K^{a,b}_{\vec e,\varphi(\vec e)}(x)\ne0
\quad\Longleftrightarrow\quad
\forall\vec e\ (\varphi(\vec e)\ne\vec e\Rightarrow
M^{a,b}_{\vec e,\varphi(\vec e)}\ne0)
$$

を $\mathbb Q(\zeta_8)[x]$ の厳密計算で全数検査した。

- 実行: `sage sagemath/check/kac-ward-determinant-term-nonzero/check.sage`
- 状態: PASS（2026-08-30）
- 浮動小数点: 不使用
