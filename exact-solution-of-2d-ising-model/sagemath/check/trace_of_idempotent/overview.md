# SageMath Check: trace_of_idempotent

## 対象

**対象ラベル**: `trace_of_idempotent` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/009_eigenvalues_of_V.ts`
- ブロック: `eigenvalues_of_V_003_claim_trace_of_idempotent`（冪等行列のトレースは像の次元）
- 範囲: 準備の鎖（`Q^2 = QQ`）、Step 1 の三つの鎖（`x = Qx + (x-Qx)`・`Q(x-Qx) = 0`・`y = Qy`）、Step 2 の `Qv_j = v_j` の鎖と
  `(PD)_{il}` の鎖、Step 3 の `tr(Q)` の鎖の全行と、主張の直和分解・`tr(Q) = dim im Q`

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `Q^2 = Q^1Q = (Q^0Q)Q = (IQ)Q = QQ`（`def_exp` (1)、`identity_matrix_is_left_unit_of_mat_mult`） | `check_preparation_power.sage` | `Q` の成分を `QQ` 上の不定元に置き、冪を `A^0 := I`・`A^{m+1} := A^m A` のとおりに組んで 5 行の値を比べ、両端を Sage の冪・行列積と比べる | **PASS** | `n = 1,…,5` で厳密等号 |
| Step 1 `(Qx+(x-Qx))_k = (Qx)_k + (x-Qx)_k = (Qx)_k + (x_k-(Qx)_k) = x_k`（`def_matrix_sum`・`def_matrix_difference`・加法の結合律・交換律・逆元・零元）と、成分の一致からの `x = Qx + (x-Qx)` | `check_step1_direct_sum.sage` | `x` の成分を `QQ(i)` 上の不定元に、`Q` を `QQ(i)` の具体の冪等行列に置いて 4 行の値を比べ、Sage のベクトルの和・差とも比べる | **PASS** | `n = 1,…,5`、各 `r = 0,…,n` で 3 個ずつの `Q` |
| Step 1 `Q(x-Qx) = Qx-Q(Qx)`（`mat_mult_vector_difference`）`= Qx-(QQ)x`（`mat_mult_associative`）`= Qx-Qx`（`QQ = Q`）`= 0`（`matrix_difference_zero_iff_equal`） | 同上 | 本文の積・差・零ベクトルの組み方で 5 行の値を比べ、Sage の行列積でも `Q(x-Qx) = 0` を確かめる。否定コントロールとして冪等でない `2I` では `0` にならないこと | **PASS** | 同上 |
| Step 1 `y = Qx = (QQ)x = Q(Qx) = Qy` | 同上 | `y := Qx` とおいて 5 個の値を比べる | **PASS** | 同上 |
| Step 1 `Qy = 0`（`y ∈ ker Q`）と主張の直和分解 | 同上 | `x` を不定元のままでは `y ∈ ker Q` を課せないので、Sage の `column_space`・`right_kernel` で `im Q ∩ ker Q = {0}`、`im Q + ker Q = ℂ^n`、`dim im Q + dim ker Q = n`、`dim im Q = r` を確かめる | **PASS** | 同上 |
| Step 2 `Qv_j = Q(Qx_j) = (QQ)x_j = Qx_j = v_j`（`j ≤ r`）と `Qv_j = 0`（`j > r`） | `check_steps2_3_trace.sage` | `im Q`・`ker Q` の基底を Sage から取り、`x_j` を `solve_right` で求めて `v_j = Qx_j` を確かめ、5 個の値を比べる | **PASS** | 同上 |
| Step 2 `(PD)_{il} = Σ_k P_ik D_kl = P_il D_ll + Σ_{k≠l} P_ik D_kl = P_il D_ll + Σ_{k≠l} P_ik 0 = P_il D_ll + Σ_{k≠l} 0 = P_il D_ll = (v_l)_i D_ll = {(v_l)_i 1, (v_l)_i 0} = {(v_l)_i, 0} = (Qv_l)_i = ([Qv_1…Qv_n])_{il} = (QP)_{il}` | 同上 | `P` を基底を列に並べた行列、`D` を本文の定め方の対角行列として、全成分で 12 個の値を比べる（`k ≠ l` で `D_kl = 0` も確かめる）。`QP = PD` を Sage の行列積でも確かめる | **PASS** | 同上 |
| Step 3 `tr(Q) = tr(P'(QP))`（`trace_basic_properties` (4)）`= tr(P'(PD)) = tr((P'P)D) = tr(ID) = tr(D) = ΣD_kk = Σ_{k≤r}1 + Σ_{k>r}0 = Σ_{k≤r}1 = dim im Q` | 同上 | `P'` を Sage の `inverse` で求め、仮定 `P'P = PP' = I` を本文の積で確かめてから 10 個の値を比べる。両端を Sage の `trace`・`rank` と比べる。否定コントロールとして冪等でない `2I` では `tr(Q) ≠ dim im Q` | **PASS** | 同上 |

## 計算の帰属と範囲

浮動小数点と `RR` / `CC` への脱出はない。

- 冪等行列は、`QQ(i)` の可逆行列 `S`（乱数の種を固定して決める）で `S diag(1^r, 0^{n-r}) S^{-1}` として作る。エルミートとは限らない。
  `r = 0`（零行列）と `r = n`（単位行列）も含む。冪等性 `Q·Q = Q` は作った後に確かめる。
- 準備の鎖は `Q` を不定元に、Step 1 の鎖は `x` を不定元にして、一般の等式として確かめた。仮定 `Q^2 = Q` を使う行は、
  不定元のままでは仮定を課せないので具体の冪等行列で確かめた。
- 大きさは `n = 1,…,5` である。一般の `n` は人手証明が担う。

両辺を同じ式から作らないため、積・和・単位行列は本文の定め方どおりの組み方（`_shared/matrix_operations_by_definition.sage`）で、
差・零ベクトル・トレース・冪・列に並べた行列は `_prelude.sage` で本文の式どおりに組み、主張の両端は Sage の行列積・`trace`・`rank`・
`column_space`・`right_kernel` と比べた。

## 確かめられない行と理由

- 定義を開く行（`def_matrix_sum`・`def_matrix_difference`・`def_trace`・`def_exp` (1)・`mat_mult`・`P` と `D` の定め方の行）は、
  検算での組み方そのものが定義なので隣り合う行の比較は同語反復である。独立な確認は、鎖の両端を Sage の組み込みと比べる検査が担う。
- 「`im Q` の基底と `ker Q` の基底を合わせると `ℂ^n` の基底になる」「基底を列に並べた行列は `P'P = PP' = I` を満たす `P'` を持つ」は、
  本文に定義と証明のない線型代数の事実である（状態台帳の「検算で見つかった本文の誤り」）。検算は具体の行列でそれが成り立つことを確かめるにとどまる。
- Step 3 の最終行の、自然数 `r` を `1_C` の `r` 個の和として読むことは主張の読み方の約束であり、検算では `K(r)` との一致として確かめた。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh trace_of_idempotent
```

実行ログは `sagemath/check/trace_of_idempotent/logs/` に保存する。
