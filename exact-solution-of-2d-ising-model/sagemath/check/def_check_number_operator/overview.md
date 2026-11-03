# SageMath Check: def_check_number_operator

## 対象

**対象ラベル**: `def_check_number_operator`

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`
- ブロック: `evenEigen_001_definition_check_number_operator`（ň_μ := ψ̌_μ^† ψ̌_{M_col+1−μ} の定義と、(1) 共役添字の対合・(2) X̌ と V̌' の書き換え）
- 範囲: 証明の (1) の σ(σ(μ)) = μ の鎖（5 個の等号）、単射の鎖（2 個の等号）、全射の段落。証明の (2) の X̌ の鎖（1 個の等号）と V̌' の行。主張 (1)・(2)。

## 証明の行との対応

記号は証明のもの: σ(μ) := M_col + 1 − μ、g_μ は γ(θ̃_μ) の代わりに置いた互いに独立な不定元。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| (1) σ が M̌ から M̌ への写像であること（`def_check_index_set` (2)） | `check_conjugate_index_involution.sage` | M_col = 2..40 の全ての μ で σ(μ) ∈ M̌ | **PASS** | `ZZ` で厳密 |
| (1) σ(σ(μ)) の鎖の第 1〜第 5 等号（σ の定義 ×2、a − (b − c) = a − b + c、a − a = 0、0 + a = a） | `check_conjugate_index_involution.sage` | 各行を `ZZ[M, μ]` の多項式として組み、隣り合う行が等しい。第 3〜第 5 等号の操作そのものも `ZZ[a, b, c]` で確かめる。多項式環は元を標準形で持つので、各行の等号は「多項式として等しい」ことの確認である | **PASS** | `ZZ[M, μ]` で厳密 |
| (1) 単射の鎖（上の鎖、σ(μ) = σ(ν)、上の鎖） | `check_conjugate_index_involution.sage` | M_col = 2..40 の全ての組 (μ, ν) で、σ(μ) = σ(ν) なら鎖の 3 行が成り立ち μ = ν。像の個数が M_col | **PASS** | `ZZ` で厳密 |
| (1) 全射の段落と、ň_μ の個数と添字 μ・σ(μ) が M̌ に入ること（`def_check_index_set` とその (2)） | `check_conjugate_index_involution.sage` | M_col = 2..40 で σ(σ(ν)) = ν かつ σ(ν) ∈ M̌、像を並べると M̌。対照: μ ↦ −μ と μ ↦ M_col + 2 − μ は M̌ に入らない添字がある | **PASS** | `ZZ` で厳密 |
| (2) X̌ の鎖の第 1 等号（`def_check_Vprime` の X̌ から、各項へ ň_μ の定義） | `check_X_chain_exact.sage` | 両行は g_μ について斉一次なので、等号は各 μ の g_μ の係数の一致と同値。係数 ψ̌_μ^†ψ̌_{σ(μ)} − (1/2)_C I（本文の成分の式の積・スカラー倍・差）と ň_μ − (1/2)_C I（ň_μ は Sage の行列の積）を E_μ の中で比べる。係数が 0 でないことも見る。**この等号は ň_μ の定義の代入なので、両辺は同じ二つの因子の積であり独立な確認ではない。** 検算が確かめているのは、本文の成分の式の積と Sage の積が一致すること、ψ̌_{σ(μ)} を E_{σ(μ)} から E_μ へ移す写像が正しいこと（r^2 が F の同じ元であること）、σ(μ) を取り違えると崩れることである。対照: 対を μ 自身に取った ψ̌_μ^†ψ̌_μ では σ(μ) ≠ μ の全ての項で一致しない | **PASS** | 数体 E_μ で厳密（結合定数 3 組 × M_col = 2, 3, 4 × 全 μ） |
| 主張 (2) の第一式を γ の実際の値で | `check_Vprime_ball.sage` | X̌ を `def_check_Vprime` の形（積を取ってからボールへ移す）と ň_μ の形（因子をボールへ移してから積を取る）で別々に組み、重なる。上の行と同じく定義の代入なので独立な確認ではなく、γ の実際の値で和を組んだときに崩れないことの確認である | **PASS** | ボール（下記） |
| (2) V̌' = exp(X̌)（`def_check_Vprime` の V̌' の定義）と主張 (2) の第二式 | `check_Vprime_ball.sage` | `def_check_Vprime` の形の X̌ の Sage の exp と、ň_μ の形の X̌ の `def_exp` の部分和（尾の上界つき）のボールが重なる。この行は定義そのものなので、exp の作り方が本文の定義と合っていることの確認である。対照: exp(−X̌) とは重ならない | **PASS** | ボール（下記） |

## 計算の帰属と範囲

- 共通の準備は `_prelude.sage`。`T_V_plus_eq_T_check_Vprime_on_check_Z_Y/_prelude.sage` の数体の組み方（K_1 = 2 log y、K_2 = log x、x, y ∈ `QQ`_{>1}。
  Ž_μ・Y̌_μ・位相は数体 F に、ψ̌_μ^†・ψ̌_μ は E_μ := F(r_μ)、r_μ := |γ_2(θ̃_μ)| に）を読み込み、ψ̌_{σ(μ)} を E_{σ(μ)} から E_μ へ移す写像を足す。
  移す前に r_{σ(μ)}^2 と r_μ^2 が F の同じ元であり、`AA` で r_{σ(μ)} = r_μ > 0 であることを確かめる。ψ̌^†・ψ̌ が `def_check_fermi` の
  (Ž, Y̌)P̌ の組の積と一致し、分母 2√M_col b が 0 でないことも確かめる。
- μ ごとに体 E_μ が違うので、X̌ の和は g_μ の係数の組として持つ。g_μ を独立な不定元に置いたので、和の等号は係数ごとの等号と同値である
  （γ(θ̃_μ) は実対数による ℝ の値で、厳密な体には入らない）。
- 結合定数は (x, y) = (2, 2)、(3, 3/2)、(5/4, 3)。M_col = 2, 3, 4（M_col = 3 の μ = 2 は σ(μ) = μ の自己共役点）。
- **浮動小数点を使う所と理由**: `check_Vprime_ball.sage` だけで、ℝ への脱出を含む量（γ(θ̃_μ) の実対数、行列の exp の極限）である。
  RealBallField・ComplexBallField（512 ビット）の区間で囲み、等号は区間が重なることで判定する。行列の exp の尾の上界は
  `s^{N+1}/(N+1)!/(1 − s/(N+2))`（s は成分の 2 乗和の平方根の上界で `def_matrix_norm` のノルム以上）で、2^{-300} 未満になるまで N を伸ばす。
  ほかの 2 ファイルはすべて `ZZ` と数体の中で厳密である。

## 実行

```bash
bash sagemath/tools/run-all-checks.sh def_check_number_operator
# 個別（M_col を引数で絞れる）
cd sagemath/check/def_check_number_operator && sage check_X_chain_exact.sage 2 3
```
