# SageMath Check: 平面単純閉路のトーラス射影

**対象ラベル**: `claim_plane_simple_cycle_projection_closed_nonbacktracking`

始点 $(0,0)$ の頂点単純な閉単位格子路（長さ $10$ 以下）を全列挙し、$L=1,2,3$ の各トーラスへの
射影について、辺番号が $E_L$ に入ること、始点・終点写像が頂点射影と一致すること、
巡回の全ての隣接対で接続していること、反転が現れないこと（閉じた非後退辺列であること）を
`ZZ` で全数検査する。

- 実行: `sage sagemath/check/plane-cycle-torus-projection/check.sage`
- 状態: PASS（2026-09-01）。頂点単純な閉単位格子路 144 本、$L=1,2,3$ の射影の歩の検査 3,216 件を全列挙した。
- 計算: 有限列挙、整数の剰余・場合分け・比較だけ。浮動小数点は使わない。
