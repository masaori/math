# 非零項の閉路別の重み

**対象ラベル**: `claim_tagged_matching_cycle_weight`

| 検証 | 内容 | 状態 |
|---|---|---|
| `check.sage` | 閉路長一を含む閉路族で式変形 33,888 件と、標識付き完全マッチング 224 件の項を円分体上で照合 | PASS（2026-10-28。2026-11-12 に三度再実行して PASS） |

一般の閉路族への証明は本文に置く。Lean 二版は三段（項を向き付き対の列で書き直す段 `KacWard/TaggedMatchingTermOrientation.lean`、実際の交互閉路の対を射影した閉歩道の辺で読む段 `KacWard/TaggedCyclePairWalk.lean`、閉路ごとの合成 `KacWard/TaggedMatchingCycleWeight.lean`）とそれぞれの必要十分版・導出版で済み、本文ブロックの `lean:` に登録した。
