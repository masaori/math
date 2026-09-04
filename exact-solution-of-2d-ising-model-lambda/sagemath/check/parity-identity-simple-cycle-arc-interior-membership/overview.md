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
- 状態: **未実行**（2026-09-05 実装。上流検算の読み込みだけで 13 分の実測があり、
  四変種の実行が tick の締切に収まらなかった。次の tick が最初に実行し、
  観測値を記録して assert を確定させる。assert は観測直後に固定し、
  再実行の確認は日次監査に委ねてよい——その場合はここへその旨を書く）。
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
