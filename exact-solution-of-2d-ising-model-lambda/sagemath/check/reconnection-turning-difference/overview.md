# 接続の組み替えと回転差

**対象ラベル**: `claim_reconnection_turning_difference`
- 実行: `sage sagemath/check/reconnection-turning-difference/check.sage`
- 状態: PASS（2026-08-30、組み替え四つ組 1,176 件）

`L=1,2,3` の全向き付き辺について、共通の後続辺を二つ選んだ四つ組
（`f, f' ∈ Next(e) ∩ Next(e')`）を尽くし、二通りの対応の一歩の回転数の和が
`ℤ/4ℤ` で合同であること、差が 4 の倍数かつ `-4 ≤ D ≤ 4` に収まり
`{-4, 0, 4}` に属すること、三値がすべて実際に出現することを `ZZ` と
`Integers(4)` で厳密に検査する。浮動小数点は使わない。
