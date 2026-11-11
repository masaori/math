# SageMath Check: 巡回方向の反転と一歩の回転数

**対象ラベル**: `claim_plane_simple_polygon_cyclic_turning`

本文の「逆向きに巡ると各曲がりの符号が反転する」を、方向番号四種から成る非後退の隣接二辺 12 組で照合する。

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_reversed_pair.sage` | 方向を反転し順序を入れ替えた一歩の回転数 | PASS（2026-11-11） | 非後退の方向対 12 組すべてで一致 |

整数 `ZZ` と四方向の剰余だけを使い、実数体へは出ない。

実行: `sage sagemath/check/step-turning-reversal/check_reversed_pair.sage`
