# 交互閉路に沿う対角変換の因子

**対象ラベル**: `claim_alternating_cycle_gauge_ratio`

| 検証 | 内容 | 状態 |
|---|---|---|
| `check.sage` | 長さ一から三の閉路の方向と反転で等しいねじれ偶奇を全列挙し、円分体で因子の比を検算 | PASS（2026-10-28、584 件。2026-11-12 再実行） |

一般の閉路長への証明は本文に置く。実数体・複素数体は使わない。Lean 二版は `Ising2DLambda.KacWard.alternating_cycle_gauge_ratio`（具体版）と `Ising2DLambda.NecSuf.KacWard.cycle_gauge_ratio_necSuf`（必要十分版）。
