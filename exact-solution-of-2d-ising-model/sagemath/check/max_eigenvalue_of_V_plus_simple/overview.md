# SageMath Check: max_eigenvalue_of_V_plus_simple

## 対象

**対象ラベル**: `max_eigenvalue_of_V_plus_simple`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_011_theorem_max_eigenvalue_of_V_plus_simple`（Λ̌_max = Λ^{(1/2)}_{M_col} であり V^{(+)} の単純固有値）
- 範囲: (1) の 4 行の鎖、(2) の ǧ(1,…,1) − ǧ(ε) の 10 行の鎖と、それに続く ǧ(ε) < ǧ(1,…,1) ⟹ exp の不等号の 2 行・(2s_2)^{M_col/2} ∈ ℝ_{>0}・Λ̌_ε の 8 行の鎖、
  (3) の左から Q̌_{ε'} を掛ける 5 行、d の鎖 4 行、割り算の鎖 5 行、項を消す 4 行、逆向きの Q̌y = y の 8 行と V^{(+)}y = Λ̌_max y の 6 行の全てと、主張 (1)(2)(3) そのもの。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| (1) の 4 行 | `check_step1_lambda_half_chain.sage` | 角の行は θ̃_μ/π と θ^{(1/2)}_{M_col,μ}/π を QQ で、exp・arccosh・実数冪の行は RealField(200)（M_col = 2..8、結合定数 4 組と臨界点） |
| 同上（厳密） | `check_claim_with_actual_V_plus.sage` | 角の行を QQ で、Λ̌_{(1,…,1)} = a·Π exp(γ_μ/2) = Λ^{(1/2)}_{M_col} を AA で。Λ^{(1/2)} は角 2π(μ − 1/2)/M_col から 1 の冪根と結合定数で直接作る（Λ̌ の側の γ_1(θ̃_μ) と独立なのは、cos を 1 の冪根から作ることと、c_2^*・s_2^* を t = tanh K_2 から作ることの二点。c_1・s_1 の式は同じ） |
| (2) の ǧ の 10 行の鎖と Λ̌_ε の 8 行の鎖 | `check_step2_strict_inequality_chains.sage` | 等号の行は γ_μ を不定元に置いた QQ 上の多項式環で、不等号の行は γ_μ を正の有理数に置いて厳密に（M = 2..6、ε と μ_0 を全列挙）。物理の γ と Λ̌_ε の鎖は RealField(200) |
| (2) の鎖の exp を取った値、ǧ(ε) < ǧ(1,…,1) からの 2 行、(2s_2)^{M_col/2} > 0、Λ̌_ε の鎖の両端 | `check_claim_with_actual_V_plus.sage` | 実際の γ_μ（exp(γ_μ) ∈ AA）で exp(ǧ(1,…,1) − ǧ(ε)) = Π exp(a_μ) ≥ exp(γ_{μ_0}) > 1 と a·exp(ǧ(ε)) < a·exp(ǧ(1,…,1)) = Λ̌_max を AA で |
| (3) の左から Q̌_{ε'} を掛ける 5 行 | `check_step3_left_projection_chain.sage` | Jordan–Wigner の模型の Q̌_ε と有理数の Λ_ε で QQ で厳密に（M = 2, 3, 4）。否定コントロールは不定元の行列 |
| (3) の後半の 5 本の鎖 | `check_step3_eigenspace_chains.sage` | 同じ模型で QQ で厳密に |
| (3) の全ての鎖（実際の V^{(+)} で） | `check_claim_with_actual_V_plus.sage` | 本文の ψ̌ から作った Q̌_ε、実際の V^{(+)}、V^{(+)} − Λ̌_max I の核の基底 x で、括弧どおりに QQbar で |
| 主張 (3) の固有空間の一致と次元 1 | `check_claim_with_actual_V_plus.sage` | V^{(+)} − Λ̌_max I の核の次元が 1（数体 E_1 で。Λ̌_max は、Q̌_{(1,…,1)} の成分の比で作った E_1 の元の QQbar での像が AA の Λ̌_max に等しいことを確かめてから使う）、その基底 v が Q̌_{(1,…,1)}v = v、rank Q̌_{(1,…,1)} = 1 |
| 主張の読み（最大固有値で単純） | `check_claim_with_actual_V_plus.sage` | V^{(+)} の固有多項式の根（AA、重複込み）が {Λ̌_ε} に一致し、最大の根が Λ̌_max で重複度 1 |

鎖が使う上流の主張（eigenvalues_of_V_plus (1) の V^{(+)}Q̌_ε = Q̌_εV^{(+)} = Λ̌_εQ̌_ε、check_joint_eigenspace_decomposition (1)(2)(4)、
gamma_theta_tilde_mu_positive）は、`check_claim_with_actual_V_plus.sage` が実際の行列で成り立つことを先に確かめてから使う。

否定コントロール:
- `check_step1_lambda_half_chain.sage`: Λ^{(0)}_M、前因子の冪を M にしたもの、和の 1/2 を落としたもの（105 件）。
- `check_step2_strict_inequality_chains.sage`: γ_{μ_0} = 0 だと最後の狭義不等号が外れる。
- `check_step3_left_projection_chain.sage`: 不定元の行列では (1) と固有方程式を使う 2 行だけが外れる。
- `check_step3_eigenspace_chains.sage`: 固有ベクトルでない x、im Q̌ に入らない y で決まった行だけが外れる（12 件）。
- `check_claim_with_actual_V_plus.sage`: Λ^{(0)}_{M_col} ≠ Λ̌_max、固有ベクトルでない有理数の列 z で V^{(+)}z ≠ Λ̌_max z と左から Q̌_{(0,…,0)} を掛けた行が外れること、
  Q̌_{(1,…,1)}z ≠ z、(1,…,1) 以外に重複度 2 以上の固有値があること（θ̃_μ と θ̃_{M_col+1−μ} の γ が等しいため。単純性の比較 mult = 1 が自明でないことの確認）。

構成上かならず一致する比較（写し間違いの検出だけに効く）:
- `check_claim_with_actual_V_plus.sage` の (1) の Λ̌_max = a·Π exp(γ_μ/2) の行は、Λ̌_{(1,…,1)} を同じ積で作るので必ず一致する。中身は独立な経路の exp(γ) の一致と、Λ^{(1/2)} との一致である。
- (3) の鎖のスカラー倍の外出し・結合律・単位元・冪の定義の行は、Sage の行列の計算規則だけで必ず成り立つ。中身として効くのは、V^{(+)}Q̌_ε = Q̌_εV^{(+)} = Λ̌_εQ̌_ε、固有方程式、Σ_εQ̌_ε = I、Q̌^2 = Q̌、Λ̌_ε ≠ Λ̌_max（ε ≠ (1,…,1)）である。
- (3) の V^{(+)}y の鎖の (Λ̌_{(1,…,1)}Q̌)y = (Λ̌_maxQ̌)y の行は、Λ̌_max := Λ̌_{(1,…,1)} と置いているので必ず一致する。
- `check_claim_with_actual_V_plus.sage` の (2) の Λ̌_ε = a·exp(ǧ(ε)) と a·exp(ǧ(1,…,1)) = Λ̌_max、exp(a_{μ_0}) = exp(γ_{μ_0}) は同じ積から作るので必ず一致する（件数に数えない）。中身は狭義不等号 a·exp(ǧ(ε)) < a·exp(ǧ(1,…,1)) と a > 0、exp(γ_{μ_0}) > 1 である。
- `check_step2_strict_inequality_chains.sage` の (B) の定義の展開の行（Λ̌_ε・s_2・ǧ の定義）は、同じ定義から組むので必ず一致する。
- `check_step1_lambda_half_chain.sage` の 4 行目と 5 行目（def_Lambda_delta_M を δ → 1/2 で開いた値と Λ^{(1/2)}_M）は、同じ式を作り直しているので必ず一致する。中身は角の一致と 1 行目の Λ̌_{(1,…,1)} との比較である。

## 計算の帰属と範囲

- `check_claim_with_actual_V_plus.sage`: K_1 := 2 log y、K_2 := log x、(x, y) ∈ {(2, 2), (3, 3/2), (5/4, 3)}、M_col = 2, 3。V^{(+)} は def_V_plus の積を射影の y^λ と V_2 の成分 x^n で AA に作る。
  ψ̌・ň_μ は数体 E_1 で作り（`check_joint_eigenspace_decomposition/_number_operators.sage` の本物の ψ̌ の設定）、E_1 → QQbar の埋め込みで移す。
  exp(γ_μ) = γ_1 + √(γ_1^2 − 1)（def_gamma_theta・def_arccosh の実対数の中身）、exp(γ_μ/2) := √(exp(γ_μ)) として AA で持つ。
  **ℝ への脱出は K_1・K_2 の選び方と γ を arccosh の式から作る一点だけ**で、以後の等号・不等号・核・固有多項式の根は全て厳密計算である。浮動小数点は使わない。
- `check_step1_lambda_half_chain.sage`・`check_step2_strict_inequality_chains.sage` の物理の結合定数の部分は RealField(200)（ℝ 脱出: exp・arccosh・実数冪の値。差が 10^{-50} 未満、または十分大きいことを見る）。
  有理数の結合定数では exp・arccosh の値が代数的数にならないので、厳密な比較は `check_claim_with_actual_V_plus.sage` の結合定数の選び方で行っている。
- 範囲外: `check_claim_with_actual_V_plus.sage` の M_col ≥ 4、他の結合定数。

## 由来

2026-11-04 に `050_claim_even_sector_eigenvalues/` から次の 4 本を内容の名前で移した（中身は不変。step3_eigenspace の冒頭の注記の参照先を新しい名前にし、step2 の乱数に種を置いた）。

| 旧い名前 | 新しい名前 |
|---|---|
| `check_26_max_eigenvalue_simple_left_projection_chain.sage` | `check_step3_left_projection_chain.sage` |
| `check_max_eigenvalue_simple_step1_lambda_half_chain.sage` | `check_step1_lambda_half_chain.sage` |
| `check_max_eigenvalue_simple_step2_strict_inequality_chains.sage` | `check_step2_strict_inequality_chains.sage` |
| `check_max_eigenvalue_simple_step3_eigenspace_chains.sage` | `check_step3_eigenspace_chains.sage` |

浮動小数点で V^{(+)} の固有値全体と単純性を見る旧い検算 `050_claim_even_sector_eigenvalues/check_06` は 050 に残してある。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_step1_lambda_half_chain.sage` | (1) の 4 行 | **PASS** | 角の一致 35 項、隣どうしの行 140 段、否定コントロール 105 件 |
| `check_step2_strict_inequality_chains.sage` | (2) の二つの鎖 | **PASS** | 等号 3200 段、不等号 1920 段、物理の結合定数で 476 通り |
| `check_step3_left_projection_chain.sage` | (3) の左から掛ける 5 行 | **PASS** | 143 段、否定コントロール 2 行 |
| `check_step3_eigenspace_chains.sage` | (3) の後半の 5 本の鎖 | **PASS** | 279 段、否定コントロール 12 件 |
| `check_claim_with_actual_V_plus.sage` | 主張 (1)(2)(3) と (2)(3) の鎖を実際の V^{(+)} で | **PASS** | 等号 759 個、不等号 120 個、否定コントロール 30 件 |

人手証明の計算の誤りは見つからなかった。(2) の散文（移項・real_exp_strictly_increasing・(2s_2)^{M_col/2} > 0）を (∵) 付きの鎖と
def_second_transfer_matrix_prefactor の参照にした（主張は不変）。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh max_eigenvalue_of_V_plus_simple
```
