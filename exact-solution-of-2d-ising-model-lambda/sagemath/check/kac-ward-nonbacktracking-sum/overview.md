# SageMath Check: 行列式の非後退置換の位相表示の和

**対象ラベル**: `claim_kac_ward_determinant_nonbacktracking_phase_sum`

一辺二のトーラスで、非後退置換（動く辺がすべて直ちに引き返さない後続へ移る置換）を
全列挙（$30{,}784$ 件）し、各置換の軌道ごとの位相表示
$\prod_{C}\bigl(-x^{\lvert C\rvert}\cdot(-1)^{a\,h(\gamma_C)+b\,v(\gamma_C)}\zeta_8^{\,t_{\circ}(\gamma_C)}\bigr)$
の総和を、四つのスピン構造について $\det\bigl(I-x\,M^{a,b}\bigr)$ の直接計算と
$\mathbb Q(\zeta_8)[x]$ で比較して一致を検査する。行列式は全置換にわたる和なので、
この一致は「非後退でない置換の項が零である」ことも同時に確かめる。

- 実行: `sage sagemath/check/kac-ward-nonbacktracking-sum/check.sage`
- 状態: PASS（2026-08-31、非後退置換 $30{,}784$ 件、スピン構造 $4$ 件）
- 浮動小数点: 不使用
