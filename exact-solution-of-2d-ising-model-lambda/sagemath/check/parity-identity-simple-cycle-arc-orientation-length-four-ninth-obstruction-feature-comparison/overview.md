# SageMath Check: 八特徴追加後に残る語長四障害の特徴比較

## 対象

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

- 範囲: 位置ビット閉式へ先行する八つの障害を除く特徴を加えた有限合同系
- 内容: 次の左核矛盾証拠と、そこで相殺しない語長四弧型の特徴を比較する
- 帰属: 有限集合と $\mathbb F_2$。浮動小数点を使わない

## 結果

2026-09-15 に実行した。最初の交差所属積 `step0_e_left*step0_d_up`、先頭語位置の
上辺・下辺・左辺所属 `step0_e_up`・`step0_e_down`・`step0_e_left`、最初の語位置の
両側の列切断旗 `step0_wrap_col0`・`step0_wrap_collast`、左側での倍化辺所属
`step0_d_left`、反対側の行切断旗 `step0_wrap_rowlast` を加えた系から、9 鍵を台に持つ
次の左核矛盾証拠を取り出した。9 行を足すと、自由未知数として残した 7,968 弧型と
先行八特徴は相殺し、固定済みの語長四弧型 6 種だけが奇数回残る。候補値の和は一、
鍵の右辺の和は零なので、これは先行する八つの証拠とは独立な障害である。

6 種上で一次特徴と二特徴積を全数比較すると、相殺しない特徴は 554 個あり、そのうち
一次特徴は 21 個だった。先頭語位置のこちら側の行切断旗 `step0_wrap_row0` は証拠との
積が一になる。この列も加えた全 7,085 鍵の系は階数 6,311、拡大階数 6,312 でなお
非可解だった。したがって、この特徴は今回の証拠を除くが、閉式を完成させる十分条件ではなく、
さらに独立な障害が残る。一般の辺長・全語長についての命題ではなく、一般命題と Lean 二版は
未追加である。

## 実行方法

```sh
sage sagemath/check/parity-identity-simple-cycle-arc-orientation-length-four-ninth-obstruction-feature-comparison/check.sage
```
