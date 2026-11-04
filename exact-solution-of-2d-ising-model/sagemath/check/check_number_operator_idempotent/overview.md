# SageMath Check: check_number_operator_idempotent

## 対象

**対象ラベル**: `check_number_operator_idempotent`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_002_claim_check_number_operator_idempotent`（ň_μ^2 = ň_μ。(1) ψ̌_μ^†ψ̌_μ^† = O・ψ̌_{σ(μ)}ψ̌_{σ(μ)} = O、(2) ψ̌_{σ(μ)}ψ̌_μ^† = I − ň_μ、(3) ň_μ^2 = ň_μ）
- 範囲: 証明の (1) の 2 本の鎖（各 2 個の等号）と matrix_sum_with_itself_zero_implies_zero の結論、(2) の 2 本の鎖（4 個と 2 個の等号）と
  matrix_summand_from_sum_equation の仮定、(3) の鎖（23 個の等号）。主張 (1)(2)(3)。
- 記号: σ(μ) := M_col + 1 − μ、D := ψ̌_μ^†、P := ψ̌_{σ(μ)}、n := DP（`def_check_number_operator` の ň_μ）。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| (1) の鎖 XX + XX = [X, X]_+ = O（X ∈ {D, P}）と XX = O | `check_part1_part2_anticommutator_chains_jordan_wigner_model.sage` | 反交換関係を満たす模型（Jordan–Wigner のフェルミ演算子 c_μ。D := c_μ^T、P := c_μ）で各行を `QQ` の行列として組み、隣と比べる。不定元の 2×2 行列では反交換関係を引く行だけが外れる（否定コントロール） | **PASS** | M = 2, 3, 4 で 90 段、不定元で 5 段（計 95 段。(1)(2) の合計）、否定コントロール 3 行 |
| (2) の鎖 DP + PD = [D, P]_+ = δI = 1_ℂ I = I と PD = I − DP = I − ň_μ | 同上 | 同上。δ_{σ(μ),σ(μ)} は添字から `def_kronecker_delta` で計算する | **PASS** | 同上 |
| (3) の鎖の 23 個の等号（先頭 4 個は `def_exp` (1) の冪を積へ運ぶ行） | `check_part3_chain_jordan_wigner_model.sage` | 同じ模型で括弧どおりに各行を組んで隣と比べる。不定元の 2×2 行列では (2) と (1) の第 1 式を引く 2 行だけが外れ、結合律・分配律・単位行列・符号の外出し・差の書き換えの行は等号のまま残る | **PASS** | M = 2, 3, 4 で 207 段、不定元で 21 段（計 228 段）、否定コントロール 2 行 |
| (1)(2)(3) の全ての鎖の全ての等号（仮定の行を含む）と主張 (1)(2)(3)、matrix_summand_from_sum_equation の仮定 DP + PD = I | `check_with_check_psi.sage` | 本文の ψ̌（`def_check_fermi` の式どおり。Ž_μ・Y̌_μ・位相は数体 F、ψ̌ は E_μ := F(r_μ)、r_μ := \|γ_2(θ̃_μ)\|。ψ̌_{σ(μ)} は E_{σ(μ)} から E_μ へ R ↦ R で移す）で、上の模型の検算と同じ鎖の関数を使って全ての等号を確かめる。ň_μ ≠ O, I と D, P ≠ O も見る（等号が自明でない）。対照: σ(μ) ≠ μ のとき対を μ 自身に取り違えた ψ̌_μ^†ψ̌_μ では (2) と (3) が成り立たない | **PASS** | 結合定数 3 組 × M_col = 2, 3 × 全 μ で 549/549 件（1 件が 1 本の鎖か 1 個の等号か 1 つの主張） |

## 計算の帰属と範囲

- **厳密**: すべて。模型の検算は `QQ` と `QQ` 上の多項式環、本物の ψ̌ の検算は数体 E_μ の中の等号。浮動小数点は使わない。
- **模型と本物の ψ̌ の役割**: 証明の鎖が使う仮定は反交換関係（`anticommutator_of_check_psi`）とそこから出す (1)(2) だけなので、
  模型の検算は「仮定さえ満たせば鎖が通る」ことと、否定コントロールで「どの行が仮定を使うか」を示す。
  本物の ψ̌ の検算は、本文の ψ̌ が仮定を満たし、同じ鎖が本文の行列で通ることを示す。
- **ℝ への脱出**: r_μ = |γ_2(θ̃_μ)| と (√M_col)_ℂ（ℝ_{≥0} の平方根）。どちらも代数的数として厳密に持つ（`def_check_number_operator` の検算の準備と同じ）。
- **作り方で自明な比較**（両辺を同じ Sage の式から作るので、本文の写し間違いだけを検出する）:
  (1)(2) の鎖の第 1 等号（反交換子の定義を右辺から左辺へ）、(2) の第二の鎖の第 2 等号（I − DP から I − ň_μ。n := DP と置いたので同じ式）、
  (3) の鎖の「n n」から「(DP)(DP)」、「DP − D(nP)」から「n − D(nP)」、「n − D(nP)」から「n − D((DP)P)」の 3 個（どれも ň_μ の定義の代入）。
  (3) の「n − O O」の行は左因子が O なので仮定なしでも成り立ち、否定コントロールの対象にしない。
- 範囲外: 本物の ψ̌ の検算の M_col ≥ 4。M_col = 4 では ψ̌ を数体 E_μ（F の上の二次拡大、F は 16 次）に作るだけで 250 秒、16 次の行列の積一つが 5 秒かかり
  （2026-11-04、負荷 37 の VM で測った）、一本の鎖に積が 40 個ほど要るためである。M_col = 4 の鎖は模型の検算が受け持つ。模型の検算の M_col ≥ 5 も範囲外。
  鎖が使う仮定（本物の ψ̌ の反交換関係）そのものは、M_col = 2..5 で `anticommutator_of_check_psi` の検算の「主張」の行が厳密に確かめている。

## 由来

2026-11-04 まで、この主張の検算は `050_claim_even_sector_eigenvalues/` の番号付きの検算にあった（そのディレクトリの対象ラベルは
`eigenvalues_of_V_plus` だけなので、この主張は未検算に数えられていた）。

| いまの名前 | 旧い名前 |
|---|---|
| `check_part1_part2_anticommutator_chains_jordan_wigner_model.sage` | `check_28_check_number_operator_idempotent_anticommutator_chains.sage` |
| `check_part3_chain_jordan_wigner_model.sage` | `check_23_check_number_operator_associativity_chains.sage` の前半（後半の Step 2・Step 3 の鎖は `../check_number_operators_commute/check_step2_step3_chains_jordan_wigner_model.sage`） |
| `_chains.sage` | 上の二つのファイルがそれぞれの中で定めていた鎖の組み立て（中身は不変。関数名 `check_chain`・`kron` を共有の準備の同名の関数とぶつからないよう `check_chain_lines`・`kron_tensor` に改めた） |
| `check_with_check_psi.sage` | 新しく足した |

冪等性そのものを浮動小数点で確かめた `050_claim_even_sector_eigenvalues/check_01_number_operator.sage` は、他の主張と共有しているのでそこに残した。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh check_number_operator_idempotent
# 個別（M_col を引数で絞れる）
cd sagemath/check/check_number_operator_idempotent && sage check_with_check_psi.sage 2 3
```
