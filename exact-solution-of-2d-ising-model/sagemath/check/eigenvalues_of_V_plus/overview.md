# SageMath Check: eigenvalues_of_V_plus

## 対象

**対象ラベル**: `eigenvalues_of_V_plus`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`
- ブロック: `evenEigen_010_theorem_eigenvalues_of_V_plus`（Λ̌_ε := (2 sinh 2K_2)^{M_col/2} exp(Σ_μ γ(θ̃_μ)(ε_μ − 1/2)) と置くと
  V^{(+)}Q̌_ε = Q̌_εV^{(+)} = (Λ̌_ε)_ℂQ̌_ε。固有値は正の実数で、最大は全ての ε_μ = 1、最小は全ての ε_μ = 0）
- 範囲: (1) の二つの鎖（各 9 行）。対角化可能性の段落、(2) の正値性・大小の比較、Λ̌_maxΛ̌_min の鎖はまだ散文で、ここでは確かめていない
  （主張の浮動小数点の確認は `050_claim_even_sector_eigenvalues/check_06`）。
- 記号: a := (2s_2)^{M_col/2}、e := exp(ǧ(ε))、Q̌_ε := Π_μ R_μ^{(ε_μ)}（R^{(1)} := ň_μ、R^{(0)} := I − ň_μ）。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| (1) の第一の鎖 V^{(+)}Q̌_ε = … = (Λ̌_ε)_ℂQ̌_ε | `check_part1_eigen_relation_chains.sage` | ň_μ を `_vprime_settings.sage` の模型から取り、a と exp(γ_μ/2) を不定元に置いて各行を括弧どおりに作り、隣どうしを比べる |
| (1) の第二の鎖 Q̌_εV^{(+)} = … = (Λ̌_ε)_ℂQ̌_ε | 同上 | 同上 |

否定コントロール: 不定元の成分の 2×2 行列と不定元 a・e では、仮定（V^{(+)} = a_ℂV̌'、V̌'Q̌_ε = Q̌_εV̌' = e_ℂQ̌_ε）を使う 2 行が等号を外れ、
スカラー倍の主張を引く行は等号のまま残る。

構成上かならず一致する比較（写し間違いの検出だけに効く）: 5〜9 行目（real_inclusion_preserves_product と、a・ǧ(ε)・s_2・Λ̌_ε の定義の読み替え）は、
同じ多項式 a·e の行として作るので必ず一致する。

## 計算の帰属と範囲

- 成分は QQ 上のローラン多項式環 QQ[a, t_1^{±1}, …, t_M^{±1}]（厳密）。exp(γ_μ/2) と a の値そのものは ℝ への脱出なので、不定元に置いた。
- M_col = 2, 3、ε は全列挙。範囲外: M_col ≥ 4、本物の ψ̌ の ň_μ（鎖が ň_μ について使う性質は Q̌_ε の固有関係だけである）。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_part1_eigen_relation_chains.sage` | (1) の二つの鎖 | **PASS** | 等号 144 段、否定コントロール 4 行 |

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh eigenvalues_of_V_plus
```
