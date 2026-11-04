# SageMath Check: max_eigenvector_in_even_sector

## 対象

**対象ラベル**: `max_eigenvector_in_even_sector`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_007_theorem_max_eigenvector_in_even_sector`（(1) η_{(1,…,1)} = +1、(2) η_ϵ = (−1)^{M_col−|ϵ|} = (−1)^{M_col+|ϵ|} と εQ̌_ϵ = (−1)^{M_col+|ϵ|}Q̌_ϵ、
  (3) ε = (−1)^{M_col}Π_μ(I − 2ň_μ)、(4) im Q̌_{(1,…,1)} ⊆ F^{(+)} と、その言い換え「V^{(+)} の最大固有値の固有ベクトルは F^{(+)} に属する」）
- 範囲: 証明の準備 (P1)（4 行）・(P2)（3 行）、(1) の含意の鎖（3 行）、(2) の η_ϵ の鎖（8 行）と行列の式（2 行）、(3) の鎖（3 行）、
  (4) の εQ̌_{(1,…,1)} の鎖（3 行）・Q̌y = y の鎖（4 行）・εy = y の鎖（4 行）・y ∈ F^{(+)}・言い換えの鎖（2 行）の全てと、主張 (1)〜(4)。

## 使う行列と値

本文の ψ̌（`def_check_fermi` の式どおりの行列）から作った ε、ň_μ := ψ̌_μ^†ψ̌_{σ(μ)}、Q̌_ϵ、η_ϵ は `../epsilon_eigenvalue_on_check_Q/_prelude.sage` の
`EpsilonSetting` から取る（結合定数 K_1 := 2 log y、K_2 := log x、(x, y) ∈ {(2,2), (3,3/2), (5/4,3)}、M_col = 2, 3。成分は数体 E_1 の元で厳密。
η_ϵ は `epsilon_eigenvalue_on_check_Q` の証明の (1) の作り方で求め、V^{(+)} を使わない）。
実際の V^{(+)}（`def_V_plus` の ((V_1^{(+)})^{1/2}V_2)(V_1^{(+)})^{1/2}）は `max_eigenvalue_of_V_plus_simple` の検算と同じく、
`_shared/transfer_matrix_factor_inverses.sage` の整数固有値のスペクトル射影（y^λ）と V_2 の成分 x^n から QQ の行列として作り、E_1 へ移す。
Λ̌_ϵ は V^{(+)}Q̌_ϵ = Λ̌_ϵQ̌_ϵ の成分の比として E_1 の元で持つ。E_1 → QQbar の埋め込みは `max_eigenvalue_of_V_plus_simple` の検算と同じ。

## 証明の行との対応

| 証明の行 | ファイル | 確かめ方 | ステータス | 結果 |
|---|---|---|---|---|
| (1) の 1 行目 tr(εV^{(+)}) = r_ℂ かつ r ∈ ℝ_{>0}（`trace_of_epsilon_V_plus`）、2 行目 tr(εV^{(+)}) > 0（`trace_of_epsilon_V_plus_via_check_eigenvalues` の z > 0 の定め方。証人 r）、3 行目 η_{(1,…,1)} = +1（同 (3)）、主張 (1) | `check_part1_sign_of_eta.sage` | tr は本文の積と `def_trace` の和で E_1 に、r は QQ に。3 行目は ψ̌ 側の η と、引いた主張の当てはめとして tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ と ϰ > 0 を AA・QQbar で（ϰ := (2s_2)^{M/2}Π 2sinh(γ(θ̃_μ)/2)）。独立に tr(εV^{(+)}) = Σ_ϵ η_ϵΛ̌_ϵ（E_1） | **PASS** | 3 組 × M_col = 2, 3。等号・主張 42 件、否定コントロール 18 件 |
| (P1) の 4 行（k = 0..8）、(P2)（全ての ϵ で \|ϵ\| ≤ #M̌ = M_col）、(2) の η_ϵ の 8 行と行列の式 2 行（全ての ϵ）、(3) の 3 行、主張 (2)(3) | `check_part2_part3_signs.sage` | (P1) は ℂ = QQ(i)、包含は r ↦ r + 0i、冪は `def_power_of_complex_number` の帰納法どおり。(2)(3) は E_1。行列は本文の定め方（body_*）で括弧どおりに組み、主張は Sage の `*`・`-` で独立に組んだ右辺と比べる | **PASS** | 等号・主張 528 件、否定コントロール 105 件 |
| (4) の εQ̌_{(1,…,1)} の 3 行、Q̌y = y の 4 行・εy = y の 4 行（x を I の全ての列と有理数の列に）、y ∈ F^{(+)}、言い換えの 2 行、主張 (4) | `check_part4_image_in_even_sector.sage` | E_1 で括弧どおり。im は列の張る空間なので、I の全ての列で im の全体を見る。言い換えは、Λ̌_{(1,…,1)} の QQbar での像が V^{(+)} の固有多項式（QQ）の最大の根（AA）で重複度 1 であることを確かめ、V^{(+)} − Λ̌_max I の核（E_1）と Q̌_{(1,…,1)} の列空間が一致し、その基底が εv = v を満たすことを見る。独立に、ψ̌ を使わず V^{(+)} − λ_max I の核（QQbar）の基底 v が εv = v | **PASS** | 等号・主張 420 件、否定コントロール 18 件 |

## 計算の帰属と範囲

- **厳密**: すべて。E_1・QQ(i)・QQ・AA・QQbar の等号と不等号。浮動小数点は使わない（ログの ϰ・Λ̌_max の小数は表示だけ）。
- **ℝ への脱出**: K_1 = 2 log y・K_2 = log x の選び方（exp・cosh・sinh の値が有理数になる）と、γ(θ̃_μ) を arccosh の実対数の式 exp(γ) = γ_1 + √(γ_1^2 − 1) から代数的数として作る一点（`def_check_number_operator` の検算の準備と同じ）。
- **作り方で自明な比較**（両辺を同じ値から作るので、本文の写し間違いだけを検出する）: (P1) の 2 行目（ℂ = QQ(i) の包含は恒等で、(−1_ℂ)(−1_ℂ) と ((−1)(−1))_ℂ は同じ元）、
  (2) の 1 行目の η_{(1,…,1)}(−1)^{M−|ϵ|}（`epsilon_eigenvalue_on_check_Q` (3) の当てはめで、η_ϵ と比べるので自明でない）以外の η の鎖の行（数体の同じスカラーの算術）、
  (3) の 2・3 行目、(4) の Q̌y・εy の鎖の置き方の行、(P2)（|ϵ| と #M̌ を数えて比べるだけ）、(1) の 2 行目の証人（1 行目で確かめた r をそのまま証人に取る）。鎖の両端の比較と主張（Sage の演算子で組んだ右辺との比較、ψ̌ を使わない固有ベクトルの比較）は自明でない。
- **(1) の 3 行目について**: 引いた同値（`trace_of_epsilon_V_plus_via_check_eigenvalues` (3)）そのものの検算はその主張の検算が受け持つ。ここでは、
  同じ設定で η_{(1,…,1)} が ψ̌ から +1 と求まり、tr(εV^{(+)}) > 0 と tr(εV^{(+)}) = η_{(1,…,1)}ϰ_ℂ が成り立つ（η = −1 なら tr = −ϰ < 0 で一致しない）ことを確かめた。
- **証明の書き直し**（この検算を付けたときに行った。主張は不変）: (1) の散文を、`trace_of_epsilon_V_plus` の読み方（左辺が右辺の像 r_ℂ、r ∈ ℝ_{>0}）と
  `trace_of_epsilon_V_plus_via_check_eigenvalues` の z > 0 の定め方をつなぐ行を足した 3 行の含意の鎖に、(2) の「(1) を代入して」「(−1)^{−|ϵ|} = (−1)^{|ϵ|}」（定義の無い負の冪）を
  非負の冪だけの 8 行の鎖と準備 (P1)(P2) に、(3) の「代入する」を 3 行の鎖に、(4) の εQ̌_{(1,…,1)} = Q̌_{(1,…,1)} を Lean の具体版（`epsilon_mul_Qproj_univ` の `one_smul`）と同じ
  εQ̌ = η_{(1,…,1)}Q̌ = 1_ℂQ̌ = Q̌ の鎖にし（Lean と同じ経路なのはこの鎖だけで、(2) の (−1)^{M+|ϵ|} の鎖と y = Q̌x からの鎖は Lean に無い。Lean の連続実行の受け持ち）、「冪等性より y = Q̌y」を y = Q̌x からの 4 行の鎖に、言い換えを `max_eigenvalue_of_V_plus_simple` (3) を引く 2 行の鎖にした。
- 範囲外: M_col ≥ 4（数体 E_μ の次数が大きく、`epsilon_eigenvalue_on_check_Q` の検算と同じ理由）。

## 否定コントロール

- `check_part1_sign_of_eta.sage`: r の和を差にしたもの、tr(V^{(+)})（ε を落とす）は tr(εV^{(+)}) に一致しない。η = −1 とした −ϰ は負で tr(εV^{(+)}) に一致しない。
- `check_part2_part3_signs.sage`: 指数を 1 ずらした (−1)^{M−|ϵ|+1} は η_ϵ でない。符号を反転した −(−1)^{M+|ϵ|} は η_ϵ でない。M_col が奇数で (−1)^{|ϵ|} は η_ϵ でない。(3) の右辺の符号の反転、M_col が奇数で (−1)^M を落とした Π は ε でない。
- `check_part4_image_in_even_sector.sage`: im に入らない有理数の列 z では Q̌z ≠ z。η_ϵ = −1 となる ϵ の Q̌_ϵ の列 y では εy ≠ y。V^{(+)} の 2 番目に大きい根の固有空間は F^{(+)} に入らない基底を持つ。

## 由来

この主張の旧い検算は `053_claim_even_sector_closing/check_02_epsilon_parity.sage`（浮動小数点。対象ラベルは `onsager_exact_solution` だけなので、
この主張は未検算に数えられていた）にあり、章の他の主張と共有しているのでそこに残した。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh max_eigenvector_in_even_sector
# 個別（M_col を引数で絞れる）
cd sagemath/check/max_eigenvector_in_even_sector && sage check_part4_image_in_even_sector.sage 2
```

実行ログは `logs/` に保存してある（2026-11-04）。
