# 弧署名の内部頂点所属情報の位置の切り分け

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

`parity-identity-simple-cycle-arc-signature-compression` で、内部頂点の
$D/C$ 所属だけを落とす turnwrapword でも頂点項の分解が保たれないことが
確定した。そこで turnwrapword と完全署名（解あり）の間に四変種を置き、
内部頂点のどの所属情報が必要かを切り分ける。

- interior_d: 曲がり/直進の型・切断旗に、四スロット（名前順）の $D$ 所属を加える。
- interior_c: 型・切断旗に、四スロットの $C$ 所属を加える。
- interior_dc: 型・切断旗に、$D$ 所属と $C$ 所属の両方を加える。
- interior_orient: 型を四スロットの $E$ 所属（名前順）へ置き換える
  （曲がり/直進では落ちる向きの情報だけを戻し、$D/C$ 所属は落としたまま）。

各変種で、直接衝突（圧縮弧型の多重集合の偶奇が等しく頂点項が異なる鍵対）の
有無と、合同の $\mathbb F_2$ 線型系の可解性を判定する。

- 実行: `sage sagemath/check/parity-identity-simple-cycle-arc-interior-membership/check.sage`
- 状態: **部分実行**（2026-09-05）。`interior_d` は型 $10{,}059$ 種・階数
  $6{,}760$・直接衝突 $25$ 件で、合同線型系は解を持たなかった。残る
  `interior_c`・`interior_dc`・`interior_orient` は 07:40 のまとめ開始時刻までに
  完了しなかったため未実行である。次の tick は一変種ずつ実行できる形へ検算を割り直し、
  観測値を assert へ固定する。
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
