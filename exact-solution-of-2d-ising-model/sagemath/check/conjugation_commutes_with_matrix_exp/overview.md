# SageMath Check: conjugation_commutes_with_matrix_exp

## 対象

**対象ラベル**: `conjugation_commutes_with_matrix_exp`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_claim_conjugation_commutes_with_matrix_exp`（正則な B について T_B(exp(X)) = exp(T_B(X))、T_B(A) := (BA)B^{-1}）
- 範囲: 証明の準備（部分和 P_N の置き方と二つの収束）、Step 1 の二つの鎖（p = 0 と p → p+1）、Step 2 の二つの鎖（N = 0 と N → N+1）、
  Step 3（二つの積の連続性）、結論の行（極限の一意性）と、主張そのもの。
- 記号: c_p := (1/p!)_ℂ、P_N(A) := Σ_{p=0}^{N} c_pA^p（P_0 = c_0A^0、P_{N+1} = P_N + c_{N+1}A^{N+1}）、冪は def_exp (1) の A^0 := I、A^{p+1} := A^pA。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| Step 1 の p = 0 の 3 行（X^0 := I、単位的、(T_B(X))^0 := I） | `check_steps1_2_exact.sage` | X の成分を KG 上の不定元に置き（n = 2, 3）、n = 4 は KG の具体の X で、各行を本文の成分の式で作って隣どうしを厳密に比べる |
| Step 1 の p → p+1 の 4 行（冪の定義、乗法的、帰納法の仮定、冪の定義） | 同上 | p = 0..3 |
| Step 2 の N = 0 の 4 行（準備、スカラー倍を保つ、Step 1、準備） | 同上 | 同上 |
| Step 2 の N → N+1 の 6 行（準備、和を保つ、帰納法の仮定、スカラー倍を保つ、Step 1、準備） | 同上 | N = 0..3 |
| Step 3（BP_N(X) → B exp(X)、(BP_N(X))B^{-1} → (B exp(X))B^{-1}） | `check_step3_and_conclusion.sage` (b) | 二つの段を一つにまとめた評価で見る（途中の BP_N(X) → B exp(X) は単独では見ない）。exp(X) を def_exp の部分和のボールで作り、‖T_B(P_N(X)) − T_B(exp(X))‖ ≤ ‖B‖‖P_N(X) − exp(X)‖‖B^{-1}‖（二つの連続性の主張の中身の matrix_norm_submultiplicativity）を N = 5, 10, 20, 40 で、右辺が単調に減って 2^{-20} 未満になることを確かめる |
| 結論の行と主張 T_B(exp(X)) = exp(T_B(X)) | `check_step3_and_conclusion.sage` (a)(b) | (a) X = (log y)·N（N は整数の固有値の整数行列）で両辺を射影から別々に作って厳密に、冪零の X で両辺を有限和として厳密に。(b) ボールの重なり |

否定コントロール:
- `check_steps1_2_exact.sage`: B^{-1} を B に取り違えた共役は冪を保たない。共役しない X^2 は T_B(X)^2 と違う。部分和の次数を一つずらすと一致しない（n ごとに 3 件）。
- `check_step3_and_conclusion.sage`: B^{-1} を B に取り違えると T_B(exp(X)) が exp(T_B(X)) に一致しない。冪零の X で、共役しない exp(X) は exp(T_B(X)) と違う。ボールで T_B(exp(X)) は exp(X) と重ならない。

構成上かならず一致する比較（写し間違いの検出だけに効く）:
- Step 1 の「冪の定義」の行（p = 0 の 1→2 行目と 3 行目、p → p+1 の 1→2 行目と 4 行目）は、`power_body` が A^0 := I・A^{p+1} := A^pA の漸化式そのもので行列を作るので必ず一致する。
- Step 1・Step 2 の「帰納法の仮定」の行は、左右を同じ関数で作るので必ず一致する（中身は前の段の行で確かめている）。
- 「準備の P_0・P_{N+1}」の行は、`partial_sum_body` が P_N を左から足して作るので必ず一致する。

## 計算の帰属と範囲

- `check_steps1_2_exact.sage`: KG = QQ(i) と KG 上の多項式環（厳密）。B は KG の 2・3・4 次の正則な行列、B^{-1} は Sage の inverse で作り、本文の積で BB^{-1} = B^{-1}B = I を確かめてから使う。
- `check_step3_and_conclusion.sage` (a): KG（厳密）。ℝ への脱出は X に log y を入れる選び方の一点だけで、exp の値は射影に y^λ を掛けて作る（def_exp の級数とは独立な経路）。
- `check_step3_and_conclusion.sage` (b): 256 ビットのボール（ℝ への脱出: exp の極限とノルムの平方根）。exp は `_shared/pauli_sites_exact.sage` の body_exp_ball（def_exp の部分和に尾の上界を各成分の半径として足したもの）。許容誤差は置かず、不等号はボールの上端で、等号は重なりで判定する（不等号の判定には、半径の分として 2^{-150} の余裕を置いた）。
- 範囲外: n ≥ 5、p ≥ 5、N ≥ 5（厳密な鎖）。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_steps1_2_exact.sage` | Step 1・Step 2 の帰納法の鎖 | **PASS** | 等号 144 個、否定コントロール 9 件 |
| `check_step3_and_conclusion.sage` | Step 3 の極限、結論の行と主張 | **PASS** | 厳密な等号 9 個、ボールで確かめた行 15 個、否定コントロール 12 件 |

人手証明の計算の誤りは見つからなかった（この主張は constant_c_value_even_sector の Step 2 の散文から切り出したもの）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh conjugation_commutes_with_matrix_exp
```
