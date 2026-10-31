# SageMath Check: 接触の無い置換の位相積

旧主張「接触の無い置換の位相積は軌道ごとの二次符号の積に等しい」は参照用ノート「不採用経路: 接触の無い置換の位相積」に保存した。

**対象ラベル**: `def_oriented_edge_endpoints`（参照用ノート「不採用経路: 置換の接触対の個数」に対応）

一辺 $L=2$ のトーラスで非後退置換を全列挙し、置換の接触対の個数 $N_{\mathrm{ct}}(\varphi)$ が零のものについて、四つのスピン構造 $(a,b)$ ごとに

$$
\prod_{C}\Bigl(-\prod_{\vec e\in C}M^{a,b}_{\vec e,\varphi(\vec e)}\Bigr)
=\prod_{C}\chi_{a,b}\bigl(h(\gamma^{\varphi}_C),v(\gamma^{\varphi}_C)\bigr)
$$

を $\mathbb Q(\zeta_8)$ で厳密検査する。併せて証明の中間段（各軌道列の通過の頂点が相異なること）と、基点を一つ回した選択で右辺が変わらないことを確かめる。

- 実行: `sage sagemath/check/contact-free-permutation-phase-product/check.sage`
- 状態: PASS（2026-10-30）
- 結果: 非後退置換 $30{,}784$ 個中、接触の無い置換 $49$ 個。四つのスピン構造を合わせた $196$ 件で等式が成立し、各軌道列の通過の頂点の相異なることと基点独立性も全数で確認した。

計算はすべて整数と円分体の厳密計算であり、浮動小数点は使わない。
