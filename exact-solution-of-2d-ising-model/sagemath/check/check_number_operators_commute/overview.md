# SageMath Check: check_number_operators_commute

## 対象

**対象ラベル**: `check_number_operators_commute`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_003_claim_check_number_operators_commute`（μ ≠ ν のとき (1) ψ̌_μ^†ň_ν = ň_νψ̌_μ^†・ψ̌_{σ(μ)}ň_ν = ň_νψ̌_{σ(μ)}、(2) ň_μň_ν = ň_νň_μ）
- 範囲: Step 1 の δ の計算（2 個の等号）、4 式（1・3・7・1 個の等号）、結びの鎖 XW + WX = [X, W]_+ = O（2 個の等号）と
  matrix_equals_negation_if_sum_is_zero の結論 XW = −(WX)、Step 2 の鎖（10 個の等号、X ∈ {ψ̌_μ^†, ψ̌_{σ(μ)}}）、Step 3 の鎖（7 個の等号）。主張 (1)(2)。
- 記号: σ(λ) := M_col + 1 − λ、D_λ := ψ̌_λ^†、P_λ := ψ̌_{σ(λ)}、n_λ := D_λP_λ（`def_check_number_operator` の ň_λ）。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| Step 1 の δ の計算・4 式・結びの鎖と XW = −(WX) | `check_step1_anticommutator_chains_jordan_wigner_model.sage` | 反交換関係を満たす模型（Jordan–Wigner のフェルミ演算子 c_μ。D_μ := c_μ^T、P_μ := c_μ）で各行を `QQ` の行列として組み、隣と比べる。δ は添字から `def_kronecker_delta` で計算する。不定元の 2×2 行列では反交換関係を引く行と XW = −(WX) だけが外れ、反交換子の定義・和の交換・δ の対称性・0_ℂ I = O の行は一致する（否定コントロール） | **PASS** | M = 2, 3, 4、μ ≠ ν の全 20 組。厳密等号 520 個、否定コントロール 6 行 |
| Step 2 の 10 個の等号と Step 3 の 7 個の等号 | `check_step2_step3_chains_jordan_wigner_model.sage` | 同じ模型で括弧どおりに各行を組んで隣と比べる。不定元の 2×2 行列では Step 1・(1) を引く 4 行だけが外れ、結合律・符号の外出し・二重の符号反転の行は等号のまま残る | **PASS** | M = 2, 3, 4 で 540 段、不定元で 13 段（計 553 段）、否定コントロール 4 行 |
| 全ての鎖の全ての等号（仮定の行を含む）、XW = −(WX)、主張 (1)(2) | `check_with_check_psi.sage` | 本文の ψ̌（`def_check_fermi` の式どおり。D_λ・P_λ は E_λ := F(r_λ) の行列）を、μ と ν の行列が掛けられる環 C へ移し、上の模型の検算と同じ鎖の関数で全ての等号を確かめる。C は、E_ν = F なら E_μ、r_ν^2 = r_μ^2（F の元として。ν = σ(μ) を含む）なら E_μ（R ↦ R。r_ν = r_μ を `AA` で確かめる）、それ以外は E_μ[S]/(S^2 − r_ν^2)（R ↦ S）。どの C にも本物の値への環の準同型（S ↦ +r_ν）があるので、C の中の等号は本物の値の等号を導く。ň_μň_ν ≠ O も見る（C が体のとき。r_ν^2 が E_μ の平方でなければ剰余環も体である）。対照: ν = σ(μ) ≠ μ のとき、対を取り違えた ψ̌_μ では [ψ̌_μ, ψ̌_ν^†]_+ ≠ O | **PASS** | 結合定数 3 組 × M_col = 2, 3 × μ ≠ ν の全ての組で 1068/1068 件（1 件が 1 本の鎖か 1 個の等号か 1 つの主張） |

## 計算の帰属と範囲

- **厳密**: すべて。模型の検算は `QQ` と `QQ` 上の多項式環、本物の ψ̌ の検算は数体 E_μ とその上の二次の剰余環の中の等号。浮動小数点は使わない。
- **模型と本物の ψ̌ の役割**: 証明の鎖が使う仮定は反交換関係（`anticommutator_of_check_psi`）と、そこから出す Step 1 の XW = −(WX)・(1) だけなので、
  模型の検算は「仮定さえ満たせば鎖が通る」ことと、否定コントロールで「どの行が仮定を使うか」を示す。
  本物の ψ̌ の検算は、本文の ψ̌ が仮定を満たし、同じ鎖が本文の行列で通ることを示す。
- **剰余環の中の判定の向き**: E_μ[S]/(S^2 − r_ν^2) は体とは限らない（r_ν^2 が E_μ の平方なら二つの体の積になる）。等号は準同型で本物の値へ移るので確かめになるが、
  「等しくない」は本物の値で等しくないことを導かないので、対照と ň_μň_ν ≠ O は C が体の組でだけ見る。
  なお走らせる範囲（M_col = 2, 3）では、C が体でない場合は起きない（M_col = 2 は全ての組が r_ν^2 = r_μ^2、M_col = 3 は E_ν = F・r_ν^2 = r_μ^2・E_μ = F で C = F[S]/(S^2 − r_ν^2) が体、の三つが結合定数ごとに 2 組ずつ）。
- **ℝ への脱出**: r_λ = |γ_2(θ̃_λ)| と (√M_col)_ℂ。どちらも代数的数として厳密に持つ（`def_check_number_operator` の検算の準備と同じ）。
- **作り方で自明な比較**（両辺を同じ Sage の式から作るので、本文の写し間違いだけを検出する）:
  反交換子の定義を当てる行（第 3 式の第 1・第 3 等号、結びの第 1 等号）、第 3 式の δ の対称性の行（`kronecker_delta` は対称な関数なので構成上一致する）、
  Step 2 の先頭と末尾の等号と Step 3 の先頭と末尾の等号（どれも ň の定義の代入）。
- 範囲外: 本物の ψ̌ の検算の M_col ≥ 4。M_col = 4 では ψ̌ を数体 E_μ（F の上の二次拡大、F は 16 次）に作るだけで 250 秒、16 次の行列の積一つが 5 秒かかり
  （2026-11-04、負荷 37 の VM で測った）、組が 12 個あって一組に積が 100 個ほど要るためである。M_col = 4 の鎖は模型の検算が受け持つ。模型の検算の M_col ≥ 5 も範囲外。
  鎖が使う仮定（本物の ψ̌ の反交換関係）そのものは、M_col = 2..5 で `anticommutator_of_check_psi` の検算の「主張」の行が厳密に確かめている。

## 由来

2026-11-04 まで、この主張の検算は `050_claim_even_sector_eigenvalues/` の番号付きの検算にあった（そのディレクトリの対象ラベルは
`eigenvalues_of_V_plus` だけなので、この主張は未検算に数えられていた）。

| いまの名前 | 旧い名前 |
|---|---|
| `check_step1_anticommutator_chains_jordan_wigner_model.sage` | `check_29_check_number_operators_commute_step1_anticommutator_chains.sage` |
| `check_step2_step3_chains_jordan_wigner_model.sage` | `check_23_check_number_operator_associativity_chains.sage` の後半（前半の (3) の鎖は `../check_number_operator_idempotent/check_part3_chain_jordan_wigner_model.sage`） |
| `_chains.sage` | 上の二つのファイルがそれぞれの中で定めていた鎖の組み立て（中身は不変。関数名 `check_chain`・`kron` を `check_chain_lines`・`kron_tensor` に改めた） |
| `check_with_check_psi.sage` | 新しく足した |

可換性そのものを浮動小数点で確かめた `050_claim_even_sector_eigenvalues/check_01_number_operator.sage` は、他の主張と共有しているのでそこに残した。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh check_number_operators_commute
# 個別（M_col を引数で絞れる）
cd sagemath/check/check_number_operators_commute && sage check_with_check_psi.sage 2 3
```
