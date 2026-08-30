# 台の辺が相異なる閉歩道の接触点での分割

**対象ラベル**: `claim_edge_simple_contact_split`

追加の対象ラベル: `claim_contact_split_seam_parity`, `claim_contact_split_turning_update`,
`claim_contact_split_pair_descent`, `claim_contact_elimination_by_splitting`

- 実行: `sage sagemath/check/edge-simple-contact-split/check.sage`
- 状態: PASS（2026-08-30）
- 使用する環: `ZZ` と有限集合だけ。浮動小数点は使わない。

一辺二のトーラス上の閉じた非後退辺列を長さ 8 まで全数列挙し、台の辺が相異なるものの
すべての接触点について、二つの添字区間が空でない短い閉じた非後退辺列になり、台の辺集合が
互いに交わらず元の台の辺集合を覆うことを検査する。

さらに各接触点分割について、横・縦の切断線指示値の和が二本の閉歩道へ厳密に分かれること
（偶奇の組の保存、`claim_contact_split_seam_parity`）と、循環総回転数のずれが
$\{-4,0,4\}$ に収まりつつ零でない接触点が実在すること（回転数はこの分割で保存されない）を検査する。
ずれそのものは、元の二接続を再接続後の二接続へ置き換えた回転数差と一致すること
（`claim_contact_split_turning_update`）も各接触点で検査する。
接触対の個数については、元の接触対集合を「両方が区間 $(k,l]$」「両方が補集合」「混合」へ
三分割し、二本の接触対数が前二者の個数と一致すること、選んだ接触点が混合部分に属して
混合部分が 1 以上であること、そして和の狭義減少（`claim_contact_split_pair_descent`）を
各接触点で検査する。
さらに、台の辺が相異なる各閉歩道を、接触対が残る限り先頭の接触点で二分する。
反復が接触対数以下の回数で止まること、得た空でない有限族の各成員で接触対数が零であること、
台の辺集合が互いに交わらず元の集合を覆うこと、二つの切断線偶奇の総和が保存されること
（`claim_contact_elimination_by_splitting`）を検査する。
