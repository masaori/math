# 全スピン反転行列の固有値候補の必要十分版

対象の人手証明は `structured-latex/content/004_transfer_matrix.ts` の
`epsilon_action_eigenvalues_are_signs` である。

| 役割 | ファイル | 主要定理 |
| --- | --- | --- |
| 具体版 | `Ising2D/Part004/ClaimEpsilonActionEigenvalues.lean` | `Ising2D.epsilon_action_eigenvalues_are_signs` |
| 必要十分版 | `Ising2D/NecSuf/InvolutionEigenvalue.lean` | `Ising2D.NecSuf.eigenvalue_eq_one_or_neg_one_of_involution` |
| 具体版の再導出 | `Ising2D/Part004/ClaimEpsilonActionEigenvaluesFromNecSuf.lean` | `Ising2D.epsilon_action_eigenvalues_are_signs_of_necSuf` |

## 実際に効く仮定

- `Ring K`: 固有値の二次式で差と負元を扱い、平方差を因数分解するために使う。乗法の可換性は使わない。
- `IsDomain K`: 因数分解後の積が零なら一方の因子が零であることを使う。
- `AddCommGroup V` と `Module K V`: 線型写像の作用、スカラー倍、その差を扱う。
- `Module.IsTorsionFree K V`: 非零固有ベクトルに掛けて零になったスカラーを消す。
- `T (T x) = x`: 具体版の `epsilon M * epsilon M = 1`、行列作用の結合則、単位行列の作用をまとめた対合性である。
- `T f = lambda • f` と `f ≠ 0`: 内外二回の固有値方程式と、零ベクトルでは固有値を絞れないことに対応する。

有限添字、行列、複素数、有限次元性、固有空間、係数環の可換性は必要十分版の証明に現れない。
特に可換性を要求せず、平方差の展開は単位元だけが係数と交換することから成立する。

## 三つの証明の段対応

具体版は本文どおり、行列作用の結合則、複素線型性、単位行列の作用を成分和から示す。
必要十分版では、最初と三番目は `T (T x) = x` に、二番目は線型写像の `map_smul` に対応する。
その後は両版とも、固有値方程式を二回代入し、二次式を零にし、平方差を因数分解し、
零積の二場合を解く同じ順序で進む。再導出ファイルは `Matrix.toLin' (epsilon M)` を必要十分版へ渡し、
二回作用が元へ戻ることを `epsilon_mul_self` から証明する。

## プログラミングによる検証

`lake build` と `bash scripts/check-no-sorry.sh` により、具体版、必要十分版、再導出の型検査と、
主要定理が `sorryAx` に依存しないことを判定する。
