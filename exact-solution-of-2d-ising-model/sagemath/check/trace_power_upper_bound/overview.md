# SageMath Check: trace_power_upper_bound

## 対象

**対象ラベル**: `trace_power_upper_bound` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_008a_claim_trace_power_upper_bound`（`tr(W^n) ≤ 2^{M_col} c(M_col)^n`）
- 範囲: 証明の四つの準備（【e_k のノルム】【冪の実対称性】【対角成分の表示】【W^ae_k の成分とノルム】）、偶数の場合の鎖 10 行、奇数の場合の `W^{2a+1} = W^a(WW^a)` の鎖 7 行と成分の鎖 12 行、最後のトレースの鎖 5 行、主張そのもの。
- 記号は証明のとおり `c := c(M_col)`、`d := 2^{M_col}`、`u := W^ae_k`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| 【e_k のノルム】（`‖e_k‖ = √(Σ|(e_k)_i|^2) = √(|(e_k)_k|^2) = √(|1|^2) = √1 = 1`） | `_lines.sage` | AA の平方根で作ったノルムの 5 段、根号の中が 1 | **PASS** |
| 【冪の実対称性】（`W^p` は実対称） | `_lines.sage` | `def_exp` (1) の漸化式で作った冪が Sage の冪 `P**p` と一致し、成分が QQ、`def_matrix_transpose` で作った転置と一致。鎖 `(W^p)_kl = ((W^p)^⊤)_kl = (W^p)_lk` の 2 段を全成分で | **PASS** |
| 【対角成分の表示】（`e_k^⊤W^pe_k = ΣΣ… = Σ_j (e_k)_k(W^p)_kj(e_k)_j = Σ_j (W^p)_kj(e_k)_j = (W^p)_kk(e_k)_k = (W^p)_kk`） | `_lines.sage` | 5 段の等号と、組み込みの行列積 `e^⊤Qe` との比較、`i ≠ k` の項が 0 | **PASS** |
| 【W^ae_k の成分とノルム】（`u_l = Σ_m (W^a)_lm(e_k)_m = (W^a)_lk(e_k)_k = (W^a)_lk`、`‖u‖ ≤ c^a‖e_k‖ = c^a`、`‖u‖^2 ≤ c^{2a}`） | `_lines.sage` | 成分の式と組み込みの積、3 行の等号、`rayleigh_bounds_operator_norm` の冪の主張（指数 `a`）の不等号、`0 ≤ ‖u‖`、`(c^a)^2 = c^{2a}`、二乗した不等号 | **PASS** |
| 偶数の場合の鎖（【対角成分の表示】 → `2a = a+a` → `matrix_power_exponent_law` → `mat_mult` → 【冪の実対称性】 の対称性 → `u_l = (W^a)_lk` → `u_lu_l = |u_l|^2` → `def_matrix_norm` → `≤ c^{2a}` → `n = 2a`） | `_lines.sage` | 8 段の等号、不等号、最後の等号。`W^{2a} = W^aW^a` を行列として比較 | **PASS** |
| 奇数の場合の `W^{2a+1} = W^{a+(1+a)} = W^aW^{1+a} = W^a(W^1W^a) = W^a(W^{0+1}W^a) = W^a((W^0W)W^a) = W^a((IW)W^a) = W^a(WW^a)` | `_lines.sage` | 7 段の行列の等号（冪は `def_exp` (1)、積は `mat_mult` の成分の式） | **PASS** |
| 奇数の場合の成分の鎖（【対角成分の表示】 → 上の鎖 → `mat_mult` 2 回 → 分配則 → 【冪の実対称性】 → 【W^ae_k の成分とノルム】 → `def_real_bilinear_value` → `def_rayleigh_sup` → 【W^ae_k の成分とノルム】 と `c > 0` → 指数法則 → `n = 2a+1`） | `_lines.sage` | 8 段の等号、不等号 2 段、等号 2 段 | **PASS** |
| トレースの鎖（`def_trace` → 【対角成分の表示】 → 各 `k` の評価と有限和 → `d c^n` → `d = 2^{M_col}`） | `_lines.sage` | Sage の `trace`（別の経路）と `def_trace` の和と【対角成分の表示】 の和の一致、各 `k` の不等号、和の不等号、`Σc^n = dc^n` | **PASS** |
| 主張（`tr(W^n) ≤ 2^{M_col}c^n`） | 両方の `check_*.sage` | 一般の半正定値行列は `n ≤ 6`（`d ≤ 3`）・`n ≤ 5`（`d = 4, 5`）、本文の `W` は `M_col = 2, 3` で `n ≤ 5` | **PASS** |

`_lines.sage` の `check_proof_lines` を二つの検算が呼ぶ。

- `check_generic_positive_semidefinite_matrices.sage`: 証明が使う `W` の性質は「成分が実数で対称」「半正定値（`rayleigh_bounds_operator_norm` の前提）」「`c` は上限」だけなので、
  `P := A^⊤A`（`A` は整数の `n'×n` 行列、`n = 1..5`、`n' = n−1, n, n+1`）の有理行列 28 組で確かめる。等号 20672 個、不等号 2446 個。
- `check_symmetrized_transfer_matrix.sage`: 本文の `W = (BV_2)B`（`def_symmetrized_transfer_matrix`）を `K_1 := 2 log y`、`K_2 := log x`
  （`x, y ∈ {2, 3}`、`M_col = 2, 3`）で作る。`W` は QQ の行列である。等号 14464 個、不等号 1144 個。`W` の大きさが `d = 2^{M_col}` であることも確かめる。

`W` の作り方、`c(M_col)` の作り方（特性多項式の最大の実根を AA で取り、`cI − W` の半正定値性と固有ベクトルでの到達で上限であることを確かめる）、
ノルム・`x^⊤Py`・行列とベクトルの積・冪の関数は、直前の主張の検算 `sagemath/check/rayleigh_bounds_operator_norm/_prelude.sage` を読み込んで使う（その overview の「`c(M_col)` の作り方」）。

## 計算の帰属と範囲

- **厳密**: 行列の成分は QQ、`c` と平方根は AA（実代数的数）で、等号・不等号は全て厳密な比較。浮動小数点は使わない。
- ℝ への脱出は、本文の `W` の `K_1, K_2` の選び方と、上限 `c(M_col)`（`def_rayleigh_sup` で実数の上限として定まる）だけで、どちらも AA の代数的数として作れる場合に限って確かめている。
- 範囲: 一般の行列は `d = 1..5`、本文の `W` は `M_col = 2, 3`（`d = 4, 8`）、`n ≤ 5` または `6`。

## 否定コントロール（3 件、`check_generic_…`）

- `c` の代わりに 2 番目に大きい固有値 `c'` を使うと、`[[2,1,0],[1,2,1],[0,1,2]]` で大きい `n` に `tr(P^n) > 3c'^n` となる（`c` が上限であることが効いている）。
- 対称だが半正定値でない `diag(1, −2)` では、`c = 1` だが `tr(P^2) = 5 > 2·1^2`（半正定値性が効いている）。
- 対称でない `[[0,1],[0,0]]` では【冪の実対称性】 の `(W^1)_{kl} = (W^1)_{lk}` が外れる。

## 構成上かならず一致する比較（写し間違いの検出だけに効く）

- 【e_k のノルム】の 1 行目（`norm_exact` と同じ式）、偶数の鎖の `W^{2a} = W^{a+a}`（同じ添字の冪）、【対角成分の表示】の 1 行目（`bil` は二重和そのもの）と 2〜5 行目、【冪の実対称性】の鎖の 2 行目（転置を `def_matrix_transpose` の式で作る）、奇数の鎖の `ΣΣu_lW_lmu_m = u^⊤Wu`（`bil` の定義そのもの）、【W^ae_k の成分とノルム】の 1〜3 行目、偶数・奇数の鎖の `mat_mult` と分配則の行は、和の項を落とす・並べ替えるだけなので QQ の計算規則で必ず一致する。中身は、組み込みの行列積 `e^⊤Qe`・`P*e` と Sage の `trace`・冪 `P**p` との比較にある。
- `W^{2a+1}` の鎖の `W^{a+(1+a)}`・`W^{0+1}`・`W^0`・`I` の行は、冪を `def_exp` (1) の漸化式で作るので構成上一致する。`matrix_power_exponent_law` を当てる行（`W^aW^{1+a}`、`W^a(W^1W^a)`）は、別々に作った冪の積の比較なので中身がある。

## 証明の修正（2026-11-04）

- 「`W` は実対称なので `W^n` も実対称」と「冪の指数法則」は本文に主張が無かった。`matrix_power_exponent_law`・`product_of_real_entry_matrices_has_real_entries`・
  `power_of_real_symmetric_complex_matrix_is_real_symmetric` を足して引いた（それぞれに同名の検算を付けた）。
- 旧い鎖は `(W^ae_k)^⊤(W^ae_k)` と `(W^a)^⊤ = W^a` を使っていたが、行列の積の転置の主張は本文に無い。対角成分を `mat_mult` で開き、`W^a` の成分の対称性と `u_l = (W^a)_lk` で `‖u‖^2`・`u^⊤Wu` に着く形にした。
- `(W^n)_kk = e_k^⊤W^ne_k`・`‖e_k‖ = 1` を `def_real_bilinear_value`・`def_matrix_norm` から示す準備を置いた。「レイリー上限評価の `a` 回の適用」は `rayleigh_bounds_operator_norm` の冪の主張を `k → a` で一度当てるものなので、そう書いた。
- レビューの指摘で、`‖u‖^2 ≤ (c^a)^2 = c^{2a}` を地の文から根拠付きの鎖に、`(W^p)_kl = ((W^p)^⊤)_kl = (W^p)_lk` の二つの等号に別々の根拠を、偶数の場合に `2a = a+a` の行を足し、準備を番号でなく内容の名前で呼ぶ形にした。
- 計算の誤りは無かった。主張は不変。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh trace_power_upper_bound
```

実行ログは `logs/` に保存する。
