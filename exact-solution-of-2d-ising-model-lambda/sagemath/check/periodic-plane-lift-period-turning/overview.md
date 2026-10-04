# SageMath Check: 周期持ち上げ一周期の回転数の同定

**対象ラベル**: `claim_periodic_plane_lift_period_turning`

辺長一から四、長さ一から六の全単位歩列のうち、トーラスで閉じて循環しても非後退であるものを列挙する。各格子で二つの代表始点（同じ点は一度だけ）、全ての周期内の基点と周期の外の正負の基点を使う。巻き付きは実際の辺番号の切断線指示値から計算し、持ち上げは商と余りから構成する。

| ファイル | 本文の等式 | 状態 |
|---|---|---|
| `check_base_representative.sage` | tilde P_r = P_r | PASS（132092） |
| `check_interior_successor.sage` | tilde P_(r+1) = P_(r+1), r+1<m | PASS（108760） |
| `check_boundary_index.sage` | tilde P_(r+1) = tilde P_m | PASS（23332） |
| `check_boundary_definition.sage` | tilde P_m = P_0+B | PASS（23332） |
| `check_endpoint_winding.sage` | P_0+B = P_m | PASS（23332） |
| `check_boundary_last_index.sage` | P_m = P_(r+1) | PASS（23332） |
| `check_step_index.sage` | 整数除法 h=qm+r への代入 | PASS（132092） |
| `check_step_reorder.sage` | 添字の加法の並べ替え | PASS（132092） |
| `check_step_translate.sage` | 二点への整数並進式の代入 | PASS（132092） |
| `check_step_cancel.sage` | 共通の qB の消去 | PASS（132092） |
| `check_step_successor.sage` | 後の点を一周期の点へ戻す | PASS（132092） |
| `check_step_base.sage` | 前の点を一周期の点へ戻す | PASS（132092） |
| `check_step_recurrence.sage` | 持ち上げの有限漸化式 | PASS（132092） |
| `check_step_displacement.sage` | 整数ベクトルの加法の消去 | PASS（132092） |
| `check_step_original_direction.sage` | 元辺の変位と列 D の同定 | PASS（132092） |
| `check_word_definition.sage` | u_j = tilde P_(k+j+1)-tilde P_(k+j) | PASS（132092） |
| `check_word_remainder.sage` | 一歩の同定へ h=k+j を代入 | PASS（132092） |
| `check_word_rotation.sage` | 余りを巡回移動の添字へ戻す | PASS（132092） |
| `check_local_turn.sage` | theta(D_j,D_(rho_1(j))) = tau(e_(j+1),e_(rho_1(j)+1)) | PASS（132092） |
| `check_sum_definition.sage` | 循環隣接和の定義 | PASS（23332） |
| `check_sum_cyclic_index.sage` | 内部和と閉じ目を I_m 上の和へ移す | PASS（23332） |
| `check_sum_first_substitution.sage` | 各項の第一引数への歩の同定の代入 | PASS（23332） |
| `check_sum_second_substitution.sage` | 各項の第二引数への歩の同定の代入 | PASS（23332） |
| `check_sum_table.sage` | 整数の表 a の定義への置換 | PASS（23332） |
| `check_sum_rotation.sage` | 巡回移動による隣接二項和の不変性 | PASS（23332） |
| `check_sum_table_back.sage` | 整数の表 a を元の歩の重みへ戻す | PASS（23332） |
| `check_sum_turn.sage` | 各隣接対の回転表の一致 | PASS（23332） |
| `check_sum_split.sage` | 回転の和を内部と閉じ目へ分割 | PASS（23332） |
| `check_sum_internal_turn.sage` | 内部和を t(gamma) へ戻す | PASS（23332） |
| `check_sum_total_turn.sage` | 閉じ目を含めた t_circ(gamma) の定義 | PASS（23332） |
| `check_whole_period.sage` | 実際の辺列の回転表による独立な一周期の照合 | PASS（23332 periods, turns=[(-4, 2444), (0, 18444), (4, 2444)], nonzero winding and turn=2760） |

整数の表は辺番号から読んだ方向差で別に構成し、歩ベクトルの双線形な重みとの一致を各置換で確認する。非零巻き付きかつ非零回転数の例も検査に含め、両辺が常に零である検査にしない。

プロジェクト直下で `sage sagemath/check/periodic-plane-lift-period-turning/check.sage` を実行する。行別ファイルも同じ場所から単独で実行できる。

実行結果（2026-10-04、SageMath 10.9）: 行別30本と一周期の独立照合が全て通過した。23,332周期の循環回転数は −4 が2,444例、0 が18,444例、4 が2,444例であり、非零巻き付きかつ非零回転数の2,760例も含む。
