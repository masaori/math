# 一側閉包の横断二列の基点不変性

**対象ラベル**: `claim_one_sided_transverse_steps_base_independent`

巻き付き成分をそれぞれマイナス三から三（同時零を除く）、反復回数を一から四、基点を三種類として、整数の等号を一行ずつ検査する。順向き・逆向きの両方、周期境界、横断歩数一、各巻き付き成分が零の場合を含む。一側閉包への代入では、さらに辺長一から三・周期数一から三を使う。最後に、単位歩を順に足して構成した独立の有限列と比較する。全て整数の厳密計算で、有限例を一般証明とみなさない。

| ファイル | 対応する操作 | 状態 |
|---|---|---|
| `check_base_expand.sage` | 反復横断階段の定義展開 | PASS（5,616例） |
| `check_base_associate.sage` | 加法の結合則 | PASS（5,616例） |
| `check_base_zero.sage` | 零元の挿入 | PASS（5,616例） |
| `check_base_fold.sage` | 原点基準の定義へ戻す | PASS（5,616例） |
| `check_step_substitute.sage` | 隣接二点に基点分離を代入 | PASS（10,080例） |
| `check_step_cancel.sage` | 共通基点の消去 | PASS（10,080例） |
| `check_upper_definition.sage` | 一側閉包の第二部分の歩 | PASS（45,360例） |
| `check_upper_origin.sage` | 第二部分を原点基準の順向き列へ同定 | PASS（45,360例） |
| `check_lower_definition.sage` | 一側閉包の第四部分の歩 | PASS（45,360例） |
| `check_lower_origin.sage` | 第四部分を原点基準の逆向き列へ同定 | PASS（45,360例） |
| `check_whole_sequences.sage` | 単位歩から作った順向き・逆向きの有限列との照合 | PASS（1,152組） |

実行日: 2026-10-04。`check.sage` から全11本を実行して通過した。
この環境では micromamba の SageMath 環境の Python から `sage.all` と `preparse` を読み、検査の絶対パスを `__file__` と `sys.argv[0]` に指定して実行した。
