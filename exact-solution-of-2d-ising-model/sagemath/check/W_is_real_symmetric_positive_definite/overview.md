# SageMath Check: W_is_real_symmetric_positive_definite

## 対象

**対象ラベル**: `W_is_real_symmetric_positive_definite` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`
- ブロック: `maxeig_003_claim_W_is_positive_definite`（`W` は実対称正定値で、可逆）
- 範囲: 証明の Step 1（`σ_m^zσ_{m+1}^z`・`K_1D`・`S_2` の実対称性と `S_2` の表示の鎖 2 行）、Step 2（エルミート性・正定値性・`B'B = I`・
  部分和の実対称性・`B` と `A` の実対称性）、Step 3（`W` の鎖 4 行、合同と正の実数倍による正定値性、転置の鎖 4 行）、
  可逆性の段（`BB'` の鎖 3 行、`BV_2 ∈ R^×`、`W ∈ R^×`）、主張そのもの。
- 記号は証明のとおり `D := Σ_m σ_m^zσ_{m+1}^z`（`σ_{M+1}^z := σ_1^z`）、`B := exp((1/2)K_1D) = V_1^{1/2}`、`B' := exp(−(1/2)K_1D)`、
  `S_2 := iK_2^*H_2`、`A := exp(S_2)`、`c := (2s_2)^{M_col/2}`、`W := (BV_2)B`。

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス |
|---|---|---|---|
| Step 1 の準備（`m^+`、`σ_{m+1}^z = σ_{m^+}^z`、`σ_{m^+}^zσ_m^z = σ_m^zσ_{m^+}^z`。`m^+ = m` は `M_col = 1` だけ） | `check_step1_K1D_transpose_and_real_entries.sage` | `M_col = 1..6` の全ての `m` | **PASS** |
| Step 1 の `(σ_k^z)^⊤ = σ_k^z` の 5 行、`(σ_m^zσ_{m+1}^z)^⊤ = σ_m^zσ_{m+1}^z` の 5 行（周期端を含む）、`(K_1D)^⊤ = K_1D` の 5 行 | `check_step1_K1D_transpose_and_real_entries.sage` | 各行を本文の字面どおり（クロネッカー積は成分の式、転置は `def_matrix_transpose` の成分の式）に組み、隣の行と比べる。`M_col = 1..6`、`K_1` は実の不定元 | **PASS** |
| Step 1 の成分の実性の 2 段落（`σ_k^z`、`σ_m^zσ_{m^+}^z`、`σ_m^zσ_{m+1}^z`、`D`、`K_1D = (K_1)_ℂD`） | `check_step1_K1D_transpose_and_real_entries.sage` | `σ_k^z` がその因子の並びのクロネッカー積に等しいことと、各行列の成分の虚部が 0 | **PASS** |
| Step 1 の結論（`σ_m^zσ_{m+1}^z` は成分が実で転置について対称、`K_1D` は実対称）を別の経路で | `check_symbolic_exponents.sage` | `M_col = 2..5` の全ての `m`（周期的な延長を含む）で成分が実・転置で不変。`K_1` は実の不定元。`D` が有限和 `Σ_m σ_m^zσ_{m+1}^z` に等しいことも見る | **PASS** |
| Step 1 の `S_2` の表示の鎖 `S_2 = iK_2^*H_2 = K_2^*Σ_mσ_m^x` と、`S_2` は実対称 | `check_symbolic_exponents.sage` | 1 行目は `S_2` の定義を書く行。2 行目を `H_2 = Σ_m Z_mY_m`（Jordan–Wigner の行列から作る）と `Σ_m σ_m^x` から別々に組んで比べる。`K_2^*` は実の不定元 | **PASS** |
| Step 2: `K_1D`・`S_2` はエルミート（`real_symmetric_matrix_is_hermitian`）、`(1/2)K_1D` もエルミート（`real_multiple_of_hermitian_is_hermitian`） | `check_symbolic_exponents.sage` | 共役転置で不変を多項式環 `KG[K_1, K_2^*]` で厳密に | **PASS** |
| Step 2 の散文「実対称行列の冪は実対称で、`def_exp` の級数の部分和は実対称」 | `check_symbolic_exponents.sage` | `X = (1/2)K_1D, S_2` の冪 `X^p` と部分和 `Σ_{p≤N}(1/p!)X^p`（`N = 0..6`、`M_col = 2..4`）の成分が実・転置で不変 | **PASS** |
| Step 2: `B`・`A` は実対称正定値（`exp_hermitian_is_positive_definite` と散文の「極限も実対称」）、`B'B = I`（`exp_of_negative_is_left_inverse`）、`B = V_1^{1/2}`（`def_transfer_matrix_square_root`） | `check_exact_exponentials_and_W.sage` | 下の「計算の帰属」の厳密な `B, B', A` で、成分が実・転置で不変・`B^* = B`・正定値の二つの判定・`B'B = I`。`BB = V_1` は `V_1` を `def_transfer_matrix` の成分から `B` を経由せずに作って比べる | **PASS** |
| Step 3 の `V_2 = (2s_2)^{M_col/2}A`（`V2_exponential_representation`）と `(2s_2)^{M_col/2} > 0` | `check_exact_exponentials_and_W.sage` | `V_2` を成分の定義から作り `cA` と比べる。`s_2 > 0`・`c > 0`・`c^2 = (2s_2)^{M_col}` | **PASS** |
| Step 3 の `W` の鎖 4 行（`W = BV_2B = B(cA)B = c(BAB) = c(B^*AB)`） | `check_exact_exponentials_and_W.sage` | 各行を組み、隣の行と比べる | **PASS** |
| Step 3 の続く段落（`B^*AB = B^*(AB)` は正定値（`congruence_preserves_positive_definite`）、`W` は正定値（`positive_real_multiple_preserves_positive_definite`）） | `check_exact_exponentials_and_W.sage` | 結合律の行を比べ、`B^*(AB)` と `W` に正定値の二つの判定を当てる | **PASS** |
| Step 3 の転置の鎖 4 行（`W^⊤ = (BV_2B)^⊤ = B^⊤V_2^⊤B^⊤ = BV_2B = W`） | `check_exact_exponentials_and_W.sage` | 転置は `def_matrix_transpose` の成分の式で組み、各行を比べる。`V_2^⊤ = V_2`・`B^⊤ = B` も個別に見る | **PASS** |
| 可逆性の `BB'` の鎖 3 行（置き方、`matrix_double_negation`、`exp_of_negative_is_left_inverse`） | `check_exact_exponentials_and_W.sage` | `−(−D) = D` を符号反転の成分の式で確かめ、`exp(−(−(1/2)K_1D))` を `−(−D)` の固有値の射影から作って各行を比べる | **PASS** |
| 可逆性の `BV_2 ∈ R^×`（`V2_invertible`、`def_invertible_elements_of_R` (ii)）と `W = (BV_2)B ∈ R^×` | `check_exact_exponentials_and_W.sage` | `V_2^{-1} = (c^{-1})_ℂexp(−S_2)` が左右の逆元であること、`(BV_2)^{-1} = V_2^{-1}B'`、`W^{-1} = B'(V_2^{-1}B')` が左右の逆元であること、`det W ≠ 0` | **PASS** |
| 主張そのもの（成分が実、`W^⊤ = W`、正定値、可逆） | `check_exact_exponentials_and_W.sage` | 上の各行に加え、具体の `x = u + iv`（3 本）で `x^*Wx` の虚部が 0・実部が正 | **PASS** |

正定値性の判定（`def_hermitian_positive_definite` の「エルミートで、∀x ≠ 0 で x^*Ax ∈ ℝ_{>0}」）: エルミート性を共役転置の等号で確かめ、
(1) 首座小行列式が全て正（Sylvester の判定法）と (2) 特性多項式の係数の符号が厳密に交代する（エルミート行列の固有値は実なので根が全て正と同値）の
二つを求め、一致することも確かめる（`_prelude.sage` の `is_positive_definite_exact`）。二つの判定法は本文には無い独立な経路である。

否定コントロール（計 92 件）:
- `check_step1_K1D_transpose_and_real_entries.sage`（18 件）: 並びを逆にしない `(σ_1^zσ_1^x)^⊤ ≠ (σ_1^z)^⊤(σ_1^x)^⊤`、因子に `σ^y` を持つ `σ_1^y` は成分が実でない、周期端を `σ_{M+1}^z := I` と取り違えた和は `D` と違う（`M_col = 1..6` の各 3 件）。
- `check_symbolic_exponents.sage`: `i` を掛けない `K_2^*H_2` は成分が実でなく、エルミートでもない。実だが対称でない `σ_1^zσ_1^x` で転置の検査が落ちる。
- `check_exact_exponentials_and_W.sage`: 平方根でない `V_1` は `V_1V_1 ≠ V_1`、指数の符号を取り違えた `B'` は `B'B' ≠ V_1`。係数を `c^2` にすると `V_2` と外れる。並びを逆にしない `(BV_2)^⊤ ≠ B^⊤V_2^⊤`。
  合同でない `BV_2` は対称でない。`B(−A)B` は正定値でない。
- **直した可逆性の段の理由**: 旧い段は `Wx = 0` から `x^⊤Wx = 0` を作り、正定値性で `x = 0` としていた。正定値性は `x ∈ ℂ^n` の `x^*Wx` の条件なので、
  複素の `x` では従わない。実対称正定値な `W` について `u := e_1`、`v := (e_2 − (u^⊤We_2/u^⊤Wu)u)·√(u^⊤Wu/v'^⊤Wv')` と置くと、
  `x := u + iv ≠ 0` で `x^⊤Wx = 0`（一方 `x^*Wx > 0`）となることを `M_col = 2, 3` で厳密に確かめた（平方根を取るので AA で作り、AA の式の木の深さのため `M_col ≤ 3`）。

構成上かならず一致する比較（写し間違いの検出だけに効く）:
- `check_symbolic_exponents.sage` の `D = Σ_m σ_m^zσ_{m+1}^z`（有限和）は、共有の準備の `bond_sum` が同じ項の有限和なので必ず成り立つ。
- `BB'` の鎖の 1→2 行は、`−(−D) = D` を確かめた後では、`exp(−(−(1/2)K_1D))` を同じ射影から作るので必ず成り立つ。中身は `−(−D) = D`（符号反転の成分の式）の検査にある。
- `W` の鎖 2→3 行（スカラーの移動）と `B^*(AB) = (B^*A)B`（結合律）は、行列の成分の計算規則だけで必ず成り立つ。
- `check_exact_exponentials_and_W.sage` の数体 `F` の中では、成分は実数なので共役は恒等写像であり、`W` の鎖 3→4 行（`B^* = B`）は必ず成り立つ。
  `B^* = B` の中身は、同じ `B` を AA で作った前半の検査（転置と共役転置）が受け持つ。
- `B'B = I` と `BB' = I` は、`B`・`B'` を同じ射影の和 `Σ_λ y^{±λ}P_λ` で作るので必ず成り立つ。`def_exp` の部分和を通した確認は
  `check_symbolic_exponents.sage` の部分和の実対称性に限る（部分和の極限としての `exp` の値は、この検算では作らない）。
- `W` の成分が実であることは、`F` が AA へ埋め込まれた実の数体であることから構成上成り立つ。中身は `iH_2` の成分が整数で虚部が 0 であること
  （共有の準備 `iH2_integer_matrix` の検査）と、`D` の成分が整数であることにある。

## 計算の帰属と範囲

- `check_symbolic_exponents.sage`: `KG = QQ(i)` 上の実の不定元 `K_1`・`K_2^*` の多項式環で、任意の実数の結合定数で成り立つ形（`M_col = 2..5`、部分和は `M_col = 2..4`）。
- `check_exact_exponentials_and_W.sage`: `K_1 := 2 log y`、`K_2 := log x`（`x, y ∈ {2, 3}`、`M_col = 2..4`）と選ぶ。
  `B = Σ_λ y^λP_λ(D)`・`B' = Σ_λ y^{−λ}P_λ(D)` は QQ、`t = tanh K_2 = (x^2 − 1)/(x^2 + 1)`、`s_2 = (x^2 − x^{−2})/2` とし、
  `A = Σ_λ (√t)^{−λ}P_λ(iH_2)`・`c = (√(2s_2))^{M_col}`・`V_2`（成分 `x^n`）は `√t`・`√(2s_2)` を含む AA へ埋め込まれた数体 `F` に作る
  （AA の式の木が `M_col = 4` で深くなりすぎるため。`M_col ≤ 3` では共有の準備の AA の `A` と一致することも見る）。
  **ℝ への脱出は `K_1`・`K_2` の選び方の一点だけ**で、以後の等号・不等号は全て `QQ`・`F`・AA の厳密計算である。浮動小数点は使わない。
  `exp` の値は `def_exp` の級数ではなく固有値の射影から作る（独立な経路）。
- 範囲外: `M_col ≥ 7`（Step 1 の `K_1D` の転置の鎖と成分の実性）、`M_col ≥ 6`（`check_symbolic_exponents.sage` の Step 1 の行）、`M_col ≥ 5`（exp を含む行と主張）、上に挙げた以外の結合定数。一般の場合は人手証明が担う。
- Step 2 の散文「極限も実対称」（部分和の極限が実対称であること）は、極限そのものを作らないので確かめられない。極限の値が実対称であることは、
  固有値の射影から作った `B`・`A` で確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh W_is_real_symmetric_positive_definite
```

実行ログは `sagemath/check/W_is_real_symmetric_positive_definite/logs/` に保存する。
