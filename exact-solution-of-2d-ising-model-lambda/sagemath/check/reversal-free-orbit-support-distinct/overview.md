# SageMath Check: 反転対を含まない非後退置換の軌道列の台の辺の相異なり

**対象ラベル**: `claim_reversal_free_orbit_support_edges_distinct`

一辺二のトーラスで非後退置換を全列挙（$30{,}784$ 件）し、動く辺の集合が反転対
$\{(e,0),(e,1)\}$ を含まない置換（$497$ 件）について、各動く辺 $\vec e$ から始まる
軌道列 $\gamma_{\varphi}(\vec e)$ を最小回帰時刻まで組み、その項の台の辺
（第 1 成分）が互いに相異なることを検査する。あわせて、証明の準備が引く二つの事実
（各項が動く辺であること、項が向き付き辺として相異なること）も同じ列挙で確かめる。

- 実行: `sage sagemath/check/reversal-free-orbit-support-distinct/check.sage`
- 状態: PASS（2026-08-31、反転対なし $497$ 件・軌道列 $3{,}376$ 本）
- 浮動小数点: 不使用
