# 同じ軌道の点を始点にした台の一致の検算

**対象ラベル**: `claim_finite_permutation_orbit_basepoint`

- 実行日: 2026-10-11
- 状態: PASS。行別16本・計3,338,928確認と、定義の独立検算が通過。
- 本文の16計算行を一行一ファイルで検算する。大きさ0〜6の全874置換を列挙し、自然数の反復回数は0〜添字集合の大きさの二倍とする。
- 各行はその行に必要な局所条件で検査する。第一包含の所属同値は、始点が元の台に属さない場合も含める。
- 行別検算の所属判定は無向辺の隣接リストの探索から求める。定義の検算では、これを順逆の反復列から求めた台と照合し、全ての始点対で所属・両包含・台の等号を調べる。
- 空集合の唯一の置換も含む。空集合では点の条件は空である。有限例の厳密検算であり、一般の証明は本文と Lean が担う。

| ファイル | 本文の計算 | 状態 | 確認数 |
|---|---|---|---|
| `check_forward_zero.sage` | 零回の反復の所属 | PASS | 29,367 |
| `check_forward_successor.sage` | 後者の反復を展開する | PASS | 373,837 |
| `check_forward_induction.sage` | 移した始点に帰納法の同値を使う | PASS | 373,837 |
| `check_forward_one_step.sage` | 一歩の不変性を使う | PASS | 29,367 |
| `check_inverse_transfer.sage` | 逆置換の台へ移す | PASS | 373,837 |
| `check_inverse_iteration.sage` | 逆置換に順向きの同値を使う | PASS | 373,837 |
| `check_inverse_return.sage` | 元の置換の台へ戻す | PASS | 29,367 |
| `check_self_zero.sage` | 自己所属の零回の証人 | PASS | 5,039 |
| `check_subset_forward_witness.sage` | 第一包含で順向きの到達先を代入 | PASS | 373,837 |
| `check_subset_forward_membership.sage` | 第一包含で順向きの所属を戻す | PASS | 373,837 |
| `check_subset_backward_witness.sage` | 第一包含で逆向きの到達先を代入 | PASS | 373,837 |
| `check_subset_backward_membership.sage` | 第一包含で逆向きの所属を戻す | PASS | 373,837 |
| `check_symmetric_forward_membership.sage` | 逆所属で順向きの同値を逆に使う | PASS | 63,773 |
| `check_symmetric_forward_witness.sage` | 逆所属で順向きの到達先を代入 | PASS | 63,773 |
| `check_symmetric_backward_membership.sage` | 逆所属で逆向きの同値を逆に使う | PASS | 63,773 |
| `check_symmetric_backward_witness.sage` | 逆所属で逆向きの到達先を代入 | PASS | 63,773 |
| `check_definition.sage` | 定義の独立検算と両包含・台の等号 | PASS | 874置換・5,039始点・29,367組 |

プロジェクト直下で `sage sagemath/check/finite-permutation-orbit-basepoint/check.sage` を実行する。
