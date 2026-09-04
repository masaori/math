# 内部頂点基準では切断依存項だけを位相量へ同定できない

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

共有端点対と局所行列式を合わせた頂点量について、同じ局所配置を一辺五の
内部頂点へ移した値を基準に取った。実際の頂点量と基準値の符号差を全頂点で
足し、非共有端点対の軌道分解に現れる座標切断横断項を加えたものを
「切断依存項」とした。残りを「切断非依存項」とすると、両者の和は全鍵で

\[
  \varepsilon_{\mathrm h}(E)+\varepsilon_{\mathrm v}(E)
  +\varepsilon_{\mathrm h}(E)\varepsilon_{\mathrm v}(E)
  +\langle D\cup C_0,E\rangle \pmod 2
\]

に一致した。

ただし、同じ巻き付き偶奇と交差対を持つ鍵の中で、切断依存項と切断非依存項は
ともに値を変えた。一辺二・一辺三のいずれにも、この二項の値が複数現れる位相類が
ある。従って「局所配置を固定した内部頂点の値」を引く基準では、切断依存項だけを
巻き付き偶奇と交差対へ同定できない。次は二項を分離せず、切断を横切る辺を動かす
ときの両者の同時変化を追う必要がある。

- 実行: `sage sagemath/check/parity-identity-cut-contribution-topological/check.sage`
- 状態: PASS（2026-09-04）
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。浮動小数点は使わない。
