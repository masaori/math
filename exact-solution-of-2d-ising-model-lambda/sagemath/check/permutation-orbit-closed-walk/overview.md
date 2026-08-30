# SageMath Check: 動く辺の軌道列の閉路性

**対象ラベル**: `claim_permutation_power_return`, `def_permutation_minimal_return`,
`def_permutation_orbit_sequence`, `claim_moved_orbit_closed_nonbacktracking`

一辺二の周期正方格子の向き付き辺のうち先頭六本の全置換 $6!$ 個を取り、残りを固定した
（前 tick の非零置換項の検査と同じ標本）。全置換・全辺で回帰の存在
$1\le k\le|\vec E_L|$ と最小回帰時刻の最小性を検査した。そのうえで、
すべての動く辺で行き先が非後退後続辺に属する置換について、各動く辺の軌道列が

- 各項が動く辺であること、
- 隣接接続と閉じる接続がすべて非後退後続に属すること（閉じた非後退辺列）、
- $r_{\varphi}(\vec e)$ 個の項が相異なること

を全数検査した。空虚な検査にならないよう、仮定を満たし動く辺を持つ置換が
標本中に実在することも確認した。

- 実行: `sage sagemath/check/permutation-orbit-closed-walk/check.sage`
- 状態: PASS（2026-08-30）
- 浮動小数点: 不使用
