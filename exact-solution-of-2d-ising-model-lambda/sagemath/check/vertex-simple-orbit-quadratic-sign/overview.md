# SageMath Check: 頂点単純な置換軌道の二次符号

**対象ラベル**: `claim_vertex_simple_orbit_quadratic_sign`

一辺 $L=2,3,4$ の全頂点単純な閉じた非後退辺列と四つのスピン構造 $(a,b)$ について、円分体 $\mathbb Q(\zeta_8)$ の等式

$$
-(-1)^{a h+b v}\zeta_8^{t_\circ}
=(-1)^{hv+(1-a)h+(1-b)v}
$$

を厳密検査する。併せて、既存の `claim_vertex_simple_cycle_turning_by_seam_parity` の全数検査を同じ列挙で再実行する。

- 実行: `sage sagemath/check/vertex-simple-orbit-quadratic-sign/check.sage`
- 状態: PASS（2026-09-02）
- 結果: 頂点単純な閉じた非後退辺列 373716 本、四つのスピン構造を合わせた 1494864 件で等式が成立した。内訳は、切断線偶奇 $(0,0)$ かつ $t_\circ=\pm4$ が 73616 本、切断線偶奇が非零かつ $t_\circ=0$ が 300100 本である。

計算はすべて整数と円分体の厳密計算であり、浮動小数点は使わない。
