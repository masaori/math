# SageMath Check: 164_Z_Y_generate_algebra

## 対象

**対象ラベル**: `Z_Y_generate_algebra` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`

- 範囲: Z,Y の生成する部分多元環が Mat(2^M,C) 全体（次元 4^M）。Step 3 の 2 次の行列の展開の鎖（check_02）。Step 3 後半の `E_k` の場合分けと積 `E_1⋯E_M = e_1⊠⋯⊠e_M` の鎖（check_03）。Step 1 の第 1〜4 式・`σ_k^xσ_k^x`・`σ_k^x` の鎖と、引いた異サイトの可換性の場合（check_04）

語を長さ順に生成し、張る空間の次元がどの深さで 4^M に達するかを記録する。対比として **Z だけでは全体を生成しない**ことも確認しており、生成集合に Y が必要であることが分かる。

## チェック一覧

| # | ファイル | 検証内容 | 判定数 | 最大相対誤差 | ステータス |
|---|---------|---------|-------|------------|-----------|
| 01 | `check_01_span_dimension.sage` | 生成される部分空間の次元（M=2,3） | 4 | 0.000e+00 | **PASS** |
| 02 | `check_02_pauli_decomposition_chains.sage` | Step 3 の展開 `A = κ_0 I + κ_x σ^x + κ_y σ^y + κ_z σ^z`（`κ` は `def_complex_quotient` の商 `/2_ℂ`）の準備 (a)〜(g) の鎖（(f)・(g) は人手では Step 1 の冒頭に置く。(f) は ℂ を実数の組で表して 4 行）と、`R_11`・`R_12`・`R_21`・`R_22` の鎖（`R` の定義・`def_matrix_sum`・`def_matrix_scalar_multiple` の 3 行と `κ` の定義の代入の行を含む）を一行ずつ。`a_11, a_12, a_21, a_22, z, w` を不定元にした QQ(i) 上の有理関数体で厳密に。`2_ℂ ≠ 0`・`ii = −1_ℂ`・`R = A`、否定の対照 3 件（`κ_0` の `/2_ℂ` を落とす、`κ_y` の `i` を落とす、`κ_z` の符号を逆にする） | 132 | 厳密 | **PASS** |
| 03 | `check_03_site_factor_products.sage` | Step 3 後半: `E_k := I⊠⋯⊠e_k⊠⋯⊠I`（第 `k` 因子だけが `e_k ∈ {I,σ^x,σ^y,σ^z}`）が、`e_k = I` なら `I_{Mat(2^M,ℂ)}`（`kronecker_product_rule` (2)）、`e_k = σ^x,σ^y,σ^z` なら `σ_k^x,σ_k^y,σ_k^z`（`def_site_pauli_matrices`。`σ_k^a` はクロネッカー積を使わず成分から組み立てる）であること。`P_1 := E_1`・`P_{s+1} := P_sE_{s+1}` の帰納法の `P_1` の鎖（2 行）・帰納法の仮定・帰納の一段の鎖（6 行）を一行ずつと、`P_M = E_1⋯E_M = e_1⊠⋯⊠e_M` を、M=1,2,3 と `B^M` の全ての組で QQ(i) 上で厳密に。否定の対照 4 件（因子の順を逆にする、`e_2` の位置をずらす、`σ^x` の位置をずらす、`σ^y` を転置する） | 1144 | 厳密 | **PASS** |
| 04 | `check_04_step1_pauli_chains.sage` | Step 1: 第 1 式 `σ^xσ^x = I`、第 2 式 `σ^yσ^z = iσ^x` の 14 行（`mat_mult` の和の形・`complex_zero_times_is_zero`・加法の単位元・積の可換律・`multiply_by_minus_one`・`double_negation_in_cc`・積の単位元・`def_matrix_scalar_multiple`）と各行の根拠の成分、第 3 式 `σ^x = (-i)(σ^yσ^z)` の 4 行（準備 (g) の結論 `(-i)i = 1_ℂ` を含む）、第 4 式 `σ_k^aσ_k^b = I⊠⋯⊠(σ^aσ^b)⊠⋯⊠I` の 3 行（全ての `a, b`、M=1,2,3、全ての `k`。`σ_k^a` は成分から独立に組み立てる）、`σ_k^xσ_k^x = I_{Mat(2^M,ℂ)}` の 3 行と `σ_k^x = (-i)(σ_k^yσ_k^z)` の 4 行（M=1,2,3、全ての `k`）、引いた `distinct_site_pauli_matrices_commute` の場合（M=2,3）を QQ(i) 上で厳密に。否定の対照 5 件（第 2 式の係数を `-i`、第 3 式の係数を `i`、`(-i)(-1)` を `-i` と読む、第 4 式の積を別のサイトへ、同じサイトの `σ^y, σ^z` の可換性） | 308 | 厳密 | **PASS** |

許容誤差は既定の相対誤差 `1.0e-09`（成分の最大絶対値で正規化）。既定から変更していない。

## 備考

M=4 以上は語の数が急増するため対象外。次元の議論自体は M に依らないので M=2,3 で十分な検算になる。

## 実行時に出力された観測値

```
  M=2 depth=1: 語の総数=5, 張る空間の次元=5 / 16
  M=2 depth=2: 語の総数=21, 張る空間の次元=11 / 16
  M=2 depth=3: 語の総数=85, 張る空間の次元=15 / 16
  M=2 depth=4: 語の総数=341, 張る空間の次元=16 / 16
  M=2: Z のみで張る次元=4 (< 16 のはず)
  M=3 depth=1: 語の総数=7, 張る空間の次元=7 / 64
  M=3 depth=2: 語の総数=43, 張る空間の次元=22 / 64
  M=3 depth=3: 語の総数=259, 張る空間の次元=42 / 64
  M=3 depth=4: 語の総数=1555, 張る空間の次元=57 / 64
  M=3 depth=5: 語の総数=9331, 張る空間の次元=63 / 64
  M=3 depth=6: 語の総数=55987, 張る空間の次元=64 / 64
  M=3: Z のみで張る次元=8 (< 64 のはず)
```

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh 164
```

実行ログは `sagemath/check/164_Z_Y_generate_algebra/logs/` に保存してある（この表の数値はそのログから取った）。
