# 横断の平滑化と直進通過数

**対象ラベル**: `claim_smoothing_straight_visit_count_update`, `claim_smoothing_vertex_crossing_number_update`, `claim_smoothing_other_vertex_crossing_invariance`, `claim_smoothing_crossing_number_update`, `claim_smoothing_cyclic_turning_invariance`, `claim_smoothing_seam_parity_invariance`, `claim_smoothing_interval_invariance`, `claim_smoothing_splits_closed_walk`, `claim_smoothing_split_turning_sum`, `claim_smoothing_split_seam_parity`, `claim_smoothing_split_crossing_partition`, `claim_smoothing_split_crossing_descent`, `claim_crossing_elimination_by_smoothing`
- 実行: `sage sagemath/check/smoothing-straight-visit-count/check.sage`
- 状態: PASS（2026-08-30、閉じた非後退辺列 24,628 件・横断対 3,584 対・他頂点の横断数不変検査 11,904 件）
- 使用する環: `ZZ` と有限集合だけ。浮動小数点は使わない。

$L=1$（辺 1〜5 本）と $L=2,3$（辺 1〜8 本）の全閉じた非後退辺列の全横断対について、
出辺を交換した平滑化後の直進通過数 $n^{\mathrm{sm}}_{w,a}$ を全頂点・全軸で数え、
横断の頂点では各軸 1 減（同頂点検査 7,168 件）、他の頂点では不変
（他頂点検査 23,808 件）であることを検査する。平滑化後の各接続が非後退のままである
ことと、孤立していない横断（同じ頂点を三回以上通る対 1,248 件）が標本に含まれる
ことも確認する。

同じ全横断対について、平滑化後の頂点横断数を横断の定義から独立に数え、平滑化後の二軸の
直進通過数の積、および平滑化前の各軸の直進通過数から一つずつ引いた積と一致することを
3,584 対すべてで検査する。

同じ全横断対について、横断の頂点と異なる各格子頂点 $w$ での横断数を、平滑化の前後で
横断の定義から独立に数えて一致することを 11,904 件で検査する
（`claim_smoothing_other_vertex_crossing_invariance`）。

同じ全横断対について、平滑化前後の横断数を横断述語からそれぞれ直接数え、
$c(\gamma)+1=c_{\mathrm{sm}}(\gamma;k,l)+n_{v,0}(\gamma)+n_{v,1}(\gamma)$ を 3,584 対すべてで検査する
（`claim_smoothing_crossing_number_update`）。

同じ全横断対について、平滑化後の各出辺が非後退後続に属すること
（`def_smoothed_cyclic_total_turning` の well-definedness）を確認したうえで、
一歩の回転数の総和（循環総回転数）を平滑化の前後で `ZZ` で計算し、
一致することを 3,584 対すべてで検査する（`claim_smoothing_cyclic_turning_invariance`）。

同じ全横断対について、`def_seam_parities` どおりに各辺の二つの切断線指示値を独立に計算し、
元の辺列と平滑化後の出辺族の有限和をそれぞれ二で割った余りが両成分で一致することを
3,584 対すべてで検査する（`claim_smoothing_seam_parity_invariance`）。

同じ全横断対について、平滑化後の添字後続写像 ν（`def_smoothed_successor_map`）を
巡回後続の二点交換として構成し、区間 A = {r : k < r <= l} の帰属の同値
（`claim_smoothing_interval_invariance`）を全添字で検査する（3,584 対）。

同じ全横断対について、二つの添字区間を本文の順序で並べ、
平滑化後の各出辺が同じ区間の次の辺（末尾では先頭）に一致することと、
その接続が非後退であることを 3,584 対すべてで検査する
（`claim_smoothing_splits_closed_walk`）。

同じ全横断対について、二本の辺列それぞれの循環総回転数を辺列から独立に
計算し、その和が元の閉歩道の循環総回転数に等しいことを 3,584 対すべてで
検査する（`claim_smoothing_split_turning_sum`）。

同じ全横断対について、二本の辺列それぞれの横・縦の切断線偶奇を
辺列から独立に計算し、成分ごとの和の偶奇が元の閉歩道の偶奇に等しいことを
3,584 対すべてで検査する（`claim_smoothing_split_seam_parity`）。

同じ全横断対について、二本の辺列それぞれの横断数を各辺列の巡回構造から
独立に数え、混合横断数（一方の辺添字と他方の辺添字の対で横断の三条件を
満たすものの個数）と合わせた和が、平滑化後の横断数に等しいことを
3,584 対すべてで検査する（`claim_smoothing_split_crossing_partition`）。

さらに、選んだ横断が二軸の直進通過を一つずつ含むことを確認し、上の分割等式と
平滑化前後の全体更新式を同じ標本で合わせて、二本の閉歩道の横断数の和が元の
閉歩道の横断数より真に小さいことを 3,584 対すべてで検査する
（`claim_smoothing_split_crossing_descent`）。

最後に、横断対とは独立の全閉歩道 24,628 件について、横断が残る限り最初の
横断を平滑化で二本へ分ける操作を繰り返し、平滑化の回数が元の横断数以下で
横断のない閉じた非後退辺列の空でない族に達すること、族の循環総回転数の総和と
二つの切断線偶奇の総和の法 2 が元の閉歩道と一致することを検査する
（`claim_crossing_elimination_by_smoothing`）。
