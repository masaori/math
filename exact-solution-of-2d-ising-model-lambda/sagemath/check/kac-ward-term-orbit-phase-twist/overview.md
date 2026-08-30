# SageMath Check: 非後退置換の置換項の位相表示

**対象ラベル**: `claim_kac_ward_term_orbit_phase_twist_product`

一辺二のトーラスで、向き付き辺が相異なる閉じた非後退辺列（長さ 8 まで、$3{,}856$ 件）から
台の上で列を巡回させ台の外を固定する置換（単一軌道）と、長さ 4 以下の閉歩道の対で台が
交わらないものの合成（二軌道、$9{,}456$ 件）を組み、主張の仮定（動く辺はすべて直ちに
引き返さない後続へ移る）を検査したうえで、四つのスピン構造について定義どおりの置換項
$T^{a,b}_{\varphi}(x)$ と
$\prod_{C}\bigl(-x^{\lvert C\rvert}\cdot(-1)^{a\,h(\gamma_C)+b\,v(\gamma_C)}\zeta_8^{\,t_{\circ}(\gamma_C)}\bigr)$
を $\mathbb Q(\zeta_8)[x]$ で独立に計算して一致を検査する。

- 実行: `sage sagemath/check/kac-ward-term-orbit-phase-twist/check.sage`
- 状態: PASS（2026-08-31、$4\times(3{,}856+9{,}456)=53{,}248$ 件）
- 浮動小数点: 不使用
