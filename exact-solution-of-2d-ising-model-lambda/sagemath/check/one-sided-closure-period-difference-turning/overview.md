# 一側閉包の周期数差と循環総回転数

**対象ラベル**: `claim_one_sided_closure_period_difference_turning`

整数除法で四つの点列を組み立て、隣接差と射影辺の方向表を別々に計算する。
固定四列の反復から組み立てた点列との一致も検査する。
差の計算は本文の各等号に分け、全て整数で評価する。

| ファイル | 対象の行 | 状態 |
|---|---|---|
| `check_period_turning.sage` | C_m(u) = t_◦(γ) | PASS |
| `check_return_projection.sage` | C_n(r) = t_◦(R_−) | PASS |
| `check_return_zero.sage` | t_◦(R_−) = 0 | PASS |
| `check_projection_next.sage` | 差の第一項を射影回転数から歩の循環和へ置換 | PASS |
| `check_projection_current.sage` | 差の第二項を射影回転数から歩の循環和へ置換 | PASS |
| `check_fixed_next.sage` | 第一項の実際の歩列を固定四部分列へ置換 | PASS |
| `check_fixed_current.sage` | 第二項の実際の歩列を固定四部分列へ置換 | PASS |
| `check_repetition_difference.sage` | 固定四部分列の差 = C_m(u) + C_n(r) | PASS |
| `check_substitute_period.sage` | C_m(u) + C_n(r) = t_◦(γ) + C_n(r) | PASS |
| `check_substitute_return.sage` | t_◦(γ) + C_n(r) = t_◦(γ) + 0 | PASS |
| `check_add_zero.sage` | t_◦(γ) + 0 = t_◦(γ) | PASS |

実行: プロジェクト直下で `sage sagemath/check/one-sided-closure-period-difference-turning/check.sage`。

2026-10-04: 行別11本の各21,204例が全て通過した。
辺長一から四、周期長一から六、正負の基点添字、横断反復数一・二、周期数一・二・三を含む。
長さ一から六の循環非後退方向列から、各辺長で閉じ、非零巻き付きとなるものを全列挙した。
始点は (0,0) と (L−1,L−1) の二点であり、辺長一の重複は除く。
基点添字ごとに横断反復数と周期数を定めて検査するため、それら全ての直積ではない。
うち2,760例は元の回転数が非零である。

この追加検算は頂点単純性を要求せず、閉包の接合に後退がある場合も方向対の重みを零に拡張して計算する。
本文の非後退な一側閉包そのものについては、併記した
`one-sided-periodic-lift-closure` の独立な頂点単純閉路の全列挙が検査する。
有限列挙を一般の周期数の証明とは扱わない。Lean の具体的な点列版・必要十分版・導出版は、
元辺の有限漸化式と巻き付き端点を仮定した一般の周期数について検証する。
実際の閉歩道から平面持ち上げを構成してこれらの仮定を満たす接続は未完了であり、
この主張全体を「Lean 二版 済」とは扱わない。接続は台帳の Whitney 系の作業に残す。

最大横断水準を基点とする例では、追加の行別検算で射影の非後退性も確かめる。
`check_nonbacktracking_*.sage` は次の各等号・不等号を一ファイルずつ検査する。

| ファイルの末尾 | 対象の行 | 状態 |
|---|---|---|
| `period_end_periodicity`, `period_end_maximum` | 一周期の両端の横断座標と最大水準の一致 | PASS |
| `lift_last_definition`, `lift_last_additivity`, `lift_last_maximum`, `lift_last_sign` | 元周期の末歩の横断座標が非負となる四行 | PASS |
| `lift_first_definition`, `lift_first_additivity`, `lift_first_maximum`, `lift_first_sign` | 元周期の始歩の横断座標が非正となる四行 | PASS |
| `upper_positive` | 横断上り列の各歩の横断座標が正 | PASS |
| `lower_definition`, `lower_additivity`, `lower_negative` | 横断下り列の符号反転・加法性・負値の三行 | PASS |
| `parallel_endpoints`, `shift_definition`, `shift_cancel` | 平行階段の両端と並進ベクトルの横断座標が零 | PASS |
| `return_first_definition`, `return_first_additivity`, `return_first_endpoint`, `return_first_sign` | 帰路始歩の横断座標が非負となる四行 | PASS |
| `return_last_definition`, `return_last_additivity`, `return_last_endpoint`, `return_last_sign` | 帰路末歩の横断座標が非正となる四行 | PASS |
| `lift_upper_sign`, `upper_return_sign`, `return_lower_sign`, `lower_lift_sign` | 四接合の横断座標の符号の不一致 | PASS |
| `parts_nonbacktracking` | 固定四列の内部と反復境界で逆歩が隣り合わない | PASS |
| `projection_nonbacktracking` | 実際の閉包を射影した辺列の連続性と全隣接対の非後退性 | PASS |

2026-10-04: 非後退性の追加行別31本は各6,988例で全て通過した。
最大横断水準を基点とするものだけを対象とし、そのうち1,100例は元の回転数が非零である。
周期数 c と c+1 の両閉包について実際の射影辺を読み、連続性と全隣接対を確かめた。
Lean の補助証明も元周期の最大水準と循環非後退性から四接合条件を導き、頂点単純性を仮定しない。
