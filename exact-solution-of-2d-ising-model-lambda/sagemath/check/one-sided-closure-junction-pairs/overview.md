# 一側閉包の四接合の歩ベクトル対

**対象ラベル**: `claim_one_sided_closure_junction_pairs`

巻き付き成分はマイナス一から一（同時零を除く）、辺長は一から三、基点は二種類、基点添字は負値・周期境界を含む四種類、横断反復回数は一・二、周期数は一から四とする。周期歩道は平行階段そのものと往復の二歩を前置したものを使う。長さ一と各巻き付き成分が零の場合を含む。幾何の単純性を仮定しない端点同定の検査であり、有限例を一般証明とみなさない。

各式の整数演算を一行ずつ検査する。最後に、単位歩を順に加えた閉点列を独立に構成し、全点と四つの接合を照合する。

| ファイル | 対応する操作 | 状態 |
|---|---|---|
| `check_lift_repetition.sage` | 周期持ち上げ部分の反復同定 | PASS（30,720例） |
| `check_upper_fixed.sage` | 横断順向き列の基点不変性 | PASS（6,912例） |
| `check_return_repetition.sage` | 平行帰路の反復同定 | PASS（23,040例） |
| `check_lower_fixed.sage` | 横断逆向き列の基点不変性 | PASS（6,912例） |
| `check_last_expand.sage` | 末項の添字の四則展開 | PASS（6,144例） |
| `check_last_period_remove.sage` | 整数倍の除去 | PASS（6,144例） |
| `check_last_residue.sage` | 余りの代表元の評価 | PASS（6,144例） |
| `check_pairs_substitute.sage` | 四部分の等式の端点への代入 | PASS（3,072例） |
| `check_pairs_last.sage` | 末項の余りの代入 | PASS（3,072例） |
| `check_pairs_first.sage` | 先頭の余りの評価 | PASS（3,072例） |
| `check_whole_closure.sage` | 独立に構成した閉点列の四接合 | PASS（3,072例） |

実行日: 2026-10-04。`micromamba run -p /home/masaori/.local/share/math-mamba/envs/sage sage sagemath/check/one-sided-closure-junction-pairs/check.sage` で全11本が通過した。
