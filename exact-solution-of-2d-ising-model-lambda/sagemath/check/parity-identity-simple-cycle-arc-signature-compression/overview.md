# 弧署名の圧縮による頂点項分解の保存性

**対象ラベル**: `claim_kac_ward_determinant_fiber_stratified_phase_sum`

`parity-identity-simple-cycle-boundary-arc-decomposition` で確定した
「$\partial D$ で切った弧の完全な署名列による頂点項の分解」について、
弧型を粗い統計へ圧縮しても分解が保たれるかを三段の水準で判定する。

- counts: 弧の長さ・曲がり型頂点の個数・切断旗の総数・両端頂点の完全署名の対。
- turnword: 曲がり/直進の型の列（反転同一視）・切断旗の総数・両端頂点の完全署名の対。
- turnwrapword: 型と切断旗を頂点ごとに並べた列（反転同一視）・両端頂点の完全署名の対
   （内部頂点の $D/C$ 所属だけを落とす圧縮）。

各水準で、直接衝突（圧縮弧型の多重集合の偶奇が等しく頂点項が異なる鍵対）の
有無と、合同の $\mathbb F_2$ 線型系の可解性を判定する。

- 実行: `sage sagemath/check/parity-identity-simple-cycle-arc-signature-compression/check.sage`
- 状態: **PASS**（2026-09-05）。観測直後に次の値を assert へ固定した。
- counts: 型 $8{,}890$ 種、階数 $5{,}898$、直接衝突 $243$ 件、解なし。
- turnword: 型 $9{,}225$ 種、階数 $6{,}198$、直接衝突 $160$ 件、解なし。
- turnwrapword: 型 $9{,}998$ 種、階数 $6{,}708$、直接衝突 $65$ 件、解なし。
- 方法: 有限集合、$\mathbb F_2$、整数、$\mathbb Q(\zeta_8)$ の厳密演算のみ。
  浮動小数点は使わない。

三水準はいずれも同じ圧縮弧型の多重集合を持ちながら頂点項が異なる鍵を生じ、
圧縮弧型へ任意の値を割り当てても合同線型系を解けない。とくに turnwrapword の失敗により、
内部頂点の $D/C$ 所属を全て落とすことはできない。
