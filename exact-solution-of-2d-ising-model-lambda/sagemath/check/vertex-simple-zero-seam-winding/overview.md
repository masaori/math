# 切断線偶奇が零の頂点単純閉路の巻き付き零

**対象ラベル**: `claim_vertex_simple_zero_seam_winding`

辺長三から六の一セル・横二セルの境界と逆向きの閉路について、全基底辺の整数係数を照合し、横・縦の切断線重み付き和が符号倍で零になることを厳密整数演算で検算する。一般の証明は本文と Lean 具体版・必要十分版に置く。

実行: `/home/masaori/.cache/masaori-math/sage-env/bin/sage check.sage` — 2026-11-06 PASS。出力: `RESULT: PASS; signed boundary and both integer winding sums`。
