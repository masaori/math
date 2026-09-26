# SageMath Check: 167_V1_restriction_to_eigenspaces の両符号版（退避）

## 対象

退避対象: `V1_restriction_to_eigenspaces` の旧 (±) 両符号版
（`(end(V_1))|_{F^{(±)}} = (end(V_1^{(±)}))|_{F^{(±)}}`、複号同順）

(−) セクターを本文から外したとき（2026-09-26）、`V1_restriction_to_eigenspaces` はその場で `F^{(+)}` 上の置き換えだけの主張に書き直された
（`F^{(-)}` 側の述べ方は参照用ノートにも移されておらず、旧版はリポジトリの履歴にだけ残る）。本文側の検査
`check/167_V1_restriction_to_eigenspaces/` は (+) だけに書き直した。ここは書き直す前の検査の記録である。

| ファイル | 検証内容 | ステータス |
|---|---|---|
| `check_01_restriction.sage` | 両符号での制限の一致、不変性、反対符号では一致しないこと（複号同順）、`[ε, H_1^{(±)}] = 0` | PASS |

## 実行方法

共有ライブラリを `../../../_shared/operators.sage` から読む。2026-09-26 に SageMath 10.9 で再実行し、PASS した（`logs/`）。
