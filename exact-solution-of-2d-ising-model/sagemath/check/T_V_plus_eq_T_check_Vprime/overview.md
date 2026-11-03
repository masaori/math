# SageMath Check: T_V_plus_eq_T_check_Vprime

## 対象

**対象ラベル**: `T_V_plus_eq_T_check_Vprime`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evenfermi_008_claim_T_eq`（T_{(V^{(+)})} = T_{(V̌')}）
- 範囲: 準備 1 の二つの鎖（3 個と 2 個の等号）、準備 2 の復元公式、Step 1 の鎖（13 個の等号、(W, U) = (Ž, Z), (Y̌, Y)）、
  Step 2 の四つの鎖（和・スカラー倍・積が 7 個ずつ、単位元が 4 個の等号）、主張そのもの。
  Step 2 の末尾の「閉じている」ことの確認と Step 3（最小性による包含 A ⊆ E と A = R）は等号の鎖を持たない集合の議論なので、
  行としては確かめない。その代わりに、主張をすべての行列単位で直接確かめる（行列単位は R を張るので、Step 3 の結論そのものに当たる）。

## 証明の行との対応

記号は証明のもの: `c := (M_col)_C^{-1}`、`a_{jμ} := exp(i(j_R θ̃_μ)_C)`、`T'_g(X) := (gX)g^{-1}`（mat_conj の T_B）、
`(W, U)` は `(Ž, Z)` または `(Y̌, Y)`。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 1 の第 1 の鎖（`T_V_plus_is_conjugation`、`def_T_g`、T'_g の定め方） | `check_exact_side.sage` | T_{(V^{(+)})} を `def_T_V_plus` の三つの共役 T_S∘T_{V_2}∘T_S の合成で、T_{V^{(+)}} と T'_{V^{(+)}} を V^{(+)} = (SV_2)S と (S^{-1}V_2^{-1})S^{-1} の積で作り、各行が等しい。左辺を Sage の `V X V^{-1}`（独立な逆行列）と比べる。X は Z_j・Y_j・Ž_μ・Y̌_μ と標本 3 個。第 2・第 3 等号の両辺は同じ (gX)g^{-1} の式なので独立な確認ではない。対照: 逆向きの共役とは一致しない | **PASS** | 数体 F の中で厳密 |
| 準備 1 の第 2 の鎖（`def_check_Vprime` (2)、T'_g の定め方） | `check_vprime_ball.sage` | 両辺は同じ (V̌'X)(V̌')^{-1} の式なので独立な確認ではない。ボールの V̌'・exp(−X̌) による共役を、Sage の行列の exp・逆行列による共役とも比べる | **PASS** | ボール（下記） |
| 準備 2 の復元公式（`recover_Z_Y_from_check_Z_Y`） | `check_exact_side.sage` | c Σ_μ a_{jμ}W_μ を本文の成分の式（スカラー倍・左から順の有限和）で組み、`jw` で作った Z_j・Y_j と等しい。Sage の和・積でも等しい。a_{jμ} = ζ_{4M}^{2(2μ−1)j} は QQbar の exp(2πi·jθ̃_μ/(2π)) と一致することを毎回確かめる。対照: 係数を exp(−i(j_R θ̃_μ)_C) にすると崩れる j がある、c を掛け忘れると崩れる | **PASS** | 同上（全 j） |
| Step 1 の第 1〜第 6 等号（復元公式、準備 1 の第 1 の鎖、`mat_conj` のスカラー倍、`matrix_conjugation_preserves_finite_sum`、`mat_conj` のスカラー倍、準備 1 の第 1 の鎖） | `check_exact_side.sage` | 各行を別々に組み、隣り合う行が等しい | **PASS** | 同上（全 j × 二組） |
| Step 1 の第 7〜第 13 等号（`T_V_plus_eq_T_check_Vprime_on_check_Z_Y`、準備 1 の第 2 の鎖、`mat_conj`、`matrix_conjugation_preserves_finite_sum`、`mat_conj`、準備 1 の第 2 の鎖）と最後の復元公式 | `check_vprime_ball.sage` | 第 6 等号の右辺は厳密な値をボールへ移したもの。以降の行を V̌'・exp(−X̌) のボールで別々に組み、隣り合う行のボールが重なる。両端 T_{(V^{(+)})}(U_j) と T_{(V̌')}(U_j) も重なる。第 8・第 12 等号は T_{(V̌')} と T'_{V̌'} を入れ替えるだけの行で、両辺を同じ (V̌'W)(V̌')^{-1} で組むので独立な確認ではない | **PASS** | 同上 |
| Step 2 の和・スカラー倍・積の鎖の第 1・第 2・第 3 等号（準備 1 の第 1 の鎖、`mat_conj` の和・スカラー倍の式、`conjugation_is_ring_homomorphism` の乗法性） | `check_exact_side.sage` | x, y は標本 3 個（生成元の積 Z_1Y_M、Y_1 + iZ_2、成分が小さい整数と i の組の行列）、α = 2i − 1/3。各行を別々に組み等しい | **PASS** | 同上 |
| Step 2 の三つの鎖の第 4〜第 7 等号（x, y ∈ E、準備 1 の第 2 の鎖、`mat_conj`・`conjugation_is_ring_homomorphism` を右辺から左辺へ、準備 1 の第 2 の鎖） | `check_vprime_ball.sage` | 第 3 等号の右辺（V^{(+)} の側）は厳密な値を移したもの。以降の行をボールで組み、隣り合う行が重なる。第 4 等号の「x, y ∈ E」は主張から従う事実で、検算は主張が標本で成り立つことを確かめているにすぎない。第 5・第 7 等号は T_{(V̌')} と T'_{V̌'} を入れ替えるだけの行で、独立な確認ではない | **PASS** | ボール |
| Step 2 の単位元の鎖（準備 1、`conjugation_is_ring_homomorphism` の単位性 ×2、準備 1） | 両方 | 第 1・第 2 等号は厳密、第 3・第 4 等号はボール。第 4 等号は T'_{V̌'} と T_{(V̌')} を入れ替えるだけの行で、独立な確認ではない | **PASS** | 同上 |
| 主張 | `check_vprime_ball.sage` | すべての行列単位 e_{rs}（2^M × 2^M 個）と標本 3 個で、厳密な T_{(V^{(+)})}(x) を移した値が T_{(V̌')}(x) のボールと重なる（標本は Sage の exp・逆行列の共役とも）。対照: 標本は逆向きの共役 (V̌')^{-1}xV̌' とは重ならない | **PASS** | 同上 |

## 計算の帰属と範囲

- 共通の準備は `_prelude.sage`。`T_V_plus_eq_T_check_Vprime_on_check_Z_Y/_prelude.sage`（数体 F の組み方、ψ̌ の作り方、ボールへの埋め込み、
  行列の exp のボール）を読み込み、実空間の Z_j・Y_j、c と a_{jμ}、F の中の V^{(+)}・(V^{(+)})^{-1} を足す。
  K_1 = 2 log y、K_2 = log x（x, y ∈ QQ_{>1}）と選ぶと、S = exp(X)・V_2・Ž_μ・Y̌_μ・位相が一つの数体 F に入る。
- 結合定数は (x, y) = (2, 2)、(3, 3/2)、(5/4, 3)。M_col = 2, 3, 4。
- **浮動小数点を使う所と理由**: `check_vprime_ball.sage` だけで、ℝ への脱出を含む量（γ(θ̃_λ) の実対数、行列の exp の極限）である。
  RealBallField・ComplexBallField（512 ビット）の区間で囲み、等号は区間が重なることで判定する。行列の exp の尾の上界は
  `s^{N+1}/(N+1)!/(1 − s/(N+2))`（s は成分の 2 乗和の平方根の上界で `def_matrix_norm` のノルム以上）で、2^{-300} 未満になるまで N を伸ばす。
  `check_exact_side.sage` はすべて数体 F の中で厳密である。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh T_V_plus_eq_T_check_Vprime
# 個別（M_col を引数で絞れる）
cd sagemath/check/T_V_plus_eq_T_check_Vprime && sage check_exact_side.sage 2 3
```
