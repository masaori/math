# 弧署名の圧縮による頂点項分解の保存性

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

`parity-identity-simple-cycle-boundary-arc-decomposition` で確定した
「$\partial D$ で切った弧の完全な署名列による頂点項の分解」について、
弧型を粗い統計へ圧縮しても分解が保たれるかを三段の水準で判定する。

1. counts: 弧の長さ・曲がり型頂点の個数・切断旗の総数・両端頂点の完全署名の対。
2. turnword: 曲がり/直進の型の列（反転同一視）・切断旗の総数・両端頂点の完全署名の対。
3. turnwrapword: 型と切断旗を頂点ごとに並べた列（反転同一視）・両端頂点の完全署名の対
   （内部頂点の $D/C$ 所属だけを落とす圧縮）。

各水準で、直接衝突（圧縮弧型の多重集合の偶奇が等しく頂点項が異なる鍵対）の
有無と、合同の $\mathbb F_2$ 線型系の可解性を判定する。

- 実行: `sage sagemath/check/parity-identity-simple-cycle-arc-signature-compression/check.sage`
- 状態: **未実行**（2026-09-05 の tick で実装したが、上流検算の読み込みだけで
  13 分を要すると実測され、tick の締切内に実行が終わらないため。
  次の tick が最初に実行し、観測値をここへ記録して assert を確定させる）
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。
