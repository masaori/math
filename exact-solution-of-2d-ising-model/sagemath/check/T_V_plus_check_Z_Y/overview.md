# SageMath Check: T_V_plus_check_Z_Y

## 対象

**対象ラベル**: `T_V_plus_check_Z_Y`

- ファイル: `structured-latex/content/eigenvalue_problem_reduction_to_A_theta.ts`
- ブロック: `evensectorT_010_claim_T_V_plus_action`（`T_{(V^{(+)})}` の `Ž_μ, Y̌_μ` への作用）
- 範囲: 証明の準備の `β_1, β_2`、(z)・(y) の 12 行の鎖の全ての行、2 列を並べる鎖の 1〜7 行目。
  同じ主張の倍精度の検算は `047_claim_even_sector_T_action` の `check_04` にある。ここは鎖の行ごとの厳密な検算である。

## 証明の行との対応

`S := (V_1^{(+)})^{1/2}`。

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 準備 `(β_j)_{l1} = (B_1(θ̃))_{lj}` | `check_chain_rows_exact.sage` | 準備に書いた `β_1, β_2` の成分が、`def_B1_theta_B2` の成分の式で組んだ `B_1(θ̃)` の第 1 列・第 2 列に等しい | **PASS** | `M_col = 2, 3, 4`、全 μ、`(x, y) = (2, 2), (3, 3/2)` で厳密等号 |
| (z)・(y) の鎖の始点 | 同上 | `T_{(V^{(+)})}(X)` を、`T_{(V^{(+)})}` を経ずに `V^{(+)} = S V_2 S` の Sage の積と inverse で作った共役 `V^{(+)}X(V^{(+)})^{-1}` が 1 行目に等しい | **PASS** | 上と同じ範囲で厳密 |
| (z)・(y) の鎖の 1〜12 行目 | 同上 | 各行を行の表記どおりに組み（共役は `def_T_g` の `(gW)g^{-1}` を本文の積の成分の式で、組と数の列の積・組と 2×2 行列の積は二つの定義の成分の式で、組と Mat(2,1,ℂ) の元の積は成分を取る約束で、`B_2β_j` などは `mat_mult` の成分の式で）、隣どうしが等しい。2 行目は `T_actions_on_check_Z_Y` の左の等号の形 | **PASS** | 上と同じ範囲で厳密 |
| 2 列を並べる鎖の 1〜7 行目 | 同上 | 各行を行の表記どおりに組み、隣どうしが等しい。始点は Sage の共役。`(B_1B_2)B_1` を `mat_mult` の成分で組んだものは Sage の積と一致する | **PASS** | 上と同じ範囲で厳密 |
| 対照 | 同上 | (z)・(y) の 6 行目の `B_2` を転置すると 5 行目と一致しない。7 行目の `G = (B_1B_2)B_1` を転置すると始点と一致しない（`G` が対称な場合はログに SKIP と書いた） | **PASS** | 上と同じ範囲 |

## 計算の帰属と範囲

- 共通の準備は `../calc_of_TxT_check_Z_Y/_prelude.sage` と `_shared/transfer_factor_actions_on_check_Z_Y.sage`。
  `K_1 = 2 log y`、`K_2 = log x`（`x, y ∈ QQ`、`x, y > 1`）と選ぶと、`S`・`V_2`・cosh・sinh・位相が一つの数体 `F` に入るので、全ての等号を厳密に判定する（浮動小数点なし）。
- ℝ への脱出は K_1・K_2 の選び方と、位相 `exp(∓i(θ̃_μ)_C)` を 1 の冪根で表すことだけである。
- 範囲外: `M_col ≥ 5`、log の形でない K_1・K_2。
- 2 列を並べる鎖の 8 行目（`factorization_of_A_theta_general` による `A(θ̃_μ)` への置き換え）は、その主張の検算 `factorization_of_A_theta_general` が確かめる。

## 確かめられない行と理由

- 定義の展開の行（`β_j` の置き方、組の積の定義、`mat_mult`）は、検算が両辺を同じ式で組むので一致は作り方から通る。値として独立に確かめているのは、始点（Sage の積と inverse による共役）と、線型性・`calc_of_TxT_check_Z_Y`・結合律の主張を当てた行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh T_V_plus_check_Z_Y
```

`check_chain_rows_exact.sage` は引数で `M_col` を絞れる。実行ログは `logs/` に保存する（2026-11-17）。
