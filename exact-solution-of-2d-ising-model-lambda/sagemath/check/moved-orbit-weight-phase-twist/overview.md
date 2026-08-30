# SageMath Check: 動く軌道の遷移成分積の位相とねじれへの分解

**対象ラベル**: `claim_moved_orbit_weight_phase_twist`

一辺二のトーラスの向き付き辺が相異なる閉じた非後退辺列のすべて（長さ 8 まで、$3{,}856$ 件）
から、台の上で列を巡回させ台の外を固定する置換 $\varphi$ を組み、主張の仮定
（動く辺はすべて直ちに引き返さない後続へ移る）を検査したうえで、四つのスピン構造について
$\prod_{\vec e\in C}M^{a,b}_{\vec e,\varphi(\vec e)}$ と
$(-1)^{a\,h(\gamma)+b\,v(\gamma)}\,\zeta_8^{\,t_{\circ}(\gamma)}$ を
$\mathbb Q(\zeta_8)$ で独立に計算して一致を検査する。

- 実行: `sage sagemath/check/moved-orbit-weight-phase-twist/check.sage`
- 状態: PASS（2026-08-31、$4\times3{,}856=15{,}424$ 件）
- 浮動小数点: 不使用
