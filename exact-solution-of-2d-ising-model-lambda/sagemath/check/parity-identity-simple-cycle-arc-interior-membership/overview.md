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
- 状態: **PASS**（2026-09-05）。四変種とも直接衝突を持ち、合同線型系に解が無かった。

  | 変種 | 弧型の種数 | 階数 | 直接衝突 | 可解 |
  | --- | --- | --- | --- | --- |
  | interior_d | $10{,}059$ | $6{,}760$ | $25$ | 否 |
  | interior_c | $10{,}030$ | $6{,}740$ | $48$ | 否 |
  | interior_dc | $10{,}075$ | $6{,}776$ | $16$ | 否 |
  | interior_orient | $10{,}061$ | $6{,}771$ | $16$ | 否 |

  読み方: $D$ 所属だけ・$C$ 所属だけ・その両方・スロット名つきの向きだけ、の
  どれを内部頂点へ戻しても足りない。必要なのは向きと所属を同時に保つ
  完全署名との残差である。観測は同じ実行の中で assert へ固定した。
- 実測時間: $446$ 秒（2026-09-05。他の検算と同時に走らせた状態での計測）。
  以前は上流の検算 36 本の assertion を読み込みのたびに再実行していたため、
  読み込みだけで 13 分かかり、四変種の実行は tick の上限 2700 秒に収まらなかった。
  上流を `construction.sage`（構成）と `check.sage`（assertion）へ分けて構成だけを読むようにし、
  さらに行の作り方を「弧型ごとの個数の偶奇の台」だけを持つ疎な形へ変えた。
  分離の形は `bash scripts/verify-upstream-load-and-roadmap.sh` が機械検査する。
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
