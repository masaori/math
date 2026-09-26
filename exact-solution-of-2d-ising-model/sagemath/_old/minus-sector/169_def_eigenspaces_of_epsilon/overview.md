# SageMath Check: 169_def_eigenspaces_of_epsilon の両符号版（退避）

## 対象

退避対象: `def_eigenspaces_of_epsilon` の旧 (±) 両符号版（`F^{(±)}` の両方を扱っていたもの）

(−) セクターを本文から外したとき（2026-09-26）、`def_eigenspaces_of_epsilon` は「`F^{(+)}` は複素部分線型空間である」
だけの主張にその場で書き直された（`F^{(-)}` の部分空間性は `odd_eigenspace_is_complex_subspace` として
参照用ノート `structured-latex/notes/minus_sector_not_adopted.ts` へ退避された。その検査は `../odd_eigenspace_is_complex_subspace/`）。本文側の検査
`check/169_def_eigenspaces_of_epsilon/` は (+) だけに書き直した。ここは書き直す前の検査の記録である。

| ファイル | 検証内容 | ステータス |
|---|---|---|
| `check_01_eigenspaces.sage` | `ε² = I`、固有値が `±1`、`dim F^{(+)} = dim F^{(-)} = 2^{M-1}`、`ε = σ^x_1⋯σ^x_M` | PASS |

## 実行方法

共有ライブラリを `../../../_shared/operators.sage` から読む。2026-09-26 に SageMath 10.9 で再実行し、PASS した（`logs/`）。
