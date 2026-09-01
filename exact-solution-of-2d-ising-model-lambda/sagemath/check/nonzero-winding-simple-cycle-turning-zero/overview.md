# SageMath Check: 周期単純路の循環総回転数は零

**対象ラベル**: `claim_nonzero_winding_simple_cycle_turning_zero`

$L=1,2,3$ の非零巻き付きの頂点単純な閉じた非後退辺列 $\gamma$ について、循環総回転数
$t_{\circ}(\gamma)$ が零であることを、証明の合成の各段ごと `ZZ` で検査する。
証明と同じく、最大横断水準を達成する最初の基点添字 $k_0$ と反復回数 $t=1$ を取り、
周期数 $c=1,2,3$ の一側閉包のトーラス射影の循環総回転数 $t_{\circ}(\Gamma_c)$ を計算する。
$a:=t_{\circ}(\Gamma_1)-t_{\circ}(\gamma)$、$b:=t_{\circ}(\gamma)$ と置き、
$a+cb=t_{\circ}(\Gamma_c)$（$c=1,2,3$）、$t_{\circ}(\Gamma_c)\in\{4,-4\}$、
$b=0$、$t_{\circ}(\gamma)=0$ を全数比較する。

- 実行: `sage sagemath/check/nonzero-winding-simple-cycle-turning-zero/check.sage`
- 状態: PASS（2026-09-01）。非零巻き付きの頂点単純閉路 3,464 本について、
  合成の等式と帰属 $a+cb=t_{\circ}(\Gamma_c)\in\{4,-4\}$ を 10,392 件、
  結論 $t_{\circ}(\gamma)=0$ を 3,464 件、全列挙で検査した。
- 計算: 有限列挙、整数の除法・絶対値・場合分け・四則と順序だけ。浮動小数点は使わない。
