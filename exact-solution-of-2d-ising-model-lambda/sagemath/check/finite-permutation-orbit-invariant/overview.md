# 軌道の台の不変性の検算

**対象ラベル**: `claim_finite_permutation_orbit_invariant`

- 実行日: 2026-10-11
- 状態: PASS。行別19本・計586,974確認と、定義の独立検算が通過。
- 本文の19計算行を一行一ファイルで検算する。整数・有限集合の厳密計算だけを使う。
- 準備の帰納法は、大きさ0〜4の全289写像と反復回数0〜8で調べる。順逆の到達は、大きさ0〜6の全874置換・全始点と反復回数0〜添字集合の大きさの二倍で調べる（後者の式では一回を加える）。
- 所属の同値は全29,367組の始点と点で調べる。空集合の置換も列挙に含み、点を量化する条件は空となる。
- 定義の検算では、順逆の反復列とは別に無向辺の隣接リストを探索して到達集合を求める。有限例の検算であり、任意の有限集合・回数に対する証明は本文と Lean が担う。

| ファイル | 本文の計算 | 状態 | 確認数 |
|---|---|---|---|
| `check_commute_zero_value.sage` | 零回の反復を消す | PASS | 1,114 |
| `check_commute_zero_return.sage` | 零回の反復へ戻す | PASS | 1,114 |
| `check_commute_successor_definition.sage` | 反復の後者を展開する | PASS | 10,026 |
| `check_commute_induction.sage` | 移した始点での帰納法の等式 | PASS | 10,026 |
| `check_commute_successor_return.sage` | 反復の後者へ戻す | PASS | 10,026 |
| `check_forward_successor.sage` | 順向きの後者を展開する | PASS | 63,773 |
| `check_forward_commute.sage` | 準備の可換式を順向きに使う | PASS | 63,773 |
| `check_forward_witness.sage` | 順向きの到達先を代入する | PASS | 63,773 |
| `check_backward_zero_successor.sage` | 逆向き零回では順向き一回を使う | PASS | 5,039 |
| `check_backward_zero_value.sage` | 順向き零回を消す | PASS | 5,039 |
| `check_backward_zero_inverse.sage` | 逆向き零回を挿入する | PASS | 5,039 |
| `check_backward_zero_witness.sage` | 逆向き零回の到達先を代入する | PASS | 5,039 |
| `check_backward_cancel.sage` | 逆写像の打ち消し | PASS | 63,773 |
| `check_backward_commute.sage` | 準備の可換式を逆向きに使う | PASS | 63,773 |
| `check_backward_successor.sage` | 逆向きの後者へ戻す | PASS | 63,773 |
| `check_backward_witness.sage` | 逆向きの到達先を代入する | PASS | 63,773 |
| `check_inverse_transfer.sage` | 逆置換の台へ所属を移す | PASS | 29,367 |
| `check_membership_cancel.sage` | 逆写像の打ち消しによる所属の同値 | PASS | 29,367 |
| `check_membership_inverse.sage` | 元の台と逆置換の台の所属の同値 | PASS | 29,367 |
| `check_definition.sage` | 定義と独立な到達集合・一歩の所属同値 | PASS | 5,039始点・29,367組 |

プロジェクト直下で `sage sagemath/check/finite-permutation-orbit-invariant/check.sage` を実行する。
